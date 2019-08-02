Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB55EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EEE2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBxO6004"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbfHBDyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 23:54:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45741 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbfHBDyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 23:54:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so75637593wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 20:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVqjc4SdzxvCshXdZKDlYnySqqfw/iPc/gG+SV8VbwM=;
        b=kBxO6004q3rhYWAVNzIZNtb/WL8zj3N1Pu2zH+LEBTWUQp4XLD2XKnvwBjGSqD8SRT
         M3w1KabHdm2hPnAMf1b24wCA41ZW9KaOl/12Kq0fhdZ2qlJv6WD3A+Aww0ObbuiMeWeL
         jIEHFb26zAV+839jrYoawQLynYbtobwHxfn2rRmnrhhDPjaSHyWHuiCNgHCY1krr8Pn5
         tYhM9kiWECemZb4y/RNM4gFvRr/zaeAK/0SwW4ywnaiI8B7hrL96LyrgN3+B5j+Qe2wD
         w/KFRoYLrs/xL4lmLBFoSvkv12HZvOm+TO7tgm5lYPOhF/JYKfqiQ53KYcjZ27D8hoGD
         59sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVqjc4SdzxvCshXdZKDlYnySqqfw/iPc/gG+SV8VbwM=;
        b=OqpQsDmGwMLbGndOJze0FKr7toejdnxT5zmor9mQomtPbayjTSgAdXNPLrXkNFinuy
         Ut3WATsaXTAoXpSKFG8P1EOVhnQNgKx/adSthk4jOqNxBE2bEWI/ir5tiJPs4A+ysXJu
         DKuvUIX420evGIfbwdQ//rmvPlZFQ7aKwcLqCLCn+XcjkmEDkbQYRLO8Hvw6YZm0EX7b
         PJgBccWoFpF0QXMj+gEKrEVQ2KnwTP9o0JgYTGJ8Gav9WSBKjtOMQncEF/xUNUukortx
         68Mq0EvPfrGA7f0dxhZN//vvGc80AziaVGruuwwGSXlS2bHCmxt84/4DxM+6NExHvq+9
         G7cw==
X-Gm-Message-State: APjAAAXWU7/eYzS3SOcxLj5yopmdd4yGrDKON14TOBDQ9bkdIuIa2YQM
        JX2NP1VUX3AHxN20PSRsOWUQaN11bdOQoeooVsU=
X-Google-Smtp-Source: APXvYqyWCf2W+0oBxAYOAcUKe/KR5cL6hEPHRfQUH2gFRlKRc1q61WXi2UXVrjeR7SJrgfQd/UMlBdIhq32zh6m8JZQ=
X-Received: by 2002:adf:f450:: with SMTP id f16mr111399931wrp.335.1564718079127;
 Thu, 01 Aug 2019 20:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <1564563107-23736-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1564563107-23736-1-git-send-email-hongxing.zhu@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 2 Aug 2019 06:54:27 +0300
Message-ID: <CAEnQRZBJTCMYXwBz9pDVGD+7-gE_Jba-5kwXYC8qOPkEBiVT=g@mail.gmail.com>
Subject: Re: [PATCH v3] mailbox: imx: add support for imx v1 mu
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     jassisinghbrar@gmail.com, Oleksij Rempel <o.rempel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One more thing. See below:

On Wed, Jul 31, 2019 at 12:14 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:

<snip>

> -/* Control Register */
> -#define IMX_MU_xCR             0x24
>  /* General Purpose Interrupt Enable */
>  #define IMX_MU_xCR_GIEn(x)     BIT(28 + (3 - (x)))
>  /* Receive Interrupt Enable */
> @@ -44,6 +36,13 @@ enum imx_mu_chan_type {
>         IMX_MU_TYPE_RXDB,       /* Rx doorbell */
>  };
>
> +struct imx_mu_dcfg {

Can you rename this into imx_mu_regs ?

> +       u32     xTR[4];         /* Transmit Registers */
> +       u32     xRR[4];         /* Receive Registers */
> +       u32     xSR;            /* Status Register */
> +       u32     xCR;            /* Control Register */
> +};
