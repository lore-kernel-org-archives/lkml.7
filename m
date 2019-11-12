Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8AAC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B9F21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmruY7yE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKLBi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:38:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41305 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfKLBi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:38:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so16683636wrm.8;
        Mon, 11 Nov 2019 17:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiULEZkokgNmMrqFci3Nlwk7YUL2pDKG1OagmCeHKvI=;
        b=dmruY7yE/dvccXk/rZHi6iA417hakL/D4k0+WlWyVHS3lG66vQGEGdLZfyfXFH3Fo/
         xzgu3YOr1Eo7FEUm84GaDxtxo/quydotTWFBtlb/Q0ePub1uYuvz91GMaWay5v1DcjqT
         a7hssXl5vvxYG6AylwOzUpw6F4UO+YdlAOV4ulUZIe4pCYjv9mqtzd1sV9fgmR/MQuw3
         pS/Pkk90WHUkObOaL/7CqwjB+Ew9SOKfVxaORz0WqWjXCnIpMUAt9dg5at21AP8yUh8T
         qzMpEnJdWFT6g2iJprBWI3xQckE5Fyj2fQlqSXKa+W8YJ7L9kcbvdG9y1Z5MCRx6OHgk
         n/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiULEZkokgNmMrqFci3Nlwk7YUL2pDKG1OagmCeHKvI=;
        b=Jq00SQJ+Q1upx/qAkAPEPJc1zcOH9dYLXZrT86kK/Fk40dNYNT1XR642RHYafXqPTU
         BRf9n40XGc3XJ5yEqUb0LQh3F0XZ5NB1uSGdoyjQoNtrmo+/UHhmYRR6GyWFzkwnZoD+
         io6MznA80nd+G27nRHy9HVmk3vXYafKOtmF76u4yBBOimge11eLDSWIim6kWxgyRMJ9N
         qSvnKlE4bLWqFTVOfTMvCoMOSfbl65FR9nmRKOE4F04SD+AmhQ6lsfi1/mI6fh11NB8D
         tZWF39hIRSlVcmkm6ZyCF4RDR73R4JDUAS17Byh9WHyY37/x8egllxPlnA1eGMtm0CTd
         kQuw==
X-Gm-Message-State: APjAAAX78coPjXm9I7ILn4jucVojNEqXmobEfZ7oH3dousn+BObbfNu2
        q9fcSeDKCVGxLL+clTTrb/jsCHTY4sY/dVH1vUjIazdU
X-Google-Smtp-Source: APXvYqxXYyG7hCRjp8kmObfGVJp0w42islnFxgov672V5SeQh1/RJn08uQQh3TQcyy85z1RrDTE69+WTJFPVDtId0sQ=
X-Received: by 2002:adf:f547:: with SMTP id j7mr24219844wrp.69.1573522734750;
 Mon, 11 Nov 2019 17:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-5-chunyan.zhang@unisoc.com> <20191112005600.GA9055@bogus>
In-Reply-To: <20191112005600.GA9055@bogus>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 12 Nov 2019 09:38:18 +0800
Message-ID: <CAAfSe-uohXXHyQ7txhPmLCpyQODDHAuxjuUVbGcwYySN6G9tNQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: serial: Add a new compatible string
 for SC9863A
To:     Rob Herring <robh@kernel.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
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

On Tue, 12 Nov 2019 at 08:56, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 11 Nov 2019 17:02:29 +0800, Chunyan Zhang wrote:
> >
> > SC9863A use the same serial device which SC9836 uses.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  Documentation/devicetree/bindings/serial/sprd-uart.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,

Yes, I know.

> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

The reason was that I switched to yaml rather than txt in last version
which recieved your Acked-by.
Not sure for this kind of case I can still add your Acked-by.

Thanks,
Chunyan
