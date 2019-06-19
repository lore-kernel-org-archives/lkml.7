Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3B2C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F8C21881
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="qDPrAoze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfFSPGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:06:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34473 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfFSPGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:06:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so1351470ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ibyG5bX60xLf/QgXN/rIQ6uHQgmGprxM+/cTln4vbLM=;
        b=qDPrAoze7yjN7tb9Vzm/Frb+wUNsibV8JByFDq/HfnkJ313bNTu9K0tCuaraybSodO
         EVyUOlXDkJ6lMzD+veBxVb/0OtyU9/CnYBSiIOapR9jEx6Wf2YKa9Rct92jeqfXRcu2q
         L1HJ1/Dyncr2bY3oMZVampivb+jVz8rGNOYASawBtnK5/7Ph4yRQaULqMekzN4KRQv/4
         8Xsw2E1IZKD9L/XATSVcf2mLEtd5iM0dKlP85fjsBZ3FTSffksy0XnGLaJiteql6S0ft
         MIXGu0MBPcPmZVda3Iam8h1yWwPEKVSeLSDjiMhAGYnW8K0VvH8zqXN+2SsgHvOMJNsh
         am1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ibyG5bX60xLf/QgXN/rIQ6uHQgmGprxM+/cTln4vbLM=;
        b=KdyH9I6JKHT5DEjU11EP34M0jTKgMLZ87y/HWeZg7GKu52lkMmlPh9tYBUt+GCNR6M
         yPTCzBV3t2tyh0Q6vgbJ2TGm4h4OLQ4ARpa+295CN+78v5m7qH/oNSCfYI7EwUZESy/U
         m/dEY+5u8KJpdVpPw74DUdEHra5oVImMUshbymSDLm9WynEYGLYnCBHe6+X4lDZg9twi
         Hq2fy/zy+7E/NqUtJuG18vQBq9FDyJxiTmDEOgKnfnx45vrEU1r0aZxgqcM8KaXPnym9
         jE0POwz6yK3TNN2dIIWjkptxnUKU9xJOGY12pCp5SGtwfprW/H9/dCxCZh2NF/V3QJZU
         iJOw==
X-Gm-Message-State: APjAAAUirVKP2Q+s+1CFxNyldf9CapiI7XIKt0dETOq2bdocgFNlh8wx
        mkNAPizQg94uMa8W7FO1NDU9Rw==
X-Google-Smtp-Source: APXvYqzJDv99mVWs86VvqX5o/RwXHyWCNeveKdAKlLtCN4h/+JqnERmwmNhgra9lNpm/APw4dXZdNA==
X-Received: by 2002:a2e:8007:: with SMTP id j7mr21387070ljg.191.1560956759016;
        Wed, 19 Jun 2019 08:05:59 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id r84sm3467491lja.54.2019.06.19.08.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 08:05:57 -0700 (PDT)
Date:   Wed, 19 Jun 2019 07:11:01 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-kernel@vger.kernel.org, arm@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        Yannick =?iso-8859-1?Q?Fertr=E9?= <yannick.fertre@st.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: add Panfrost driver
Message-ID: <20190619141101.lfkj62regpbt7dlp@localhost>
References: <20190604112003.31813-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604112003.31813-1-tomeu.vizoso@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:20:01PM +0200, Tomeu Vizoso wrote:
> With the goal of making it easier for CI services such as KernelCI to
> run tests for it.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks!


-Olof
