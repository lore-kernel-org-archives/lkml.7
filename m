Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C68CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD902070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rTiDJtDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfH0V47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:56:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44496 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0V46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:56:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id c81so247768pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 14:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Y58GzbpuJMrCv6Aud3l4fk9q/EphwZ4HzmalX9EXO6k=;
        b=rTiDJtDz0lF8iZtwS2E9aimITSlzG6HIFOf6vlZyAafpkeUG64U7MV9Yu39sFcNIvd
         u5fD4k5wylpqkm8n/QGqUCllNPs1caHICWt7RnY9nej7dGYSJx3OaxEj241aSl/rHIys
         8Q9xzRI9YZPYV1Zp48hrFayXPKz1YzRqaheng59FI1LBq7n+17QKjJbdwJWzCuFBDi3c
         S0IAg6FMJ6j3lBjTeFkFp8aLLZfa5JTuD4LvlAren6zm7wf1YGNZmP7SIX1D63Jni5ri
         oEGhgXFyITLiuSzeR/me8xGCH8SjCDcCD3b2OTElyF1odsAR2+cp1eDPuCR5tKtW4hRN
         OaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Y58GzbpuJMrCv6Aud3l4fk9q/EphwZ4HzmalX9EXO6k=;
        b=Pxx62nWCok80wMm15ECHcN6042yf1Rh2RcdfD50FboYavFKncbZZFv47VyMhzl1Ov0
         EDPNWjAuzv++2gW1COCkxMBdD7NxKXmvoQQBRN1TKPZUDVKvzzRKyv28Zdnl2c6wxCZi
         6el3HydnNqVA4RPNgWCtB8nO4xD6QqJvPCsyCJJV2mB2e0lZKY1lZTWp89xVX6JSAUyv
         uO7JfZgybbJ39PAL6Jxoxa2mJPndeBtqUMis2lJIaZU34fIUDadgZYBWPzAhdpyQwwI2
         xLW+yznFhuTsArnOiQ3uZpfDlCa++szrXYMLMQHkOed/I+xGGFSD166zf3CzJ/CQj+x9
         wSHg==
X-Gm-Message-State: APjAAAXkU59iHqfKY+XIGf5mbsAIjgUya3Qsz31SwQarGOg5fyxDWOdc
        HrQalP6Mk0M3Y+a3bJhB2VWNAjjRpjQ=
X-Google-Smtp-Source: APXvYqypJmra42f+zZaaG5L+JyglSUCu3Jctb6ZUUahBE8VPLzbP7kgdlKfYkQUSzRkfGvw0nbiVeA==
X-Received: by 2002:a65:640d:: with SMTP id a13mr566500pgv.256.1566943017473;
        Tue, 27 Aug 2019 14:56:57 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:cc35:e750:308e:47f])
        by smtp.gmail.com with ESMTPSA id f72sm168758pjg.10.2019.08.27.14.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 14:56:56 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/3] arm64: dts: meson-g12: specify suspend OPP
In-Reply-To: <20190827100307.21661-1-narmstrong@baylibre.com>
References: <20190827100307.21661-1-narmstrong@baylibre.com>
Date:   Tue, 27 Aug 2019 14:56:56 -0700
Message-ID: <7hy2zeuv9z.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Tag the 1,2GHz OPP as suspend OPP to be set before going in suspend mode,
> for the G12A, G12B and SM1 SoCs.
>
> It has been reported that using various OPPs can lead to error or
> resume with a different OPP from the ROM, thus use this safe OPP as
> it is the default OPP used by the BL2 boot firmware.
>
> Neil Armstrong (3):
>   arm64: dts: meson-g12a: specify suspend OPP
>   arm64: dts: meson-sm1: specify suspend OPP
>   arm64: dts: meson-g12b: specify suspend OPP

Queued patches 1, 3 for v5.4.

The SM1 patch has a dependency on the SM1 DVFS series, which in turn has
a dependency on clock changes.  Once I get a stable tag for the SM1
clock changes, I'll queue up the rest.

Kevin
