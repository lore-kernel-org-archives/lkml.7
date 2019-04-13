Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06287C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79E72084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="gTEcBrVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDMIvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:51:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41780 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfDMIvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:51:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so10993462lja.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ve8OjLojDAr32NCY4CjJx01ZbEgIeFz3+fo38Qj3tXw=;
        b=gTEcBrVKxxTUM+I3AADq6DjewEgGBS4r7XMY4miwxSFgDSy/E0a433DL1UqXOb5cvq
         TMpegwt9mTgfGR10vecX3A6wz76i/GT1D1BI3Fi2T4eQTOj9HVM5hy7NqxlWBBERzFxf
         8Ao7hAXB9VhTWY7jH03MV2O0gjQCrvySuUxHi4alQdXKAu9gUlOYgBGKyn9gdIw4x417
         2+DssRtyukuHQflQmcxgWrdGGlKFxP9CCj0AQyR/gzHRBjuIi+bZlOgihlWacp5r0rdx
         pvW1ILO5cf5IAqldYNrrSc50GWvwAnaK/uonWiz6bPPznJ216PXt/BKjJ2za3k35/T1A
         owzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ve8OjLojDAr32NCY4CjJx01ZbEgIeFz3+fo38Qj3tXw=;
        b=sLoghm77r7TUkYFMcOaEMRuI4vxEQNreAeyObwMYfIy4Rg7CLQFFJowfNdpG/YNJoJ
         8ZYQp1eKCpJFtWD4fDcfhR0zrql0PEYQ5sd7HbwiunsE/TxxfDTBfH6DHLMWStS5r+Jo
         D0cufGzW4oEXY0DL81NQHs+FtqA7EGp1Mgk+eZuMtk/i2dO2KX/R2fXGZ+bZv85iIEmx
         /t9x0y2R/ziCrSn0ETdqx0HmeiJYfl6WRsDwgtyxVRVEpanYAhg9FDlRl4du/jwLVlWr
         xBAGQmGc1co1Bj0yTpaQtkqX0Zj1Kq+oPaEf7GGSx8akPi6d03erWuGG1aijKjydUtZW
         pcAQ==
X-Gm-Message-State: APjAAAUNxKbY2bLS+xNHoMBQJd3Hfp3BOC96gRYLXWnHOIEqagrDp0Y1
        Ek12wEIfv+yWRulGLpLbag5UJw==
X-Google-Smtp-Source: APXvYqyb7er5dlqDQWzKVsqeL+ViwYHI2ySdsps5mJ6INdI9fbnG5vtbtW/fHuIa4m6Pquaeq97J9A==
X-Received: by 2002:a2e:8149:: with SMTP id t9mr34958188ljg.2.1555145513115;
        Sat, 13 Apr 2019 01:51:53 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.85.47])
        by smtp.gmail.com with ESMTPSA id b25sm8632670lje.71.2019.04.13.01.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 01:51:52 -0700 (PDT)
Subject: Re: [PATCH 1/2] mtd: nandsim: Embed struct nand_chip in struct
 nandsim
To:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Cc:     bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org
References: <20190413084052.15416-1-richard@nod.at>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <60d400af-245d-9eb4-c57b-ae5683c98da4@cogentembedded.com>
Date:   Sat, 13 Apr 2019 11:51:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413084052.15416-1-richard@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 13.04.2019 11:40, Richard Weinberger wrote:

> We well need struct nand_controller soon, so more stuff need to

    We will, maybe?

> be parts of struct nandsim.
> While we are here, rename "nand" to "ns" to use the same naming scheme
> everywhere in nandsim.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
[...]

MBR, Sergei
