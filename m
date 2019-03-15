Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CB1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C702186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="b9K9gySO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCOVQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:16:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45973 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCOVQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:16:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id t82so8476237oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGGR8l7ZhEyPC+Uq7I15TeHxFirEjOjPYiPcaqY8A8I=;
        b=b9K9gySOwM9Kt8K6pQ2/9raP1GT7rSRzvnHNATBXojBJJq3f3Q2hXBvCrQhpyUvF0p
         whoPZJJxes2kaQd1P/5+MWCt6XN3+TpfdtbQ1YIJnEf2UEVWlZ0cJ85Om3RdVjKfWO+t
         EeReaOpaKWyjLGFKw08LJTpdtRHcuB2x0j5leMJT+lGlgC+jV0y33znBwIfH7eBvaVBf
         WZKmK8vzS5XbTLoR2zMue3gYrvpridl6w8jiBFOextnMSgvVsfrIiCl3y2PYXWpEgxo4
         9nBL/sq/UZEB5fg3MvpujSmsWZl1LZ6wq9gGFF9/WAq5QpYoSfXr9T6KMvP/ODBt1e/6
         iPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGGR8l7ZhEyPC+Uq7I15TeHxFirEjOjPYiPcaqY8A8I=;
        b=NY5NsQpGfpj+5obkQZCXqZQ/vF756tOM4gruPZ1Eckz2umpCcKuRUc9YXPguGjAsdF
         iliNRRFaS6gpYMCtDTABLXoBATGH6RL7TmFkiI0W7S4FaaCq5rKOZQ9whGYPa7Qeubr4
         UvQ/IU8EAMg27ae4sBiNE0a2dno41sNlWRLw5spRXPHTntZW1zVIq1RNDvfVtloBPc02
         pDZR75Xn2oImXPYXKzov41NePJk+XuEiU+OogJanXv6nmDwZ22m/V/2N5GXdXGVp9r+O
         4BLUiPoHryN1nvILqwYYdcZZkXF+PnRZkA3fSdnU4q3NtEktKoSE8t2FEwJ+G5I1MayV
         Uupw==
X-Gm-Message-State: APjAAAUj7tLztCvLHy1aSsk2DWldzVDHlPRftvAMCJv5ZsAY8pgFNn/V
        3Wv1cwdchY5P1AaUKXHLxDZv4OvFSsG3stKdK3s=
X-Google-Smtp-Source: APXvYqzw+m0vFbRkhAfgbes49irYzTkU/qUnWHxpoZCkUHefXDMMHPzkmnhUyGdEgly0OL44bEkZ/ONiStY6xXppJ0Y=
X-Received: by 2002:a54:4e02:: with SMTP id a2mr3005399oiy.140.1552684597495;
 Fri, 15 Mar 2019 14:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-8-narmstrong@baylibre.com>
In-Reply-To: <20190307151342.7381-8-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 22:16:26 +0100
Message-ID: <CAFBinCBKraoQXZL6uOr0Fd7QQX6EKwaheiViF1TcKnX4vdtFhw@mail.gmail.com>
Subject: Re: [PATCH 7/9] arm64: dts: meson: g12a: Add SAR ADC node
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 4:14 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This patch adds the SAR ADC controller node.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
