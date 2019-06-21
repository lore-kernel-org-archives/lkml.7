Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C98C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9DB20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561140769;
	bh=2R3oUQcJMMZmCh0PNjkySpJmH/XshwWM5185+M83vcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lDM72d7AC4TheuvXj//Zcvwjdw+y8rpOYVbfYi5+VLPk2Bt4U50MhIbjgjlEjukA4
	 +zWadwaqBDPCmpxBniqQGoh9x1tfO/W1AYoECmyAVGXuJG70knvmhtMntFIOrXXkEQ
	 YS6gp6Be7X1q9isQBz6umlbdiX3oxLJ4nYob+gvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfFUSMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:12:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50750 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfFUSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:12:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so7148008wmf.0;
        Fri, 21 Jun 2019 11:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K8ZqNlSRzlw+iByGaPZNdN2szcR/O2ehXG6DihUgi5k=;
        b=drmGJzhuScrC+d+ESdKGFkTiWyPI+iYoi3r8jzPdAp1kp67l5PNG5LvWNIBaa0Oa0b
         SFxv6Rj81jbfZy2Vr1MlW35NMfac8g3a0H5/YyPl4FIVQgA4Uo6v4kUGvx1On//+oVVN
         TeEj9dUfCyepxs1U2aqBy88CI5KIsRV5z0b49U9r3ezYjMS9oU3PqLbamo1GooqIdAII
         orzSSxXBRoHjUCcsQCcW23W+VpnKBSn1gdMGJEGkoZfkYEuJObey5gWlZXNQ9iVFiSJM
         HJgr06ZO/CeF5iJme9o2O/nrEMqXv6LWkL+75Uk1U/XIG6pd9V4AiWAmb1m4CBWI7yqK
         k2ZA==
X-Gm-Message-State: APjAAAWjadfnwrw4p8EEbjh2W7GAPLWJsJF5wLmyUjqiqCIMjw5v8gjg
        xVtCeVWfvcf0mJJbE+9wwIuNov+5
X-Google-Smtp-Source: APXvYqxxO+HkCjrMZC9y5KfK+BU2nNihU5fwC/SA7zEcs/MVwbeu/GDip2tz7utkxVE97ewJTt8utg==
X-Received: by 2002:a1c:1947:: with SMTP id 68mr4932544wmz.171.1561140765354;
        Fri, 21 Jun 2019 11:12:45 -0700 (PDT)
Received: from kozik-lap ([194.230.155.186])
        by smtp.googlemail.com with ESMTPSA id h90sm4746092wrh.15.2019.06.21.11.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 11:12:44 -0700 (PDT)
Date:   Fri, 21 Jun 2019 20:12:42 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: exynos: only build mcpm support if used
Message-ID: <20190621181242.GA18341@kozik-lap>
References: <20190619125545.1087023-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190619125545.1087023-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 02:55:29PM +0200, Arnd Bergmann wrote:
> We get a link error for configurations that enable an exynos
> SoC that does not require mcpm, but then manually enable
> mcpm anyway wihtout also turning on the arm-cci:
> 
> arch/arm/mach-exynos/mcpm-exynos.o: In function `exynos_pm_power_up_setup':
> mcpm-exynos.c:(.text+0x8): undefined reference to `cci_enable_port_for_self'
> 
> Change it back to only build the code we actually need, by
> introducing a CONFIG_EXYNOS_MCPM that serves the same purpose
> as the older CONFIG_EXYNOS5420_MCPM.
> 
> Fixes: 2997520c2d4e ("ARM: exynos: Set MCPM as mandatory for Exynos542x/5800 SoCs")

Thanks, applied.

Best regards,
Krzysztof

