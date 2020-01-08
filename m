Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0766DC33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAA020880
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578456116;
	bh=blXanwhUKF/O2mPP2xvjP8uzPc5gl9VfnG9EBi9qDXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BGml7a4CBRzoVGzNo5ezdEmsuC78n0llto7CIJZ94B/I/RrcrA/0OkpdFg2VHNwo4
	 0GKA296OEQKIZanwtWRsgCuTk89l8A//JnDWHheWdGm8HA0yYMcXv7jy1oyr7TEq8Q
	 ousczelY+0euxBdCT2CgnQ+sYofTtnGq68iZbNL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgAHEBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:01:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgAHEBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:01:51 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 477EA21744
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jan 2020 04:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578456110;
        bh=blXanwhUKF/O2mPP2xvjP8uzPc5gl9VfnG9EBi9qDXQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dcHDEN8veVYHLRYJi2IBrEvwMLkxTqRWqWz6sGwXBCeFcgud09yLVa7PXYezDejho
         mLSZ+x16Mo53nyCz5TfVBieWyZNPB0NEVu7g41Z1q+U8gJtxrV5e/qnCd3fEskKHUs
         Hrsss6X++WY8JopgzjIQ5xROrGWPBcTnnIBuAx8E=
Received: by mail-qt1-f180.google.com with SMTP id e6so1712933qtq.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 20:01:50 -0800 (PST)
X-Gm-Message-State: APjAAAWC6lL/i1CJbrUJ/Yy1GpUwXtgl2oYYEPGUuMqcwSbla1RAuwLy
        DZ/I+oH8wLyuImEHjwC71cxrOMLzWQntxW/M6g==
X-Google-Smtp-Source: APXvYqwFJb8dLgGhcgHBSB4r4ovkIRZEnEUzKfJVSxsskY0an7OzKIiPwZU0NjgU+N9o+MZWSlzKwX9Ic9GmEnhELRI=
X-Received: by 2002:ac8:1415:: with SMTP id k21mr1942901qtj.300.1578456109415;
 Tue, 07 Jan 2020 20:01:49 -0800 (PST)
MIME-Version: 1.0
References: <1576845281-32675-1-git-send-email-qiangqing.zhang@nxp.com> <1576845281-32675-2-git-send-email-qiangqing.zhang@nxp.com>
In-Reply-To: <1576845281-32675-2-git-send-email-qiangqing.zhang@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 Jan 2020 22:01:38 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ZJ0asAxaPFgiuHKC2o6UP_5Mht=EascFVpJ6AUoKPvA@mail.gmail.com>
Message-ID: <CAL_Jsq+ZJ0asAxaPFgiuHKC2o6UP_5Mht=EascFVpJ6AUoKPvA@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 6:38 AM Joakim Zhang <qiangqing.zhang@nxp.com> wrote:
>
> This patch adds the DT bindings for the NXP INTMUX interrupt multiplexer
> for i.MX8 family SoCs.

4 versions in 2 days? Don't do that. Give reviewers some time.

Convert this to DT schema please. And make sure to send to DT list if
you want it reviewed. You only sent v1 to the list.

Rob
