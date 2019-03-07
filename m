Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCEEC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C8820851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfCGTJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:09:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfCGTJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:09:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 137B9882F0;
        Thu,  7 Mar 2019 19:09:18 +0000 (UTC)
Received: from redhat.com (ovpn-125-54.rdu2.redhat.com [10.10.125.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD4136013F;
        Thu,  7 Mar 2019 19:09:12 +0000 (UTC)
Date:   Thu, 7 Mar 2019 14:09:10 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190307190910.GE3835@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190306092837-mutt-send-email-mst@kernel.org>
 <15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
 <20190307101708-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307101708-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 07 Mar 2019 19:09:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:34:39AM -0500, Michael S. Tsirkin wrote:
> On Thu, Mar 07, 2019 at 10:45:57AM +0800, Jason Wang wrote:
> > 
> > On 2019/3/7 上午12:31, Michael S. Tsirkin wrote:
> > > > +static void vhost_set_vmap_dirty(struct vhost_vmap *used)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < used->npages; i++)
> > > > +		set_page_dirty_lock(used->pages[i]);
> > > This seems to rely on page lock to mark page dirty.
> > > 
> > > Could it happen that page writeback will check the
> > > page, find it clean, and then you mark it dirty and then
> > > invalidate callback is called?
> > > 
> > > 
> > 
> > Yes. But does this break anything?
> > The page is still there, we just remove a
> > kernel mapping to it.
> > 
> > Thanks
> 
> Yes it's the same problem as e.g. RDMA:
> 	we've just marked the page as dirty without having buffers.
> 	Eventually writeback will find it and filesystem will complain...
> 	So if the pages are backed by a non-RAM-based filesystem, it’s all just broken.
> 
> one can hope that RDMA guys will fix it in some way eventually.
> For now, maybe add a flag in e.g. VMA that says that there's no
> writeback so it's safe to mark page dirty at any point?

I thought this patch was only for anonymous memory ie not file back ?
If so then set dirty is mostly useless it would only be use for swap
but for this you can use an unlock version to set the page dirty.

Cheers,
Jérôme
