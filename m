Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFA0C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2161E2176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bofh-nu.20150623.gappssmtp.com header.i=@bofh-nu.20150623.gappssmtp.com header.b="jJ1yhaLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfK2KC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 05:02:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52920 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfK2KC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:02:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id l1so13549314wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 02:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bofh-nu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5UrKqSRJKoGBPMgO2/jdCKMQcuQ7A1Ss66dwsiix9b0=;
        b=jJ1yhaLnNR0CYGklrHbhvyokqlCl72QlSTMfSa4E21afa0fYB8h7HwmCoSh8aVQe6U
         iu5bAl6x2CbffFH/bawfVtQgwanXgHO+iS1Gb+OOA06PXIu/PIpL/HJn6LjoQyAkRO70
         fxLYUtGpmfos2QR3CnLxgKJc59EDfltbblF2X6VKh+1o5HkGi+iyOiEa1L1YEFNfaPVi
         Ni5VDKVwx/4bFy8RwrxZNNrw86cFlsDODmaLZv0yCr5qRZSmRt10SSWPFopZ4auPDcDq
         dY3UsZ//d3BFZG6YSXWhh0M8Id1A0ugvSDqZdrW2smTbAWpG+H1lgDdlT80mzZ4SNjNj
         /cPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5UrKqSRJKoGBPMgO2/jdCKMQcuQ7A1Ss66dwsiix9b0=;
        b=aP5GM5AirXB/x4jkEtvikaljuvGxdE97c5DsDAObPYg8iH/zC48b3NvUk0r8u2Pnvo
         VBmbag5v0IDj/f/4vhqnh23e3uRaZjSARzq2FxaUvjZc8IeMc6WJ+sMmmjlR9qZfvye5
         y5GejZliHsD49Htua85LdYWOpNJ9/ePVocQfh2Il8jNc10vl0VuKqncebNRcFlCd/AnE
         QT0/wPfDWarKZ+Y/Qhch2yfIks29jRCyJKxK6FJbpc2y0eO0TQN/dk/ilFtF/UPenloy
         +5mn31E/OWyH2xiEPFgUwmJs4zrDeEMRihCVkn7c+q0rRzDSHYP19/PLA+Omy3uMRika
         W/Aw==
X-Gm-Message-State: APjAAAXvNZTJjR58k6gqGO3iRtxMNz4fGq4YbXtrSSIVTxIxWd0ajhg4
        vj0qlXwkEL0rNTnFKg7vyD+7ve1ApZpmAf+lkJ89vw==
X-Google-Smtp-Source: APXvYqzTAFXNZGcwafQIeJec73W3RgozsYABeK30eaJTije1g+7R6/B3hF2p2eSWHt317C9cAPOBhlSgllb4GK9GIO4=
X-Received: by 2002:a1c:7708:: with SMTP id t8mr13713623wmi.29.1575021776664;
 Fri, 29 Nov 2019 02:02:56 -0800 (PST)
MIME-Version: 1.0
References: <1574864578-467-1-git-send-email-neal.liu@mediatek.com> <1574864578-467-4-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1574864578-467-4-git-send-email-neal.liu@mediatek.com>
From:   Lars Persson <lists@bofh.nu>
Date:   Fri, 29 Nov 2019 11:02:45 +0100
Message-ID: <CADnJP=uhD=J2NrpSwiX8oCTd-u_q05=HhsAV-ErCsXNDwVS0rA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] hwrng: add mtk-sec-rng driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Crystal Guo <Crystal.Guo@mediatek.com>,
        linux-crypto@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neal,

On Wed, Nov 27, 2019 at 3:23 PM Neal Liu <neal.liu@mediatek.com> wrote:
>
> For MediaTek SoCs on ARMv8 with TrustZone enabled, peripherals like
> entropy sources is not accessible from normal world (linux) and
> rather accessible from secure world (ATF/TEE) only. This driver aims
> to provide a generic interface to ATF rng service.
>

I am working on several SoCs that also will need this kind of driver
to get entropy from Arm trusted firmware.
If you intend to make this a generic interface, please clean up the
references to MediaTek and give it a more generic name. For example
"Arm Trusted Firmware random number driver".

It will also be helpful if the SMC call number is configurable.

- Lars
