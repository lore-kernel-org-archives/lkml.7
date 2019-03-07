Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73922064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfCGPet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:34:49 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40481 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:34:49 -0500
Received: by mail-qt1-f193.google.com with SMTP id f11so275726qti.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Wsfg0ok9ugLJ683R6tW39HiYXOlqVaFSZwOTghjsqWI=;
        b=NBHGSACvGfLHmdkc0yDZiGVpqvStiT/qFrG0PXNX2DYrqD+WbOOp12GfGs5sL0QiQs
         h1AFGIM9pFyBI6BcEBfets/+I8H7UHacu23e2r9X6Oy+fo27owyTKUzZNRS34GJ7ybNa
         Z/DneJLj5+1Zkr/st4lTYrhzR9BJISwsqbvELydPUlvYajb7cuPzjQUAl2IzS+smx4iV
         zpzTu2cYb8CFw6UAJf9CiNUZsciV0rubCF7zLFe/tGOauNAXQy7xKdjmO87lhMVgixwg
         mlaPZWze2218xSbvUswe9rNwgkng4K31E4uSe0vgRn9MiFOvEDV9m+yWJbwPd6e7+c63
         FG/w==
X-Gm-Message-State: APjAAAVo6GWqLgCOYu2AQyMoIyMBMH/VfXkaTUJiKvGHYme1QgA1r9Yn
        2AUjY25OEkfMzyckr0eA3H2Q7Q==
X-Google-Smtp-Source: APXvYqz69aAWMZo6tBGadWm6DMo8HXGSmtwBcs9kAOiIp3jiWs4Vy0Z3okP7DZSreWC/fa5WNW5dOA==
X-Received: by 2002:ac8:23aa:: with SMTP id q39mr10380050qtq.82.1551972888059;
        Thu, 07 Mar 2019 07:34:48 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id x43sm3517230qtc.10.2019.03.07.07.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 07:34:47 -0800 (PST)
Date:   Thu, 7 Mar 2019 10:34:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org, aarcange@redhat.com
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190307101708-mutt-send-email-mst@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190306092837-mutt-send-email-mst@kernel.org>
 <15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:45:57AM +0800, Jason Wang wrote:
> 
> On 2019/3/7 上午12:31, Michael S. Tsirkin wrote:
> > > +static void vhost_set_vmap_dirty(struct vhost_vmap *used)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < used->npages; i++)
> > > +		set_page_dirty_lock(used->pages[i]);
> > This seems to rely on page lock to mark page dirty.
> > 
> > Could it happen that page writeback will check the
> > page, find it clean, and then you mark it dirty and then
> > invalidate callback is called?
> > 
> > 
> 
> Yes. But does this break anything?
> The page is still there, we just remove a
> kernel mapping to it.
> 
> Thanks

Yes it's the same problem as e.g. RDMA:
	we've just marked the page as dirty without having buffers.
	Eventually writeback will find it and filesystem will complain...
	So if the pages are backed by a non-RAM-based filesystem, it’s all just broken.

one can hope that RDMA guys will fix it in some way eventually.
For now, maybe add a flag in e.g. VMA that says that there's no
writeback so it's safe to mark page dirty at any point?





-- 
MST
