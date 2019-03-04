Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F45C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8886720863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RckMeCKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfCDHNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:13:35 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47173 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfCDHNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 02:13:34 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190304071332euoutp02a748ee6eec61d52c8dea9f6ce21ac6bd~IsAZbVfpx1687716877euoutp02P
        for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2019 07:13:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190304071332euoutp02a748ee6eec61d52c8dea9f6ce21ac6bd~IsAZbVfpx1687716877euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551683613;
        bh=cnnHNV3ALpqW7HqQfqWqY8a/xGu/phKkpoyrNS9ayvE=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=RckMeCKcwp+ocLLNgayvv7E3z1Fj68WrYmuUyrjaYtHFHkTcPQx106VoL5u3m70+/
         tR6Ki+GFG82yfhmHa0+YAd8YiNt9JuqTzvpTH3LqM7DI7NUQPKD7l/M36wAjEGWKO/
         OpOt3Ow7rAU3KiJA7/GmVshmfeBf3Aw+o5aMnGW4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190304071332eucas1p2f4835150b1f779bf7163dab2931b3be5~IsAZBEM9z2835328353eucas1p2f;
        Mon,  4 Mar 2019 07:13:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1F.6D.04806.C10DC7C5; Mon,  4
        Mar 2019 07:13:32 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190304071331eucas1p1a18736c357651269e61974a927cdda8a~IsAYMLe7G2687426874eucas1p1T;
        Mon,  4 Mar 2019 07:13:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190304071331eusmtrp109e19aa9bdac00f3ba985759a22bc913~IsAX9zHoU1111411114eusmtrp1M;
        Mon,  4 Mar 2019 07:13:31 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-98-5c7cd01c0f49
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.6F.04284.B10DC7C5; Mon,  4
        Mar 2019 07:13:31 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190304071330eusmtip112465b41e38502db23268eb94800ecd3~IsAXkzsUU3172931729eusmtip1V;
        Mon,  4 Mar 2019 07:13:30 +0000 (GMT)
Subject: Re: [PATCH v2] drm/bridge: sil_sii8620: make remote control
 optional.
To:     Inki Dae <inki.dae@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <74a6da1b-e35a-f90a-ff02-e39bbf5e3d77@samsung.com>
Date:   Mon, 4 Mar 2019 08:13:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190304021325.GA30785@innovation.ch>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7oyF2piDBZ18lgcXvSC0eLK1/ds
        FpPuT2Cx6Jy4hN3i5qdvrBaXd81hs3jxXNqB3WPnrLvsHrM7ZrJ63O8+zuTRt2UVo8fnTXIe
        M9q3sQawRXHZpKTmZJalFunbJXBlbGn9wlywQaLiy9EtrA2MD4W7GDk5JARMJJpXtDB2MXJx
        CAmsYJTYs/MkM4TzhVHixru5TBDOZ0aJhgUT2WBaTjz5ywaRWM4o8bv1CVTLW0aJH4+Xs4NU
        CQsESJx/PJUFJCEi0MUksXnCUlaQBJuApsTfzTeB2jk4eAXsJO4sKQIJswioSNw4vo8JxBYV
        iJA43PuOEcTmFRCUODnzCQuIzSlgLPHj5QIwm1lAXqJ562xmCFtc4taT+WCnSgisY5eY2rkF
        bL6EgIvEw23uEFcLS7w6voUdwpaROD25hwXCrpdomnmFGaK3g1HixOLlUG9aSxw+fpEVZA4z
        0M3rd+lDhB0lpuy5xg4xnk/ixltBiBP4JCZtm84MEeaV6GgTgqhWlLh/diszhC0usfTCV6jh
        HhIf1m9jm8CoOAvJk7OQPDYLyWOzEG5YwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cT
        IzAVnf53/OsOxn1/kg4xCnAwKvHwGqjUxAixJpYVV+YeYpTgYFYS4e08DxTiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXAaHVwkXzX+U3fdtrfqCzUqlj3
        doehirnCLdvs+x+eBh0TO2n1avK75xmnbqstPCDz/sIEht4Fi6/HuMR91fRsLrW8/K6/bJEc
        e1aTdSHjfXf/HIk91zOO5bULiqk/WzzzCdP2ZiaXwwWSnKXTSndN8ZSecGuv1FGH5yVvf8ha
        xKxoXO/PPs1BWYmlOCPRUIu5qDgRAInyFh5BAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7rSF2piDB6+EbY4vOgFo8WVr+/Z
        LCbdn8Bi0TlxCbvFzU/fWC0u75rDZvHiubQDu8fOWXfZPWZ3zGT1uN99nMmjb8sqRo/Pm+Q8
        ZrRvYw1gi9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3
        S9DL2NL6hblgg0TFl6NbWBsYHwp3MXJySAiYSJx48peti5GLQ0hgKaPE8wvX2CAS4hK7579l
        hrCFJf5c64Iqes0osWdLDztIQljAT+L8mdOsIAkRgS4mieZVp1kgqq4zSly+vpwVpIpNQFPi
        7+abQO0cHLwCdhJ3lhSBhFkEVCRuHN/HBGKLCkRIfHwKYfMKCEqcnPmEBcTmFDCW+PFyAZjN
        LKAu8WfeJWYIW16ieetsKFtc4taT+UwTGAVnIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbU
        K07MLS7NS9dLzs/dxAiMs23Hfm7ewXhpY/AhRgEORiUeXgOVmhgh1sSy4srcQ4wSHMxKIrwi
        p4BCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MAXkl8YamhuYWlobmxubGZhZK4rznDSqj
        hATSE0tSs1NTC1KLYPqYODilGhizDt81jzn40/LIhKlsFYF3JL8ryk0U5f7HO+X2fN17zjdO
        uJmulfmUcUuxvyIma6J8nkHAjNYLZxefsm2fdEqH8/zSkhu2InxXDHPNhHi1d8sZl6zY11Gq
        5hb+OYO/+KrhkjvTlm95pCJ+m/GD0U2F4gn8t9t4vhpymlTK6zm/aROQ/3z5wkYlluKMREMt
        5qLiRAC90JcqyQIAAA==
X-CMS-MailID: 20190304071331eucas1p1a18736c357651269e61974a927cdda8a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190304021330epcas5p28ff0e4ba57999a6ef7fd3d151fc94714
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190304021330epcas5p28ff0e4ba57999a6ef7fd3d151fc94714
References: <20190124072125.GA28127@innovation.ch>
        <20190125013355.GA6722@innovation.ch>
        <CGME20190304021330epcas5p28ff0e4ba57999a6ef7fd3d151fc94714@epcas5p2.samsung.com>
        <20190304021325.GA30785@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.2019 03:13, Life is hard, and then you die wrote:
> On Thu, Jan 24, 2019 at 05:33:55PM -0800, Ronald Tschalär wrote:
>> commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
>> of RC_CORE) changed the driver to select both RC_CORE and INPUT.
>> However, this causes problems with other drivers, in particular an input
>> driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
>> commit):
>>
>>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
>>
>> According to the docs and general consensus, select should only be used
>> for non user-visible symbols, but both RC_CORE and INPUT are
>> user-visible. Furthermore almost all other references to INPUT
>> throughout the kernel config are depends, not selects. For this reason
>> the first part of this change reverts commit d6abe6df706c.
>>
>> In order to address the original reason for commit d6abe6df706c, namely
>> that not all boards use the remote controller functionality and hence
>> should not need have to deal with RC_CORE, the second part of this
>> change now makes the remote control support in the driver optional and
>> contingent on RC_CORE being defined. And with this the hard dependency
>> on INPUT also goes away as that is only needed if RC_CORE is defined
>> (which in turn already depends on INPUT).
>>
>> CC: Inki Dae <inki.dae@samsung.com>
>> CC: Andrzej Hajda <a.hajda@samsung.com>
>> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
>> ---
>> Resending this, as I somehow managed to forget to cc dri-devel.
>> Apologies for the duplication.
>>
>> Changes in v2:
>>  - completely remove dependencies on both RC_CORE and INPUT in Kconfig,
>>  - make remote control functionality in driver contingent on RC_CORE
>>    being defined
>>
>>  drivers/gpu/drm/bridge/Kconfig       |  2 --
>>  drivers/gpu/drm/bridge/sil-sii8620.c | 17 +++++++++++++++++
>>  2 files changed, 17 insertions(+), 2 deletions(-)
> [snip]
>
> Is there anything I can do to help get this reviewed and moved forward?


Addressing my comments [1] ? :)

Ah I see, for some reasons (my mistake apparently) my response was not
sent to you, sorry.

[1]: https://lkml.org/lkml/2019/1/28/258


Regards

Andrzej


>
>
>   Cheers,
>
>   Ronald
>
>
>

