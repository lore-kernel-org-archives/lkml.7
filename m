Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314C4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0BD2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242518;
	bh=ZnqWddNa7Rz+t2BiSJ6GxPgyyCMa9QmktYNfzRHXveI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IrUxBzb4/Xuk3gBhvbQZrV4x+zkJHJ6buMHNTI43C1bx3BoT6UKABPTKJGpi6iLvq
	 INAigLzzoOFcTR0mvGfgdL8MIfayhcLg7TifUy25MrCPFsHenyCsnVjFlGaswFJfqn
	 pfCH1SBzl3FzEVV+StCYvbbJ7KEji0tcgA+OY5yA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfHSTV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbfHSTV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:21:56 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3156B2087E;
        Mon, 19 Aug 2019 19:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242515;
        bh=ZnqWddNa7Rz+t2BiSJ6GxPgyyCMa9QmktYNfzRHXveI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0PqPUCX/5rAahyjp2+wMnTU1KMuIi8N50pI0o/yTankh4WaSJSUlDPThE5a477H98
         hTjg3Bvg+xEew88kmWrNPeCarrrBCk+dfQOyYTMAj9ei5FQG+k8TxyhVbcaf3N779h
         cw9VGm314vA31G7Dx3Ir5T0E5gOEhDp6J56Kk/yU=
Received: by mail-qt1-f176.google.com with SMTP id y26so3181237qto.4;
        Mon, 19 Aug 2019 12:21:55 -0700 (PDT)
X-Gm-Message-State: APjAAAVNlRS/5DvrFLmj+kvcX0gi5y00d2rJrCW78w7poVCGaRyQqvFy
        V9FD4tHAqE8rNYAPDXLd0N9HONNRjPW6gnbSWg==
X-Google-Smtp-Source: APXvYqx9XuvRiV2Apgg4lwgIvKoE2Nklh9cbFOgdE0XW6cxtwo8T75kyR2R5r1nXiQF1fSxb2DxbmmBvu5nb+yGMf2Q=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr22391797qtc.143.1566242514433;
 Mon, 19 Aug 2019 12:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <1566199149-5669-1-git-send-email-masonccyang@mxic.com.tw> <1566199149-5669-3-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1566199149-5669-3-git-send-email-masonccyang@mxic.com.tw>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Aug 2019 14:21:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJB7JgSTcp9oVhnqxp7Xq4P1wj_sxggN-r7RXd8pOQ2xQ@mail.gmail.com>
Message-ID: <CAL_JsqJB7JgSTcp9oVhnqxp7Xq4P1wj_sxggN-r7RXd8pOQ2xQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] dt-bindings: mtd: Document Macronix raw NAND
 controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Vignesh R <vigneshr@ti.com>, Stefan Agner <stefan@agner.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Julien Su <juliensu@mxic.com.tw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Liang Yang <liang.yang@amlogic.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        anders.roxell@linaro.org,
        Christophe Kerello <christophe.kerello@st.com>,
        Paul Cercueil <paul@crapouillou.net>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 1:55 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
>
> Document the bindings used by the Macronix raw NAND controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mtd/mxic-nand.txt          | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mxic-nand.txt

I would ask for this to use DT schema, but given it is v7 already:

Reviewed-by: Rob Herring <robh@kernel.org>
