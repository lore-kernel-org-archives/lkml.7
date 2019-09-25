Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A426C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD5021D80
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kAVODz2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfIYWEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:04:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46445 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfIYWEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:04:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so302986pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=YeAl8mUR5ysBqtVRjeF0K3lTpX9dLqo1DLUgKRVNBCs=;
        b=kAVODz2SbNFA24N12lzrYsnEjoiYTW3A/X9GWMAh7zTc/1Ob81Oe4TIe5eKAasPbUh
         Gcj8UMKYeOZvrglDEs7YXZaghdGe5VaUL/57m7dcHuvxDDQn+T+RrA7OjJwFVWNKMWkx
         Of9C1jOw2N+/hiP/r2wCEA/4oker4WI2s5mabRiTe7+2jhNSZl7rcLAjHE52L8GidDll
         puzBzXPLuLLtvTV+K4oo4UBV/wiOmwrGJglJendCO5lcfCZUoqB/8ZnIrdDN6C5Ac6M6
         gertYQ5e0Qh2hZr4n+3kJDBVd8dsGcxbQpNEWuh4R2A/UqiES232s2FufTAuq24CN+lv
         xEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YeAl8mUR5ysBqtVRjeF0K3lTpX9dLqo1DLUgKRVNBCs=;
        b=dnrnkKLygWZrFrVjJyH8x1PeQY5sufRi1W8sf72r934Q7cdZS+Syiaqr42OAYFo714
         lCIsGQT5o6pj7R2TJZW5CuTfDZAPtt+lUVR4PsLCHN7WOFMKC5fqtDBK78JJiNTtxzvO
         TG3hn4KpTJc9MEzRjVPXBxGuZ+XOi0pPZ813AYmIq2V2idhHGFk0COODJqejlVWqLt4d
         hWRjqEn+OrA//pziy+hg9OMbWAhYgZoICoQ7KL4Q1apxOz4KKcgOuiy3N/OBi1tDQScn
         PtJDiP09GhXNo5BvRvURRMvobw8T/g5my6dGWRJttyeoJu+vAkEANy/DcNSpZS+jE119
         BTqQ==
X-Gm-Message-State: APjAAAUFDx96UBF4dU2A21/LS/1A7aZNLJgHNFbu+AY61BKfqx9eaQLA
        e1mdk8n5ux/z00CrEGGj2Qt75Q==
X-Google-Smtp-Source: APXvYqxUwa/wf6Ah6xwPK6rJPAIvd99PeWHWaExNxLuo5zzuQAq8iypBAr7+D2+VjDRrb42Q/pp6Hw==
X-Received: by 2002:a17:90a:f0d7:: with SMTP id fa23mr8733337pjb.120.1569449054656;
        Wed, 25 Sep 2019 15:04:14 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y80sm18688pfc.30.2019.09.25.15.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 15:04:14 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4-next 0/3] Odroid c2 usb fixs rebase on linux-next
In-Reply-To: <20190902054935.4899-1-linux.amoon@gmail.com>
References: <20190902054935.4899-1-linux.amoon@gmail.com>
Date:   Wed, 25 Sep 2019 15:04:13 -0700
Message-ID: <7ha7asuj6q.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anand Moon <linux.amoon@gmail.com> writes:

> Some time ago I had tired to enable usb bus 1 for Odroid C2/C1
> but it's look like some more work is needed to u-boot and
> usb_phy driver to initialize this port.
>
> Below patches tries to address the issue regarding usb bus 2 (4 port)
> while disable the usb bus 1 on this board.
>
> Previous patch
> [0] https://lkml.org/lkml/2019/1/29/325
>
> Re send below series based re based on linux-next-20190830.
> For review and testing.
>
> [1] https://patchwork.kernel.org/cover/11113091/
>
> Small changes from previous series.
> Fix the commit message for patch 1

Queued for v5.5.

I fixed up the typo in patch 2/3 when applying as suggested by Martin.

Kevin
