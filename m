Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C215C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1462F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ikWmfACd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfFSRfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:35:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44510 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFSRfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:35:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id r15so230746lfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H6nFYo1W7u7smqgdQOkCZedekCwWjKsij2XVSq9qOaA=;
        b=ikWmfACd18AAbMWou3st+ieXzirNCfV7cxvr3S6mSQEHNTpvibjZ2ttrZkPyoNEHlB
         VAvSkKUkGrCuNRom0GcY3aT8VGdcm1vFGUvSEl7vKZy0JY43rsAjRHo9yMi1K0UBLuM1
         5afeiaai4/dQK3zEU8/ZRQfloIRXnEM3Fqc3KZA86o0Cap7vJ+M2psPr4kUUHW2ckq/N
         tYpchQMigZ4+Hxw33ZG688P6vm2jLmSVh31dcu1j0EnQDO9fxqRPsGe/uWEVkgCLzO4W
         SgcGFYQ6Cuqcc/zR9gG8XBt7PByhD+vhxO5IdppPRDzGE74AaxnqNhtc1s0lj+IJkc/h
         ALEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H6nFYo1W7u7smqgdQOkCZedekCwWjKsij2XVSq9qOaA=;
        b=RcobBZ5ilZhda31tqeOwikdDF4As+7CEHblsPN3STzkOdW3wc9CMv/QgOZztIYKGwq
         HxztOKstHbClt5wcQ9EzDIKnPgAZRqstDUuX0qZu5VhcCgnFWzD4/ZgWwQT9+7l7fLjl
         Jl8q/7vN1oNtQrsk0m9l5JY0vLwo8O4M0zVAhCkqQtO0uhMDUtPIy5IHQFkEQ+Q1A39x
         YTKXzYkOnx0DxfUu+eLxMI/WFuO7nDbHfbGjQy/pl1uYbP5ECiPpO6zw+ez6CuH5r6Lx
         BnBR8aiNTz3VqyWmvWKuzm+92EkGrNBsRzFw552fhqTQ9tP/MbaBHPdkzntaptMbRKQT
         /e5A==
X-Gm-Message-State: APjAAAULIt2koaA0F83iCFYto1OUD1Alj+pAJEzVqryuq8O2RUOENjQg
        yerR0G6nBiEVwhfqlGoZRpLn+g==
X-Google-Smtp-Source: APXvYqySMwzePnkslphTyGRvGZ5fTcPfgrmnaB4ZRrToN2PQZdf6+ZHkDKuTjfE//AzrU7bg4cqIEA==
X-Received: by 2002:a19:710b:: with SMTP id m11mr57184785lfc.135.1560965705098;
        Wed, 19 Jun 2019 10:35:05 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id p76sm2675051ljb.49.2019.06.19.10.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:35:03 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:34:08 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Stefan Agner <stefan@agner.ch>
Cc:     arm@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        ard.biesheuvel@linaro.org, robin.murphy@arm.com, nico@fluxnic.net,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kgene@kernel.org,
        krzk@kernel.org, robh@kernel.org, ssantosh@kernel.org,
        jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, tony@atomide.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ARM: OMAP2: drop explicit assembler architecture
Message-ID: <20190619173408.wse4xgmuzv6hcvsp@localhost>
References: <c0ca465daa7c7663c19b0bcb848c70e8da22baff.1558996564.git.stefan@agner.ch>
 <5ead0fe96f7e5729e4a82f432022b16cb84458a6.1558996564.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ead0fe96f7e5729e4a82f432022b16cb84458a6.1558996564.git.stefan@agner.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 12:40:51AM +0200, Stefan Agner wrote:
> OMAP2 depends on ARCH_MULTI_V6, which makes sure that the kernel is
> compiled with -march=armv6. The compiler frontend will pass the
> architecture to the assembler. There is no explicit architecture
> specification necessary.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
> Changes since v2:
> - New patch
> 
> Changes since v3:
> - Rebase on top of v5.2-rc2

Applied to arm/soc. Thanks!


-Olof
