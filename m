Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C417C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679B8216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlhGz3hX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfETTdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:33:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33916 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfETTdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:33:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id v18so11223975lfi.1;
        Mon, 20 May 2019 12:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yz8Y8j4LrokiV0kHGKvYwP2NDd57XNHFUFDJFy1gO6M=;
        b=OlhGz3hX9ttMhH0DBkznm5Hzb3CE0esiN2TGXVrnCfKVux3ap139WFhixnnjcuj8Uw
         eXfMa/kv7mROD0/mhmUVGiRFJwtePrDwcTQW7/B/tdXhnmcv0QRvMMF5zbF9/p9/bmDr
         O1urDaNv5xouz1I+cXyIvUiYBkyh0pZpgFD/ERUY5IQWB/faVMwohjpZScS/W80vTgjC
         0lAlN3/Q4/RgH2mIerMYYoR7EKIakurSrEltaxgdnPPpzSPS7FlgWElxwaNYnYP2sOJs
         qIo+ZrKfZI26iPV840NnsVDgC0DKNm5+uBngJcrDG92FN930DQaAv1onmvWe4Kd9v06n
         SeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yz8Y8j4LrokiV0kHGKvYwP2NDd57XNHFUFDJFy1gO6M=;
        b=TPYxaHQsfHI5rGl0kAF/E0b3cW/wayTSO5w3cLNQ8AGKRtnT2cZt5yS7GXbZ9iLscD
         3hvd14Gbebqm5FfjbDVDMCryU6HQxw9U8XiFAhiWNBFEr9/N38RrpddxxIQFoGtT2kkG
         /x0RggAS+Q/F6cJULfuoxbGqSwPj8EMXsU5i++g4KL2j+qzm89rUsJv/j20Qsfj/Jy/i
         6BI4G44EkUDnCkmljwoSmM+0c8c07aX+VpPKfdcr9mII/AatiLgx89ZU+YZikdX8gIfI
         +1KFPecZu93+pLrSiNKuSg8nvj17qPOYu49Fq/DGSsHiTQATdGiB8nbb3sNIrmrQ0+F2
         XlTw==
X-Gm-Message-State: APjAAAVLuYf20QR6aMV1zpJE3kvzbNvlnCkrXJgscavcppEMC5tzpQ+r
        GZj9VZUTvQNsv/B0l9hIGnp58ronfPp6LlTrGHo=
X-Google-Smtp-Source: APXvYqwMGtpeI+8XdPSNDz1LKzf/YqJGUe9ectHzyz4W3M6PXY5URxGKWcyo6ZNyMSayfoXCbU+EFQIkzQAGe+lFTsk=
X-Received: by 2002:a19:a50b:: with SMTP id o11mr24145346lfe.2.1558380792220;
 Mon, 20 May 2019 12:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190515144210.25596-1-daniel.baluta@nxp.com> <20190515144210.25596-2-daniel.baluta@nxp.com>
 <CAOMZO5Avmjf9GpGWBbMJrOxWdvdBTyXMoOPQw_uOQHhCayuHtg@mail.gmail.com>
In-Reply-To: <CAOMZO5Avmjf9GpGWBbMJrOxWdvdBTyXMoOPQw_uOQHhCayuHtg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 May 2019 16:33:07 -0300
Message-ID: <CAOMZO5BO7fXFX=qQh29P7Eji7WaAVsjR++BwiyRbkO9EtfNWxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: imx8mm: Add SAI nodes
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

On Thu, May 16, 2019 at 3:33 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Daniel,
>
> On Wed, May 15, 2019 at 11:42 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> > i.MX8MM has 5 SAI instances with the following base
> > addresses according to RM.
> >
> > SAI1 base address: 3001_0000h
> > SAI2 base address: 3002_0000h
> > SAI3 base address: 3003_0000h
> > SAI5 base address: 3005_0000h
> > SAI6 base address: 3006_0000h
>
> No SAI4?
>
> I know the RM does not show the SAI4 in the memory map, but the clock
> driver does show a SAI4 clock gate.
>
> So it seems we have a contradiction in the reference manual. Could you
> please double check with the internal folks?

Despite the SAI4 confusion, the current patch correctly describe the
SAI interfaces as per the Reference Manual, so:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
