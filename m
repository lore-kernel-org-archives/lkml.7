Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C0BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C042075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ftFJPVEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfKZMIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 07:08:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45909 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfKZMIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:08:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so22070905wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 04:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VQjjqFDsNM/6pE1oM/K01ML2mXuln8XPZDY4RZUivOc=;
        b=ftFJPVEttEP3GedBZ2x5HGNphCA2lsPKmm8UDIb+ofgtvrD6/sjW3i5b9NvBmdc+cl
         Q5yrnsC8K8rc1xA6pkrK2R0gaBfGM69vg1Xm7pCgBwXZntobK3Og7Wit2uTfM13ZwA04
         OQsBfBLFsgI67RfAezmcLQ5hd0LOFzwJtWdFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=VQjjqFDsNM/6pE1oM/K01ML2mXuln8XPZDY4RZUivOc=;
        b=eb1O5e8gspazT9eBHHxI1N4gNyjLRj431D6uwrlFXFK3d4R9P7/f9Jk0+U+lXfc1hy
         bhlSk9Q2uDiq7otMEvQO1LPMOEN24Zm1lVDkLvVnq1M6nABGiZMerFeV0G5tJtdEIx2l
         9la9zvetzWBIbvTLlpITiV+rJTS04DQblBhI053HQWJ+j+fDWZIDKJlmlIDOFSxhJxCg
         24xK8JhG6i04fYm3+6FMwmIqGaLW3xwAe+/U5Dlcw0hkp8XsLC/js0Nyg3d0QqKlSshM
         74vbW5cMwtQGMyAnvF4/RPrrXxFBemxAuYkAHvgkdRpJ6xDdErif0RHtz+horvpO2xBR
         NJBA==
X-Gm-Message-State: APjAAAVledWr+IkM6BLF/YZU1Vsb1E5FW7wtQTjfiVOrOWyVh9IYRz0t
        qf+UqNJEoIq2xpmLEt21WV+ntQ==
X-Google-Smtp-Source: APXvYqyCVzH+f7yqTMpfD8vYQ/DrJUuOIE2WH3AwCdN2GqBS6WDrLDj1/zSPULNRsndeZMxFounfcA==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr38041522wrv.119.1574770088328;
        Tue, 26 Nov 2019 04:08:08 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id k1sm15080399wrp.29.2019.11.26.04.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 04:08:07 -0800 (PST)
Date:   Tue, 26 Nov 2019 13:08:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
Subject: Re: [PATCH v1 2/2] drm/komeda: Refactor sysfs node "config_id"
Message-ID: <20191126120805.GU29965@phenom.ffwll.local>
Mail-Followup-To: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
References: <20191126105412.5978-1-james.qian.wang@arm.com>
 <20191126105412.5978-3-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126105412.5978-3-james.qian.wang@arm.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 10:54:47AM +0000, james qian wang (Arm Technology China) wrote:
> From: "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>
> 
> Split sysfs config_id bitfiles to multiple separated sysfs files.
> 
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>

I guess Dave&my questions werent quite clear, this looks like uapi that's
consumed by hwc, so the userspace needs to be open source. Plus it needs
to be discussed/reviewed like any other kms uapi extensions, with a
critical eye whether this makes sense to add to a supposedly cross-vendor
interface.

I suspect the right thing to do here is to push the revert. From a quick
look at git history this landed together with the other kms properties in
komeda which we reverted already.
-Daniel

> ---
>  .../drm/arm/display/include/malidp_product.h  | 13 ---
>  .../gpu/drm/arm/display/komeda/komeda_sysfs.c | 80 ++++++++++++++-----
>  2 files changed, 62 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers/gpu/drm/arm/display/include/malidp_product.h
> index dbd3d4765065..b21f4aa15c95 100644
> --- a/drivers/gpu/drm/arm/display/include/malidp_product.h
> +++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
> @@ -21,17 +21,4 @@
>  #define MALIDP_D71_PRODUCT_ID	0x0071
>  #define MALIDP_D32_PRODUCT_ID	0x0032
>  
> -union komeda_config_id {
> -	struct {
> -		__u32	max_line_sz:16,
> -			n_pipelines:2,
> -			n_scalers:2, /* number of scalers per pipeline */
> -			n_layers:3, /* number of layers per pipeline */
> -			n_richs:3, /* number of rich layers per pipeline */
> -			side_by_side:1, /* if HW works on side_by_side mode */
> -			reserved_bits:5;
> -	};
> -	__u32 value;
> -};
> -
>  #endif /* _MALIDP_PRODUCT_H_ */
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_sysfs.c b/drivers/gpu/drm/arm/display/komeda/komeda_sysfs.c
> index 740f095b4ca5..5effab795dc1 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_sysfs.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_sysfs.c
> @@ -18,28 +18,67 @@ core_id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  static DEVICE_ATTR_RO(core_id);
>  
>  static ssize_t
> -config_id_show(struct device *dev, struct device_attribute *attr, char *buf)
> +line_size_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct komeda_dev *mdev = dev_to_mdev(dev);
>  	struct komeda_pipeline *pipe = mdev->pipelines[0];
> -	union komeda_config_id config_id;
> -	int i;
> -
> -	memset(&config_id, 0, sizeof(config_id));
> -
> -	config_id.max_line_sz = pipe->layers[0]->hsize_in.end;
> -	config_id.side_by_side = mdev->side_by_side;
> -	config_id.n_pipelines = mdev->n_pipelines;
> -	config_id.n_scalers = pipe->n_scalers;
> -	config_id.n_layers = pipe->n_layers;
> -	config_id.n_richs = 0;
> -	for (i = 0; i < pipe->n_layers; i++) {
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", pipe->layers[0]->hsize_in.end);
> +}
> +static DEVICE_ATTR_RO(line_size);
> +
> +static ssize_t
> +n_pipelines_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct komeda_dev *mdev = dev_to_mdev(dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", mdev->n_pipelines);
> +}
> +static DEVICE_ATTR_RO(n_pipelines);
> +
> +static ssize_t
> +n_layers_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct komeda_dev *mdev = dev_to_mdev(dev);
> +	struct komeda_pipeline *pipe = mdev->pipelines[0];
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", pipe->n_layers);
> +}
> +static DEVICE_ATTR_RO(n_layers);
> +
> +static ssize_t
> +n_rich_layers_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct komeda_dev *mdev = dev_to_mdev(dev);
> +	struct komeda_pipeline *pipe = mdev->pipelines[0];
> +	int i, n_richs = 0;
> +
> +	for (i = 0; i < pipe->n_layers; i++)
>  		if (pipe->layers[i]->layer_type == KOMEDA_FMT_RICH_LAYER)
> -			config_id.n_richs++;
> -	}
> -	return snprintf(buf, PAGE_SIZE, "0x%08x\n", config_id.value);
> +			n_richs++;
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", n_richs);
> +}
> +static DEVICE_ATTR_RO(n_rich_layers);
> +
> +static ssize_t
> +n_scalers_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct komeda_dev *mdev = dev_to_mdev(dev);
> +	struct komeda_pipeline *pipe = mdev->pipelines[0];
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", pipe->n_scalers);
> +}
> +static DEVICE_ATTR_RO(n_scalers);
> +
> +static ssize_t
> +side_by_side_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct komeda_dev *mdev = dev_to_mdev(dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", mdev->side_by_side);
>  }
> -static DEVICE_ATTR_RO(config_id);
> +static DEVICE_ATTR_RO(side_by_side);
>  
>  static ssize_t
>  aclk_hz_show(struct device *dev, struct device_attribute *attr, char *buf)
> @@ -52,7 +91,12 @@ static DEVICE_ATTR_RO(aclk_hz);
>  
>  static struct attribute *komeda_sysfs_entries[] = {
>  	&dev_attr_core_id.attr,
> -	&dev_attr_config_id.attr,
> +	&dev_attr_line_size.attr,
> +	&dev_attr_n_pipelines.attr,
> +	&dev_attr_n_layers.attr,
> +	&dev_attr_n_rich_layers.attr,
> +	&dev_attr_n_scalers.attr,
> +	&dev_attr_side_by_side.attr,
>  	&dev_attr_aclk_hz.attr,
>  	NULL,
>  };
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
