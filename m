Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78ABC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9D2222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rs85drgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfLKOrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:47:15 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33309 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbfLKOqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:46:52 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191211144650euoutp015cb54efe58771cf88d0b8c1792d85f58~fWGrWslHs1943619436euoutp01Q
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:46:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191211144650euoutp015cb54efe58771cf88d0b8c1792d85f58~fWGrWslHs1943619436euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576075610;
        bh=qTaGKuC9cCAB+1j7GCP6On5IHmid3yqkEWyTajSdyOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rs85drgLpVj2uyoqmt/9tZLkFzB9W3qW4usI43aCwWTvXYFVNryQguA06YfAwd6XA
         7Pt0OLc+o7NpuvkOuJrrX1WJlt6Zr8zQ6suSygzuyhTatg1v73ddBMvmqyCiIaQDTT
         g0gcNte8vnb6EqOR2lbyFSBkP7Ia49t8rjEZ8x1U=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191211144649eucas1p10daab46774e3fe745a10ea188a13a1e2~fWGq2ACyk3190531905eucas1p1E;
        Wed, 11 Dec 2019 14:46:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FB.0E.60698.95101FD5; Wed, 11
        Dec 2019 14:46:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191211144649eucas1p1b882634306383e225dbab70629d2f222~fWGqTXSmH1750817508eucas1p1a;
        Wed, 11 Dec 2019 14:46:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191211144649eusmtrp2f9accd69be9afcf8a453ba1f947b6715~fWGqSsvuR0169801698eusmtrp26;
        Wed, 11 Dec 2019 14:46:49 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-a8-5df101596e99
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.9A.07950.95101FD5; Wed, 11
        Dec 2019 14:46:49 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191211144648eusmtip1fe02aa74fd490787f74d96f1003eafb3~fWGpmIbrv0888708887eusmtip18;
        Wed, 11 Dec 2019 14:46:48 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 2/4] ARM: dts: qcom: Correct USB3503 GPIOs polarity
Date:   Wed, 11 Dec 2019 15:46:36 +0100
Message-Id: <20191211144638.24676-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211144638.24676-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTURzGObv3bneryfUqeLRIHGkU5gtW3siiIPTWh+qDvVmSKy822qbt
        qrmiEudLLpPs1VbLpaH5smlqL0q5XOGQaHNKYuJGtaA0VMQ0ytKcd9q35//8f895OIeDI+Qr
        LAiXKTMZlVIql/BF6NOuX7b1h8FEctTARCxlc8+g1OPyRox6ax5DqaIOPUppqhr5lN3eJKCa
        3f0Y1dd+j0/1aRyAKrd38KjK6gKEMr5xCqi8/BiqsLgao1pMRQLql8XO207QVT9dCN30uR6j
        23ROAd1cV8ynh/pf8GmzvkFAtzy8SOd3m1G6tLUO0JPNq/aJkkRxqYxcls2oIreliE7aSjrR
        jC5hTs/kNJoLfgu0QIhDYgN88HUc0QIRThKPANTon2Dc8APAgjtazEORxCSA0xMJi4mBXIMX
        qgGw57Wbt5QY1OkXEnwiGmpHtXzPwp9oAHDmSjnqGRDChkC9xoF6KD8iHhqccwsaJUKhecCI
        eLSY2AqHLn/nc33BsL7p1byP40JiG7zRqfacA4leAXTXOQDH7IQzbh2P035wxNrqvd1KONdW
        weMCGgA/2YwCbigBsC+v3JveAl9bHZinASHWwsb2SM7eAX/O2ReKIeEDB0Z9PTYyL689ve21
        xfBSIcnRYVBnNS3Vdvb0ehEalr0/zz1QGYCTw0XgKgjW/e8yAFAHApgsVpHGsDFK5kwEK1Ww
        Wcq0iBPpimYw/6/ezlqnnoOOP8ctgMCBZLnY8Gw8mcSk2axaYQEQRyT+YmvhWDIpTpWqzzKq
        9GOqLDnDWsAKHJUEiGMqh5NJIk2ayZximAxGtbjl4cKgXCDcVSpyyffWpoAW/601um9pCmfC
        7Idwzf4LgflJ6kSTqfr0CUtnuG+D8133rT2bZ/8Orgm8bz/qcBVc1z8bLz7wsd73rtInsfWl
        MUI33Goita7Q6KmbIQcPVeSsjpOpN4bEK87trm0rtnwJ2BQbFlUkG1Ee8c9f1vWkp5slXVUB
        EpQ9KY1eh6hY6T+XuXA6UwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7qRjB9jDbatFrQ49/g3i8XGGetZ
        LU7vf8di0b5vLotF8+L1bBbnz29gt9j0+BqrxeVdc9gsLjdfZLSYcX4fk8WiZa3MFmuP3GW3
        aGoxtmjrXMZqsXldO7vFz0PnmRwEPBZ/v8fsseHRalaPnbPusntsWtXJ5nHn2h42j/1z17B7
        bF5S79Fycj+LR9+WVYwenzfJBXBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GWc6znIUnCMs+LC528sDYy/2LsYOTkkBEwkbjQsYO1i5OIQEljK
        KLHxxAcmiISMxMlpDawQtrDEn2tdbBBFnxgl3v7tZQZJsAkYSnS9hUiICGxglDjz/gkLSIJZ
        4BqzxLLN0iC2sICbxIK7/8HiLAKqEvtvrAVr5hWwlbjT/ZoNYoO8xOoNB4DiHBycAnYSUw5W
        goSFgEruTTrENoGRbwEjwypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzA6Nl27OeWHYxd74IP
        MQpwMCrx8C7Y/j5WiDWxrLgy9xCjBAezkgjv8bZ3sUK8KYmVValF+fFFpTmpxYcYTYFumsgs
        JZqcD4zsvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjFO1musL
        BC/ktvr3/e54rRS+YF3rX+OUIo+uI00a7LFZB6Y5VxvMvlzcsMhL39MroITrwV0FjyVX3lSx
        eMw8+dlPol7PxEfblMVKjbP4l+eb4x8uiP49NC3i5CX+2azJvLVfl1vFfhI3c11ppT1383uO
        18dULFb1JOs5tl91nFS44v3zfskLSizFGYmGWsxFxYkAD5/F+bQCAAA=
X-CMS-MailID: 20191211144649eucas1p1b882634306383e225dbab70629d2f222
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191211144649eucas1p1b882634306383e225dbab70629d2f222
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191211144649eucas1p1b882634306383e225dbab70629d2f222
References: <20191211144638.24676-1-m.szyprowski@samsung.com>
        <CGME20191211144649eucas1p1b882634306383e225dbab70629d2f222@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current USB3503 driver ignores GPIO polarity and always operates as if the
GPIO lines were flagged as ACTIVE_HIGH. Fix the polarity for the existing
USB3503 chip applications to match the chip specification and common
convention for naming the pins. The only pin, which has to be ACTIVE_LOW
is the reset pin. The remaining are ACTIVE_HIGH. This change allows later
to fix the USB3503 driver to properly use generic GPIO bindings and read
polarity from DT.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
index 26160c324802..942e3a2cac35 100644
--- a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
+++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
@@ -143,7 +143,7 @@
 				compatible = "smsc,usb3503a";
 				reg = <0x8>;
 				connect-gpios = <&gpioext2 1 GPIO_ACTIVE_HIGH>;
-				intn-gpios = <&gpioext2 0 GPIO_ACTIVE_LOW>;
+				intn-gpios = <&gpioext2 0 GPIO_ACTIVE_HIGH>;
 				initial-mode = <1>;
 			};
 		};
-- 
2.17.1

