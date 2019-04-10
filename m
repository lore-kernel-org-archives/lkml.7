Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA934C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABC320850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxvZOSVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732737AbfDJO0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:26:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39326 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731971AbfDJO0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:26:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so2314709ljg.6;
        Wed, 10 Apr 2019 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNT8cKVfeIi7uAkEe1ZbC3EOVjlhbfRiqWYvgGhOSpU=;
        b=hxvZOSVXLpGJNzR/H4f9Gz91udtTQtL3pLwAum6no4hIHKAfCWMPLqTxlnU15oLf6N
         Qh4GV5NbbOp+zkWnubOICh6csky4HsdginEzcvKqnKm+rLubBCz5lhd5WpwEwwyrm0aK
         xu+geq0OyR21JmiMtJ6tkO1HNudtM5eN6E7VBN30sjtTtBu1kesNKpxIyGwTjc/5xM7y
         RlqHCq5rCW+0hZtXGDEz6pxEWRJJmuoNQwFr/W7LdHf8ISA8ZDUpAKtkQ/W8iNu8KhrD
         rGsPjf7h3ZX232vDRcEZd6fbSiVF+S1W7Kzo4TVbB0BCUONoVMI99FnHlAjGm8BwPs/v
         /tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNT8cKVfeIi7uAkEe1ZbC3EOVjlhbfRiqWYvgGhOSpU=;
        b=LsuyxUOXKFA0rhG+zIOFaVXljuIrFL0K6bLZBHGkgZS7Va0VzFcHiuh8ej07ckQcgM
         mjFYIknEgjyx4oj14VW9vyzQAdByMKpiblBL6ceB6/rnO6H/Wnxce8sdXFEhmO0mWbLZ
         qO8PeWb2kZpaGZ3xVMTu5zGhAQOumfjC1vhfS5TVRUb1n4jPe2wt5355rwYyrC9U7Trs
         j4ZdtlvIMKoJ9sCnNaAuHU+ITOY3D3r7ISPGzw2A2tnNpzGz4oGBa4npE6TPY9z/xIe6
         biKKal/3gWew1FS7Zy62bFO39ztkRBPtKpT3qJi6VwM9Hl6fww8U8CfUsP0N+d28cU1i
         aTbw==
X-Gm-Message-State: APjAAAVYevfHeKn8+Krzluepg/D8NUOJcNnNXUZGengXhwrHtgpv3DTg
        FpIhBvmwjlqDlBQTQ+ULBbGfVmUoit+5mhwjrkg=
X-Google-Smtp-Source: APXvYqxHd755icfvww8fjK4Q1wSOaGRHRC+OMoeABHe27VJHeKhddhShRkz0ROeDCtpxUMloeEdgGPQRNSXS/l3sPEo=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr23144071lje.138.1554906370195;
 Wed, 10 Apr 2019 07:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com> <1554894380-25153-3-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554894380-25153-3-git-send-email-viorel.suman@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 10 Apr 2019 11:26:04 -0300
Message-ID: <CAOMZO5Aw=Z1-jKkG07mHCTmVhFE6GLG90-qiuMQfNUXAoze_xw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ASoC: fsl_audmix: remove "model" attribute from DT document
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Viorel Suman <viorel.suman@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 8:06 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Remove "model" attribute from fsl_audmix DT document.

Please provide the reasoning.
