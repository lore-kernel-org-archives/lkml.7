Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70287C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F1721855
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="l0/gF9/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfFSNj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:39:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37422 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbfFSNjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:39:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id d11so12167905lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 06:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=poQTjuhtDsupGdVClN0ALov7TDRSULG2jSa2vmjVCU4=;
        b=l0/gF9/OzFgtGmzu7Ddh94ZXY54MyG2jXNCKTSFXAdsBC/fnoN5fG8IjW/eOgNukxP
         Ge373wE/T0YzSFbHLkXp6XkrtHU9mUmwjk7EHw+f2TeVxkgML3d9iDSEvjNajpa+6746
         yQdmuYz36CveVabg5LDbdCLwdMklqodT2SjIvIpGoP+x6PzsZNlG8/lox1bj7i/NL2Ki
         N0gSC8rBoz7T5YInhwaB6YKHfeP5/SMeNjw1NWhrKZXNSem0XOZ/OOLbEFF1/+nnrBFQ
         n3mN0QBoDJo4oGA+e2ID+94wEft9iVNHGoVAxH/PiA6Y39yWM+Mc57ZyDDFsez8ElW+R
         QzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=poQTjuhtDsupGdVClN0ALov7TDRSULG2jSa2vmjVCU4=;
        b=KZFH1SDFwU2fp7nbTeVwEdvYsVsx4Lke7Qhugxf9azi6cuO2/GvSmdYUvGW56IaWf7
         wvyRZ9seNqmmCiDYejmydFBRgB8BznPSgUzN3+GI3oeyraPTJN+b7yvlzZ0tP2oW32Dh
         OA2e/X7lMj+fyutwq4YuJ4FfzVuQSvfPagxDbeJt2rxjtx4k7y6tCDFPqkng/eo5JmRe
         3+SgER9WerXKBU24YvedxwZ2sNIzHfU4zGedrua2x9Yp9w/yyg2UffEidbGqIFacmL8a
         ueUHHdSyX6in1X/fx3qsJrLED1OSpywdy4FbpP0hGfeaRwzU9caNQsdiEA6LO+VUlTr2
         tuJw==
X-Gm-Message-State: APjAAAWWIlR6VEA0OzfAdRBN1iot7gcewr3Pk0R2O0CSBHKV6BO4ppEX
        0bLHyc3jUSr6Qo7dBwEvu5SbhA==
X-Google-Smtp-Source: APXvYqxKjnVwguoOB08XOnRxBMmddtcMtOfbSZXzkSUZWCk4zT6Htfabazmn5u6TTmwmpHl9zyBoRA==
X-Received: by 2002:a19:491d:: with SMTP id w29mr45756307lfa.149.1560951563329;
        Wed, 19 Jun 2019 06:39:23 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id n1sm2648220lfl.77.2019.06.19.06.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 06:39:22 -0700 (PDT)
Date:   Wed, 19 Jun 2019 06:27:50 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: dts: exynos: Pull for v5.3
Message-ID: <20190619132750.crkv5cvdt2w5jt3h@localhost>
References: <20190616175513.3681-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616175513.3681-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 07:55:13PM +0200, Krzysztof Kozlowski wrote:
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.3
> 
> for you to fetch changes up to d2cac68e0d9b038da7207c0b63e1399c4f9f60c4:
> 
>   ARM: dts: exynos: Add ADC node to Exynos5410 and Odroid XU (2019-06-11 20:37:21 +0200)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v5.3
> 
> 1. Fixes for minor warnings.
> 2. Enable ADC on Exynos5410 Odroid XU board.
> 
> ----------------------------------------------------------------
> Krzysztof Kozlowski (3):
>       ARM: dts: exynos: Move CPU OPP tables out of SoC node on Exynos5420
>       ARM: dts: exynos: Raise maximum buck regulator voltages on Arndale Octa
>       ARM: dts: exynos: Add ADC node to Exynos5410 and Odroid XU

Merged, thanks!


-Olof
