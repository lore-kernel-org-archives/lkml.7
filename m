Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA17C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EC52182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AE+GfRAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfEJVqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 17:46:51 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:44569 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbfEJVqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 17:46:50 -0400
Received: by mail-pg1-f177.google.com with SMTP id z16so3595081pgv.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Zc0GHzZNo+25JcRNut2Uq1tt6Pzoax4+5TEhbqXwV8o=;
        b=AE+GfRAlBDdQ6pq/jCuAIl+qbEmIGqBjK9ZUuOAI75sqs2d0/H8sgwHsEAUke4hmDO
         lpwGG9ImoARcAFcypbD1cb5/W/RsRtFmT2q2xJ1XJucVjxQnoshIp+50GN5koDhOwJIK
         JdQ1QY3qYEUhzqvrM6Ix8ywt/TLtuvL0z3e614kpoQd3dfb7dj22AucZWPF0nOoAbw5/
         EWSRNdnxj4QNLvZiQKV1BtNuMueh/fzvG7lzAsAaQx6JabadU+jD5HZcTRimL0DuKykN
         UT1vwc+7pgzZwITrrx4gzM1d3o6pLGSU9BEoTY70jBs3UUCvedruijtTrNpGTb6JWjY2
         ERCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Zc0GHzZNo+25JcRNut2Uq1tt6Pzoax4+5TEhbqXwV8o=;
        b=BidioIhle/bC3+Lv1p5n4yrGOZ6/mD449+Usi7f7/463u2dfUwZ5CmbbfJ/2+udLnd
         CzD7tBoJVruYHZLwrYeAHPIKvayoAVsR5WGZJkhlYWoK/66myL+dLFjXMw7yXqn2RLDf
         pWH70Slxq2xd+SpRwcwIWrBEFmEwk6cOQGLeX85LCcPAbJnAGBPF6ungq/ApFgmGrxbi
         b9eCIrC6wd0YafTmIAHgHYNiXMRXx8a0FUeI6h1EeZc1ilJ/YUzq7zYAFJQQCvg59uuN
         6H13fS3BW9pqBI3wyviXZ8X+Jgd3R4NKbVBr6YnmFK/1duNftb+uCZsQc0SpBHt5wjAT
         ckgw==
X-Gm-Message-State: APjAAAV/WF5tl6TQBUgHL3dJI9YEpYF6gWS7ycRX78iyReZ6i7UULYUR
        /u2Q9B77AsqjL6TKwKH+iptG+g==
X-Google-Smtp-Source: APXvYqx7Qz8727ToqlQwkGqzMKdKVJ/pToX52WT+rAo5AwoXgddhjxhaLVG5/tc8WSszoJoW7FsVRA==
X-Received: by 2002:a63:b00e:: with SMTP id h14mr12554111pgf.321.1557524809196;
        Fri, 10 May 2019 14:46:49 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:fd66:a9bc:7c2c:636a])
        by smtp.googlemail.com with ESMTPSA id w6sm2968084pge.30.2019.05.10.14.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 14:46:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: g12a board node order
In-Reply-To: <20190510155327.5759-1-jbrunet@baylibre.com>
References: <20190510155327.5759-1-jbrunet@baylibre.com>
Date:   Fri, 10 May 2019 14:46:47 -0700
Message-ID: <7hzhnuc794.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The order of the nodes in the u200 and sei510 is bit fancy.
> Order nodes by address, then node name, then aliases.
>
> This makes rebasing is little less painful

Fully agree.  Thanks for the cleanup.

Queued for v5.3 (branch: v5.3/dt64)

Kevin

