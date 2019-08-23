Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA70C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808C422CF7
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DubrrLXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391144AbfHWHwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:52:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33940 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732838AbfHWHwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:52:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id x18so8024363ljh.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqpwIMCq4y9TWYu08ngpLNeK2cRwz3qeYJT+U8RgRXY=;
        b=DubrrLXkoiYf/fFwa21azYYe43fLHngxuHKyq7387+Xa0R0Ff7zONRqKscfvffrNGV
         xvigud8tSrm9hg2nb8/TtO16kqEvOUt0akzEULGED8Y0T1bkMcGum+zqpT9cDEubuxwH
         zDtMB+FG+h9mOlH0GO/5JUOIYRtup9FsgSXyMbXSH0v0zu95BVHpnO1Kv0uauQPnbaQN
         5iv7ncrpq6JE1kyhB4tmhP8salJo4dzrG3ceLVnfRJhb8EOfy2yI5PyZG7o7nknFYOb4
         PaMq+OOt5MpDwHdQivCI3RF23PTm/tHeg0D3RtIQVtlTBdG62FIvyqLB0f0/PLrSLxtW
         1rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqpwIMCq4y9TWYu08ngpLNeK2cRwz3qeYJT+U8RgRXY=;
        b=DdLDPbb6QTVLEquCJDUi7uiR5jt8ObDJ7qu8XksUe44kNLJPNSmoLBb/HyL3d/QOG8
         ydjVyGM4843secocqo36649gFRuhhSIl+ifgqKV8P5UP/QC8UJCL++n38dB4jStjQnKS
         /C0lSDewiIFk+EeyDjepW+SR9l0bL7o4WWZgQqwCMsrWVHEEFHzolq3+rmJhM4VpDrm/
         sSEp7LoQtzyeJtMsP5XwvgUkXWm9D63G9wvVFQSsCxTdh6UhqN7Tcx19vDK3DpXiZksl
         9e/gyCDCxy2FXImRA2spsL79I4Ls+Lfjval3fx3EDYkr1srRxuxgmoxlJJKA6kMb8uMe
         MqNw==
X-Gm-Message-State: APjAAAVXr1g3GxhXLoUmpjSEzODjkKF31Divmn03nfrfU3kH4i2MBYc7
        bvs76U9Y71F96WQ4SQKElAxi35Vg7PIkW55JOB9PHw==
X-Google-Smtp-Source: APXvYqxKaJvKhF13Q1aLZVUTLP1o3k+sNGLKbFE8QiSoT0WUr4YT9FXA/najFQ6V2Iew5rRXx0yaKkpm1sgPJmmTTwY=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr2103001ljo.69.1566546768877;
 Fri, 23 Aug 2019 00:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <1565686400-5711-1-git-send-email-light.hsieh@mediatek.com> <1565686400-5711-6-git-send-email-light.hsieh@mediatek.com>
In-Reply-To: <1565686400-5711-6-git-send-email-light.hsieh@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 09:52:37 +0200
Message-ID: <CACRpkdbpsK08mYX_M5vvaExR2HCa8ct16zC92euLJzewYEDG-Q@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] pinctrl: mediatek: Add support for pin
 configuration dump via sysfs.
To:     Light Hsieh <light.hsieh@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Light,

thanks for your patch!

On Tue, Aug 13, 2019 at 10:53 AM Light Hsieh <light.hsieh@mediatek.com> wrote:

> From: Light Hsieh <light.hsieh@mediatek.com>
>
> Add support for pin configuration dump via catting
> /sys/kernel/debug/pinctrl/$platform_dependent_path/pinconf-pins.

This is debugfs so rename the subject "*debugfs"

> pinctrl framework had already support such dump. This patch implement the
> operation function pointer to fullfill this dump.

Fair enough, that's fine.

> Change-Id: Ib59212eb47febcd84140cbf84e1bd7286769beb0

This has been remarked on before.

This patch is missing your Signed-off-by, please fix that.

Yours,
Linus Walleij
