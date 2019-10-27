Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EF2CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBD2205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XglZzy/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfJ0Gcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 02:32:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:58099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfJ0Gcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 02:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572157953;
        bh=URb4ktMfUpL1dbYIat3/0f/YdBmBlVy9KjAM/7UpLI0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XglZzy/WMm59HtyMddVqjE6ZR2+RaxPmfwEmYCXzobfiJeL01Z4U7Obw90woqrfgb
         U4GeXgWqrDWPrbBr+eMNLB+IHQEsYMZrhgincWFuJy401uyX7T8HutSvALTIyFQ8dK
         tKIlCC23G/wAFx9sUPnqKvPQGmWMEAp2MU3Pddww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.153.185] ([217.61.153.185]) by web-mail.gmx.net
 (3c-app-gmx-bap44.server.lan [172.19.172.114]) (via HTTP); Sun, 27 Oct 2019
 07:32:32 +0100
MIME-Version: 1.0
Message-ID: <trinity-c8e754a2-3369-4915-91dd-4e328c8d8a54-1572157952924@3c-app-gmx-bap44>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Fabio Estevam" <festevam@gmail.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Aw: Re: [PATCH, RESEND] serial: 8250-mtk: Ask for IRQ-count before
 request one
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 27 Oct 2019 07:32:32 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAOMZO5Bb=1CUpw__xxS2N0w+ZP0+LnBBW9+JLVr03x6TC2Z7=g@mail.gmail.com>
References: <20191026194522.28293-1-frank-w@public-files.de>
 <CAOMZO5Bb=1CUpw__xxS2N0w+ZP0+LnBBW9+JLVr03x6TC2Z7=g@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ZwFWc4VD9dcVeZ8c7PaQyxCHzgAqT53gsWj2AJnSZjBgsFAC2j82vL5w/gSwf6To88DKA
 0JVhXeQGn6v1xg0j6H+pFB8vA8+G3TYvM7Slk1tW8sLbSXnjKM8T+P7wBcDqXssvwR9ws1e+sTQe
 aJqoVJNc+XDlrH9pnB4HQeTnFTiiEP+UoM5ROLtw/5h8kkLPEbD+UxQrLCp8YTZ97jRaW5MJh0ZW
 bM4K1Wgk1DmIF2UCcsSQP8MQP3/WRsna/nRScowwiffo8+6oaCX4zehW3QPQlNUqjonbdPOZJk+w
 N0=
X-UI-Out-Filterresults: notjunk:1;V03:K0:AFsynnJYb5U=:KBDbqLyPbYU5CLeqGZx3Vo
 Sfnot+l7NRHzME8agB4fxaK7Rf01wkVSaeg1QGQ+dzmIKGc0efJ/YlsvMg9TZZRiQfx4ej1V9
 Zo/2BChttYcdZZsI2tZheHb2tu0Izlf6WvHdTE6Dwi97qWNg7bPaHtgHuHwfFmpBNtJnHrpCG
 fr2tpnbNC2TOjr+Exx02YsaHbmmIRMPAWSuPDMuwjQXRvR4ffqa+BECFzZUhmYjzhbit36Qyt
 ZakEpDe9Kh9YUXJW9aXAJztfq+66NJJuZMzEYicOR9bGB2R+lhea04uxcnNhWKq6CB4q3zwq+
 GRX3mr+KdMgOKLhrahiMZ+8eugpCP3Ldrl0RY0hjPrXEKX6+De4W0n2saAfp9H45+uQTXPCzg
 BI1tfs7KMJG6kSsuKLInuWV5O2/b7pcM2pLXYbJNPDCUHc8kDFixkYrHBq10obM3MCW+w4/1K
 11XyCKqW9iDB4HsGO2W/MsweDQ82iA+eRMe7XdX1xmJQmRfLLZaKHb6VEc69Mk4BPOMf/O1HP
 gstDfHykbv+cMcfOaTz4XFsMpb6T+KNeA2yPd2PTXAYyoadOusBMiPCRQhJvYSULYTLHu9J5w
 w/WboqFnJlp0Xvk2Ekh7KvzjsD0KhKJ37v6cpAlBsJr1E4efWL+3XcE/awA+s1KhFAB6LPo1W
 OFE9pK3qpw72iSLZJDdFmKl5quWbLc5xGULgM5MET6guvM5N/poP7PhPszZcKQaDM+3c=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thank you, seems to work too

have posted v2 here: https://patchwork.kernel.org/patch/11213957/

regards Frank

> Gesendet: Samstag, 26. Oktober 2019 um 21:31 Uhr
> Von: "Fabio Estevam" <festevam@gmail.com>

> The solution that was accepted for this case was to use
> platform_get_irq_optional() instead.
>
> You could try using platform_get_irq_optional() here as well.

