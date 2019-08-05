Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EBEC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8FB208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="krxrwuHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfHEVrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:47:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38552 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfHEVrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:47:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so40312546pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uen0o9EWyihb8JD0XCmurleyeEO9Sh3FbyjhtFa72iY=;
        b=krxrwuHaZL0UwGH57VzlvsLeIWI4NxpK879CAPB8bDxdJeAiCJREZe35FPhKcnnY0F
         yItpJQZX46W3iya4Z6PynxD4Zh5lFy2TIBu6do042B1SkiTg0003a5rZ3Zz4jcQXd54w
         v+ErJdagrw7AlS5jtNfG9Eq1IcGPWFb7eCGoAINMMwmYGSpBdhJCat/bEoFP699Kc7CH
         T1MFDOcyK5skmoh+dO++iJZA7DMeXjpEG1UgZtgnOz9CfoAhOofLHnGu4ioaVOCQhCzj
         ylf94EVNpcY6AlbeWE860lBQIU5acTWxK4EmtHyPgyIizfql59+hrPy7aQ3fcnzt1x+U
         8GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uen0o9EWyihb8JD0XCmurleyeEO9Sh3FbyjhtFa72iY=;
        b=s2Tpgmbj5Jvuy1QiEq6SrrE6snrU4hWnfr9jHs1HAF78dGplbKevvNYLIjLKDm0qiJ
         yvzRIKtzZ3WQPVNa5YOvvjPGL+me9pU1tdCdhywTLykM/4hDWoF4O5877yJNnP82avMO
         oEJSXXTP0bGNM/XN57X6bHSgP1uExyrPD0PxnR8QT9TIZZTiDbyweXtZ2uIAdujpGDiu
         9pBHBIRjuSnXfAUuT1WUrJ8kSFHdqCEVoQdA2Ih+9aN3ALJWHCRqAVKt6PaUL/cxWbLI
         lfXB6IJmH8n/s6kvRBCyAbCUNVKStzAEVOdnnIxITamMVgezGFDkHapEZJxRWQ1H5JL4
         LONQ==
X-Gm-Message-State: APjAAAVxXLCpHAQD/cAk3wb3KCWtAssOvjUdaczNh0kn4pEEi7+k4IRL
        NVg6d9FGleP+iGPz3jFobtgbNg1jGQscNA==
X-Google-Smtp-Source: APXvYqyExudIPbUknudufG2uNBdAsRYtIyN2g30//+P4aZV+iM7poBR/0RQ/P2wvpcDI1qT0p3acew==
X-Received: by 2002:a63:c64b:: with SMTP id x11mr23952115pgg.319.1565041674478;
        Mon, 05 Aug 2019 14:47:54 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:7483:80d6:7f67:2672])
        by smtp.googlemail.com with ESMTPSA id w18sm109529632pfj.37.2019.08.05.14.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 14:47:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/6] soc: amlogic: meson-gx-socinfo: add A311D id
In-Reply-To: <20190731124000.22072-2-narmstrong@baylibre.com>
References: <20190731124000.22072-1-narmstrong@baylibre.com> <20190731124000.22072-2-narmstrong@baylibre.com>
Date:   Mon, 05 Aug 2019 14:47:53 -0700
Message-ID: <7h36ifgu7q.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> From: Christian Hewitt <christianshewitt@gmail.com>
>
> Add the SoC ID for the A311D Amlogic SoC.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.4,

Thanks,

Kevin
