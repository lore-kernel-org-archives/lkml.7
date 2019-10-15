Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A785ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1A820650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZIQzB/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbfJOU0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:26:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40204 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbfJOU0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:26:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id v38so19315584edm.7;
        Tue, 15 Oct 2019 13:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dK3t9AxAtDqpmJRfjX81BITOjcQhY9SeVbBfeMuALZ4=;
        b=mZIQzB/PTEGfdZOyUPws2dWuOFpjB3wfSVVLSfgTbo2xLkMfjOTvL1yjasjGVEla6W
         yBCv4O4PayyPJ5o7mwhHBEv96UuapbXXeP69kIm3LjobI6e5uJouQXpe36oK1Mp2ZH7Y
         kyH6Hk7sJKEdZ4SEyMxZw2aDEEVewW5H3RKxMeS4WkdbYJ0zCoZ4xY+/rZeIYVTyU90e
         Mun9bLBYyGXNWA8vr3ZKlRxX3ZJB2YNrQpoxyNFR2eCyggDQ0TZ7MJq2H8AwYE1zxbNL
         FBZcKEwRwq6kR0zoG9pJQ9n7FDWBd+4GOi+yNBVOhy1Krf3K6JlxFR0yeJJseNmlZOV1
         3i/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dK3t9AxAtDqpmJRfjX81BITOjcQhY9SeVbBfeMuALZ4=;
        b=Dkv2dW3nTeW4BfetFiAhbaqJOgZ08cc+0VjS5+c0+SrdkAhhWICoxIaFjaOZV21NuW
         VWd27fe6sufWnlhY0/zrCeos5oaPFvXojXhWLtpxPPM9skepH8SNKcZiP28fOhY3rMDU
         GpPBxWOrxgSkRLT97ATrXAbkFYvvS06Qftp4vKnEoP5X170Glg574fixEIwes7p+/odx
         RdhXsRPphLmvIkQKEDzkUsB0RhMQU3EFVrShz5imZ2p7UswK/2YwgLRYJFAE1dM56o/z
         1j+lA3OLblL9qDF5h11FkFZ+HVBkhCUokgrqBKEn/IBWHDTN2u5P91NzK/Da46PE8juR
         ikFg==
X-Gm-Message-State: APjAAAVSGzxGtqDv+D2SmdkaEI2fuxQs75AAK+TUAkG81HVxx2Y+oCzY
        UCK/aZZc6Oe+y5fHn8y855Eeg5mb
X-Google-Smtp-Source: APXvYqzZfaog4m4XbjIi4VxCNQ4ywbycZoYkr4l2X5kIUkDKB5zTCm1Zz13b3xqBJ1L9KBMrpi+TvA==
X-Received: by 2002:a05:6402:557:: with SMTP id i23mr35269304edx.71.1571171177323;
        Tue, 15 Oct 2019 13:26:17 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a36sm3909355edc.58.2019.10.15.13.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 13:26:16 -0700 (PDT)
Subject: Re: [PATCH 2/2] include: dt-bindings: rockchip: remove RK_FUNC
 defines
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191015191000.2890-1-jbx6244@gmail.com>
 <20191015191000.2890-2-jbx6244@gmail.com> <2236841.lnJlJmhppS@phil>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <29be43a3-516b-ce33-8a19-ffd8202d9c3a@gmail.com>
Date:   Tue, 15 Oct 2019 22:26:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2236841.lnJlJmhppS@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

What's the plan for RK_FUNC_GPIO ? Change all to '0' or keep it?

On 10/15/19 10:10 PM, Heiko Stuebner wrote:
> Hi Johan,
> 
> Am Dienstag, 15. Oktober 2019, 21:10:00 CEST schrieb Johan Jonker:
>> The defines RK_FUNC_1, RK_FUNC_2, RK_FUNC_3 and RK_FUNC_4
>> are no longer used, so remove them to prevent
>> that someone start using them again.
> 
> That won't work. Devicetree provides a slightly flexible promise of
> backwards compatibilty. So a new kernel should still work old devicetrees.
> (not exactly sure if this means dt-binaries and sources or only binaries)
> 
> So while I think RK_FUNC_0-n should not be used anymore, we should
> probably just mark them as "deprecated" in a first step.
> 
> 
> Heiko

