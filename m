Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F579C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EAA215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570106952;
	bh=3I16dtKMV/ywKVSjTPwklsWAsz9K/b2UODMZF56SWZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UW1V3w/5RjRGkwO/2YOM9EVepB6jxZadHVRoM6iaVGtTFxSf/qosy7B+wYgPMvCxU
	 dtAadb8Lp/OVp4yQUAWbK48gPeHHWrKI/p96nx4mSaAVMvdv3pM4uQAQ906BLeDVj1
	 d2kmaS4pVpARb9PAi2nkQURO5ctq6uZ+R1D/l+74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfJCMtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:49:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfJCMtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+3A0RVi/eynu6cHrvlnzbDBBXa/7l6DXVZbYu9LkAQI=; b=ShUzobsjuDPIifsb0K9SQmZn+
        xIPryyo6TVO6d1PgEwfo+n3ogNYeXAgoDzeZ8GfSlXO3aPywkEawRyvTYsSltg99TmrfQJA2UAu6F
        vxhThdlNmA4rZ8miSRAHF2nIORFM8zR4e2/zDi9+qLYfhfKkBMGmIyhGO8EOEWV4+WUuUQSYAK83H
        zjIOWM8DCFDL6VA6168FgeyFCbcOfowWCdJTVxImlPiT5Qldw6MTmA06NPS+zkR1RyhuXt4LkRjZs
        KCJKIVZ03hyt/DQ8KQ478mGhEQ5DEnKs7amDKXT44eaXW6mY9qu0ulY343nrU9whomtFEar/3kW8I
        klGGE4xMA==;
Received: from 177.133.68.49.dynamic.adsl.gvt.net.br ([177.133.68.49] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iG0Xd-0003Rg-8Z; Thu, 03 Oct 2019 12:49:09 +0000
Date:   Thu, 3 Oct 2019 09:49:04 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Gonsolo <gonsolo@gmail.com>
Cc:     JP <jp@jpvw.nl>, crope@iki.fi, Sean Young <sean@mess.org>,
        linux-media@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] si2157: Add support for Logilink VG0022A.
Message-ID: <20191003094904.3aa5fdc7@coco.lan>
In-Reply-To: <CANL0fFTtHn4ocL4BD4cVKhVzjLhnQ0a45yq5x4MxWAVu-tD8sw@mail.gmail.com>
References: <20191001205203.4b1a5fb6@coco.lan>
        <20191002141359.30166-1-gonsolo@gmail.com>
        <20191002141359.30166-2-gonsolo@gmail.com>
        <20191002142744.GA3475@gofer.mess.org>
        <CANL0fFS9TGKJH2rfkXzak78BaLazTNO7GoZhSb4vLBsDrmz3FQ@mail.gmail.com>
        <20191002150650.GA4227@gofer.mess.org>
        <CANL0fFRoL6NxOCbNC=XjQ6LDkeeqAayaLUbm9xARWX9ttqfPFg@mail.gmail.com>
        <29ab2e43-4374-a3ea-6ae1-a4267867eaa4@jpvw.nl>
        <20191002154922.7f1cfc76@coco.lan>
        <CANL0fFRJZBfEDWK_c2w1TomvB5-i4g09LopyJUbO5NtOwKdDTg@mail.gmail.com>
        <CANL0fFTwJ4yRO+5q6WkL0+DtwdrRti6r_WY1intisYJhs5En8w@mail.gmail.com>
        <20191003081742.0933264b@coco.lan>
        <CANL0fFTtHn4ocL4BD4cVKhVzjLhnQ0a45yq5x4MxWAVu-tD8sw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 3 Oct 2019 13:41:23 +0200
Gonsolo <gonsolo@gmail.com> escreveu:

> Hi!
> 
> > It means that there's a firmware stored at the device's eeprom
> > (version 4.0.2). When the driver starts, it downloads a newer firmware
> > from the file dvb-demod-si2168-b40-01.fw.  
> 
> Thanks for the explanation.
> 
> > Btw, could you please try the enclosed hack and post the results?  
> 
> Will do in a second.
> 
> FWIW, this hack worked:
> 
> diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
> index e87040d6eca7..28a3a4f1640e 100644
> --- a/drivers/media/tuners/si2157.c
> +++ b/drivers/media/tuners/si2157.c
> @@ -136,6 +136,7 @@ static int si2157_init(struct dvb_frontend *fe)
>         #define SI2147_A30 ('A' << 24 | 47 << 16 | '3' << 8 | '0' << 0)
>         #define SI2146_A10 ('A' << 24 | 46 << 16 | '1' << 8 | '0' << 0)
>         #define SI2141_A10 ('A' << 24 | 41 << 16 | '1' << 8 | '0' << 0)
> +       #define GONZO     (255 << 24 | 255 << 16 | 255 << 8 | 255 << 0)
> 
>         switch (chip_id) {
>         case SI2158_A20:
> @@ -148,6 +149,10 @@ static int si2157_init(struct dvb_frontend *fe)
>         case SI2177_A30:
>                 fw_name = SI2157_A30_FIRMWARE;
>                 break;
> +       case GONZO:
> +               dev_info(&client->dev, "trying null\n");
> +               fw_name = NULL;
> +               break;
>         case SI2157_A30:
>         case SI2147_A30:
>         case SI2146_A10:

What does it print with this hack?

Also, could you get the SI version after the reset code at
skip_fw_download, just after retrieving si2157 firmware version?

Thanks,
Mauro
