Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB093C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C2E21881
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="uxSUY3Zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfFSPGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:06:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40112 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730052AbfFSPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:06:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so12402791lff.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qo3e63HL3BzDtfqkQiaY62IQlXV/H1BFP1jalf87HMc=;
        b=uxSUY3ZxDLYKi6tP3oJ+OgL02Da5xhLsw2kgcnf8dWSKkxZx49Yn1Rf2dhRqASNOR/
         uyih413YiGOdufoC2Snp1BzgYJC7TdUj02oLV4BzEw0y0Eqp8FHEJwShX4bIIR46JIGY
         e28m8kq6Bl4T6bkFAW0JExXNp4chY1fjQG+WkQc3TekfEdcDkJoVxe9T01/Yx2RHNolX
         u4BEJARBt+s9uJLbn3LzlBSwkWaaiLSonuChC6KyJDxUz79E5vJ1FPIk7jYsRIM2E8d5
         /yWbFFNvtSTqaW1eELAl9/WAgUqgbHmU56MWfH0+/mFNHV15iBrJhe1ME2/XCjKbefMx
         YL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qo3e63HL3BzDtfqkQiaY62IQlXV/H1BFP1jalf87HMc=;
        b=I1YEyAT2gzczSmMClPLnGvr9+BeInqCCpk+Oh9w32/qEbTXDTsA+2ZLZLsNdp1yOxl
         zqbuV7SyTfagRL7VecrRukphxMAez1iFQcFrigQoqGW+gLwsG0VuEXj/hGbM3Df47dO3
         NTpG6dQuc7gtIoGfS374d0KMYzepj6ZodOEidQ1xfomRz5DHA/mqeCMzjTaBJiupfAiS
         /DOzep2s79jV/hrKB24iVajV1EV6VzP7Sal7JuOEvfSkNWX+k+Shz+QierqE2IsjZhnA
         aRfDJZJ9O61ZvBNOJFNzVCoXFEUrzlGDT9qadYQvASiu9quVbJJfo1hq7IIT9DdzX85Y
         EgVA==
X-Gm-Message-State: APjAAAXZSvdsgk9XA6JQcUs6Bz0pW2QjcsnGx8xQdxspiSzqGW0MqF4m
        DPuTz9DL2I+ShFyZfnX88Z52qQ==
X-Google-Smtp-Source: APXvYqx2OQTjYY91I+p4ttJwT1ZdJWsfYL5Dxi2KwgLxgOydHZgkuJM1ooIblOIa8NRl8LMbuo6YMA==
X-Received: by 2002:ac2:494f:: with SMTP id o15mr33066277lfi.84.1560956760977;
        Wed, 19 Jun 2019 08:06:00 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id g14sm3001223lja.23.2019.06.19.08.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 08:06:00 -0700 (PDT)
Date:   Wed, 19 Jun 2019 07:11:12 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-kernel@vger.kernel.org, arm@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] arm64: defconfig: add Panfrost driver
Message-ID: <20190619141112.lvw2ibyrqr53livv@localhost>
References: <20190604112003.31813-1-tomeu.vizoso@collabora.com>
 <20190604112003.31813-2-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604112003.31813-2-tomeu.vizoso@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:20:02PM +0200, Tomeu Vizoso wrote:
> With the goal of making it easier for CI services such as KernelCI to
> run tests for it.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Applied, thanks!


-Olof
