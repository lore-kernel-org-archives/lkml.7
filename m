Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080C9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E0021D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/LiJppe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437609AbfJYIwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:52:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40034 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436926AbfJYIwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:52:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so1342795wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=exH7wNrvvCyD2xlKncd5d7scqAdy8JMCpKT6Dj5gCMc=;
        b=P/LiJppexSpoU0kjzgG1KyPIzofv+N8qtq8srko9s77pZexKqCysdXk5Mg0W5PZmog
         eY08xRKGXJ/XNm90rgAupe0G1IgrKwfOHe3Fp5y7rMnVP6ZJLMG0hjKbIuVcHilTRPkZ
         yldxUjE23S3SxDeuZqBuJIMoDCTPV7ZDbFCmgC3vIEGJqdAge1GBJ8+xVZrWVaBPvJid
         ATvZxAcMDt47mFAG/n4ULaAwH3+6akM17+SbZed6kjdRK72F04RT1v/Ir+fr8x5BL+0N
         QaV/JpbzGc+QE40AgPvA4oS0xTJBMLU1tysNciz0ROYnCqRGdr2z+EjCp2+ZpwyyllIi
         w7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=exH7wNrvvCyD2xlKncd5d7scqAdy8JMCpKT6Dj5gCMc=;
        b=LTuvb1g2qQE9rkHtGrq4FvexO2ceqGCme4vzzSQ8mY8bkEZ2hEUzljZm64+okStDo+
         eSGZATPo8n/qIHp7LNOrRQzaFmRyHW9A/+y11oFhCjeVA9EG+hTl9n7MjlC7TVFdebeL
         dlu4FUj0dnh1Q5t4pi8l9XfTydapFV0sZYvXqiFYC7y0ryrZd7gAbyBQzOO2TXO9Xov3
         SToo5BR/J6Gaj6te9jYr+sD+OhIffmgTxmyoBjtLK+Jcado0+zGbs5bxN4XPiPBoJv5i
         BEqxgERVV2O1Gj4nUtl+Glaq+MSLUEgvuwDJyFAMZg/Gp/ieagpJZjJ9dZwMlTb45d8V
         1uUw==
X-Gm-Message-State: APjAAAXUQaLZyRAcuTMX4bHAQjzdM9fdHqjxYci10OLthlU9tTx8ZgVb
        rvsnYGf/UteEl1M+ix/VJY3WCg==
X-Google-Smtp-Source: APXvYqwqeNQ4Rm3LfZvag0FuCF1LHCrER4wDzEhFJR9VIg+vCiqIqlZebROwNpKRP1vRvTHk57W2nQ==
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr1836767wrq.225.1571993541978;
        Fri, 25 Oct 2019 01:52:21 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o4sm1673291wre.91.2019.10.25.01.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 01:52:21 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:52:19 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v3 08/10] mfd: mfd-core: Protect against NULL call-back
 function pointer
Message-ID: <20191025085219.ki5gvqlycncbeztf@holly.lan>
References: <20191024163832.31326-1-lee.jones@linaro.org>
 <20191024163832.31326-9-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024163832.31326-9-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 05:38:30PM +0100, Lee Jones wrote:
> If a child device calls mfd_cell_{en,dis}able() without an appropriate
> call-back being set, we are likely to encounter a panic.  Avoid this
> by adding suitable checking.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Shouldn't this be earlier in the patch set (to avoid transient
regressions)?


Daniel.
