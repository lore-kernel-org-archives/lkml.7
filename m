Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD28C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B943D207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVORshqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKOLPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 06:15:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36033 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfKOLPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:15:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so10559085wrx.3;
        Fri, 15 Nov 2019 03:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8V3MrejWzhb3k4NOooEju9diG1hvNPQtxVaPIcJims=;
        b=NVORshqCuZdXdiaY8iP1cBSWLK+CvUqi7Af0gAsRD/ShCjZhqh8dVBaa5lfPTrMZmJ
         eCmFTYid3RyKKJiOl47W2eWX7KuVs8fSU3BkLrwXLi1wYZpdTKH8mrmqpcaqeIbhhPn3
         MpLrABTJKeb6KrvU9ayGgKU8C/2p+ErhYe/a0Y5tvgbeozmMOHJxj4UExVr5Ski92DUT
         +AO0+HB+ewFy0bRK5O0eSt+zUKhjzYGiz+OWJBx8/H4d/WzUcSV2mmP37FHhdNeuIQE0
         DkwwVRd1iv+bCME9PqnUvc9LBbuldHeE0bi85Yo8cnPWHX+S+cVNhTzuYVjQsJw1ejSh
         A0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8V3MrejWzhb3k4NOooEju9diG1hvNPQtxVaPIcJims=;
        b=NdOXt4vN1T+EooyzlbiSfJrRs5g819j3ogrGva6XiwxzoSj0kN8vbOP8F0IdYloKS4
         QHwC26FEt0i2rG2kB/pmir3QlC0AEjI5NMyUG69hmunlz1UL0OO5eoTQw31m3lPOXoo/
         noGOQoFygh3RQVAqnZmhsHXElqNlaHEZWA2VNweNdg7ZLMZc0o7jpeBO36lMRd7FjmFE
         jxiDWRPWWso/CYRptHmDbPcPzQ028eV61Vly8o3wcAioVhrPqijfp3qTb37iR1IZREEG
         d0udFb9AzyO9rVcW4JqKyRisK+WssCsoW08zy+lGxKgWBO4eMC1Yde5ha5d83E4ezUi8
         z0LA==
X-Gm-Message-State: APjAAAUC9M3/0dRByHpktCS2XQZh+8U5RC5NNoNfiHULWjqZJJruFkHQ
        17bwb5rvwR61aXj1nf2wQNxxrOSk/LW3c/vBPFxfnmFY
X-Google-Smtp-Source: APXvYqxsBWGbFcyYwphuRtzfWV4fObMitrZ9jisVvO6ZMo8vLhTodwoUcAn9cTLjg+hKCSWEpzMwJT3RLwjfQsgOQUU=
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr4954748wru.35.1573816504400;
 Fri, 15 Nov 2019 03:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com> <20191111090230.3402-3-chunyan.zhang@unisoc.com>
In-Reply-To: <20191111090230.3402-3-chunyan.zhang@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 15 Nov 2019 19:14:28 +0800
Message-ID: <CAAfSe-sCM7T2TZ25hgXSdqOCWzXN2J4qeoSRi8bveqnwGy3vBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: serial: Convert sprd-uart to json-schema
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, 11 Nov 2019 at 17:03, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:

[cut]

> +
> +examples:
> +  - |
> +    serial@0 {
> +      compatible = "sprd,sc9860-uart", "sprd,sc9836-uart";
> +      reg = <0x0 0x100>;
> +      interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;

Seems this setence cannot pass dt_binding_check, it need to be changed to:
interrupts = <0 2 4>;

Do you need me to send another patch, or you can help to fix that on
your tree :)

Thanks,
Chunyan
