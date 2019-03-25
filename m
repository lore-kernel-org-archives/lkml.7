Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BB5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA372087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nXT+XlEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfCYRX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:23:26 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41495 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfCYRX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:23:26 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so8763415otb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFPdlKrZ7muGpk/OHmSwyqw31Qc59RqslbAhZWdSAdE=;
        b=nXT+XlErTaEJkKio3UTicMsk/9K83R4WRRuImRdQIs4lNsrRt3BG3Ndvh/mlEoUG0e
         7uQUXEuyaCswEhgjabyTX9RZrhNMK3DY23wdquLUUxBywUVxaBKl+he+y67BLenPhkqU
         WcszlwWZFb13LqKD0ehTaWuaom00wYcGBlIh10F8vH1ie9nR3gE4f0QlvAoK1AbOGJHM
         sDCyq3lT2L7pBPI4QsxPG1D6Ado6ioUdJUJpfbF7DSsqcS0ASLlRcvNolVqaQJWyOqTq
         Db+7ASAtiMz2ZQke0nbtkJYqqigQ1zraI96DBXMWKKnDqGV1LYsOqVfvJVwXWcORQklK
         cxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFPdlKrZ7muGpk/OHmSwyqw31Qc59RqslbAhZWdSAdE=;
        b=aH+ytxEwA9U5N6E2dV/E6Dz3h0Z19PE+++1AOvYAGixLU7tzhg/dDNWSnUQ1kYsmiI
         Hz/eWSrcvwdKRRRA+jgO9tH9k4DnT9DrUw68uhh6nHM+K4o8tvlB8xPU0Dq7F2sDabGN
         6m9kaDBq853A2tNH/ek033MkSCcGwIOucYoKi5DuOU6mrMfApe0hamT0h/ppuKpzg3nD
         N941m/YM6JVwZaTCB+VvLyaQQGGx+vfC6VgldmYAirA481MnMkmRW3cvX4ZCQU6Rs/pi
         JhkD4SkRm/CQ1HOFsh15bDZq7Ph3Kwc9yUCq+gwIkpIv83j/20zrXxqWkyP1/ZtDwuly
         uYLg==
X-Gm-Message-State: APjAAAVSw58WF3qGl3VRPkGBDY2Zmd5Mjamk/M+DYGAdWqrGNCFP/HaH
        ohRe0tlcNbFiJRtIInziXtudVgjfmG27gq+naZc=
X-Google-Smtp-Source: APXvYqyBe3LCDhubjzFRz2zAEjnUk/WiLt2IJi64lWLyjg5TX1XElGcl5bx4COt2YgwOMxSbpbiCjAzhf0PkEW/Qm+A=
X-Received: by 2002:a9d:5614:: with SMTP id e20mr18289202oti.348.1553534605479;
 Mon, 25 Mar 2019 10:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190325101453.3009-1-narmstrong@baylibre.com> <20190325101453.3009-2-narmstrong@baylibre.com>
In-Reply-To: <20190325101453.3009-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 25 Mar 2019 18:23:14 +0100
Message-ID: <CAFBinCDnYUWzJqA4xukrWLotpYhS1jUSz4TunBBfSsur_B0XoA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] arm64: dts: meson-g12a-x96-max: add regulators
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:15 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Guillaume La Roque <glaroque@baylibre.com>
>
> Add system regulators for the X96 Max Set-Top-Box.
>
> Still missing
> * VDD_EE (0.8V - PWM controlled)
> * VDD_CPU (PWM controlled)
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
