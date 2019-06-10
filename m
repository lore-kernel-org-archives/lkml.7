Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED1EC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835FC2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tr47n74p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391232AbfFJPiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:38:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38484 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390073AbfFJPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:38:06 -0400
Received: by mail-oi1-f195.google.com with SMTP id v186so6549444oie.5;
        Mon, 10 Jun 2019 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edFG4M3dfGeETqFUJO8bUxy0ZhFFaxk4UK+WX2EmVpk=;
        b=tr47n74psbwUaDzokIi83a0EDul4HoXufAoqergp8cw1gTXSnZjV+cGD8h03KIiuB/
         /GKkKgcPPzQrz1vap/IGM1f92iTpscPS1+iZlvbb3Gx+FccJLcztMg/t4vVBjgns1edu
         wFjaQbvlYWu9yKTGQ4yoHMYyftnUsPVIbJiQrCVN4mPk2xlVGfw2esAijX/AnNkueseT
         8EeOJ8vUDuigIrvTfSxgYKmF6Pf335601eCuOpReoTQE3vyDr14bFR1Rii/GGmuHxEmm
         r+ZkIpnkRG9eqKXy3NR68wBhrj5OscYAnbSjx8Xif5QWjs7q8/WUN0NoZt2Dk1V1+R1J
         bChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edFG4M3dfGeETqFUJO8bUxy0ZhFFaxk4UK+WX2EmVpk=;
        b=uNR74OGP1y7geTmRsBZ1sTGDQvnQXPMXPld8EayyLyNQ9NbamnOLDwTF1Q83Zuwho8
         JMCyAbhfLmP1KXk7afEE9a8JdfGwwuxG0uyr8J66R2MlAiYNpflhG4TKWdusSY3Lwdkb
         oEtM+X6BD0SJNlT/G4YydcwfoOw/bj/9BQmnYOgPgt9XSIsz5k6sP2QTR7yVKIqxPzkC
         /KNg15iyNm4VgTJbYoYa2a5Sq7/5GIYo5ADKVRYi57v4GsWd0wKKdUwM4gjD9DeI0asD
         XlcLy4HuCsCVRlKZAXbn6xxfLddRl8P60b5aHxZu1tE7BP0rYsDdUCnlnKIM9as2L0Oz
         1ckg==
X-Gm-Message-State: APjAAAW0N3Kca+8Om368VP3VzqpYuGGKkJwlDAQxNnXJ2gMoW3JqVRG5
        nomdeV1JcY5BkE2cWqZVHX3qOPXHH2HZzJ7jVSM=
X-Google-Smtp-Source: APXvYqwDurkb7jM2XaijsS4ZrUTDm8znwcsGoRBRj0A7pvO0YjS1HgwVsImo15PUHZ8HcOhnKV5Bnz1zkm/YyYltd5w=
X-Received: by 2002:aca:4ad2:: with SMTP id x201mr3462007oia.129.1560181085327;
 Mon, 10 Jun 2019 08:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190610124931.17422-1-jbrunet@baylibre.com>
In-Reply-To: <20190610124931.17422-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 10 Jun 2019 17:37:54 +0200
Message-ID: <CAFBinCC4g1WVFyTgQrDUcYs13HDYp7Ggn=eSQ+X=LnpEoGg--w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: g12a: sort sdio nodes correctly
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, Jun 10, 2019 at 2:49 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Fix sdio node order in the soc device tree
good catch, thank you for fixing this!

> Fixes: a1737347250e ("arm64: dts: meson: g12a: add SDIO controller")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +                                       sdio_pins: sdio {

[...]
strictly speaking we're not using alphabetical sorting here
I'm fine with it though because it's consistent with the pattern
{sdio,emmc,sd}{,_ds,_clk,...}_pins (and thus all other definitions
here)


Martin
