Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F82DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0823520840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCHDlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:41:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfCHDlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 22:41:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E21753C2CF7;
        Fri,  8 Mar 2019 03:41:00 +0000 (UTC)
Received: from redhat.com (ovpn-125-54.rdu2.redhat.com [10.10.125.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C72AB1001DC1;
        Fri,  8 Mar 2019 03:40:55 +0000 (UTC)
Date:   Thu, 7 Mar 2019 22:40:53 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190308034053.GB5562@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
 <20190307191720.GF3835@redhat.com>
 <20190307211506-mutt-send-email-mst@kernel.org>
 <20190308025539.GA5562@redhat.com>
 <20190307221549-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307221549-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 08 Mar 2019 03:41:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:16:00PM -0500, Michael S. Tsirkin wrote:
> On Thu, Mar 07, 2019 at 09:55:39PM -0500, Jerome Glisse wrote:
> > On Thu, Mar 07, 2019 at 09:21:03PM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Mar 07, 2019 at 02:17:20PM -0500, Jerome Glisse wrote:
> > > > > It's because of all these issues that I preferred just accessing
> > > > > userspace memory and handling faults. Unfortunately there does not
> > > > > appear to exist an API that whitelists a specific driver along the lines
> > > > > of "I checked this code for speculative info leaks, don't add barriers
> > > > > on data path please".
> > > > 
> > > > Maybe it would be better to explore adding such helper then remapping
> > > > page into kernel address space ?
> > > 
> > > I explored it a bit (see e.g. thread around: "__get_user slower than
> > > get_user") and I can tell you it's not trivial given the issue is around
> > > security.  So in practice it does not seem fair to keep a significant
> > > optimization out of kernel because *maybe* we can do it differently even
> > > better :)
> > 
> > Maybe a slightly different approach between this patchset and other
> > copy user API would work here. What you want really is something like
> > a temporary mlock on a range of memory so that it is safe for the
> > kernel to access range of userspace virtual address ie page are
> > present and with proper permission hence there can be no page fault
> > while you are accessing thing from kernel context.
> > 
> > So you can have like a range structure and mmu notifier. When you
> > lock the range you block mmu notifier to allow your code to work on
> > the userspace VA safely. Once you are done you unlock and let the
> > mmu notifier go on. It is pretty much exactly this patchset except
> > that you remove all the kernel vmap code. A nice thing about that
> > is that you do not need to worry about calling set page dirty it
> > will already be handle by the userspace VA pte. It also use less
> > memory than when you have kernel vmap.
> > 
> > This idea might be defeated by security feature where the kernel is
> > running in its own address space without the userspace address
> > space present.
> 
> Like smap?

Yes like smap but also other newer changes, with similar effect, since
the spectre drama.

Cheers,
Jérôme
