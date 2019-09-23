Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E338C4CED0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC9820820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbfIWQA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:00:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732882AbfIWQAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:00:55 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DEA881F31
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:00:54 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id m6so17755663qtk.23
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FnrZlG9onHbzoUOas395WBpQBkqdPWiXJrz3kgJAMNs=;
        b=uPrCEuwgYM1mv+vcWdVdM5SGTy3DQsOvwy5Fv5nikjtblwlrersdKhlh7+WPpKITst
         H4aSg8qQv0eGbyJy7rmpI3OfznYX9CoA8QlvLS7mQ3es0mqeCJ9jMRYAp0Ea+7l0ZFfB
         MIVkxAdZBvxRnQIkmoKu5II5seD12lZGJpmMKryZKkupFkJgsTCOhsgqHTF5UO+P3kNg
         JnzXa+6qnQHxJwkk3cncmyA4lQBCxo+NUx1STzFHrMzr4lXMvOyQvqyaNkG05ou8Uh+z
         gN2xZXi/f+2MnVsNPPoPtyYRcu0CJcn9i4JMTPgg7Ek5A07ndG2p2bl7+cW5pWUqCK1R
         Aqsw==
X-Gm-Message-State: APjAAAV57t8EF5ujn1hcEiwXH/x5sa1J5ScNy8UYeCkofw/ByJIFQGnF
        3+CGRKhQlUSWvSBs2NQ/NoQN3zIJ9nqC1vsjmLp92g2ZKByfUsRg+P4KbOT2oRBDLadTIDuXcOU
        oD/WZ8rEZLsaID+xeFFtRW1rJ
X-Received: by 2002:a0c:e48b:: with SMTP id n11mr25662847qvl.38.1569254453722;
        Mon, 23 Sep 2019 09:00:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzeS0qH7VWztyzQkjfFK33LHuBL/0r9aVYJeACu8zWG4i5I+VaFWBP3hOAewtn9oF8WJysLNw==
X-Received: by 2002:a0c:e48b:: with SMTP id n11mr25662820qvl.38.1569254453463;
        Mon, 23 Sep 2019 09:00:53 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id m125sm5840827qkd.3.2019.09.23.09.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 09:00:52 -0700 (PDT)
Date:   Mon, 23 Sep 2019 12:00:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        tiwei.bie@intel.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, cohuck@redhat.com,
        maxime.coquelin@redhat.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, rob.miller@broadcom.com,
        xiao.w.wang@intel.com, haotian.wang@sifive.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com,
        oberpar@linux.ibm.com, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com,
        freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com
Subject: Re: [PATCH 5/6] vringh: fix copy direction of vringh_iov_push_kern()
Message-ID: <20190923115930-mutt-send-email-mst@kernel.org>
References: <20190923130331.29324-1-jasowang@redhat.com>
 <20190923130331.29324-6-jasowang@redhat.com>
 <20190923094559.765da494@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923094559.765da494@x1.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 09:45:59AM -0600, Alex Williamson wrote:
> On Mon, 23 Sep 2019 21:03:30 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
> > We want to copy from iov to buf, so the direction was wrong.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vhost/vringh.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> 
> Why is this included in the series?  Seems like an unrelated fix being
> held up within a proposal for a new feature.  Thanks,
> 
> Alex

It's better to have it as patch 1/6, but it's a dependency of the
example driver in the series. I can reorder when I apply.


> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 08ad0d1f0476..a0a2d74967ef 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -852,6 +852,12 @@ static inline int xfer_kern(void *src, void *dst, size_t len)
> >  	return 0;
> >  }
> >  
> > +static inline int kern_xfer(void *dst, void *src, size_t len)
> > +{
> > +	memcpy(dst, src, len);
> > +	return 0;
> > +}
> > +
> >  /**
> >   * vringh_init_kern - initialize a vringh for a kernelspace vring.
> >   * @vrh: the vringh to initialize.
> > @@ -958,7 +964,7 @@ EXPORT_SYMBOL(vringh_iov_pull_kern);
> >  ssize_t vringh_iov_push_kern(struct vringh_kiov *wiov,
> >  			     const void *src, size_t len)
> >  {
> > -	return vringh_iov_xfer(wiov, (void *)src, len, xfer_kern);
> > +	return vringh_iov_xfer(wiov, (void *)src, len, kern_xfer);
> >  }
> >  EXPORT_SYMBOL(vringh_iov_push_kern);
> >  
