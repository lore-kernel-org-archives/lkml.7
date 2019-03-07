Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FA520840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfCGTir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:38:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfCGTiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:38:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6DBC821EF;
        Thu,  7 Mar 2019 19:38:45 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77C8F5C545;
        Thu,  7 Mar 2019 19:38:40 +0000 (UTC)
Date:   Thu, 7 Mar 2019 14:38:38 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190307193838.GQ23850@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190306092837-mutt-send-email-mst@kernel.org>
 <15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
 <20190307101708-mutt-send-email-mst@kernel.org>
 <20190307190910.GE3835@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307190910.GE3835@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 07 Mar 2019 19:38:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 02:09:10PM -0500, Jerome Glisse wrote:
> I thought this patch was only for anonymous memory ie not file back ?

Yes, the other common usages are on hugetlbfs/tmpfs that also don't
need to implement writeback and are obviously safe too.

> If so then set dirty is mostly useless it would only be use for swap
> but for this you can use an unlock version to set the page dirty.

It's not a practical issue but a security issue perhaps: you can
change the KVM userland to run on VM_SHARED ext4 as guest physical
memory, you could do that with the qemu command line that is used to
place it on tmpfs or hugetlbfs for example and some proprietary KVM
userland may do for other reasons. In general it shouldn't be possible
to crash the kernel with this, and it wouldn't be nice to fail if
somebody decides to put VM_SHARED ext4 (we could easily allow vhost
ring only backed by anon or tmpfs or hugetlbfs to solve this of
course).

It sounds like we should at least optimize away the _lock from
set_page_dirty if it's anon/hugetlbfs/tmpfs, would be nice if there
was a clean way to do that.

Now assuming we don't nak the use on ext4 VM_SHARED and we stick to
set_page_dirty_lock for such case: could you recap how that
__writepage ext4 crash was solved if try_to_free_buffers() run on a
pinned GUP page (in our vhost case try_to_unmap would have gotten rid
of the pins through the mmu notifier and the page would have been
freed just fine).

The first two things that come to mind is that we can easily forbid
the try_to_free_buffers() if the page might be pinned by GUP, it has
false positives with the speculative pagecache lookups but it cannot
give false negatives. We use those checks to know when a page is
pinned by GUP, for example, where we cannot merge KSM pages with gup
pins etc... However what if the elevated refcount wasn't there when
try_to_free_buffers run and is there when __remove_mapping runs?

What I mean is that it sounds easy to forbid try_to_free_buffers for
the long term pins, but that still won't prevent the same exact issue
for a transient pin (except the window to trigger it will be much smaller).

I basically don't see how long term GUP pins breaks stuff in ext4
while transient short term GUP pins like O_DIRECT don't. The VM code
isn't able to disambiguate if the pin is short or long term and it
won't even be able to tell the difference between a GUP pin (long or
short term) and a speculative get_page_unless_zero run by the
pagecache speculative pagecache lookup. Even a random speculative
pagecache lookup that runs just before __remove_mapping, can cause
__remove_mapping to fail despite try_to_free_buffers() succeeded
before it (like if there was a transient or long term GUP
pin). speculative lookup that can happen across all page struct at all
times and they will cause page_ref_freeze in __remove_mapping to
fail.

I'm sure I'm missing details on the ext4 __writepage problem and how
set_page_dirty_lock broke stuff with long term GUP pins, so I'm
asking...

Thanks!
Andrea
