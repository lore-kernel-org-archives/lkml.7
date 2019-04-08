Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C6AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CF12083E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H2x/4l4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDHFtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:49:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51041 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfDHFtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:49:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190408054921euoutp015382f6a74f8f9c23ea7a143ade356307~Tab4sJ61r0985209852euoutp01i
        for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2019 05:49:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190408054921euoutp015382f6a74f8f9c23ea7a143ade356307~Tab4sJ61r0985209852euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554702561;
        bh=JH01t/x7Iz43E12cQhTX5AvtZfsT/xA516m8zromFz8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=H2x/4l4tNN1IKtK9CwYfAv/IwpMljg/k1Ln73J7VhbKVLOZBGmP0QfLwZE5tSMu4o
         rd89u13+Cn1EOran6NjdrAoMs1lmpY5aTEQ2DECz4qfBVqpTQlZwBWCZnacz+iEuDg
         SKwF6yc35DVd4Sy1W6tipUY+C7dUF+WKMC0+mVJc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190408054921eucas1p2022a1dda8810c460d13ae090e234ed7d~Tab4GIWlO1298412984eucas1p2d;
        Mon,  8 Apr 2019 05:49:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BF.87.04325.0E0EAAC5; Mon,  8
        Apr 2019 06:49:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190408054920eucas1p1f898e53254d9b3e06ad8c3614b218dc7~Tab3UFMTi0678606786eucas1p1h;
        Mon,  8 Apr 2019 05:49:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190408054920eusmtrp1a6ca63f8390542cc7f2f03e9f5e4baa6~Tab3F5clH0391103911eusmtrp1m;
        Mon,  8 Apr 2019 05:49:20 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-58-5caae0e004fd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B4.7C.04140.0E0EAAC5; Mon,  8
        Apr 2019 06:49:20 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190408054919eusmtip2aab5ad76353225ca2aa7a12923abda28~Tab2j8sW61990319903eusmtip2m;
        Mon,  8 Apr 2019 05:49:19 +0000 (GMT)
Subject: Re: [PATCH v4 1/2] drm/bridge: sil_sii8620: make remote control
 optional.
To:     =?UTF-8?Q?Ronald_Tschal=c3=a4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b50b902d-d145-5442-389c-8fd0f73e2f87@samsung.com>
Date:   Mon, 8 Apr 2019 07:49:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190407050358.2976-2-ronald@innovation.ch>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfSxVcRjH+91zzr3H1eW4mCdM69bWaosarSMybbXO1j+1ZWvY6pYTFpfd
        g8gfCcvLwg2Rq2R5ictS8nYJCyPkbZSXLawJM+8XW16qe51b+e/zPM/3+f6e7/YjMekQYUsG
        KsJYpUIeJBOK8Zr2n30nJic1vifjJlzplNhsAd36ahbRXes7QjquoEJIp0+ocDrpSaGIHl3d
        IOjB+udCenbGjp4dXxDQnzayBJ6mjE4zRzBa9TcRk5uYQzCZScDkdV5lml+Ui5jUKg1iGser
        cEZX6cA8S6ghroi9xe5+bFBgBKt08rgpDijLTBGEjlpElsYVYDGoxywZmZBAucD2u3IiGYlJ
        KVWC4GNKi4gv1hB01Y5hfKFD0Lu5hf1beVhsHLxGsLjYLOCLBQSNvSO4QWVJXQNtWsHuhhW1
        ieDLODIwRs0iaJq2N7CQOgY770eFBpZQHjC4UrSrwakjoGsYIQxsTV2HpR8NOK+xgM6cqV02
        oVxhq3IT4z0PQlx1rpFtYGzq5e5BQK2IIFX1WW9K6osLsNYZzSewhLmOKhHP9tCd8Rjn+QFM
        lMRj/G4iguq3WmNkN2jtGCAMPpj+6Ip6J759HnJih0W8vRmMLFjwJ5hBek02xrclkPhIyqsP
        wURPtdHQBor614UqJFPvCabeE0a9J4z6/7v5CNcgGzacC/ZnOWcFe8+Rkwdz4Qp/x9shwZVI
        /9e6f3Ws16Gm7VstiCKRbL8k/6zGV0rII7io4BYEJCazkmif6lsSP3nUfVYZckMZHsRyLciO
        xGU2kuh9kz5Syl8ext5l2VBW+XcqIE1sYxBmngfrhVk5fWPjLhVb5SEW6Yrltg8N7s7DqQfy
        a4ci3KYTnx3OyG0sa7L21p62aj+3urKqE6g87SrTL88p26YGwkp763zqd5IvRq5+98pf8E+L
        yvL6XevQsFw9bG4afrSGXipeqYieL7zzlXO0ilmLHIifaWTPuCe8yRNdmu/fkeFcgPzUcUzJ
        yf8A4/1sq2cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xe7oPHqyKMfjczGzR2zSdyeLwoheM
        Fqe+/mWzaF68ns1i0v0JLBadE5ewW9z89I3V4vKuOWwWL55LW7y495bJ4sS3aUwO3B6fV71i
        9dg56y67x+yOmaweUzolPOadDPTYP3cNu0ffllWMHnvvbWHx+LxJzmNG+zbWAK4oPZui/NKS
        VIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzVU3qZCm4KVqxs
        XszcwHiWr4uRk0NCwETiT+My5i5GLg4hgaWMEmeP7maBSIhL7J7/lhnCFpb4c62LDaLoNaPE
        l9+r2UESwgIhEjv7F4N1iwj8YZRYcKIXrIpZ4AWjxK89n6BadjNK7N13jBWkhU1AU+Lv5pts
        IDavgJ3E5Y9LGUFsFgEVic+7b4DViApESNy9+IIFokZQ4uTMJ2A2p4ClxO9Nv8BuYhZQl/gz
        7xKULS/RvHU2lC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfm
        pesl5+duYgTG87ZjP7fsYOx6F3yIUYCDUYmH94fNqhgh1sSy4srcQ4wSHMxKIrw7pwKFeFMS
        K6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YavJK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5ak
        ZqemFqQWwfQxcXBKNTAqCU/yfdJobRv1Z3flj0NfFUW+pUkmLlunKPDsBY9uyd2tYfd6zy52
        thFhesJpJJOjuLxYs6iU8eXMH7sc3xmUWK5QS1yha8V2tH7rLf4bF5arRyo2ly79ESchu7Hi
        0fu7dcdDe7bKC1r16vyaaftjb/Dxr3tnP/xxceFk95zjXFOvhe8yW2SgxFKckWioxVxUnAgA
        +Xd8c/0CAAA=
X-CMS-MailID: 20190408054920eucas1p1f898e53254d9b3e06ad8c3614b218dc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190407050410epcas1p3ec1f887f8ccf8ff4495f4557437cd594
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190407050410epcas1p3ec1f887f8ccf8ff4495f4557437cd594
References: <20190407050358.2976-1-ronald@innovation.ch>
        <CGME20190407050410epcas1p3ec1f887f8ccf8ff4495f4557437cd594@epcas1p3.samsung.com>
        <20190407050358.2976-2-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.2019 07:03, Ronald Tschalär wrote:
> commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
> of RC_CORE) changed the driver to select both RC_CORE and INPUT.
> However, this causes problems with other drivers, in particular an input
> driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
> commit):
>
>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
>
> According to the docs and general consensus, select should only be used
> for non user-visible symbols, but both RC_CORE and INPUT are
> user-visible. Furthermore almost all other references to INPUT
> throughout the kernel config are depends, not selects. For this reason
> the first part of this change reverts commit d6abe6df706c.
>
> In order to address the original reason for commit d6abe6df706c, namely
> that not all boards use the remote controller functionality and hence
> should not need have to deal with RC_CORE, the second part of this
> change now makes the remote control support in the driver optional and
> contingent on RC_CORE being defined. And with this the hard dependency
> on INPUT also goes away as that is only needed if RC_CORE is defined
> (which in turn already depends on INPUT).
>
> CC: Inki Dae <inki.dae@samsung.com>
> CC: Andrzej Hajda <a.hajda@samsung.com>
> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

