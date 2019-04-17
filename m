Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09DAC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F07D2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HxzHhrBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbfDQHsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:48:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40618 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbfDQHsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:48:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190417074831euoutp02864d4e4699cbb327d355b197cac165c8~WM3fsSYWH0393303933euoutp02M
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:48:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190417074831euoutp02864d4e4699cbb327d355b197cac165c8~WM3fsSYWH0393303933euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555487311;
        bh=qcoBq5tBOKGZTWog231jA3ntWKkNru5PluYdYR46n7A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HxzHhrBF8iuBUzsVFllF4yjrjvCpEUxzanNqVupeSTntTlhnEdhThAn0tPK3Q/OFb
         Hqt/GhF751EBSdIfhKFXmZZ8Aws16o9aD7MHHGpk0gK+5HDom6epCAnxxLl9Hf2KKX
         WsIc6yBpcZkAiIMPs8sjgMVOiQTky2ejuFU21seY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190417074830eucas1p1482672c0db81cb6a73cac342bd5f3fd8~WM3e25dQM1289812898eucas1p1D;
        Wed, 17 Apr 2019 07:48:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DB.3E.04377.E4AD6BC5; Wed, 17
        Apr 2019 08:48:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190417074829eucas1p234e664f9bf295eca8d2fad6ba953f37c~WM3d-LbEF2287122871eucas1p2q;
        Wed, 17 Apr 2019 07:48:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190417074829eusmtrp2d5795a77e97e5b21883f40917d5cf787~WM3dvb-o72697726977eusmtrp23;
        Wed, 17 Apr 2019 07:48:29 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-81-5cb6da4e1404
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2F.47.04140.D4AD6BC5; Wed, 17
        Apr 2019 08:48:29 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190417074828eusmtip1524b9a6a70ae3e0faf20f312728f4550~WM3dEkjVB0059200592eusmtip1q;
        Wed, 17 Apr 2019 07:48:28 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com
Subject: [PATCH 0/3] Exynos Performance Monitoring Counters enhancements
Date:   Wed, 17 Apr 2019 09:48:05 +0200
Message-Id: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djP87p+t7bFGHzbz2+xccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzuog4LFm3hpGj02rOtk8Ni+p9zj4bg+TR9+WVYwenzfJBbBF
        cdmkpOZklqUW6dslcGV8fPWdpeAYZ8W2k6tZGhjnsHcxcnJICJhIXN3+kBHEFhJYwSixri+k
        i5ELyP7CKHH17QoWCOczo8Sk5l1sMB0zph+ESixnlNi+9xMbXMvNd9uYuxg5ONgE9CR2rCoE
        aRARWMwo8e1wFEgNs0Ank8S7yXvAJgkLeEhcvPKECcRmEVCV6J6xFszmFfCUeDd1AiPENjmJ
        m+c6mUGaJQQWsUvca58NdbiLxNsHN1khbGGJV8e3QMVlJP7vnM8EYRdLNPQuhBpUI/G4fy5U
        jbXE4eMXWUEOZRbQlFi/Sx8i7AhUfo4RJCwhwCdx460gSJgZyJy0bTozRJhXoqNNCKJaQ2JL
        zwWoRWISy9dMY4co8ZDY35cOCdBYiXVzVrJNYJSbhbBqASPjKkbx1NLi3PTUYqO81HK94sTc
        4tK8dL3k/NxNjMA0c/rf8S87GHf9STrEKMDBqMTDu+Ln1hgh1sSy4srcQ4wSHMxKIryOKVti
        hHhTEiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTAqvV7Tem9G
        seDZmRtlW1Iuf2KeoujNprxQUM9fpc97+w5Pn7tvUvyW3Mj5FarJcNK77qz51IOSwn+ir69o
        eOZ2Z0b/QYUocybN2jytz6u7EidYxXpMufyBXaPUZmPU8aNv7Dq4N17+uuj1z0I9nfk+W2+J
        ngr16v/n0FC6VmzizTUf6oVunj+txFKckWioxVxUnAgAljk7ji8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsVy+t/xu7q+t7bFGCyeK2yxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzuog4LFm3hpGj02rOtk8Ni+p9zj4bg+TR9+WVYwenzfJBbBF
        6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GV8fPWd
        peAYZ8W2k6tZGhjnsHcxcnJICJhIzJh+kKWLkYtDSGApo8Tyr/PYIBJiEpP2bYcqEpb4c62L
        DaLoE6PE71XngTo4ONgE9CR2rCoEiYsILGeUOLbqLTOIwywwnUnizrsrLCDdwgIeEhevPGEC
        sVkEVCW6Z6wFs3kFPCXeTZ3ACLFBTuLmuU7mCYw8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl
        5+duYgSG+bZjP7fsYOx6F3yIUYCDUYmHd8XPrTFCrIllxZW5hxglOJiVRHgdU7bECPGmJFZW
        pRblxxeV5qQWH2I0BVo+kVlKNDkfGIN5JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE0hNLUrNT
        UwtSi2D6mDg4pRoYO/pFm+sfLIyVUf9WXcMrsOuQwtaMF3dyU1VneQh//MXYJKe67kBYkP4/
        z9dHtm1YfSP8OfdKvufczt19Rt/lT+yblGbz4d1kS8spam13xCymZzMsyp+xwetlhkLqm2Mn
        Yt9EXyz+un3p2YJzSz8unhjEtvynxd+uSDcP63lL1/3dyWztNG0GixJLcUaioRZzUXEiAOMC
        tAeJAgAA
X-CMS-MailID: 20190417074829eucas1p234e664f9bf295eca8d2fad6ba953f37c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190417074829eucas1p234e664f9bf295eca8d2fad6ba953f37c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190417074829eucas1p234e664f9bf295eca8d2fad6ba953f37c
References: <CGME20190417074829eucas1p234e664f9bf295eca8d2fad6ba953f37c@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch set extends PPMU on Samsung Exynos by choosing type of data
which shell be counter in the PPMU registers.
It is possible to count e.g. read or write requests, read or write data.
A new field has been added in the DT 'event' node called 'event-data-type'.
It is them used during the setup of the counter. In the prevoius
implementation there was always one option used: count read+write data.
Sometimes we need more precised information and this patch set tries to
address it.

Regards,
Lukasz Luba

Lukasz Luba (3):
  include: dt-bindings: add Performance Monitoring Unit for Exynos
  drivers: devfreq: events: extend events by type of counted data
  Documentation: devicetree: add PPMU events description

 .../bindings/devfreq/event/exynos-ppmu.txt         | 18 ++++++++++
 MAINTAINERS                                        |  5 +++
 drivers/devfreq/event/exynos-ppmu.c                | 38 +++++++++++++++-------
 include/dt-bindings/pmu/exynos_ppmu.h              | 24 ++++++++++++++
 include/linux/devfreq-event.h                      |  6 ++++
 5 files changed, 79 insertions(+), 12 deletions(-)
 create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h

-- 
2.7.4

