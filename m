Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6F0C352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4D02146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JD7JeQsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfIZUqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:46:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38952 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbfIZUqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:46:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id o10so2171961pgs.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5A93QbhcJ9OxEL8d529nmFDwwgHPcXf7jnflqd7ri+Q=;
        b=JD7JeQsALzOQnI/4qgjCyDszf1kSiggpL1jpjmpP0ZrOIuc+rH3npuK/vS6qQ+APdk
         DOxSlr0vPjLBh+8bgundu2vrbnLYxdK8cJ9A6n+FIHz1xHDLi0z+VJdL82dvLTGdo8zF
         HduM+63/IdGaaCFE3qZPWGsNkoTiLLi6WDvI4TVwW4s2I2xZ5uUu+xDZXrPM1SCBrSno
         243VhgJkvY50yMHStaZPEVf1H+Otom59J+UCdTgAuVfnoDnn2+GtT1dZFqBM3z7sWZnu
         I935JuXgwOAV/a1Cyl2iPYd9RP8KwljZunUy8mZqpja4Q9GsaO0IKxZjvyjVaxIis/71
         qQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5A93QbhcJ9OxEL8d529nmFDwwgHPcXf7jnflqd7ri+Q=;
        b=W4pZn6whi/tw88IatvtSqAjY2C0Tb6DmJQ8BUELYeEfJ4FFd6UQ3eoAffqRX9sFCZT
         eKilO0fnr3x3I1vkg+ZQHjBvmRv5gdHxj1nVNq0qsDeZ+nyhscjZG9r2JtynSgHgWiwH
         xwKazv47Ee0CCmNy66WCkIY/nkh5L8nxEeaZbIT5a1/KtUFLL78c+qoe6kG1MGw79vME
         ciei2n/yqZvvO0dKP1AQhK8QMAfbVRk5TvkQ3Y4QEGnTkXzLwPMVvSd1l7/eGudnkPWQ
         1PDIHmyENbY4bEAtP1hSxys+foIimGwwYYPvLZeUGI6CHtLo1WIJbRk0tDeUoPZiMYwP
         0EJw==
X-Gm-Message-State: APjAAAVpou6vYgOgH/D1fqADhP0N6zJbRTM+OkKcgr4svOlJ6gnQvXND
        xLLOXgWlMyrrRXg/gb/3v8M7qQ==
X-Google-Smtp-Source: APXvYqzG2OOdfG5XCHclCet9YXaUJwXijZtrIpDdndqleeF+PAsM0A80TkkzpTkrpdeInKpWjGPpIg==
X-Received: by 2002:aa7:9a48:: with SMTP id x8mr415038pfj.201.1569530790856;
        Thu, 26 Sep 2019 13:46:30 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 195sm169718pfz.103.2019.09.26.13.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Sep 2019 13:46:30 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, sboyd@kernel.org,
        jbrunet@baylibre.com, mturquette@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH RFC 0/2] clk: meson: g12a: handle clock hw changes while in suspend
In-Reply-To: <20190919102518.25126-1-narmstrong@baylibre.com>
References: <20190919102518.25126-1-narmstrong@baylibre.com>
Date:   Thu, 26 Sep 2019 13:46:29 -0700
Message-ID: <7htv8ykcpm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This serie aime to support when the suspend/resume firmware alters the
> clock tree, leading to an incorrect representation of the clock tree
> after a resume from suspend-to-mem.
>
> For the Amlogic G12A/G12B/SM1 case, the SCPI firmware handling suspend
> alters the CPU clock tree in various ways.
>
> Since we know which part of the tree is possibly altered, we introduce here
> the clk_invalidate_rate() function that will rebuild the tree from the
> hardware registers in case parents and dividers have changed.
>
> Finally we call clk_invalidate_rate() from a new resume callback to refresh
> the CPU clock tree after a resume.
>
> With the clock tree refreshed, CCF can now handle the new clock tree
> configuration and avoid crashing the system on further DVFS set_rates.

For clarification, does this series work without the other proposed
fixes[1]?  or is this dependent on that?

Kevin

[1] https://lore.kernel.org/linux-amlogic/20190919093627.21245-1-narmstrong@baylibre.com/
