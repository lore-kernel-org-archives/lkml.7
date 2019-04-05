Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70703C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B46121872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI1UKJOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfDEOP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:15:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36248 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbfDEOP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:15:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so5421502ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqwK75gV/Ney8mvOPPcYpO2ABhQB7506lliIiopG9Z8=;
        b=nI1UKJOZZAu1k90Wa3ihtvAJK8LpbgA3Sr3lf3m23LKS6yFdMoEk2ETQjptxl+Rtn2
         LNP9mOvt37CCGByfMXxvQt/us4FUR2mv/3O+r1LOM51bb13P985OkGu7OFRsJIbVPb0O
         xq/foVwpIsZJMoKcg5JiOYn04FOiaa3jUJTr306MGTAiY6VH7emG9M8POZO+3pP1eptm
         n0p88NUhWKTas72J9TMLmomewzpxkbb3a2Q6mrGasvAf2tNQ0nI6/tt6Xie8EYiir07O
         a4fIMGqYkobMG8mn6Clg+tafXRBfrIRjxy+KBTUVBmxrzgDNChKxZKZYNPdlbK0mr3lm
         v70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqwK75gV/Ney8mvOPPcYpO2ABhQB7506lliIiopG9Z8=;
        b=p/+r0qibg6fyEuWIMI3KNpxJsS6rH025UPN2yjB85qfomEUGbGMYfDEZgQ2pm9UUbH
         leuxSbt82YXXkNzN6z6chtexV329IicuE2a2etNpCA48PDv2Bh8lxbIYfOlJS/LnLSWk
         L/cZ/cVMtqEWmZDUpg73gBeENb0LXXXkY2w15CN9rMvkXTqRh54IASJfa1Le9TifIUOw
         eM1KiJG1GKfjSkgAmMzzE0C9B/pbRG4F2Huyqea2FIdSYMCOyhargMdQs82vnuJLEKEQ
         HzQw3CDscX7Qvv7grj5u/BzBalorcRXm56/u07GJhcf8mYqnaMNUYcB/NMJzqyH+iyJr
         jzew==
X-Gm-Message-State: APjAAAWXbbEPRz7X3ZquzgVhcClWPdNEtPQUIFVHuSO6peohOZ0/8w32
        XTe+wSw/uBotkMDhgpxSu9pTL3URvWWdnI8joas=
X-Google-Smtp-Source: APXvYqw3GR1fXkGsk/DwrpvXt06CropD00WWVquBMcuB+nrZrE5ajJghSKP9Uis7sR6oH95nMR0HgrBbTkOC82hOm2Y=
X-Received: by 2002:a2e:5518:: with SMTP id j24mr7034630ljb.167.1554473727507;
 Fri, 05 Apr 2019 07:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190401022413.6682-1-andrew.smirnov@gmail.com> <20190401022413.6682-5-andrew.smirnov@gmail.com>
In-Reply-To: <20190401022413.6682-5-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 5 Apr 2019 11:15:16 -0300
Message-ID: <CAOMZO5Dm4Kj0nSqaZi9B9vCpyDs6Zq_7fw_WndrLAH2DQTJmxg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] arm64: dts: imx8mq: Add nodes for PCIe IP blocks
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 11:25 PM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
>
> Add nodes for two PCIe controllers found on i.MX8MQ.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
