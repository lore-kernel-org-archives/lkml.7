Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC9AC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F9121852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BOTF2/Bb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfIQMd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:33:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36788 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfIQMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:33:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id f2so3179895edw.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ilmBg9I2YMwvibWDRJZaEkCfUM/sW+D4XZUuUcRsYfc=;
        b=BOTF2/Bb/eotbRCnoavsJAQrVi+ZwxxTD2EQ7kS5NbDJ3bSwZGLUGMVTgtaAc8xAvF
         DuiPbfc29C/IgyvFaUBEDXtenoVdllLvQ4rG+MQS60fbRGQnFhsfgvSsCE/jW4HJ3wjF
         +mask6n0m6qYrh2hBXRyMCyTTeHExsm+RtneY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ilmBg9I2YMwvibWDRJZaEkCfUM/sW+D4XZUuUcRsYfc=;
        b=KvsPcKBKK9Yup8l8govpX8u4T9c1vsxdRLWmIGweG0ji0Ekdh4DWn6gJjP0jm+QogY
         GOEHrdrRrJBL7klZzEl85fC/oz+9cGv2jGXml0rW1z0tN1Z1Z+etnnm5OWjBn7Gyh5gA
         iiWzZB8oafn3YIPP3w/+2ZdilhlRj5/6qiUVg5zqhByUojGMSt4M//W11Q8hpLsoArWX
         L9f7NVyvzBabo2rGGIoLpYv/Yys83YIAr+7uhX2DjRfqgRWdo02IYNN9MJmxe8eg+SXs
         Tdmw1E4nwqwRLZ/1UszHwfrxayTxZ7aV9vWWXNh/FS8lI2utA4Gukfxzg8o+xcz/b3qx
         p0/Q==
X-Gm-Message-State: APjAAAWCRpxgtNt1k2gcmuFzmTw1oCDIY77SA86kGQsfxqfhxkpgk9Pv
        hGbGWzy8IVhPs9+B8WIPccnYmg==
X-Google-Smtp-Source: APXvYqx/IQig1FDTnjkgmHtkO1JFOjy029wlCPWaimLNWKzgUT5F7ZMNT3ZZvoo9UOVGaxA0RmMzwg==
X-Received: by 2002:a50:eac3:: with SMTP id u3mr4501795edp.9.1568723634340;
        Tue, 17 Sep 2019 05:33:54 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id z20sm411832edb.3.2019.09.17.05.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 05:33:53 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:33:51 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] drm: add drm_print_bits
Message-ID: <20190917123351.GN3958@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        open list <linux-kernel@vger.kernel.org>
References: <20190904054740.20817-1-kraxel@redhat.com>
 <20190904054740.20817-2-kraxel@redhat.com>
 <66258358-b27e-4eb1-44a4-c90aa342293c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66258358-b27e-4eb1-44a4-c90aa342293c@suse.de>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 02:46:47PM +0200, Thomas Zimmermann wrote:
> 
> 
> Am 04.09.19 um 07:47 schrieb Gerd Hoffmann:
> > New helper to print named bits of some value (think flags fields).
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  include/drm/drm_print.h     |  3 +++
> >  drivers/gpu/drm/drm_print.c | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 36 insertions(+)
> > 
> > diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> > index 112165d3195d..12d4916254b4 100644
> > --- a/include/drm/drm_print.h
> > +++ b/include/drm/drm_print.h
> > @@ -89,6 +89,9 @@ __printf(2, 3)
> >  void drm_printf(struct drm_printer *p, const char *f, ...);
> >  void drm_puts(struct drm_printer *p, const char *str);
> >  void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset);
> > +void drm_print_bits(struct drm_printer *p,
> > +		    unsigned long value, const char *bits[],
> > +		    unsigned int from, unsigned int to);
> >  
> >  __printf(2, 0)
> >  /**
> > diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> > index ad302d71eeee..dfa27367ebb8 100644
> > --- a/drivers/gpu/drm/drm_print.c
> > +++ b/drivers/gpu/drm/drm_print.c
> > @@ -185,6 +185,39 @@ void drm_printf(struct drm_printer *p, const char *f, ...)
> >  }
> >  EXPORT_SYMBOL(drm_printf);
> >  
> > +/**
> > + * drm_print_bits - print bits to a &drm_printer stream
> > + *
> > + * Print bits (in flag fields for example) in human readable form.
> > + * The first name in the @bits array is for the bit indexed by @from.
> > + *
> > + * @p: the &drm_printer
> > + * @value: field value.
> > + * @bits: Array with bit names.
> > + * @from: start of bit range to print (inclusive).
> > + * @to: end of bit range to print (exclusive).

Just an aside: At least in drm we generally but the parameter docs above
the free-flow text.
-Daniel
> > + */
> > +void drm_print_bits(struct drm_printer *p,
> > +		    unsigned long value, const char *bits[],
> > +		    unsigned int from, unsigned int to)
> > +{
> > +	bool first = true;
> > +	unsigned int i;
> > +
> > +	for (i = from; i < to; i++) {
> > +		if (!(value & (1 << i)))
> > +			continue;
> > +		if (WARN_ON_ONCE(!bits[i-from]))
> > +			continue;
> > +		drm_printf(p, "%s%s", first ? "" : ",",
> > +			   bits[i-from]);
> > +		first = false;
> > +	}
> > +	if (first)
> > +		drm_printf(p, "(none)");
> > +}
> > +EXPORT_SYMBOL(drm_print_bits);
> > +
> >  void drm_dev_printk(const struct device *dev, const char *level,
> >  		    const char *format, ...)
> >  {
> > 
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG Nürnberg)
> 




> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
