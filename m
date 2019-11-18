Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDBAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185A9222DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEC8B0+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfKRT36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:29:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35568 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfKRT35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:29:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id r7so20336333ljg.2;
        Mon, 18 Nov 2019 11:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9gvdExQj+gC4p+o0SknSJZUs0PlwD+sg+mCP0dwOG8=;
        b=hEC8B0+od2bI78b7/L/PyvKCqYt/GiytpTHFRnjM3RfByE8ObeRNnuFMxmNYntW0EN
         sIeWkesuwdmoESsy3I7CDFPrOSuq4L0YTHxC4czXDRGf2Wo+brM9rcjf1kavDFbDFfV1
         Wam/1EFXlirLkSf/C8YtlMLe3/8STuhhczxYDY8usaKrZq8mS74RXInZ1Mrru4cri3kk
         HXUWyOcIesf42qKXa649ne75VG7bZOKabib+yrGVOl1s8FuUkJ+OsfFNChyZuNkrAHjP
         fj6sQg5JHUNBLLYSljXj8SMxIucwDlY1s1N87rSFG+sSEl3Xy6hk+YIG0ODPY++UVJhy
         07vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9gvdExQj+gC4p+o0SknSJZUs0PlwD+sg+mCP0dwOG8=;
        b=Wk4x2D+YeD+0ANfqVoEg0Lq2LAjicJnqDsR7Sz3fXlHB1kCab+RkOM48Eu9spUZlDN
         zVC5lXHUpwtmmk1KFNqlfK7T9K03wn5vtYhwEn8f90Eb8vyVekb5sWQQ+F6A/23z2RFf
         gQjqnLdGserTjcTO0G87QIhXbaozveuUIPBvf58gPIUjGm2bAgWOQNbOAp6MAKCUHTKG
         JLongvUVldbj6SZPz1a/s6UZu+UTYu3VGR5CjvhN0EgqFqZdaW1mDNCAlIK2m+yAUZT9
         XpsvsKEsXxcJcvLV2B0eaHRBpbLhecp5V8U0/mj0EsG0YshTbMjIsfFlULXwNYzjlAmE
         mfXQ==
X-Gm-Message-State: APjAAAVZWabJz/XDlbmunYvmXW3R0USMmb879jH+J2SEKN8rt+8DmI3T
        8cNnHQCvye6ktgcYaGkWLgY5rFEMgY7ln9TV731zPWRF
X-Google-Smtp-Source: APXvYqyHoLBHZO5k1AZGIqxXvYds4sfZiOVS5GVnHHRnJiL4MPbxZ7032Gt7NSvLn9bd5SQaFGLhNADZMhpzZ8tGncA=
X-Received: by 2002:a05:651c:d3:: with SMTP id 19mr822507ljr.202.1574105395454;
 Mon, 18 Nov 2019 11:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20191114195609.30222-1-marco.franchi@nxp.com> <CAOMZO5Asp-m7zyY6dp72_VKZs0OisxX4B-PJtP4=GuE_-XDBsg@mail.gmail.com>
 <CAM4PwSX+tkCwt2vmBB4-WAdfaTbxUEutGjzKxCVQiAnWbtD3JA@mail.gmail.com>
In-Reply-To: <CAM4PwSX+tkCwt2vmBB4-WAdfaTbxUEutGjzKxCVQiAnWbtD3JA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 Nov 2019 16:29:49 -0300
Message-ID: <CAOMZO5BsRMQUR1Noj_XXs8NBr1wg53aS7126kqaUot4=g8esZg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: freescale: add initial support for Google
 i.MX 8MQ Phanbell
To:     Marco Franchi <marcofrk@gmail.com>
Cc:     Marco Antonio Franchi <marco.franchi@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Mon, Nov 18, 2019 at 11:16 AM Marco Franchi <marcofrk@gmail.com> wrote:

> > Also, is the schematics available?
> Yes: https://storage.googleapis.com/site_and_emails_static_assets/Files/Coral-Dev-Board-baseboard-schematic.pdf

Thanks. Would you also have the schematics for the SOM board?

I tooked a quick look and I see a ALC5635 codec, but the dts shows
WM8524 instead.

Which one is correct?

> If I applied this change, I won't be able to boot the board, due to
> the U-Boot dependence.
> Should I try to apply the U-Boot mainline support first?

You could build the mainline dtb and rename it with the fsl prefix
locally so you could boot test it.

Forgot to mention, but you also need to add a separate patch that adds
this board entry into Documentation/devicetree/bindings/arm/fsl.yaml

Regards,

Fabio Estevam
