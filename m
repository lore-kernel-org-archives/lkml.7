Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453DEC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0604320821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Cb/1hrNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfDSTJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:09:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54672 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbfDSTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:07:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190419141946euoutp022168d41c14bf070c3efdaa170b29491d~W5frIedLe2260922609euoutp02g
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:19:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190419141946euoutp022168d41c14bf070c3efdaa170b29491d~W5frIedLe2260922609euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555683586;
        bh=QJOtFNoh5dlRuZa0BCb5/nTwgHjZIpFyzRw5uANmmR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cb/1hrNcYVUi8hRFa4zdUeMw4UTIkEsHvceGQhtOq8lZFwJZ7HSoXoJ8QxU+BX9M6
         js+KC9LMMsiKpxucEsR/y+5QdqCS8g9QPYnemU4f8hReLjMH36PJ9hVDzMirLg8bHj
         YSHtDzUXzlWSN+40yl0YIDIXkKxuMgkz8eS4A64c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190419141945eucas1p12471bb235563a0e133e26deffa7943eb~W5fqdOAa_3264632646eucas1p1T;
        Fri, 19 Apr 2019 14:19:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 18.72.04298.109D9BC5; Fri, 19
        Apr 2019 15:19:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87~W5fpt85603259532595eucas1p1K;
        Fri, 19 Apr 2019 14:19:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419141944eusmtrp1dfa37bfa4f1f85a58af6bab1b495a033~W5fpf8l8O1759317593eusmtrp1a;
        Fri, 19 Apr 2019 14:19:44 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-1f-5cb9d9017813
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8B.02.04146.009D9BC5; Fri, 19
        Apr 2019 15:19:44 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141943eusmtip24b293dda9237ad973e6b4f13ad4de701~W5fouhMCN3043830438eusmtip2A;
        Fri, 19 Apr 2019 14:19:43 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v6 04/10] Documentation: dt: device tree bindings for LPDDR3
 memories
Date:   Fri, 19 Apr 2019 16:19:22 +0200
Message-Id: <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHe3cuO1uuTlPyTcVqYFSUGgS9YYVCHw5WkH1ISMmWHlRyU3c0
        Mw1mRd61NMqWl9RCM8PbELV0upZGU+cl85KWl5FaZuWNtKhcZ9W33/N//s/lfXgpTGogHKhQ
        ZRSrUsrDZKQYr21dNu0Gg/X+7rWjW1BVTgWB+hcmCVRg6CTQo68TAGW/zBOg9lQFypz4iCGT
        qVKIOi7PCNGQ2gn1NuSSaD7dAFCOqUmAHhtGhOhNQimJns0kEkj3yhu9+b4OLb0YB562zNJi
        Fs7cVXfjTL1mRMhUlyWTTPqVWZJpmX0qYDK0ZYCpMcYx89XOx0WnxAeC2LDQ86zK7dAZcUhf
        1QIeoXO5sJjTB9TghnMKoChI74V9+SdTgJiS0qUA9hT0AT5YAHAgtQXng3kAl/vnVjOiPxUJ
        vTNWVwmApqEG4l9Jt7lIYOlL0q6wrizSUmBHx8Hhfh1m8WD0jAB2rHzDLQlb2hcaP2f86YrT
        LnA6/b3QwhLaG3ZnNBL8NGc42JmMWVhEH4END7Ukr78VwoHnDM+H4Wt9odVvCz+0aYU8O0Fj
        dhrOMwfV6YXWF8TDicw8q8cDPmvrJiw7Y/QOWNHgxstecKi1lORPtA4OfNpgkbFVzKq9jfGy
        BCZdk/Lu7VCb1iXgeSMsKb9lbc5AzZRRyF8nH8Ca4nLyOtis+T/sHgBlwJ6N5hTBLLdHyca4
        cnIFF60Mdg0MV1SD1b9l/Nk2VwcWe87qAU0BmY2kOaveX0rIz3OxCj2AFCazk3gFaf2lkiB5
        7EVWFR6gig5jOT1wpHCZvSRuzaiflA6WR7HnWDaCVf3NCiiRgxoUTeU0bbvz0rx4887dsUHO
        QZ60Il67b3ociw81b41qjpJNjkUefeId2G7rGaDUb/KpC9IWG5QMsIkV+PwaUNyfNb8OTP6y
        a9qxyfX0dKVfQJvvXLjG+CNGmejH5R/UTeQ+6PLZf5VsHXavXn/i2HDL0uZ3antHj0bfNZRO
        dEnTIcO5EPmenZiKk/8G6wiKPFcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7oMN3fGGOzv17PYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO
        72OyWHvkLrvF7cYVbBaH37SzWuy/4mVx+zefxbcTjxgdhD2+fZ3E4jG74SKLx85Zd9k9Nq3q
        ZPPobX7H5nHw3R4mj74tqxg9Np+u9vi8SS6AM0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4+rGLywF+1Urvs64ytjAOFGui5GTQ0LARKLx8htG
        EFtIYCmjxNxOQYi4mMSkfdvZIWxhiT/Xuti6GLmAaj4xSlzYsBwowcHBJqAnsWNVIUiNiEC9
        RP+bS2A1zAINzBJrtl9lBUkIC4RKrHrbzwxiswioSrzsfQY2lFfAS+Ji315WiAVyEjfPdYLV
        cAp4S+xauYUN4iAviQ3X9jJNYORbwMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzCSth37
        uXkH46WNwYcYBTgYlXh4D0zaGSPEmlhWXJl7iFGCg1lJhNcxZUuMEG9KYmVValF+fFFpTmrx
        IUZToKMmMkuJJucDozyvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwen
        VAOjo7PW89WM31pnT3qiZHvELerCzluO0W9dqnZu0XwRwb1l0/sdUrWZAgKdL/y3Kt5P/F/1
        97r+Lq5dR1sDxY00XLVy2pqO9iV/ezV31+fGoJypBkdP6bytW+o3oWAR48GJCafnavvz+Nz+
        5/r6ygah71v3GR/uuqeaFNkqfoDxie7efM1Hr1pilFiKMxINtZiLihMBvG/z/boCAAA=
X-CMS-MailID: 20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree bindings for LPDDR3 SDRAM memories.

For specifying the AC timing parameters of the memory device
the 'lpddr3' binding uses binding 'lpddr2-timings'.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/lpddr3/lpddr3-timings.txt  | 57 +++++++++++++
 .../devicetree/bindings/lpddr3/lpddr3.txt          | 93 ++++++++++++++++++++++
 2 files changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3.txt

diff --git a/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt b/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
new file mode 100644
index 0000000..ebf3e00
--- /dev/null
+++ b/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
@@ -0,0 +1,57 @@
+* AC timing parameters of LPDDR3 memories for a given speed-bin.
+* The structures are based on LPDDR2 and extended where needed.
+
+Required properties:
+- compatible : Should be "jedec,lpddr3-timings"
+- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
+- max-freq : maximum DDR clock frequency for the speed-bin. Type is <u32>
+
+Optional properties:
+
+The following properties represent AC timing parameters from the memory
+data-sheet of the device for a given speed-bin. All these properties are
+of type <u32> and the default unit is ps (pico seconds).
+- tRFC
+- tRRD
+- tRPab
+- tRPpb
+- tRCD
+- tRC
+- tRAS
+- tWTR
+- tWR
+- tRTP
+- tW2W-C2C
+- tR2R-C2C
+- tFAW
+- tXSR
+- tXP
+- tCKE
+- tCKESR
+- tMRD
+
+Example:
+
+timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
+	compatible	= "jedec,lpddr3-timings";
+	min-freq	= <100000000>;
+	max-freq	= <800000000>;
+	tRFC		= <65000>;
+	tRRD		= <6000>;
+	tRPab		= <12000>;
+	tRPpb		= <12000>;
+	tRCD		= <10000>;
+	tRC		= <33750>;
+	tRAS		= <23000>;
+	tWTR		= <3750>;
+	tWR		= <7500>;
+	tRTP		= <3750>;
+	tW2W-C2C	= <0>;
+	tR2R-C2C	= <0>;
+	tFAW		= <25000>;
+	tXSR		= <70000>;
+	tXP		= <3750>;
+	tCKE		= <3750>;
+	tCKESR		= <3750>;
+	tMRD		= <7000>;
+};
diff --git a/Documentation/devicetree/bindings/lpddr3/lpddr3.txt b/Documentation/devicetree/bindings/lpddr3/lpddr3.txt
new file mode 100644
index 0000000..fc7875c
--- /dev/null
+++ b/Documentation/devicetree/bindings/lpddr3/lpddr3.txt
@@ -0,0 +1,93 @@
+* LPDDR3 SDRAM memories compliant to JEDEC JESD209-2
+
+Required properties:
+- compatible : Should be  - "jedec,lpddr3"
+- density  : <u32> representing density in Mb (Mega bits)
+- io-width : <u32> representing bus width. Possible values are 8, 16, 32, 64
+
+Optional properties:
+
+The following optional properties represent the minimum value of some AC
+timing parameters of the DDR device in terms of number of clock cycles.
+These values shall be obtained from the device data-sheet.
+- tRFC-min-tck
+- tRRD-min-tck
+- tRPab-min-tck
+- tRPpb-min-tck
+- tRCD-min-tck
+- tRC-min-tck
+- tRAS-min-tck
+- tWTR-min-tck
+- tWR-min-tck
+- tRTP-min-tck
+- tW2W-C2C-min-tck
+- tR2R-C2C-min-tck
+- tWL-min-tck
+- tDQSCK-min-tck
+- tRL-min-tck
+- tFAW-min-tck
+- tXSR-min-tck
+- tXP-min-tck
+- tCKE-min-tck
+- tCKESR-min-tck
+- tMRD-min-tck
+
+Child nodes:
+- The lpddr3 node may have one or more child nodes of type "lpddr3-timings".
+  "lpddr3-timings" provides AC timing parameters of the device for
+  a given speed-bin. Please see Documentation/devicetree/
+  bindings/lpddr3/lpddr3-timings.txt for more information on "lpddr3-timings"
+
+Example:
+
+samsung_K3QF2F20DB: lpddr3 {
+	compatible	= "Samsung,K3QF2F20DB","jedec,lpddr3";
+	density		= <16384>;
+	io-width	= <32>;
+
+	tRFC-min-tck		= <17>;
+	tRRD-min-tck		= <2>;
+	tRPab-min-tck		= <2>;
+	tRPpb-min-tck		= <2>;
+	tRCD-min-tck		= <3>;
+	tRC-min-tck		= <6>;
+	tRAS-min-tck		= <5>;
+	tWTR-min-tck		= <2>;
+	tWR-min-tck		= <7>;
+	tRTP-min-tck		= <2>;
+	tW2W-C2C-min-tck	= <0>;
+	tR2R-C2C-min-tck	= <0>;
+	tWL-min-tck		= <8>;
+	tDQSCK-min-tck		= <5>;
+	tRL-min-tck		= <14>;
+	tFAW-min-tck		= <5>;
+	tXSR-min-tck		= <12>;
+	tXP-min-tck		= <2>;
+	tCKE-min-tck		= <2>;
+	tCKESR-min-tck		= <2>;
+	tMRD-min-tck		= <5>;
+
+	timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
+		compatible	= "jedec,lpddr3-timings";
+		min-freq	= <100000000>;
+		max-freq	= <800000000>;
+		tRFC		= <65000>;
+		tRRD		= <6000>;
+		tRPab		= <12000>;
+		tRPpb		= <12000>;
+		tRCD		= <10000>;
+		tRC		= <33750>;
+		tRAS		= <23000>;
+		tWTR		= <3750>;
+		tWR		= <7500>;
+		tRTP		= <3750>;
+		tW2W-C2C	= <0>;
+		tR2R-C2C	= <0>;
+		tFAW		= <25000>;
+		tXSR		= <70000>;
+		tXP		= <3750>;
+		tCKE		= <3750>;
+		tCKESR		= <3750>;
+		tMRD		= <7000>;
+	};
+}
-- 
2.7.4

