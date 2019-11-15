Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A736EC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBAB20725
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573781605;
	bh=TjfPdNVPIeEvReyGDHdp+l0oWyIBAlhdiKCkIA2SxF4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qtzZ30ro95BNtu/RbKlupvbOPlgIP/bmQXwkjekS40rNl3veuNfVnZ5fYs5J8Gr4O
	 agrQMAUbU7o6NpAD1j+35htt7kvGQao6Mq4ZwyIiZ9queei+l1IBTxFtIHpe2Tlhjr
	 QeDm6jbwfalPs2th4xLMH6gkbI5bNaURSRReE2rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKOBdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:33:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbfKOBdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:33:24 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DB2820725;
        Fri, 15 Nov 2019 01:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573781603;
        bh=TjfPdNVPIeEvReyGDHdp+l0oWyIBAlhdiKCkIA2SxF4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wXwmH1o9Ntc1eiYydifMeSePrvyPdp843OoG1MKhziCfF0WKkKntoLojZuqNXZSWQ
         XRPqSbpgzjleJDHBFSQd90rNYLV0/lkKPUaCvcZZ2Z0Ui6dKVLAOLqry7gLks5DZG/
         hGCABoAeV60FY/M7dMTGMagtjKD8VKuUcn7yU7PA=
Received: by mail-qk1-f173.google.com with SMTP id z23so6812489qkj.10;
        Thu, 14 Nov 2019 17:33:23 -0800 (PST)
X-Gm-Message-State: APjAAAVwUWy/o344JbZIiInJo+26DxxbwJYFjWlu1+hTAkWstT44Yg/b
        L5Jv2Vzf889RDvtHaP2TcVaZdAd5eCcx7aJWAQ==
X-Google-Smtp-Source: APXvYqyrKS5cVeQ3i3w1IPqL0wZve42ikZtItrJjuSQMwNf9oO+9PoexTpjhpJX3Vg+HensaTGHh5ytaFFs4FY1vmfw=
X-Received: by 2002:a05:620a:205d:: with SMTP id d29mr10453959qka.152.1573781602693;
 Thu, 14 Nov 2019 17:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20191031165308.14102-1-afaerber@suse.de> <20191031165308.14102-4-afaerber@suse.de>
In-Reply-To: <20191031165308.14102-4-afaerber@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Nov 2019 19:33:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKON3rp61e=_7D7zD6k7XFJxbwEziZxWeKB7+i+bnTGPA@mail.gmail.com>
Message-ID: <CAL_JsqKON3rp61e=_7D7zD6k7XFJxbwEziZxWeKB7+i+bnTGPA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: Prepare Realtek RTD1195 and MeLE X1000
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 11:53 AM Andreas F=C3=A4rber <afaerber@suse.de> wro=
te:
>
> Add Device Trees for Realtek RTD1195 SoC and MeLE X1000 TV box.
>
> Reuse the existing RTD1295 watchdog compatible for now.
>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Dropped /memreserve/ and reserved-memory nodes for peripherals and NOR=
 (Rob)
>  * Carved them out from memory reg instead (Rob)
>  * Converted some /memreserve/s to reserved-memory nodes
>
>  arch/arm/boot/dts/Makefile               |   2 +
>  arch/arm/boot/dts/rtd1195-mele-x1000.dts |  31 ++++++++
>  arch/arm/boot/dts/rtd1195.dtsi           | 127 +++++++++++++++++++++++++=
++++++
>  3 files changed, 160 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rtd1195-mele-x1000.dts
>  create mode 100644 arch/arm/boot/dts/rtd1195.dtsi

Reviewed-by: Rob Herring <robh@kernel.org>
