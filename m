Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B1EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A226B20693
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dzluoQbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDALoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:44:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36829 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDALoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:44:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190401114418euoutp013e50dc1939f4905b962eff008e0c833b~RVwzKmMIW0249002490euoutp01O
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 11:44:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190401114418euoutp013e50dc1939f4905b962eff008e0c833b~RVwzKmMIW0249002490euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554119058;
        bh=cJSnM03+RHS1ybQ/bZd9DFEU9ZDBrYkgLiEOzqCL/XI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dzluoQbmbRO7xUaWWAp1RuGruDsdOi9ngbUO2y3UEmtWxD/W01HMNNQGb9yM9fCbj
         0BfGJsBCgLruoVc/5F/QfP3YDm/ThrAFeQzFdRJdcvvyyrCV9b3X8i8UpHELsgKsxN
         ZvQmlOAoL8d8zjTz9abmmuTBrq3PXmzqI5LBlF+A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401114418eucas1p2fec276a748a8368a203f3c87dc2f3b4c~RVwyjruOn0274302743eucas1p2V;
        Mon,  1 Apr 2019 11:44:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9A.0F.04325.199F1AC5; Mon,  1
        Apr 2019 12:44:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190401114417eucas1p11b51c6e03fe5dbd9376ca38ccf62392c~RVwxhs8Pg1935219352eucas1p1F;
        Mon,  1 Apr 2019 11:44:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190401114416eusmtrp224881ace895defd5f205ac7ecdbccc74~RVwxTqEsm0879508795eusmtrp24;
        Mon,  1 Apr 2019 11:44:16 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-26-5ca1f9910a58
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A6.E6.04146.099F1AC5; Mon,  1
        Apr 2019 12:44:16 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190401114416eusmtip174f4b1357ca4d64a9b1c44b1da43b5c0~RVwwyM3jC1320913209eusmtip10;
        Mon,  1 Apr 2019 11:44:16 +0000 (GMT)
Subject: Re: [PATCH] fbdev: mxsfb: implement FB_PRE_INIT_FB option
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Melchior Franz <melchior.franz@ginzinger.com>,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <b2cae305-77e8-9209-d144-5db7b19be3d6@samsung.com>
Date:   Mon, 1 Apr 2019 13:44:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190206101444.26594-1-martin.kepplinger@ginzinger.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djPc7oTfy6MMXg/0dziytf3bBYPr/pb
        rJq6k8Vi0+NrrBYn+j6wWnT9WslscXnXHDaL81dus1vsX1VjMeNCB5PF3+2bWCxebBF34PE4
        2reexWPnrLvsHptWdbJ53O8+zuSxeUm9x8Z3O5g8+v8aeHzeJBfAEcVlk5Kak1mWWqRvl8CV
        cWLlRPaCrawVv7v2sDcwnmDpYuTkkBAwkZi/ZgtbFyMXh5DACkaJ5sm72UASQgJfGCXaHpZB
        JD4zSsx994QJpuPz8kdMEInljBKPFm2Ean/LKHF27il2kCphASeJ5h33GEFsEQFzid6Nb1lB
        ipgFbjJJNC5bC1bEJmAlMbF9FVgRr4CdxJTm62BxFgEViS9X1wMdyMEhKhAh0X9GHaJEUOLk
        zCdgd3MKuErse7gGrJxZwEDiyKI5rBC2vMT2t3OYQXZJCNxil7hwbC87xNkuEmeOzGCFsIUl
        Xh3fAhWXkfi/cz4TRMM6Rom/HS+gurczSiyf/I8Nospa4vDxi1DdjhIL/ixhBblOQoBP4sZb
        QYjNfBKTtk1nhgjzSnS0CUFUq0lsWLaBDWZX186VUCUeEq9OB05gVJyF5LVZSN6ZheSdBYzM
        qxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQKT1ul/x7/uYNz3J+kQowAHoxIPbwXTwhgh
        1sSy4srcQ4wSHMxKIrxn+hfECPGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2a
        WpBaBJNl4uCUamAsfcP3IjT7gcwjUZ3+7lwp+/ZJxrcfrJlztLLN91XHFLGLTSv3hoY7XThw
        4Kfuio6/3ySfun96/0s8KOW6v+xnNqfSSoaFGzqefbq6q2f2kXTbnVmC2RpiOXPWM//4eKBh
        imcOT2rhpopIzy1r3A4ct0iL3mfWujI1e+cO3SPrfi/xub5Fa9pRJZbijERDLeai4kQARNNu
        MlYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7oTfi6MMdjUbGhx5et7NouHV/0t
        Vk3dyWKx6fE1VosTfR9YLbp+rWS2uLxrDpvF+Su32S32r6qxmHGhg8ni7/ZNLBYvtog78Hgc
        7VvP4rFz1l12j02rOtk87ncfZ/LYvKTeY+O7HUwe/X8NPD5vkgvgiNKzKcovLUlVyMgvLrFV
        ija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOLFyInvBVtaK31172BsYT7B0
        MXJySAiYSHxe/oipi5GLQ0hgKaNE55SJzF2MHEAJGYnj68sgaoQl/lzrYoOoec0o0bv2CTtI
        QljASaJ5xz1GEFtEwFyid+NbVoiiGYwSR56cYQdxmAVuMkncnPkabB2bgJXExPZVYB28AnYS
        U5qvg01iEVCR+HJ1PViNqECExK2HHSwQNYISJ2c+AbM5BVwl9j1cA1bPLKAnseP6L1YIW15i
        +9s5zBMYBWchaZmFpGwWkrIFjMyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqNx27Gfm3cw
        XtoYfIhRgINRiYe3gmlhjBBrYllxZe4hRgkOZiUR3jP9C2KEeFMSK6tSi/Lji0pzUosPMZoC
        PTGRWUo0OR+YKPJK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqemFqQWwfQxcXBKNTCa
        PWsRXvNP79r5/2F+Pdd1QtMWB/od+1hUzPus+HGL76Qsw9PTmZ+KXtTs/xptYaIgmKumks09
        02/pI90NX1rXBHs85z7zIOOI3zPFsBSD2BwOPqblTfJNi3ZKde6aeF1P4eKnJ1w6Fxzv58vN
        jF68rMjxqONZV7O24LV2qvsu5jR8fPgjXleJpTgj0VCLuag4EQAQZuHc3AIAAA==
X-CMS-MailID: 20190401114417eucas1p11b51c6e03fe5dbd9376ca38ccf62392c
X-Msg-Generator: CA
X-RootMTR: 20190206101522epcas5p34bb82638cabf533f54e4b64cbbfc286e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190206101522epcas5p34bb82638cabf533f54e4b64cbbfc286e
References: <CGME20190206101522epcas5p34bb82638cabf533f54e4b64cbbfc286e@epcas5p3.samsung.com>
        <20190206101444.26594-1-martin.kepplinger@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/06/2019 11:14 AM, Martin Kepplinger wrote:
> From: Melchior Franz <melchior.franz@ginzinger.com>
> 
> The FB_PRE_INIT_FB option keeps the kernel from reinitializing the display
> and prevents flickering during the transition from a bootloader splash
> screen to the kernel logo screen.
> 
> Make this option available for the mxsfb driver.
> 
> Signed-off-by: Melchior Franz <melchior.franz@ginzinger.com>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
