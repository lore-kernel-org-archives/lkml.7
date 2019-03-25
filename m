Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCE6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FEF20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H1BN9pIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfCYGzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:55:21 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:35849 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfCYGzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:55:20 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190325065518epoutp038bb62dc1efd2f0ac0d38ff963466b3a0~PITdhbInx0278202782epoutp039
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:55:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190325065518epoutp038bb62dc1efd2f0ac0d38ff963466b3a0~PITdhbInx0278202782epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553496918;
        bh=Tpj+PFy3IVjjiUIPs1Nt8v+KVN4DKHDz7p0seaPeDzo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=H1BN9pIMye/v39vZnLXY3YBEcYPgSDSk5bbNcZOhQxMOtU7Toau2mFyDMAsuenyj3
         u6BHdandPjxENaQP7EQdxIZlW0lbdPgM9IiPbvTobDk4R+17Tk+yfthz1xr5tn2xBW
         bp2KyJ4IY2yVzTKY0hd1OBAno1ALfRFnPfqncU1k=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190325065515epcas1p1204a93e3c204eb0bbab33e9a2b68b5b7~PITbMSTR22338523385epcas1p1Y;
        Mon, 25 Mar 2019 06:55:15 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-e3-5c987b53b887
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.B0.04108.35B789C5; Mon, 25 Mar 2019 15:55:15 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3 3/5] devfreq: rk3399_dmc: Pass ODT and auto power
 down parameters to TF-A.
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Derek Basehore <dbasehore@chromium.org>,
        Randy Li <ayaka@soulik.info>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@collabora.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190321231440.19031-4-gael.portay@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190325065515epcms1p4743158f941064730272c8f976d844237@epcms1p4>
Date:   Mon, 25 Mar 2019 15:55:15 +0900
X-CMS-MailID: 20190325065515epcms1p4743158f941064730272c8f976d844237
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRmVeSWpSXmKPExsWy7bCmrm5w9YwYg32r1Cxe3f3FaLHp43tW
        i5eHNC2uf3nOavFq8x42i/lHzrFanF12kM1ize1DjBZLdr1hs/j/6DWrxY8Np5gtvk5ezmRx
        tukNu8Wmx9dYLS7vmsNm8bn3CKPFpwf/mS2WXr/IZNG69wi7g7DHmnlrGD1mN1xk8dhxdwmj
        x6ZVnWwem5fUe/ydtZ/Fo2/LKkaP7dfmMXs0353O6rH20QYWj8+b5AK4o7JtMlITU1KLFFLz
        kvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DeU1IoS8wpBQoFJBYXK+nb
        2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZkZ5z+u5G54A1nxdPp
        f1kbGHs5uhg5OSQETCQmH9nC0sXIxSEksINRYsKilcxdjBwcvAKCEn93CIPUCAskS7w8vZ0J
        xBYSUJJouLmPGSKuL9HxYBsjiM0moCuxdcNdsDkiArPZJPYcO8YGkmAGan6yaTYbxDJeiRnt
        T1kgbGmJ7cu3MoLs4hSwl/i92RUiLCpxc/Vbdhj7/bH5jBC2iETrvbPMELagxIOfuxlhxsyY
        8h9qZLXEtemL2UFukBBoYZToXT0Fqkhf4szck2A38Ar4Stx5t5UVxGYRUJWY9K4P6jYXibMH
        JjNC3Cwvsf3tHHA4MAtoSqzfpQ9zfsPG3+zobGYBPol3X3tYYeI75j1hgrDVJA7tXgJVLyNx
        evpCqPs9JFZd/8o4gVFxFiKkZyFZPAth8QJG5lWMYqkFxbnpqcWGBabIkbuJEZzStSx3MB47
        53OIUYCDUYmH12HP9Bgh1sSy4srcQ4wSHMxKIrxPRGfECPGmJFZWpRblxxeV5qQWH2I0Bfp/
        IrOUaHI+MN/klcQbmhoZGxtbmBiamRoaKonzrndwjhESSE8sSc1OTS1ILYLpY+LglGpgtLww
        c9Z6De3ZDI1qrYdP+SxauP7Ikd3/O/9qr9h9hUtcVCot0OJmV9xGUfOKz8LBvSeTMu8kHFri
        3lHVejuUdd2BRAOZA09MdObLvKp4JRt/aqWCTTzz38gHp9dxqLIzfNmZ2eQg9cBtxeVZsdyn
        VsYI/J4X2CgV9qnw+b74yZcXtdxp41mYosRSnJFoqMVcVJwIANlcW3n/AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190321231449epcas1p4ea54b4862fd8552f207f81bce8cb706f
References: <20190321231440.19031-4-gael.portay@collabora.com>
        <20190321231440.19031-1-gael.portay@collabora.com>
        <CGME20190321231449epcas1p4ea54b4862fd8552f207f81bce8cb706f@epcms1p4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
>Trusted Firmware-A (TF-A) for rk3399 implements a SiP call to get the
>on-die termination (ODT) and auto power down parameters from kernel,
>this patch adds the functionality to do this. Also, if DDR clock
>frequency is lower than the on-die termination (ODT) disable frequency
>this driver should disable the DDR ODT.
>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>Signed-off-by: Gael PORTAY <gael.portay@collabora.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Cheers!
MyungJoo

>---
>
>Changes in v3:
>- [PATCH v2 3/5] Add Signed-off-by: Gael PORTAY <gael.portay@collabora.com>.
>		 Remove comments.
>		 Move pmu dt parsing after dt-parsing of timings to fix
>		  data->odt_dis_freq value.
>
>Changes in v2: None
>
>Changes in v1:
>- [RFC 3/10] Add an explanation for platform SIP calls.
>- [RFC 3/10] Change if statement for a switch.
>- [RFC 3/10] Rename ddr_flag to odt_enable to be more clear.
>
> drivers/devfreq/rk3399_dmc.c        | 71 ++++++++++++++++++++++++++++-
> include/soc/rockchip/rockchip_sip.h |  1 +
> 2 files changed, 71 insertions(+), 1 deletion(-)
