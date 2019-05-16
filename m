Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C44C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADFF20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k23/dPqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfEPSfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:35:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45945 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfEPSfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:35:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id n22so3379985lfe.12;
        Thu, 16 May 2019 11:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+idWcmjPST3Hl3czuPFrU6/6AI2HPcejFwVYPK17aPc=;
        b=k23/dPqHAR3dXP7Nj8FpaKzc5p6ZT7V2uAVK19Zd4XHc2cIezlyg7qupevZjFs19Wi
         lgElBoQUKnWDDb1Shm4aylkFJiBVCxa3ai79L1sv5oHRagmXUnAckeuNn+6+TMvPWWYS
         xc5z8qaVXJsy1ZT/svee0CRUGvYVI4Li0PakbgOVC2hQkypL1Xre1n0CNswYXkUTjg5T
         T9mGXMLpCHK3o0OJrOFDlORL+om+R4ww5oxNkNN1hidCgMMOjpJz6OVcLvhP2ttDcSg8
         eEcBKmZ71eZ3zdD0Yz0+DtkYyAGPVj8JvJUMHftIpb2EAQE76/Wguyc3Ktxw/CAeQVTd
         Z3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+idWcmjPST3Hl3czuPFrU6/6AI2HPcejFwVYPK17aPc=;
        b=F8Eboj56kr7sGj5UklsSN36Q4BUhW/k0dhYvIUbzwFVebOiFRn4luKTBC5Jm4LWzAX
         G5SMHERiMkHw+I85PrdcpnLw/el/kn/WxDM3HXEUR9dvPEDb0EbZ5gB+0/Xx9cZcVYGi
         8W2gk70QQtQ/PYvLIjILWgQsyKPVErj9FSzSIZqvwaVJAiMuj6iC2SXTbr28uHkH4rii
         qGmolRK2BOFnUQZZt4bwECFfDJLuTZ6gqDPxaF60ngLf+4pgUtUcXvg25221khF1FPC1
         1oPnpQ4y0yHk1+ismAkBRt2Tjgw9nLRejLWxDipF0FpCc647R1yiYWk4GypWY1h+omir
         izDQ==
X-Gm-Message-State: APjAAAXLO+/GWfDU5BKafXTI4T47wFleAynUSA7QqTCmGYgDcfNevPAl
        N6V6Yygt1EXRLWYblTVR2C5GBa6fbv3l7dC4arw=
X-Google-Smtp-Source: APXvYqz/Sid4tmtq5GFJTviFYQ/KFKX7b/x5MgwIHDmCFilPniFlpoSr6HISlpCPi0Da7K8HcAQ2SWuZWgFFg08Qh3M=
X-Received: by 2002:a19:e34c:: with SMTP id c12mr3562928lfk.145.1558031716748;
 Thu, 16 May 2019 11:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190515144210.25596-1-daniel.baluta@nxp.com> <20190515144210.25596-3-daniel.baluta@nxp.com>
In-Reply-To: <20190515144210.25596-3-daniel.baluta@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 16 May 2019 15:35:06 -0300
Message-ID: <CAOMZO5A6Gv5k3up0AtKrhQPyMLMe_8SXift68KEP2J+j8D_cJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:42 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:

> +               simple-audio-card,codec {
> +                       sound-dai = <&wm8524>;
> +                       clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;

IMX8MM_CLK_SAI3_ROOT is the internal clock that drives the SAI3
interface, not an external clock that feeds the codec.

It seems you should remove this 'clocks' entry.
