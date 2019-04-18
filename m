Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0B6C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADB0214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="beicCXg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390053AbfDRTqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:46:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39492 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389853AbfDRTqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:46:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id n187so2522290oih.6;
        Thu, 18 Apr 2019 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEouRq2XUIs+Kr06PT/8QxB3jpIE8DhcFyEyTbtMjCQ=;
        b=beicCXg+Amiwz2mmQ84fr4YfmKHW6jK/2Bc/vwIFTbt/BpqZf7qqc93W6zvr4497qb
         WR+zyWY7eqVWZtbK4/TvcGc8qvs6rZWrcgFwTPPAVeLiMpuAZhS8jgyTaHUtCVKwGPLq
         eid9YChk542PGYfNfrA0skHLMecRZNQcSJdcP3mE1XYk7ZQGUeqinM47Eng6zIZ5i97m
         o257IbKHmFQTMgLrmrNeSc6YXtNzNxu+UJVpQCyG93bZfF1G+LiN+4KMNPoPCFacfV+0
         GpTeBbWrcM8ZfOSH3x0xGj1aFHggaJeGwB+vtO7NL6PbGZtKWcMdtmomaFmmelRbXY0r
         HKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEouRq2XUIs+Kr06PT/8QxB3jpIE8DhcFyEyTbtMjCQ=;
        b=AZFve15+wr0yHLsnRTr0m43AjZFJjIwGCOmUTkKp2Q+4MluFGgip2Ee+x90oiiMh2b
         VF4HCTLv47aFOKZvuLIjJWEif4k0v52G2pUSPw27k/2O/dnsmxq7GThx6F7yl36Q4tel
         QKUJPLZq6pge6BtnBxiAFaknnYXrwSRcEOdeov0tzZremYCdWh2LbHvHEamjkUMwvQR8
         jFJ6Kk4X56J8zO31Jvheof+NoRiw2CTsflwOK3DIDSoubX9FTtE8bhgPHiJjtIAOgEz1
         3L0WojxSHz8RplClUJNjkd4icn+Qw03gEhQ9kcmtY43/hMLRltq8RY6hqGRNMXXGTrP2
         jzgQ==
X-Gm-Message-State: APjAAAUP/E/grpCquH4/Ce59x4UwV9IEg0WnYTcdgCWTbiLSbgzDw8X8
        nBALpzGj7Dj7Uovskmj2RzQDjab/zQ+Pu8UGjU4J+GzN
X-Google-Smtp-Source: APXvYqxs1oz6dybsrDbrWbS2iL8KEBfBl2fQ/eR5Sv9tj7ww+xJszPzMqkmfLSvyYXxwryiR2CnMJydyyfu3FK1BHKA=
X-Received: by 2002:aca:4482:: with SMTP id r124mr3314554oia.39.1555616776408;
 Thu, 18 Apr 2019 12:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190418122714.30805-1-jbrunet@baylibre.com> <20190418122714.30805-3-jbrunet@baylibre.com>
In-Reply-To: <20190418122714.30805-3-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 18 Apr 2019 21:46:05 +0200
Message-ID: <CAFBinCC3+VXwmzCQFL+3zPbi1r1PK6StfaXwT-fk4ogGqgAXRg@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: meson: libretech-cc: switch eMMC to 1.8v
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 2:27 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> While some 3.3v eMMC 4.0 are available from libretech, Only the 1.8v 5.0
> modules are recommended and supported for the aml-s905x-cc.
>
> the 1.8v is provided by LDOs on the eMMC card, from vcc 3.3v
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

(I don't have an eMMC module for my Libretech-CC so I can't add a Tested-by)
