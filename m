Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75476C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAC22173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1RqUfQjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfETVQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:16:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46664 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfETVQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:16:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id t187so7352962pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=mSeWmAuOKlZVmpo2pczi5ZmRRFlzkHQwhkOlfdVHPfk=;
        b=1RqUfQjz3U6YoLJOOFgB2FdZaaMQEWRYLKKg4UDiBW+LDw81+lTqX3N0SidkIp5zCR
         nbuDu9D4+f65KyqesYzFHcrmL/Uk2swKnm37G9oiveD8Aao3tT7PeHfyxRmJj59Rd0r9
         J5+WUVAkF41l1EuEWZMqCP2EnOPUPcCuFUg+xdNOlM0juOESc2cH0h+jl4zVPa80h7t6
         ug6NNZXk6kg+TZdpV9SRwZQZSfJ7RmEaRCZb7JG2vSkWk8Pjz17BVAc/VnTDKewSuQv/
         Y8Ngygm52u4d7g9IYPGmlQUWT8xaHEC8zw5KF3V0QiI9GDT+SsyxZkO2OEIYwWjO1EHb
         jUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mSeWmAuOKlZVmpo2pczi5ZmRRFlzkHQwhkOlfdVHPfk=;
        b=TKJCdw8fgQInMvQZxaRawnjCCGEN7VG6F9D93EZj7wXE5kPzjjY8W+5zNXukHWjJIi
         gCnCqLDzm/JMGw9AymPhNNjkVGG18Ek4wLOJhZL1z0UstBtgzzAxUoLglFaq62Dh/Mk3
         mMekvuSCTU2VsJmhcNNf+H/a51/MZru/ePT36ii3X8/PukflmdSeEZxLoB4ccbhkOtY2
         /BuNcZPb5pZqymTW7FX+vDmCGL+K8aErYflCYfg7OQ8pJi7XITV68mZfoY2TNhb4tvnB
         QJZQsgtOLiW4avc8t9vvIBYP/BFbY80/9f3s62yXqWDddI93k46h2/g60kfT5vUHN01R
         9zlQ==
X-Gm-Message-State: APjAAAVUqbE1XzF0PtmSDwugQl4rg5GqgIMGHGSPmLWkc+olWHKGzY5H
        KVWUEdFAkyccm7YFsJ/snIAGwA==
X-Google-Smtp-Source: APXvYqxGMg21ATGkIdFaHGjIbfxae232bkGRG8oHvdyiiN419sfsu9Uihg4c/RC/H/TL6S4zC/VVMA==
X-Received: by 2002:a63:ce43:: with SMTP id r3mr2349874pgi.368.1558387002476;
        Mon, 20 May 2019 14:16:42 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e483:1cc0:e2c2:140d])
        by smtp.googlemail.com with ESMTPSA id u66sm21840095pfb.76.2019.05.20.14.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 14:16:41 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: sei510: add bluetooth supplies
In-Reply-To: <20190516071355.26938-1-jbrunet@baylibre.com>
References: <20190516071355.26938-1-jbrunet@baylibre.com>
Date:   Mon, 20 May 2019 14:16:41 -0700
Message-ID: <7hv9y47rnq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add bluetooth vbat and vddio power supplies
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.3,

Kevin
