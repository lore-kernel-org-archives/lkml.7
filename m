Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E799C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0666720449
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AMcn31HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfDPSc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:32:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39334 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPSc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:32:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id a96so10752367pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=O2Miq9bX9p2AOkM+k8YxQfNxbc1oH7rmbPVkQaGxjAw=;
        b=AMcn31HHZBQ6o+N/HDXlkCzm1NrYNaR04206fYqcLL2CS/chfNJUCrUfxJ1SPf/7lv
         L+RtCbYpdpJyRYiXEMry4kl2Ck8ne0S0oz1WsbbNNzyfuu3ePEDmDvVcngGbj5LL6gpu
         UsNRtm5ykD3L9n6HPY9bH88mXZzdsHy7QeMZ79Z1HJqh5uHIapN2pU5xFhnihGHae8z4
         5EgKEcAmT6I158cLrMP3fapdA/SicQzwAHuy4/vqZ7Feblq/JVffXwQ+iVtsTA/29pWE
         RIe1EodWZVRy3kS1Qzpj2DmjYa+S6qfBXwDGfq28+C8re+d7UltAe6Lxs+lVJWo6fw9v
         RPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=O2Miq9bX9p2AOkM+k8YxQfNxbc1oH7rmbPVkQaGxjAw=;
        b=X/08r1DVcxdG6z6Vt/kRwxmUPsXc+5qEBzNEEzud+EeR0vdEFMOK4OQ/dp3Q/BDoGt
         XgDzXtwEJ4mMYluEbJ+B3K+nZ2oZIE+VRuSQc8b7QJMPTlGoHHxrJxtdLXgaLmNzq7Mk
         XWoWD31L8qT0ew+ywzftWtVdrdVuPY4dYnphkmwc19Sq0Q5FLusgbkkkyuHzAFFRwUVG
         DKd/LZ8IQafYMJqnFn6Dcol/+llOD9NXtoGAwpl0lQOCPoUlI69VlGZxDsTT8dUHSo4B
         OhyCSY4qMvPDbJDBnXHbjjknE2Z9PqtYiXRk71kRH0wbtoShg1wvtzqJjDQIxVFcKskX
         M5yw==
X-Gm-Message-State: APjAAAWr224zNTE7SztGBHdNVF6qnzwAGEpWjCEC3z31w0m5aF7g4f16
        DRZc9QYaZTWjnPwGaWqL3iV2/iCS6mU=
X-Google-Smtp-Source: APXvYqxqmMT+ESyxM9cZfhnEeqKPm8tj84bnDo9Psbo/3fcuG9MGpFng3Ytrv4o133p59py5bW9zMg==
X-Received: by 2002:a17:902:382:: with SMTP id d2mr23050017pld.253.1555439575464;
        Tue, 16 Apr 2019 11:32:55 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:c45e:7ed8:c242:3563])
        by smtp.googlemail.com with ESMTPSA id m16sm127926350pfi.29.2019.04.16.11.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 11:32:54 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] arm64: dts: meson-g12a: Add support for Video Display
In-Reply-To: <20190408093139.27161-1-narmstrong@baylibre.com>
References: <20190408093139.27161-1-narmstrong@baylibre.com>
Date:   Tue, 16 Apr 2019 11:32:53 -0700
Message-ID: <7hh8axpzqi.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset adds nodes for Video Display support.
>
> Dependencies :
> - patch 1: VPU, HDMI & Power Controller bindings to be applied

These are applied.

> - patch 2: Depends on AO-CEC-B bindings to be applied

These are reviewed/acked and don't cause build/boot problems.

> - patch 3, 4, 5: Patch 1

Since all the deps are ready, queuing this for v5.2,

Kevin
