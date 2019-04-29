Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0077AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A102087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="LUbBeObv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfD2GzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:55:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45833 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfD2GzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:55:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id m18so3679147lje.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z8D8MI3gegViugIwpZ2280JffkSqWg4ZFxzK/9RxXBo=;
        b=LUbBeObv/gR4XZfXo7oDu/YHe62TWZjhYvw4+JtLknzqp2Lp8hRkwlrRsrhl7Sl1C/
         q2RDtVC14PQvbgr5MBU56llQED/puyU0vk8UPj58UHtIuwGdkA7TUhIptVv4qZz8S0Pl
         Nl2D5I+nmEdXNhleozyao19ZDG4Lj9x7T1UTKK38d3kxAk+3xgQjP+MSiQUHyx1STE7X
         hZuGjAEd5UQenzMBve5zZbPdf8KldseCYP1ojLUexW+6JGKazgTLbD2hNWaBpxOo2bK6
         CM6qPU3HIAWihf7fQxKGPC5kmgfYMGJG8EG2y2rozPNAWijgrVZ5e8RHRlD2SZDnUe2S
         352g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z8D8MI3gegViugIwpZ2280JffkSqWg4ZFxzK/9RxXBo=;
        b=tBkY7vvsLJbptq/mqsWdJ5i8fwtCQa9spzb37bG24T87yyfo2nihTbkU95GqpMjmKF
         GzdhaYrWeyaiOMdJbrk46U3bR6AigEYKY7uy08KgKL2MdP1zNn96fv3+/YIiiWS/snI5
         20UiyhXuaRCDuldveJa+VCod9moufpKZsa5+JKNwjDe8enp8yOfx7BR8jfYJqf7sL95h
         UJ3XsOyW0rhfX+UYwS7msCH1U7BkP1LP+LEgOnzLjpviYehUIcJcaItz9qQiDW3HVQ8x
         Lc/LRDfhFRlWR3G8nRcmAtocPL2Jz6wQX4Y31nanwOwGbycwx0dIzmkZ+mzxKEzPD/Qm
         1gDg==
X-Gm-Message-State: APjAAAUtjXPRQWgyErrJFt3hu1kqSmsBr1/piIPIsE9X4HGxtyejVfiv
        Wqz7VJb5auryKfcg9/9oG1lmbA==
X-Google-Smtp-Source: APXvYqzYDLI6ZocQr+ZHvYXqPxeBPieMJMXCwRHAFBSqi0F7nqaoFBfUepWKJs6MF7wntspUgF7n9A==
X-Received: by 2002:a2e:99d2:: with SMTP id l18mr17299658ljj.27.1556520922194;
        Sun, 28 Apr 2019 23:55:22 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id k4sm3609685lja.18.2019.04.28.23.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 23:55:20 -0700 (PDT)
Date:   Sun, 28 Apr 2019 23:05:22 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 3/3] ARM: samsung: Changes for v5.2
Message-ID: <20190429060522.ijfpvz3c2bxa5xwi@localhost>
References: <20190414154805.10188-1-krzk@kernel.org>
 <20190414154805.10188-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414154805.10188-3-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 05:48:05PM +0200, Krzysztof Kozlowski wrote:
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.2
> 
> for you to fetch changes up to 7676e667c841375b41d9438b559756141aa93d0e:
> 
>   ARM: s3c64xx: Tidy up handling of regulator GPIO lookups (2019-04-14 12:53:03 +0200)
> 
> ----------------------------------------------------------------
> Samsung mach/soc changes for v5.2
> 
> 1. Cleanup in mach code.
> 2. Add necessary fixes for Suspend to RAM on Exynos5422 boards (tested
>    with Odroid XU3/XU4/HC1 family).  Finally this brings a working S2R
>    on these Odroid boards (still other drivers might have some issues
>    but mach code seems to be finished).
> 3. Require MCPM for Exynos542x boards because otherwise not all of cores
>    will come online.
> 4. GPIO regulator cleanup on S3C6410 Craig.

Merged, thanks.


-Olof
