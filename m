Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2D4C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8010120883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QN13UOq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfE0SBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:01:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46417 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfE0SBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:01:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id j49so15435861otc.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnoK4PcQ32UVFyVvgKGetFOED9mK/jXQboyT6bD3dDE=;
        b=QN13UOq2YxEU06ZlYM0bFo81jCO7B0LidLRXgklwd/MafCP6OGR503WNWGxhRAs8NO
         nMcAc/Q35ih2Un4fApqi3P0On5E5p98dbtrnYmE5VrpkI3WD4BKqk40ayTdQ4IbZVJJc
         R6ULYunFYunS0m7yky4sUfhKsMRDGEORZ8W82iD+DwcqDzwhbTehMFU4gdGMrGshDf1h
         y0zD3muDoSQ9rfK8yt5nS7QrlUluo8moEEqVf6DbUhj4OLzY1EeZGowITcIyovg1Nx7h
         3frxnfV5kdtgiv6NCxUcv476zTsUAX53CQtL2ghEO9koi4LMIOi0V1UMP2REHsKLRasM
         LQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnoK4PcQ32UVFyVvgKGetFOED9mK/jXQboyT6bD3dDE=;
        b=qKtRgWkPvV5dh44aLeGJ7kyaqFOFLP33ZzEgvMMZ+vF0Pp344/2juZRRw4UayaZ0lX
         rlwJyUU6HHSpWpFCIeCQGMlemxzVc2FWhmh0f30hmyuwfn8RAOdkc6h3UQbPoTsJvYuY
         gT7xYQUIWLcHKP58a8pG2k9YcPA5nZWHAs7Fb8RoQ7W6J7xs5c3nohlTF0gMqa0wMe51
         gR3W/7HLnZz6Iu6KREHX4BY6b2yGGNZMLEei7fkPzrSMDsfDFB1M22WpIBRSil4xk/5I
         VBcumABNBEVxF78Qtx5VZKgCV9CAY7m90XS1s9yH2MlVgBWPckOdTGsI++YZMoLDU4bE
         6aew==
X-Gm-Message-State: APjAAAWmbVAggAooM3B5eXWTgjxedw+Nh9ser4QdCIJZlk7urXk1NcTe
        rsQZvUSu49LHs/spQ85eoTVvXEqothWElCc3Cj0=
X-Google-Smtp-Source: APXvYqxDTzdAWQe0aoPV7ebEFThMELjXniHkv4cVzEGDcZtsCyPfFKYK0To523hJdA6unhGN0pMu5hTm1xZwHeSplIg=
X-Received: by 2002:a9d:2f08:: with SMTP id h8mr71794666otb.42.1558980081440;
 Mon, 27 May 2019 11:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190527130043.3384-1-narmstrong@baylibre.com>
In-Reply-To: <20190527130043.3384-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:01:10 +0200
Message-ID: <CAFBinCD67XCpT-zmppJ3SSs5Q5ruse-otGqMLdbeaTnkr3PKiQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: meson-g12a-x96-max: Add Gigabit Ethernet Support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:00 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Enable the network interface of the X96 Mac using an external
> Realtek RTL8211F gigabit PHY, needing the same broken-eee properties
> as the previous Amlogic SoC generations.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
