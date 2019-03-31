Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3A3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 07:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEDE2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 07:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WUU1mm0t";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WUU1mm0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfCaHSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 03:18:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfCaHSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 03:18:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B11516047C; Sun, 31 Mar 2019 07:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554016695;
        bh=PawUewnCTuIxTsnefJvU1dvWYh7+AU9FxMce1Iccj28=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WUU1mm0t7i/I1aQ/QFs16vJnCBiN9+EvzUgb9R7mmne6P6ecOfyrl3Vpf7eewWM3X
         pSWHsqpiEcpGrItVWYVU62d/xR2UV8uwYhk3KbGLVgFb32aYY7udExrr5rQGVDGEUS
         ReHy+R5sMk5ZI/1T0LWFRG5vZZ6uTX14n9Ld306A=
Received: from [10.79.166.22] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B28A602FC;
        Sun, 31 Mar 2019 07:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554016695;
        bh=PawUewnCTuIxTsnefJvU1dvWYh7+AU9FxMce1Iccj28=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WUU1mm0t7i/I1aQ/QFs16vJnCBiN9+EvzUgb9R7mmne6P6ecOfyrl3Vpf7eewWM3X
         pSWHsqpiEcpGrItVWYVU62d/xR2UV8uwYhk3KbGLVgFb32aYY7udExrr5rQGVDGEUS
         ReHy+R5sMk5ZI/1T0LWFRG5vZZ6uTX14n9Ld306A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B28A602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] leds: blinkm: clean up double assignment to
 data->i2c_addr
To:     Colin King <colin.king@canonical.com>,
        Jan-Simon Moeller <jansimon.moeller@gmx.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190330203757.8877-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <29b18466-cfd3-e22b-f17f-18f20b048d13@codeaurora.org>
Date:   Sun, 31 Mar 2019 12:48:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330203757.8877-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/2019 2:07 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently data->i2c_addr is being assigned twice, first with the
> value 0x09 and then immediately afterwards with the value 0x08.
> The first assignment is redundant and can be removed.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/leds/leds-blinkm.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> index 851c1920b63c..11b771fb933b 100644
> --- a/drivers/leds/leds-blinkm.c
> +++ b/drivers/leds/leds-blinkm.c
> @@ -594,7 +594,6 @@ static int blinkm_probe(struct i2c_client *client,
>   		goto exit;
>   	}
>   
> -	data->i2c_addr = 0x09;
>   	data->i2c_addr = 0x08;
>   	/* i2c addr  - use fake addr of 0x08 initially (real is 0x09) */
>   	data->fw_ver = 0xfe;
