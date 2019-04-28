Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B565C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0763220679
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Ja7HFyIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfD1UV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 16:21:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37802 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfD1UVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 16:21:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id h126so6355097lfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WBNRW6rEKvmiV1EHP4AivSlXBQuClRHj0jEwZDFl4eA=;
        b=Ja7HFyIijNv8Osr2VMzaYAAjG9ae2SKwgYHE9E44Qt38mP9ynZXTGq2293v1JqNov5
         LkLgnykgeuwpte+ko5TDsBadpwBWdwXQybhuUQqZGbrrPV9XPKjcxJQ41D5Wczx3pgXc
         UEJamKGc4fZKWWPwRLbTdVH4HwynYkyiCSM5sLdS1swMNm6jtjAVy/r4nYAkMEArug1C
         +evKBRH1Eu2XywmmdukWgjD0mU6PQVBG8g7HCDokd74GJ+kzLZlT1M561p1SL8waxH26
         6zKJy5m12j4Yu+0r9rtucyFyk300GYNCss+vj192jKwqcssltompoo/mclwdo0JOFlSW
         EqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WBNRW6rEKvmiV1EHP4AivSlXBQuClRHj0jEwZDFl4eA=;
        b=lhtlVF7o6VA2y7wyPF1TDUq8zHB/VCPCJ4m/QEnAvpgGSkD86PMI+sqPRpMpnWu+VD
         rTl7YfQ97o+nd4LVuhJVobv7vU2luAv/VE1Ne6m53ulUfdQOBznfxRbcpqMsBBPggGFI
         Qv9/m5nB52QIMN61PnaJQHBmOg1uN6d6Zkkswi+v7sds4tBFp4RporpUy86+Bs2U278C
         alr+aMA0ZArwpZiadtMwekf/+spm+AcAoPkzee7Q4g7BW10Csg3N6kany2/1MAQkUw+p
         z1ZckRbNwsa9JRV+kWBIJu4pii6KUh6lBn+1oIbe64zKrmJcR3oHtcQlz0k9XOX69RUo
         t/sg==
X-Gm-Message-State: APjAAAU22mJNfolF8ZXp+7WeTklKt8Cplx85u+cdftbF74IzhL11/V/C
        Kokzg8wutBeJLNg6UPWOng+1yA==
X-Google-Smtp-Source: APXvYqyJ9GDMPKcRLAnKxSeLPKKbHKPCyvVyPSW2tv7nVDqGJfWBJf6roA2CztD8j9U53sSpJ1/IVA==
X-Received: by 2002:a19:5218:: with SMTP id m24mr27816790lfb.113.1556482912794;
        Sun, 28 Apr 2019 13:21:52 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id x71sm6881484lff.82.2019.04.28.13.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 13:21:51 -0700 (PDT)
Date:   Sun, 28 Apr 2019 13:03:07 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 1/2] ARM: dts: exynos: Second round for v5.2
Message-ID: <20190428200307.hmjavmlbxwlfvfdl@localhost>
References: <20190428144221.11187-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428144221.11187-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 04:42:20PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> On top of previous pull request.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 8cc76b1c75722196fb3d7ffe67cbfeb721a7b0e3:
> 
>   ARM: dts: exynos: Remove console argument from bootargs (2019-04-10 18:13:31 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.2-2
> 
> for you to fetch changes up to b4bcbdee137833aab04942671b48a9a3beb0801b:
> 
>   ARM: dts: s5pv210: Fix camera clock provider on Goni board (2019-04-24 19:55:14 +0200)

Merged, thanks!


-Olof
