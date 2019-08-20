Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B66C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D67822CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GS9g6xF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfHTP6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:58:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37202 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfHTP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:58:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id d16so3125845wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=1/YmrgEPUrwGQtAezrJUQUWG/f9Upi15vWYJgMwCPLc=;
        b=GS9g6xF7veKyWTADssGe9mR5DQi4JssJTUPczrOxNyJ5W3gN8tL1gXdGYtR2dXlUEf
         K78u/+/wLhYnW9UV4Hm0s60p4um2xMVZdJx06VnQEhjXDcA8ZJgdWhX2QQoEeUqvF54y
         tQ/h/5muYtc2+N15fjsXrc05/orwtJV8UL87CxiZ6rra9AYU8U1GjRrOdq8JGPmgKIzM
         HZJPU26BAoPtOz7PKMgXweSVGEBWt2t9f81i1knIv7F4g/V/k2JXm41BPfPJB/OS9Ggl
         Ji2tLzlg5pZ3qHRLQnYG9rvcsNrBs60Z5kQvGMntbxEzU1Qex6bEnPTfHN1rmU8FCvMu
         TjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1/YmrgEPUrwGQtAezrJUQUWG/f9Upi15vWYJgMwCPLc=;
        b=CgHsdITjvyTVuFFdfUssimC7mAuPBU8r27ZycbZfcnPnc/wtahKhUF2lnKObWqVSxB
         p/hqTHFiikKD7CXPMKRm1O23H4o4qnIIIVnpcys+1EUBMSKa/r4NZApia0jlqA/+P3L2
         QVmcw37OdsMyXDaXElU2kHNsKkuJwov/h5msD9l1Okw5/b8GXWVRr1XgXqRK1S1f2IMT
         tdao64aM9h1u2KeODgjyT7k1shnQC/X+3vRtHg0WaCUh7baOljZl+D/v58o8K2uF1cZN
         s+pU/EAdfSqQaeOTiVY7lyywhJnm77cSti817gFgtbRSYaLMNTML5qVA5UpmXqA4g2oZ
         X6hw==
X-Gm-Message-State: APjAAAU1LTP2i8HqXdGkTuS6m/ZT3x8bH0K8kf0lBVdmgjeLR5l8ZVwd
        +++RRmFaUdr0arG+PHE6KXYQTQ==
X-Google-Smtp-Source: APXvYqxDGXqyR8DBgTsZliBd1x78ESd2JtWImg3i35oBoTeWCwNaoZ722f0+PRCBQCmmgg742+NwwQ==
X-Received: by 2002:a1c:6087:: with SMTP id u129mr731005wmb.108.1566316682808;
        Tue, 20 Aug 2019 08:58:02 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r4sm13892535wrq.82.2019.08.20.08.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 08:58:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] reset: meson-audio-arb: add sm1 support
In-Reply-To: <1566315581.3030.18.camel@pengutronix.de>
References: <20190820094625.13455-1-jbrunet@baylibre.com> <20190820094625.13455-3-jbrunet@baylibre.com> <1566315581.3030.18.camel@pengutronix.de>
Date:   Tue, 20 Aug 2019 17:58:01 +0200
Message-ID: <1jlfvnomly.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20 Aug 2019 at 17:39, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Hi Jerome,
>
> thank you for the patch. Just one nitpick and one real issue below:
>
> On Tue, 2019-08-20 at 11:46 +0200, Jerome Brunet wrote:
>> Add the new arb reset lines of the SM1 SoC family
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/reset/reset-meson-audio-arb.c | 28 ++++++++++++++++++++++++---
>>  1 file changed, 25 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
>> index c53a2185a039..72d29dbca45a 100644
>> --- a/drivers/reset/reset-meson-audio-arb.c
>> +++ b/drivers/reset/reset-meson-audio-arb.c
>> @@ -30,6 +30,17 @@ static const unsigned int axg_audio_arb_reset_bits[] = {
>>  	[AXG_ARB_FRDDR_C]	= 6,
>>  };
>>  
>> +static const unsigned int sm1_audio_arb_reset_bits[] = {
>> +	[AXG_ARB_TODDR_A]	= 0,
>> +	[AXG_ARB_TODDR_B]	= 1,
>> +	[AXG_ARB_TODDR_C]	= 2,
>> +	[AXG_ARB_FRDDR_A]	= 4,
>> +	[AXG_ARB_FRDDR_B]	= 5,
>> +	[AXG_ARB_FRDDR_C]	= 6,
>> +	[AXG_ARB_TODDR_D]	= 3,
>> +	[AXG_ARB_FRDDR_D]	= 7,
>> +};
>> +
>>  static int meson_audio_arb_update(struct reset_controller_dev *rcdev,
>>  				  unsigned long id, bool assert)
>>  {
>> @@ -82,8 +93,14 @@ static const struct reset_control_ops meson_audio_arb_rstc_ops = {
>>  };
>>  
>>  static const struct of_device_id meson_audio_arb_of_match[] = {
>> -	{ .compatible = "amlogic,meson-axg-audio-arb", },
>> -	{}
>> +	{
>> +		.compatible = "amlogic,meson-axg-audio-arb",
>> +		.data = axg_audio_arb_reset_bits,
>> +	},
>> +	{
>> +		.compatible = "amlogic,meson-sm1-audio-arb",
>> +		.data = sm1_audio_arb_reset_bits
>> +	}, {}
>
> Only slight preference, I would keep the sentinel on a separate line.
> Your choice.

Agreed.

>
>>  };
>>  MODULE_DEVICE_TABLE(of, meson_audio_arb_of_match);
>>  
>> @@ -104,10 +121,15 @@ static int meson_audio_arb_remove(struct platform_device *pdev)
>>  static int meson_audio_arb_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> +	const unsigned int *data;
>>  	struct meson_audio_arb_data *arb;
>>  	struct resource *res;
>>  	int ret;
>>  
>> +	data = of_device_get_match_data(dev);
>> +	if (!data)
>> +		return -EINVAL;
>> +
>>  	arb = devm_kzalloc(dev, sizeof(*arb), GFP_KERNEL);
>>  	if (!arb)
>>  		return -ENOMEM;
>> @@ -126,7 +148,7 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
>>  		return PTR_ERR(arb->regs);
>>  
>>  	spin_lock_init(&arb->lock);
>> -	arb->reset_bits = axg_audio_arb_reset_bits;
>> +	arb->reset_bits = data;
>>  	arb->rstc.nr_resets = ARRAY_SIZE(axg_audio_arb_reset_bits);
>
> Since SM1 has two more resets, this needs to come from device match data
> as well, or the last two resets will be unusable.

Absolutely. Sorry about that.
We are still a bit early in process of adding the support for this SoC.

I'll wait until I can do more complete tests to send a v2.

>
>>  	arb->rstc.ops = &meson_audio_arb_rstc_ops;
>>  	arb->rstc.of_node = dev->of_node;
>
> regards
> Philipp
