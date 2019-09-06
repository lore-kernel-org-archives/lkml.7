Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4B9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19802082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394403AbfIFOS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:18:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31823 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732468AbfIFOS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:18:56 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C64637E79
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 14:18:56 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id b1so6453146qtj.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 07:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=741o/xQPcgkh8sbSjiFyBn3gsnAEkmJOCIfqfDhtUBo=;
        b=c7PsEt7OUX8S6lib30SSkkd4gfMKsrPQwzqAos1d9/Jd3qOPmmIkKi7p/TA3kGhSu9
         KY0uGcWHx/ezaImZXsZG5gXu5kW5HwvkUeUOwgXE6lYqFSwgmIs3lBClZLttnELtpMga
         C3W0IOP2UyMmj5FIWeABfmMXD8Mpt1yfOEqITutxSujksUptJf1lyt7sRKemcHr9Tm38
         4yNTxQKPKulWcBPRFl79L5/LJDrErjioYLpOB8BPH3mdRydiMMgjSXa9Oa00h4TvUiPu
         NCrkOL7Bgznievc8bB5+zoifgTYrepcCgoG+cdmdSnYYanLGUgyzAqxTncvK9ZiwyyCP
         zA4Q==
X-Gm-Message-State: APjAAAUsbcz7hkwNVkNGLf7Ykt5lJG4tVSqpLVt887dnFVjI/sgpsLik
        n+e2bB04aa8jJGojjKdVdMRal8XmMs/HrUhSYgPphg27JdvvuONnS1+9R1rwWzUk7tQYGNhMkCP
        m2yCiDPZsbAQmnpcUpGhCA2DA
X-Received: by 2002:ac8:3195:: with SMTP id h21mr9753403qte.350.1567779535855;
        Fri, 06 Sep 2019 07:18:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGLpg1Ryu90HpqFQxE1o/aqz1GtskO77HSqagnTOVU8en/4xP+XAgktTlx6GUHLSwh5hScgw==
X-Received: by 2002:ac8:3195:: with SMTP id h21mr9753390qte.350.1567779535712;
        Fri, 06 Sep 2019 07:18:55 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id g12sm2422156qkm.25.2019.09.06.07.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 07:18:54 -0700 (PDT)
Date:   Fri, 6 Sep 2019 10:18:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com
Subject: Re: [PATCH 08/18] virtiofs: Drain all pending requests during
 ->remove time
Message-ID: <20190906101819-mutt-send-email-mst@kernel.org>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-9-vgoyal@redhat.com>
 <20190906105210.GP5900@stefanha-x1.localdomain>
 <20190906141705.GF22083@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906141705.GF22083@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 10:17:05AM -0400, Vivek Goyal wrote:
> On Fri, Sep 06, 2019 at 11:52:10AM +0100, Stefan Hajnoczi wrote:
> > On Thu, Sep 05, 2019 at 03:48:49PM -0400, Vivek Goyal wrote:
> > > +static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
> > > +{
> > > +	WARN_ON(fsvq->in_flight < 0);
> > > +
> > > +	/* Wait for in flight requests to finish.*/
> > > +	while (1) {
> > > +		spin_lock(&fsvq->lock);
> > > +		if (!fsvq->in_flight) {
> > > +			spin_unlock(&fsvq->lock);
> > > +			break;
> > > +		}
> > > +		spin_unlock(&fsvq->lock);
> > > +		usleep_range(1000, 2000);
> > > +	}
> > 
> > I think all contexts that call this allow sleeping so we could avoid
> > usleep here.
> 
> usleep_range() is supposed to be used from non-atomic context.
> 
> https://github.com/torvalds/linux/blob/master/Documentation/timers/timers-howto.rst
> 
> What construct you are thinking of?
> 
> Vivek

completion + signal on vq callback?

-- 
MST
