Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89976C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C42D204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kBIXYVt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfDSShz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:37:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52242 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbfDSShw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:37:52 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190419134820euoutp0235b6af837ad3c421c5f5ace44a404015~W5EOUHBzB0575605756euoutp02d
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:48:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190419134820euoutp0235b6af837ad3c421c5f5ace44a404015~W5EOUHBzB0575605756euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555681700;
        bh=m6BLNwJxu8XBQPTXD2k36Sh6Ui5ToWCk6mIqjz+eqtY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kBIXYVt9xs2/VzcI9uUEMfgd8pw0XNOwnGxANyY9dx9oVqWQopE68vzYkmoRY4O8M
         u2be3Oea/dheH3xCVMw7yQDHlOJ3alhyz8904Jnlmea0XLlL2nlTukwLW8aC426tPK
         LGfJiP/CwYAJ1ocDrEnV/+4Keat5SG5FZWGNSGoE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190419134818eucas1p128028ce136949d41b21511ad62e70010~W5ENKbfEg0557905579eucas1p1H;
        Fri, 19 Apr 2019 13:48:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E2.B0.04325.2A1D9BC5; Fri, 19
        Apr 2019 14:48:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190419134818eucas1p1d121f99f6c018c27254f0af8cab5ea64~W5EMXElFc1719517195eucas1p1r;
        Fri, 19 Apr 2019 13:48:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419134817eusmtrp182b095c218bac3cc63d8aff17d0e240a~W5EMI4acr2843728437eusmtrp1K;
        Fri, 19 Apr 2019 13:48:17 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-ec-5cb9d1a28bef
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 87.BE.04140.1A1D9BC5; Fri, 19
        Apr 2019 14:48:17 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419134817eusmtip296e67dc2187bc20cea2184ab48aa303d~W5ELbzmn61146511465eusmtip2O;
        Fri, 19 Apr 2019 13:48:17 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v3 0/4] Exynos Performance Monitoring Counters enhancements
Date:   Fri, 19 Apr 2019 15:48:04 +0200
Message-Id: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7qLLu6MMXh0Rdti44z1rBbXvzxn
        tZh/5ByrRf/j18wW589vYLc42/SG3eJWg4zFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26x
        9PpFJovbjSvYLFr3HmG3OPymndXi24lHjA6CHmvmrWH02DnrLrvHplWdbB6bl9R7HHy3h8mj
        b8sqRo/Pm+QC2KO4bFJSczLLUov07RK4MpY8X8BUsJC/4vCn68wNjA+4uxg5OSQETCTeNZ5j
        ArGFBFYwSiz5VNvFyAVkf2GUuPf1NCuE85lR4uDLViaYjlutZ5khEssZJab/mcYO19L04hVQ
        hoODTUBPYseqQpAGEYHFjBLfDkeB1DALLGOS2Nf8CWySsIC3xNz5K1lB6lkEVCV+HPEECfMK
        eEn8vt3CCrFMTuLmuU6wZRICm9glzhy9yQaRcJE4sWsGI4QtLPHq+BZ2CFtG4vTkHhYIu1ii
        oXchVE2NxOP+uVA11hKHj18E28ssoCmxfpc+RNhRYt/Cy2wgYQkBPokbbwVBwsxA5qRt05kh
        wrwSHW1CENUaElt6LkCDRExi+ZppUMM9JLa1N0EDNFbi1eNLjBMY5WYh7FrAyLiKUTy1tDg3
        PbXYOC+1XK84Mbe4NC9dLzk/dxMjMPWc/nf86w7GfX+SDjEKcDAq8fAemLQzRog1say4MvcQ
        owQHs5IIr2PKlhgh3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwc
        nFINjAJpa6q+bfrboXtg6f/GoC1Sx05Os3E4r9bscbYn7tmm8rkRsWJCP3N0n68JNjfqNG+b
        9/4js9GEwPZbD2VM9zR8T76du/tp3RWBNww1F5NVLT6cXd/6STWC/w9/3sVsn70X57jt6V/C
        9fW+jhJrQ0Zrhuzqo+Zfm6O37kzvb56r6nH6UVzhXSWW4oxEQy3mouJEALV4Ckc5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t/xe7oLL+6MMdg51dBi44z1rBbXvzxn
        tZh/5ByrRf/j18wW589vYLc42/SG3eJWg4zFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26x
        9PpFJovbjSvYLFr3HmG3OPymndXi24lHjA6CHmvmrWH02DnrLrvHplWdbB6bl9R7HHy3h8mj
        b8sqRo/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
        Uov07RL0MpY8X8BUsJC/4vCn68wNjA+4uxg5OSQETCRutZ5l7mLk4hASWMooseHxTzaIhJjE
        pH3b2SFsYYk/17rYIIo+MUo87TkKlODgYBPQk9ixqhAkLiKwnFHi2Kq3YJOYBbYxSey5spsR
        pFtYwFti7vyVrCANLAKqEj+OeIKEeQW8JH7fbmGFWCAncfNcJ/MERp4FjAyrGEVSS4tz03OL
        jfSKE3OLS/PS9ZLzczcxAgN/27GfW3Ywdr0LPsQowMGoxMN7YNLOGCHWxLLiytxDjBIczEoi
        vI4pW2KEeFMSK6tSi/Lji0pzUosPMZoC7Z7ILCWanA+MyrySeENTQ3MLS0NzY3NjMwslcd7z
        BpVRQgLpiSWp2ampBalFMH1MHJxSDYwG176v1XkStoi9mT1z28f+C/qzmOb0WFVp3nL1Vnt9
        NOlvysI5haJ6M57ZnHadLZqyyHF21/xp156f6mKW2226T89qbUhIhuHniQz/njxUlJSRFH77
        +EM4I6vs7heKM/7+Vbx8mzn4XNoCnf3rr7UunMUqz/Utdop8u1tvzfLDc6dc/nOCU2y1Ektx
        RqKhFnNRcSIAeAhIK5ICAAA=
X-CMS-MailID: 20190419134818eucas1p1d121f99f6c018c27254f0af8cab5ea64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419134818eucas1p1d121f99f6c018c27254f0af8cab5ea64
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419134818eucas1p1d121f99f6c018c27254f0af8cab5ea64
References: <CGME20190419134818eucas1p1d121f99f6c018c27254f0af8cab5ea64@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch set extends PPMU on Samsung Exynos by choosing type of data
which shell be counter in the PPMU registers.
It is possible to count e.g. read or write requests, read or write data
or latency.
A new field has been added in the DT 'event' node called 'event-data-type'.
It is them used during the setup of the counter. In the prevoius
implementation there was always one option used: count read+write data.
Sometimes we need more precised information and this patch set tries to
address it.

Changes:
v3:
- fixed wrong interpretation of ret value during DT parsing, which caused
  alwasy taking default value.
v2:
 - removed new entry in MAINTAINERS file as suggested by Bartek Zolnierkiewicz
   and added new file to existing list for devfreq events
 - added in the dt-bindings/pmu/exynos_ppmu.h 2 new entries for RO and WO for
   counters in Exynos5433
 - changed initialization with default values when data_type is not provided
   in DT (as sugessted by Chanwoo)
 - added 4th patch which adds 'event-data-type' to 'event' node for Exynos4412
   PPMU events (asked by Chanwoo)

Regards,
Lukasz Luba

Lukasz Luba (4):
  include: dt-bindings: add Performance Monitoring Unit for Exynos
  drivers: devfreq: events: extend events by type of counted data
  Documentation: devicetree: add PPMU events description
  DT: arm: exynos4412: add event data type which is monitored

 .../bindings/devfreq/event/exynos-ppmu.txt         | 18 +++++++
 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      | 10 ++++
 drivers/devfreq/event/exynos-ppmu.c                | 61 +++++++++++++++-------
 include/dt-bindings/pmu/exynos_ppmu.h              | 26 +++++++++
 include/linux/devfreq-event.h                      |  6 +++
 6 files changed, 103 insertions(+), 19 deletions(-)
 create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h

-- 
2.7.4

