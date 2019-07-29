Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C095CC7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97826206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyxTI6kA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfG2QKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:10:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36849 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfG2QKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:10:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id q26so42493361lfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npRMv0SA0p7PANP5eaT2dvKRy5JgSkEUbJ98gB+GiNA=;
        b=kyxTI6kAj6pudtAvy2uPFUZdvC2mEvsH9RAuosmIvkEdE89FXzSgL3gTBEaqAgO9Ke
         txA7wcAGjbL+v+3OV4KCv9a5ZSnjvEL73vbaRGfZ4swVZ0m8XOx3Q/lz/hpsdu1y4Zom
         DEHmi/26n2aPc+fdyjlt+qAowiXJ4HD2dlPVzFqCJKYg7+T3HBSUrqTLkltaafB18aa7
         Id1eomu8LsbZ6Gn4p71PptmeIXAU29NXY0ZwrBXQ2/8vcTNlUupL7JpsOMLwj74sjAMk
         mbufnAXbQhbZHPjn7FjOHUvODjpyjK3KOfOR+OdrpEIFsrNcZYRvoqPvezfLYcg0Ex9W
         liEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npRMv0SA0p7PANP5eaT2dvKRy5JgSkEUbJ98gB+GiNA=;
        b=SRCtt+MCgMssSU+UKM7KuILOtwkU5TXCz2x+mCgyuAz7SyX9JRBKV3zyjNiJrP28F+
         FJsoSxnW/zvJibg83WxevkkOwOQ0EhnVaU2hkLuJW9RzlpgpmVHoidtvfQsH7rKeZJaO
         p4IX5ocGq1Ujt3uJXHtttDUnXc5Tj4PoTswa7E9ABZiXBhyStmZcW+gcWOBnOdu+N1cQ
         ZckUC+fR5uzloASdSqPDxIsK8NMKeshFM8UMCQ2eTJA4Tu4ZlrMMKN6FgnMCSdu70osA
         /0mT8vp+P3QBtgyOZqT+oIPHGjhd9Idp0FbkD91PAc7M8givZvDfHrCAiQ6Sa7hDILd1
         Wu/A==
X-Gm-Message-State: APjAAAV0Z7xuxE6ynFQWt6sbaGm9KD3swm2Yt2ZItcZQxpKVYxOj+lEn
        GaqR8loN4f8LC3R9AZs1h6+l3Rk8L1/f59y/8Ak=
X-Google-Smtp-Source: APXvYqwdz1CgAj9YWJEywVjy5/+ZOXM2PAZBpcZzhiq77Jtw7OAINgOfRbirJI/QNRtMdrSjifGSh2pMRBRpwUejJb8=
X-Received: by 2002:a05:6512:21e:: with SMTP id a30mr32590426lfo.107.1564416630026;
 Mon, 29 Jul 2019 09:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190729142316.21900-1-martin@kaiser.cx>
In-Reply-To: <20190729142316.21900-1-martin@kaiser.cx>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Jul 2019 13:10:35 -0300
Message-ID: <CAOMZO5BDY5poV=bGGZZB8=xYTNw-Q7rTXRmqarpTLJMxngB4+g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx25-pdk: native-mode is part of display-timings
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:23 AM Martin Kaiser <martin@kaiser.cx> wrote:
>
> Move the native-mode property inside the display-timings node.
>
> According to
> Documentation/devicetree/bindings/display/panel/display-timing.txt.
> native-mode is a property of the display-timings node.
>
> If it's located outside of display-timings, the native-mode setting is
> ignored and the first display timing is used (which is a problem only if
> someone adds another display timing).
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
