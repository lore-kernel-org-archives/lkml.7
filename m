Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07E3C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FBA20828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="aGdC8bNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfLIRZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:25:07 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41250 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLIRZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:25:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so11335908lfp.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 09:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W/QJ5ovOHc4Q7NQmlc4wzHJJBcoki7MUH+1DSWQU63c=;
        b=aGdC8bNygzNmZFS0MkVcG2q9mU+4yfymSLwjdyJeEUTueWhiPaGoDF5Y1v/1Y4jIEH
         8uRPyaxH8jivAGk7bbXj4AIRWX4diMdaWsR8tBFN/PMQpb2mb0Cig1zilqi5oC954XBF
         3aR9u8nHb6JjUYcADRDRXWnSDftlrXlAxqakCS9APSTFQWg25V/4XoOM0IiwOEtbHUP3
         z+JudUVWroFoquKrqjFVQbmcfHmZmEZCzHmPmbrmAMxLY9FfJj/NOEuKblh01UaESTmT
         Q30cxYQKK5+0kEByO4m7Zr0Ir6+DFWCoeZjm89KTlZPR1g60o61Juqm/W6UQCcBi3SD3
         fc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W/QJ5ovOHc4Q7NQmlc4wzHJJBcoki7MUH+1DSWQU63c=;
        b=dauX+yzxqbieJSa5QwQuPtYtfMYGZACHh/JSiq/R0RLTznDHbBHBRL+JFUqDSXZbw6
         LL+aqvJYj6YIqRPTfAswag4cbfQv8uEtiaTIivvDeJ2rJiqR5fG3JBFThP8nG4+HPS6a
         fLPHVG4f5tji8eXhsPDVP1uheJ1iof+ONV5isQ0bcAjXb8KP+xOBbRrw99wdKxOdMWGK
         RhZwt7rVaa0KHrFeN7YQ+il1XNuYCZD0/QxhpE5J9w/R/wqFaWrElmHqsNbDpEbkOsMl
         BOTrifkRH+IS+ttkzqOSYxwA2YFsK2o8kussGgKsWrAN2n8uutcLI5YAcVmZJLoLBxRT
         r/Lg==
X-Gm-Message-State: APjAAAU9JDqcByS5IE1nLxRRIpwqBFuv5sqwvC7eyy3AVn7lMtrj9ttp
        Glpz5TzpjuAiy41SOgk4zioO6w==
X-Google-Smtp-Source: APXvYqwdi5x5du1IVH+xwVTC4as4D6VV+lXmBmm1HEyRlHBFA1Xo9c3Y0t/S5G4V/y8rSQcrNmA2OA==
X-Received: by 2002:ac2:44ce:: with SMTP id d14mr11736754lfm.140.1575912304733;
        Mon, 09 Dec 2019 09:25:04 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id h14sm45462lfc.2.2019.12.09.09.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 09:25:03 -0800 (PST)
Date:   Mon, 9 Dec 2019 09:22:28 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org, soc@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: dts: exynos: Second pull for v5.5
Message-ID: <20191209172228.sdhzd52u7jbfmas6@localhost>
References: <20191119142026.7190-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119142026.7190-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 03:20:26PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> On top of previous pull request - minor updates for next cycle.

Hi,

Given that this was new features, and it came in late, I didn't merge it in
before the window opened. I have however staged it into arm/dt for 5.6 now.


Thanks,

-Olof
