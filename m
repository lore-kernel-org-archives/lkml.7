Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73881CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACE420650
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njWpSQ8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfKDPcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:32:13 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40777 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:32:12 -0500
Received: by mail-lf1-f68.google.com with SMTP id f4so12565520lfk.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mr/Uxcplv3NXuIJk8Ti1kfrQNEUtvUFgTdHmY4Gpbzk=;
        b=njWpSQ8wDNfkaVeUU2fNdyl/gHikLxNHX+GZiK4dn0gkcKvE2mFYSrOLzmK2F+9yI2
         yDo7PYJAV0oFUMmlVjZkfIPH4OJYceMAFu0zAAst9LYxuOk3A6wMgldPfh8qYnbwtEiS
         iuZ67Ot57VBDn7SomMOrrcp2180LktPjNdmsEbuPvcbfOj344XahHiSBnukd+u7OAY6q
         COjC6T+tZYOp5/Kf4yz9UkVsB/4xPlqch4aZmdpLncF2G5Oo1HApFzkg1F/tMZ8izNTI
         /0OB+EkTifoz0cTCW4/1xKTo0f4iMZ3uFpVbdVlwTl6aZP+xmcRscxWfxcC7ikuH0pyS
         bHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mr/Uxcplv3NXuIJk8Ti1kfrQNEUtvUFgTdHmY4Gpbzk=;
        b=rl8BGfbJlE8GFaBr+cx2TmIAlEutsGak0JPr/fk9E08klUkiAtLPOO1e+eZowIs3hj
         L9nImyCiuAXztYKM7msnqD5vbyJfYfswFNSuS3BMBojo0Du4aeVrCkpZKMdt4gyTh2HM
         UORz6+8fownH9nLQZbR80B++DR+s0XaUs59OFqd/XcfBhLhQkPl4+WSYMi6Mqtkt3fOr
         C26rvUXz3vpP8vTUHwOrSmM8pkUQpu4GWBUhhmJ2w9l++XaLRwf3C0c/Tt7LiISItxkk
         /aScuAq9x5eRBcJZ6W06rnML5b2TC2dsNuiETrxMZ/8sNf8pthCmuzSzQT7kcDSshXES
         4NeA==
X-Gm-Message-State: APjAAAU9D/N5owGSaTWn880i2nwMdWH5yzNMJmloUX2T4JJNQllne53l
        i/ys+OPRHpSPsba2fVdQKTgYrS6CgIijeUNEqOC57Q==
X-Google-Smtp-Source: APXvYqxK6Pwq1Qm86hnw4EI2i8gx2+V2iuKJsfnwP8M8v6pQOu8BH+b+jtXWQgx2oKQZuZQAKVxi6hoscfSl4OQ33fo=
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr16987288lfp.5.1572881529546;
 Mon, 04 Nov 2019 07:32:09 -0800 (PST)
MIME-Version: 1.0
References: <1572004167-24150-1-git-send-email-qianggui.song@amlogic.com> <1572004167-24150-2-git-send-email-qianggui.song@amlogic.com>
In-Reply-To: <1572004167-24150-2-git-send-email-qianggui.song@amlogic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Nov 2019 16:31:57 +0100
Message-ID: <CACRpkdZZpc0yrewfseG3PUXgvV3H9XED25Ej21VeMYn8cUxasg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] pinctrl: add compatible for Amlogic Meson A1 pin controller
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Rob Herring <robh+dt@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 1:49 PM Qianggui Song <qianggui.song@amlogic.com> wrote:

> Add new compatible name for Amlogic's Meson-A1 pin controller
> add a dt-binding header file which document the detail pin names.
> Note that A1 doesn't need DS bank reg any more, use gpio reg as
> base.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>

Patch applied.

Yours,
Linus Walleij
