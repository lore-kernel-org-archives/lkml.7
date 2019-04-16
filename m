Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A96C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311912075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kv7JC1pY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfDPAkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:40:37 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:43100 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfDPAkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 20:40:36 -0400
Received: by mail-pf1-f178.google.com with SMTP id c8so9451770pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 17:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=XXAeaOLyklZCk/VyID8RrVHWu0+omv5PykIy/BvoF6o=;
        b=kv7JC1pYXi8BVezCoSU2PV8eTx325GmroN3DqUWhE3VneCjDfvGKKGwKxbQ5lVdkk6
         Fci44xERlGq7tG+CSlrfcT6zq9I9yq/HN9MUtrEcU0Jvrr9iyOKNaC58qK8m18GcJNJG
         unh7KlVCSHaD/Qr8j4T630pW926BcQF3xemf4c5ax5rQEIwMYqOPc9A117IyLwjXvOML
         GderRvbqT+Y+lEFGZVrtHkpWux4/BEo4IuS+x0izZ5MUKSOuA7U6B6sQYuu3h0St9zD/
         3kBGRSCLDKCa1KnA4cXg9NQ6JnTVxt2p6uqlp4XV9bLY6xmUZb+u0P8u/xUeTEhO9Xgr
         FXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XXAeaOLyklZCk/VyID8RrVHWu0+omv5PykIy/BvoF6o=;
        b=mEoZOfJ+vwFsTYthyKSUJK4ItWvKcRZq3pjzGLUHOy90JldQaerE+66b+rLTXwnRGk
         jGuA21gufqkOVo1CB9AkA6U4R0styMcgTbpFSgd9m6VPTxRljwxcSGD0yOPjgh4iQWZO
         fGR10wQuhpUKHEpPeL8rC5DmUsbxu8YZ5ftjWXZ0QXlAuqYqImzwJO3X+ML5SWlF2NH2
         yJUHOOiIwrix0I2VT4kPCUys4R4vjzLCBoQTTpPge/X5QSHGYxo6O1vpASyfcQU1wUw4
         WZjb2L6EMpuWHQWv3OEVyB+wPMPRYa0movQKpAWuVrcYLX5ce+amBqpPy2dh+VjTNV/5
         2fMQ==
X-Gm-Message-State: APjAAAUBs1xdQks4KaKAe23uFfj9/MxyLVgfOd5d56z55GhHc6pI/R88
        dFHeadybdGPcN4uLw4h0eiN0ig==
X-Google-Smtp-Source: APXvYqxGC1aDJs2lK6cDNlOEhqArl1ID8pMrw0LeYJfZwebaRyO1y9q5T7ESU4XJVAlSCPknn4UwgA==
X-Received: by 2002:aa7:8252:: with SMTP id e18mr78234501pfn.105.1555375235775;
        Mon, 15 Apr 2019 17:40:35 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:c45e:7ed8:c242:3563])
        by smtp.googlemail.com with ESMTPSA id a12sm58965761pgq.21.2019.04.15.17.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 17:40:34 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: amlogic: meson-gx-pwrc-vpu: Fix power on/off register bitmask
In-Reply-To: <20190401074801.10414-1-narmstrong@baylibre.com>
References: <20190401074801.10414-1-narmstrong@baylibre.com>
Date:   Mon, 15 Apr 2019 17:40:34 -0700
Message-ID: <7h5zrerddp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The register bitmask to power on/off the VPU memories was incorectly set
> to 0x2 instead of 0x3. While still working, let's use the recommended
> vendor value instead.
>
> Fixes: 75fcb5ca4b46 ("soc: amlogic: add Meson GX VPU Domains driver")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.2,

Kevin
