Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439AFC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD48A2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lfPq3Zkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfFSLjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:39:10 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:56043 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfFSLjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:39:09 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190619113906epoutp01d904d7d20c0a681fb0b19085ed7c610c~plp0BkIAG2267822678epoutp01C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:39:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190619113906epoutp01d904d7d20c0a681fb0b19085ed7c610c~plp0BkIAG2267822678epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560944346;
        bh=Abp7EpTVp7nDdPSWDCKCmZkD28ccLG090DnuFaeJj2A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lfPq3Zkni7ZjjBlCvvcF6hGdd9Y59i9iWSdX8steOhoTu17CEk/I0mGj0wFmGfqsn
         5DbNBW2PfBo+M9CHnlm1ZsWwMHK7/mUvFzsRExJSJmOjL7kZAb4YDTMn3O2hXc05dZ
         aSN839yliwqHI/023XuGRZIZsgN6WWdHRttMvc4s=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190619113905epcas1p2b98ad8cc73c5491bd72e966fc3666e46~plpy1jGBw0473804738epcas1p2E;
        Wed, 19 Jun 2019 11:39:05 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.00.04108.9DE1A0D5; Wed, 19 Jun 2019 20:39:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190619113904epcas1p23e2c335cda62dfa5ea02c4eb5cb0d788~plpyMLPRB0650106501epcas1p2y;
        Wed, 19 Jun 2019 11:39:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190619113904epsmtrp1ccb20c1c9ed38eaea0ba4b92bf7d2bb4~plpyF9XxI3043230432epsmtrp17;
        Wed, 19 Jun 2019 11:39:04 +0000 (GMT)
X-AuditID: b6c32a39-8b7ff7000000100c-26-5d0a1ed9fd8e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.76.03692.8DE1A0D5; Wed, 19 Jun 2019 20:39:04 +0900 (KST)
Received: from U16PB1-0090.tn.corp.samsungelectronics.net (unknown
        [10.253.235.20]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190619113904epsmtip154479b2a50747595a0935d46484ebf57~plpx5-YjY1503315033epsmtip1I;
        Wed, 19 Jun 2019 11:39:04 +0000 (GMT)
From:   jinho lim <jordan.lim@samsung.com>
To:     will.deacon@arm.com
Cc:     mark.rutland@arm.com, ebiederm@xmission.com, marc.zyngier@arm.com,
        anshuman.khandual@arm.com, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        seroto7@gmail.com, jinho lim <jordan.lim@samsung.com>
Subject: [PATCH] arm64: remove useless condition
Date:   Wed, 19 Jun 2019 20:38:57 +0900
Message-Id: <20190619113857.5053-1-jordan.lim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmru5NOa5Yg93dahY9u3cyWew7kWzx
        f1sLu8WNZWEWmx5fY7W4vGsOm8XfO//YLJZev8hk8XlZG4vFy48nWBy4PNbMW8PosXPWXXaP
        BZtKPTYvqffo27KK0ePzJjmPKYfaWQLYo3JsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4BuU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
        GBoU6BUn5haX5qXrJefnWhkaGBiZAlUm5GQ0Te9hLPjCUnH72VX2BsYeli5GTg4JAROJdY8f
        MXYxcnEICexglDj94BErhPOJUeLh/Z1QmW+MEq8uT2SDabl7/AlU1V5GieaDrcwQTgeTxO6N
        m5hBqtgENCQeLF4AtkREQFzizMQtTCA2s8APRonpOyS7GDk4hAUMJFbt4AcJswioSrz6cQ2s
        hFfASmLJqu1Qy+QlVm84ADZfQmAFm8SXa/eYIRIuEp9/TYCyhSVeHd/CDmFLSbzsb2OHaGhm
        lDhw6h1UdwOjxKxLX6DGGkv09lxgBrmCWUBTYv0ufYiwosTO33MZIQ7lk3j3tYcVpERCgFei
        o00IwlSR+LO8DmbV757vUGs9JGa9WsYKYgsJxEqsajvKOIFRdhbC/AWMjKsYxVILinPTU4sN
        C0yRY2kTIzjBaVnuYDx2zucQowAHoxIPr8Bnjlgh1sSy4srcQ4wSHMxKIrzczZyxQrwpiZVV
        qUX58UWlOanFhxhNgaE3kVlKNDkfmHzzSuINTY2MjY0tTMzMzUyNlcR547lvxggJpCeWpGan
        phakFsH0MXFwSjUwZh+ZYew+R8iUZ4nE69gg2VBf7a8bzI/u+hHyyiuVv/Vw2+qNTfaJ6+4p
        XUvYJPOu1mpvs1/EByWXO1kyBnM2XatZtX9T1/dpEVf+/5W1f1bw4xxXmKFc644bMvuES7L0
        g28smeNTX27JnWO48cns/MxnGtMLvtgu3vGCS2T7tMoUI2WxB2+KlViKMxINtZiLihMBxpB2
        1IYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSnO4NOa5YgzsfDCx6du9ksth3Itni
        /7YWdosby8IsNj2+xmpxedccNou/d/6xWSy9fpHJ4vOyNhaLlx9PsDhweayZt4bRY+esu+we
        CzaVemxeUu/Rt2UVo8fnTXIeUw61swSwR3HZpKTmZJalFunbJXBlNE3vYSz4wlJx+9lV9gbG
        HpYuRk4OCQETibvHn7CC2EICuxklnj8RhIhLSXz83c3cxcgBZAtLHD5c3MXIBVTSxiTR8vUX
        M0gNm4CGxIPFC8DmiAiIS5yZuIUJpIhZoIlJ4uu6n2DNwgIGEqt28IPUsAioSrz6cY0JxOYV
        sJJYsmo7G8QueYnVGw4wT2DkWcDIsIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzjY
        tDR3MF5eEn+IUYCDUYmHd8cHjlgh1sSy4srcQ4wSHMxKIrzczZyxQrwpiZVVqUX58UWlOanF
        hxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTDOWNdTsHd+Sx+DDr8a2yTjzJ3HP22L
        dNhwYPXed1OZBXoOGCtarJnt7yZx4VH2f/mg9AQNwVeJBznK3J96KM4ov+/4YsfC71qc6ec6
        V9yfv7PaJTdBoTFSVrl0GQ8/e/UR4+jbb+X6NNN7jmnVlrjL9smGf/adnHAlRK2h/57wpysL
        FeJ4fiqxFGckGmoxFxUnAgAJ61A3MgIAAA==
X-CMS-MailID: 20190619113904epcas1p23e2c335cda62dfa5ea02c4eb5cb0d788
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190619113904epcas1p23e2c335cda62dfa5ea02c4eb5cb0d788
References: <CGME20190619113904epcas1p23e2c335cda62dfa5ea02c4eb5cb0d788@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_instr function checks user_mode internally.

Signed-off-by: jinho lim <jordan.lim@samsung.com>
---
 arch/arm64/kernel/traps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ccc13b45d9b1..694e78b950ca 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -182,8 +182,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	print_modules();
 	show_regs(regs);
 
-	if (!user_mode(regs))
-		dump_instr(KERN_EMERG, regs);
+	dump_instr(KERN_EMERG, regs);
 
 	return ret;
 }
-- 
2.13.0

