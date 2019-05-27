Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B5DC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD04320859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EXy5Jch2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfE0SWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:22:01 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44579 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfE0SWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:22:01 -0400
Received: by mail-oi1-f193.google.com with SMTP id z65so12439904oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+FiXAOea0Da36+0fuzZTMwOJ1pKxmssdqT24E7Ljks=;
        b=EXy5Jch2r8lQ3wOHylrAfl7aymelwxSm5mLv4h/iH5tNR53XBcL5lLzx9umgiSt9jr
         x+edbQ/1lz+Ng26bcE1uw+teKoot6ROIIFb/85pZhhunR1RVKiAUevyFHYz7RO96Nrb8
         bKB5Kp8E4KRko2n/NMEnx/+Yb0Qb1idYbLIEMsb1w4vy5G1wJvC3azYd067ucdcDBTCW
         9s/lxR8Xgri+cLcUwhES1GChPO3L84gYbXFOHGYHLMHgXYtq8VrmHYTQUMl36nPj+VV+
         PuaOm+d3Tw2r/30Chj68qN2MUI4hhxVmofs8auot6ag7PtUQKEyPZCI6il86U/XEjlHf
         3chQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+FiXAOea0Da36+0fuzZTMwOJ1pKxmssdqT24E7Ljks=;
        b=W4XWGBIV1TIQK9qrWTv7o9Q9kSLmJuYN6+oUW0JENvOll4I6TGWIb8nS06ULsoZiHw
         HbEbKiHOEyitLLIGAj75hpOssU/WaFIhUf//M6Ka4OWV13A7Ma/qgjPCviuCfGfQoYIo
         5LkCnNNezEuuIeqOLYJTZ41navoTl2cPYNF8+AsnSxVp8vo9QHfvucpbAFnLK8ZJTAwb
         3M7rwwmBCC7jCAB4tO9vg29ucStmzEvxs1t9NBFGPWzVMT47XboH0Yw18rYxW7xRY/RB
         RoncAwz6+wfqHxk80jm6gy6gnEZTnBeXaT91H/UJtcRrPqycl3VBo5FXoQsZletqJbhf
         1l6g==
X-Gm-Message-State: APjAAAWBPopx/g8w2T+itTJX2ARq01B/dOVUZuBDSy+PVslpnbr9w6av
        Qi0GPItdhqjaJaYV/M5TwRud1kj4SCg9WmH9i4Y=
X-Google-Smtp-Source: APXvYqxFnHFi0FhTyZznpUbIgThLVqlOOxZ5b60t+J3xjXTJRBUFohr7MpkWLfXXloofSw0ZHtPTxVALCpnakESKsDQ=
X-Received: by 2002:aca:ed0a:: with SMTP id l10mr188186oih.39.1558981320657;
 Mon, 27 May 2019 11:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190527132200.17377-1-narmstrong@baylibre.com> <20190527132200.17377-6-narmstrong@baylibre.com>
In-Reply-To: <20190527132200.17377-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:21:49 +0200
Message-ID: <CAFBinCCO3gx1d4pjOaHK0VPoYp0z4cPx3_YsTOpzFtmJSYQZYg@mail.gmail.com>
Subject: Re: [PATCH 05/10] arm64: dts: meson-gxbb-vega-s95: fix regulators
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        christianshewitt@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Align the regulator names with other GXBB SoCS for upcoming
> SARADC support and SDIO/SDCard fixes.
> Also fix how regulators are passed to MMC controllers & USB.
if I understand this last sentence correctly then the usb_pwr
regulator should be moved to &usb1 and passed as vbus-supply there

> Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
apart from that:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
