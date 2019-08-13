Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F81EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF9E206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CXvxBtP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfHMNEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:04:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41554 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfHMNEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:04:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id w5so4012140edl.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BeprlSRyo9i3tCmSN6bMyBMTJqsuh2Pl578/LN6Zv7E=;
        b=CXvxBtP6BpeLUfjSTmWgYakTCBmeUGPojZavzZeBG44qwwncTnPDEeP8UL+7vlsgdr
         KXuvguKssX2tx10gYosyLPDX5D8JnzR+/TaV5WQ8aZd9DtcdU3FYCe/mMLu0aBPlvIXF
         sWnheBW/f0mZSYjdxIPI8uT9DLSrNHMKy/ZgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BeprlSRyo9i3tCmSN6bMyBMTJqsuh2Pl578/LN6Zv7E=;
        b=faTNjcDMaumON2UXxQjg+0gETZl0hclydF97Ix3I8bip4nVOQPkcmojIcI5fO2mKFM
         j7/BTWp+ZFfNGnWS4bx2Mf9VZL33OxM2/0AVOunPlL2Ruq48f0O3MbHqbAFA5ZeVOFmo
         nSRhl7KMbePe6qit9KC6oK+Gb/2jbJBmZDGZZkEcENBTor982DgcFLqpsnKbNS+y9NWT
         EMrnEvE9JVP1fyfji9KQJwA8r2nXrVWub3IC+BTpYT6fWbryVhF/JDRmpVqaxK6EwxDd
         uL0mjTCK5GoIfS1VLIP9/fNAMv1mDIkKDLyNsvN3Wg21jR5sSBmKXZawbnEsES7/hgWy
         DkcA==
X-Gm-Message-State: APjAAAXxTIwP+5GofSswrkfFm4UmyMWEZ5mDubLTUtFTcqRQzSO+qzZD
        tDDiLeYH8PHcddrBzeHGDetVrA==
X-Google-Smtp-Source: APXvYqz7LBTCYHg7cQQTjZ5VNnLXvpeFWAxTBiBBcrQc0PK/POH7ZTNqynUrD+HS6e+r4Jpu65duGA==
X-Received: by 2002:a50:ee89:: with SMTP id f9mr10253355edr.65.1565701459898;
        Tue, 13 Aug 2019 06:04:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j57sm1327262eda.61.2019.08.13.06.04.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 06:04:19 -0700 (PDT)
Date:   Tue, 13 Aug 2019 15:04:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/26] drm/print: Add drm_err_printer()
Message-ID: <20190813130417.GU7444@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20190718014329.8107-1-lyude@redhat.com>
 <20190718014329.8107-5-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718014329.8107-5-lyude@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 09:42:27PM -0400, Lyude Paul wrote:
> A simple convienence function that returns a drm_printer which prints
> using pr_err()
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_print.c |  6 ++++++
>  include/drm/drm_print.h     | 17 +++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index a17c8a14dba4..6112be358769 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -147,6 +147,12 @@ void __drm_printfn_debug(struct drm_printer *p, struct va_format *vaf)
>  }
>  EXPORT_SYMBOL(__drm_printfn_debug);
>  
> +void __drm_printfn_err(struct drm_printer *p, struct va_format *vaf)
> +{
> +	pr_err("%s %pV", p->prefix, vaf);

DRM printing is a huge bikeshad (or tire fire?). We can't call DRM_ERROR,
but for consistency mabye emulate the layout?

Either way: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> +}
> +EXPORT_SYMBOL(__drm_printfn_err);
> +
>  /**
>   * drm_puts - print a const string to a &drm_printer stream
>   * @p: the &drm printer
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index a5d6f2f3e430..112165d3195d 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -83,6 +83,7 @@ void __drm_printfn_seq_file(struct drm_printer *p, struct va_format *vaf);
>  void __drm_puts_seq_file(struct drm_printer *p, const char *str);
>  void __drm_printfn_info(struct drm_printer *p, struct va_format *vaf);
>  void __drm_printfn_debug(struct drm_printer *p, struct va_format *vaf);
> +void __drm_printfn_err(struct drm_printer *p, struct va_format *vaf);
>  
>  __printf(2, 3)
>  void drm_printf(struct drm_printer *p, const char *f, ...);
> @@ -227,6 +228,22 @@ static inline struct drm_printer drm_debug_printer(const char *prefix)
>  	return p;
>  }
>  
> +/**
> + * drm_err_printer - construct a &drm_printer that outputs to pr_err()
> + * @prefix: debug output prefix
> + *
> + * RETURNS:
> + * The &drm_printer object
> + */
> +static inline struct drm_printer drm_err_printer(const char *prefix)
> +{
> +	struct drm_printer p = {
> +		.printfn = __drm_printfn_err,
> +		.prefix = prefix
> +	};
> +	return p;
> +}
> +
>  /*
>   * The following categories are defined:
>   *
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
