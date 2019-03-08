Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A26C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7691420854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMlqhyY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfCHKcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:32:45 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42531 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfCHKcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:32:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id s16so15448112oih.9;
        Fri, 08 Mar 2019 02:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlgrN4mQ7XignmdImQgiWV15DEw4HqEFyqPB8KfQ+Gc=;
        b=OMlqhyY+vjlqFqRLCDFy31g4vd4IMzgd+RPsXWlwUj9EzxtZ7df7B4tajzc3IS6YcP
         7YB8w5wcKdpm7Mpru231QgXI/KXJ2rbFPnGXZ6uBoVzZFnIGM3+Odk4lvTjIiko5T9nw
         5nsvc+vE4O5uV+bZ4tJSTErEYnXSuj58ce/VpgVc3o10x/o6WR07cQcnY4O67D2tkz2M
         wN7S7useiJss88kfAGZppZRRiOiMEPFUbjND1qeuzRteyCEeRnNUjZIKo0qRC2MaKsKK
         BurV1BdxMw7vAFZrMiplJV8SaRUxa/V3/R7p0w8xq3IjZMbdmK5aQInkqHr8/iPc15wa
         p7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlgrN4mQ7XignmdImQgiWV15DEw4HqEFyqPB8KfQ+Gc=;
        b=bhHcsIdxY/Q+1/hP0Ssm7MiajXlk+uRlQUrqjuxWoU6ptk52AQrVEXuosjGMelccQq
         BIyWiyx9qMTC2Sx1oRcYAsWY9qupwgEPGwu35S/d2IKJ+EGvzw4/dnjSwsxfXoCuldDb
         6UhNeuj6DeZhHCT5qBxlNYrLYf/jZGgZUVJ0FQs1GgjxobZ7KtgDXHZxaEer5bXhs5ao
         zbL0fibWsx8Qpf0jBYxSvtD7Ou767dy5Ml1DAyWySajbD5aIPDojNlbHcnGjp6Ms0aVH
         XLMTbs/or9L0x4Q5R56zxHcT+SUP2mB2S8s3IFRW/KpHt0wrJIXlfxGP5GBEFeMpYJoP
         ZGpQ==
X-Gm-Message-State: APjAAAVm1CFrAK29xWadxljEAawPpVZmaQNJow/F8dVaovEof64JnXRG
        48zYEVW+L1RPeREWVvVEUXcWMRB+N1CdWjIxL7s=
X-Google-Smtp-Source: APXvYqxZ+06K4U3C7ug9RZjNLzZX749mP4L6f5Is0j3Kf3+gp2BWAaWpNqD1n1R7Dv4y241nq2Y/XGojr6CMKVoJmXQ=
X-Received: by 2002:aca:4a95:: with SMTP id x143mr7976352oia.18.1552041164289;
 Fri, 08 Mar 2019 02:32:44 -0800 (PST)
MIME-Version: 1.0
References: <20190227063737.24445-1-daniel.baluta@nxp.com> <20190227063737.24445-6-daniel.baluta@nxp.com>
 <CAOMZO5AY--Q7FDwK-k8u=mkR-9bxz0XWXN3HNZb4Pb+MESZ6Dg@mail.gmail.com> <CAEnQRZCyUG33SbwhPkE95tuaBdJ7Lo9WbVfJz06ZB1-X9ZbKww@mail.gmail.com>
In-Reply-To: <CAEnQRZCyUG33SbwhPkE95tuaBdJ7Lo9WbVfJz06ZB1-X9ZbKww@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 8 Mar 2019 07:32:45 -0300
Message-ID: <CAOMZO5COQNvpbdxG808aRSfMhMHznorPzoCD-Kp7rB6e8jz4Ng@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: dts: imx8mq-evk: Enable wm8524 codec
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, Mar 1, 2019 at 12:53 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:

> They are used by simple-card.c machine driver.
>
> asoc_simple_card_parse_clk
> -> /* Parse dai->sysclk come from "clocks = <&xxx>" */
> clk = devm_get_clk_from_child(dev, node, NULL);

The simple-card looks for the "clocks" properties inside the
simple-card node, not inside the codec node, right?
