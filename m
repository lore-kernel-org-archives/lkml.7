Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFE1C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC07321907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="JLYIJh7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403873AbfISPIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:08:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35774 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388808AbfISPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:08:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id m7so3988327lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bRiBZLWOEHbZzElzw6qYdz9cEfrj56jePR8fFrLJB6Q=;
        b=JLYIJh7UlR3hPvwmVneFgqbEqVHl3GPDE4Vc3SIHWnj9E9cQIqKU7szXckxtR23sN3
         oTuVimlSKjgMuZEFNXkZuVDJVntY8q41D8yhkSP1/uZ3tu+1sf66QXLA6bfL5z0gRkbx
         +Qxv4PduCuVdsA6Ci9kdkEixWeLqO8BT13SggpjvDkwm5PgSR3ja6rHxiFfSCo+aN7m2
         Y4ixYplF9xezHbCdsePOT5gq40iCvDhU+0JE9xg6W8p1UDID8do6oPtwv0c5LRgeuyqA
         b8Y6dzE97J3nNW7oBIAle0WNL3dUGgnS4ZGbpNmalc8hAy4grTbAiAdF64y+gkNtQTgz
         umXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bRiBZLWOEHbZzElzw6qYdz9cEfrj56jePR8fFrLJB6Q=;
        b=VUt3iQI884MHoOo/ERcv/S85+CJX9rcjP+nGPgQA5/znVNxiIBxVUZy39SGfUmOftc
         OSWsJSqAnZx90wRj/gy11b4SEnfLAYbtDt/m92j4GUagXb1en88avt3to6Gj1C3RyDnK
         jiAub7JUiqhtpLZBaS7yeuO6iJQ9i7+hQikfTnqKPpPfPLcDYeBuxPVVFYnaZkUY1Jot
         s7yOG5MYY4nQCZdfRCDeGPmZTYiobY6FDK5L419vCkn+K6p2TsLISKm/9bFD6bWxgeVu
         gWLhDh4xXAU057q2CSy7AdMBlo66ZZTShAIIiFmvll8XyowSmwZydDFZCJ5X5DZB9ntF
         WeuA==
X-Gm-Message-State: APjAAAXYE5xyOuzlgW5dZusmITtif+WrQq9/VmWo+WXf+OS0QdG8FEBP
        XUOCGD74deKfNpFU1OPFbe9aVmjPjMbh9g==
X-Google-Smtp-Source: APXvYqxZR0gHbcpd6pV7XpkEj1tjQ3U/96VZ+XgTMaXBqjUvXXsnTnVXeCYzl/257fe3o9eXJFj40Q==
X-Received: by 2002:a05:651c:20a:: with SMTP id y10mr4731466ljn.163.1568905690384;
        Thu, 19 Sep 2019 08:08:10 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:42ab:49bb:193e:bfb0:9713:18c9])
        by smtp.gmail.com with ESMTPSA id 77sm1697616ljj.84.2019.09.19.08.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 08:08:09 -0700 (PDT)
Subject: Re: [PATCH] mtd: st_spi_fsm: remove unused variable
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190919122937.29850-1-brgl@bgdev.pl>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <e062df64-1e13-f88d-5bef-cbc3a1a7fdf0@cogentembedded.com>
Date:   Thu, 19 Sep 2019 18:08:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190919122937.29850-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 09/19/2019 03:29 PM, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The region resource in struct stfsm is unused and can be removed.

   OK, except it's not a variable (as the subject says), it's a structure field.
"region resource" also seems strange...

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/mtd/devices/st_spi_fsm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
> index f4d1667daaf9..1888523d9745 100644
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -255,7 +255,6 @@ struct stfsm_seq {
>  struct stfsm {
>  	struct device		*dev;
>  	void __iomem		*base;
> -	struct resource		*region;
>  	struct mtd_info		mtd;
>  	struct mutex		lock;
>  	struct flash_info       *info;

MBR, Sergei
