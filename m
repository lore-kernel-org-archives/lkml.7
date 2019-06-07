Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD70CC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73216208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6Uttyul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfFGWXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:23:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35078 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbfFGWXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:23:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id h11so3047987ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKQ/jkVDmHzG3Imk3QoYm7ZRsrxgpBXEW32JYoXBK6c=;
        b=b6Uttyul57zhK0WLRFY2uElrt+7RjU0A4CqB86e19BlOPEOButGb8d+RfNG8TmtLB/
         hBYKaq1+NEQfc2TXYpAX9tB+2jG8DNuaZf5sdL85L4+yBSSqlQ0j0efAavrSbhlJ8QM9
         dnMVqvx3u5kJJXi+BuQLcqU3D1MwwvOPoW0lo6mYfxYoE5VsfLGSZSc0/bMEdRBNrPHz
         q99sHZs3QMahC9tKZJMU6C40PoGzO75S325tIkzoa6Ewy2EOI1HUtO2aG6v6ukATbBGP
         PgIbNsEzUVwnw8k8NofrSWHlXcShNIz6Rp8GGnv+pA+JAaq3n0yRBc5FXY92rMC7E6lW
         iOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKQ/jkVDmHzG3Imk3QoYm7ZRsrxgpBXEW32JYoXBK6c=;
        b=SqGd0blXVgJbUSSkp7u8WvBq8tVZClPifwBVo5Bmqz3jOI/ZRZcdFeYQMWaizGWnRY
         WQ/n/1u8RwtSBPEBBS4sOoj0TFyTha2StmqC6JEaybrewKSQwPEPlzYfadw93zgajC7G
         jtgOhaKudRcnqt3TJKYOxMu3m/uabLbb1tZtJP244IQUUpg/reXyi7oCMsql76+TSyKS
         M65Kfw4Czu9q990f9rKbUswwUM5UXv9r5gQ2d73ua9Hf3CGFdH58rfksefI32iCmaqmH
         eMaNNqwai4DwnQbF+lWztELy4lkqcc1zFn+bRwr9YXh9PXSrll190iwNeO/GJkCGIoxs
         AS+A==
X-Gm-Message-State: APjAAAWIA0VhCkzoTaDBVqm3gjh5Ejoqh35rpQqTmdf+biHjr5awyZHp
        JayP0y172GupoCfZt9Jce00a5K6DTlA0k38nz+Nfww==
X-Google-Smtp-Source: APXvYqwB2qJJmkpZg21BBIfS3DEIvPDBmZVSisAyl2+8KE4YGuHY6alNrysBJaP17ZsV+0U5Xx/P5PNamh/WkwZKcrM=
X-Received: by 2002:a2e:9e85:: with SMTP id f5mr23337666ljk.104.1559946209241;
 Fri, 07 Jun 2019 15:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <1559685212-15857-1-git-send-email-hongweiz@ami.com>
In-Reply-To: <1559685212-15857-1-git-send-email-hongweiz@ami.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:23:21 +0200
Message-ID: <CACRpkdb=NBkqG1qi6F66pcd7UaxmpT9LFVLaCLFrM2SXDihJng@mail.gmail.com>
Subject: Re: [PATCH 1/3 linux dev-5.1 v2] ARM: dts: aspeed: Add SGPM pinmux
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 11:53 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> Add SGPM pinmux to ast2500-pinctrl function and group, to prepare for
> supporting SGPIO in AST2500 SoC.
>
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>

Patch applied! I altered the subject a bit to match the change
to the pinctrl subsystem.

Yours,
Linus Walleij
