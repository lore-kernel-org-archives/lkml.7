Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4BDC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AA122CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnV+a8Sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390557AbfHWHhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:37:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37513 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732849AbfHWHhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:37:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id t14so7982381lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZWCM1NaKkWZfHYdamHWGDCsp0daigJ/P9DBMZ7/h0o=;
        b=gnV+a8SbxnF8E7z2Tj14yFsvjUuIGqSsViiLQ/zAYEOipY0vHqYoB2FX2Q9pBj7Byn
         a8uth2qvzy+VzbI5mKAiM0vjBaR9exB16/ASG5Ddhfv8myEUUBaV67NAcnESCw6XGEYK
         oFsRP3hNBTbtXU7DMZdHowrtfY6DkD9y27XIUoOGoQbKnSVxe0iRViKWToVDqVCiNSrD
         1EC2EsLbxekU9X1hKemCBp9Upb3BVVc6Fa5SwH7ARexZmFgondpi+/1u8PgmTannFBIy
         LDqliBZWjE2ewubCbfQmU9vE2GMbIRij4CGeVQ544MW/Zc5SZtl2+01ffnjVd/XT4foa
         kamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZWCM1NaKkWZfHYdamHWGDCsp0daigJ/P9DBMZ7/h0o=;
        b=fEpXj9Xo28vljyx/pKW8edV5T74ho4GT/iN0siePEjnbVc4W4Zd8undxfqOIX310PT
         0wYjIBot2SUMpNZDoiWEWPGUPs/y2HVF2Mm05/BHcSUgHERcvHQA5BlvO+kot+D4NGqp
         yCwCtvCHWtfNLeB2Lj+Mga9YXh6mhvSyhU0g4ce4483qe4NY/BS7B6wXKBJIP3MExB+w
         PSyt5oR/tZhnRBqE5GeIRkJYKPrj+iSQVDvUOZOgZ9vJ1yhMXirawGq91bHdBDsr6FHP
         MAJ8mSlmSVHy9c4IixKPCoGjh1EVnJRTtRJV3lWqdaGsKM907yGpYVYytKQvPL0tq8H2
         CDQw==
X-Gm-Message-State: APjAAAXtqeyYW3B+9EU7b7HEC6eDk+KekEndhR8FBgGZJQnJzE1CvVey
        RURyIkgoBopp9zD4Fm+Rao2TL9Gzq+ln3ZO4KwYBMA==
X-Google-Smtp-Source: APXvYqwoTIF/Emnt9eBfMVVaR3D0yZcfntQldBQ8nXDMcgI62M2HujpKdWtwI9F1v3Vnmg1r5+YyulnqcRsz+8EBjBU=
X-Received: by 2002:a2e:80da:: with SMTP id r26mr1930950ljg.62.1566545863148;
 Fri, 23 Aug 2019 00:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190808101628.36782-1-hui.song_1@nxp.com>
In-Reply-To: <20190808101628.36782-1-hui.song_1@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 09:37:31 +0200
Message-ID: <CACRpkdbYEHQ=sYohxEC99T41qUBHYgBCYjM3MaAnD9PmY4YCyA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpio: mpc8xxx: add ls1088a platform gpio node DT
 binding description
To:     Hui Song <hui.song_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 12:26 PM Hui Song <hui.song_1@nxp.com> wrote:

> From: Song Hui <hui.song_1@nxp.com>
>
> ls1088a and ls1028a platform share common gpio node.
>
> Signed-off-by: Song Hui <hui.song_1@nxp.com>

Patch applied with Rob's ACK!

Yours,
Linus Walleij
