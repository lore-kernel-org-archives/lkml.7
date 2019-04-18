Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A956C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9BC20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y8XLnrHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbfDRNiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:38:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34182 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:38:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190418133851euoutp0186e0fdac7d81c5d2a35a66533225647b~WlSqfzwYs0378803788euoutp01C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 13:38:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190418133851euoutp0186e0fdac7d81c5d2a35a66533225647b~WlSqfzwYs0378803788euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555594731;
        bh=PsslqsEHDamRjNmHw9ub1TL6udLTKrIky6m09/GrH1Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Y8XLnrHOpleyF+tV+LSCXgMPKoFPidym1G1HDCDQDKXSozqEAY3OmvlwgOpjQIjp4
         sCgf0iGxoN/X77N7UvLzISv4mXNI3LbI7BmNJrTDNsQoOJH3gDoGnkvdNcnEhR+XgZ
         YZc/BuzmKX+zO25CS9V+CzjtCaymVFqIrZrQAYNQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190418133850eucas1p1ec7f7e5965baaf88ac16eb4bf4df8327~WlSpl-oqI1528915289eucas1p1P;
        Thu, 18 Apr 2019 13:38:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AB.0B.04377.AED78BC5; Thu, 18
        Apr 2019 14:38:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190418133849eucas1p11666819084daed6e9585a4f6faa124ed~WlSotGdR61758317583eucas1p17;
        Thu, 18 Apr 2019 13:38:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190418133849eusmtrp22f1811da26c929ea41fce5e8241ae95a~WlSoe5obk2812628126eusmtrp24;
        Thu, 18 Apr 2019 13:38:49 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-28-5cb87dea8e8e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 86.55.04140.9ED78BC5; Thu, 18
        Apr 2019 14:38:49 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190418133848eusmtip2f5c1b292030ce459872c6a792a2d80d8~WlSnylzdt2312923129eusmtip2D;
        Thu, 18 Apr 2019 13:38:48 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v2 0/4] Exynos Performance Monitoring Counters enhancements
Date:   Thu, 18 Apr 2019 15:38:28 +0200
Message-Id: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTURzGd+7d3a7m5DrfTmb7MApNSCuDDimi0IeVRIlCYlYud9OVm7Y7
        NXuhqeVUNMVeNPNtmi8MYzqHTEkhnS7RXGJlGkK4D4WaH3IIlVle7qxvv3Oe5/k/fw6HxMUd
        RBCpVGtpjVqeJRV48vvHf0wfXL5jTT3UavNHvXUmAs25vhCo2TZNoCrnCo4cjh4helO0KkQL
        umBkdn4g0OxggwCtV9oAqnMMY+iFbVGI2udmMPSpsEuA7g/ZhGh0VU+gjddLINZH1t3UDWQD
        9YtCmdlYJpD1Pb8re7X2EpM9sBiBbN0sOStM8YxW0FnKPFoTEZPmmdn+24Tl9HrfsPYUCXSg
        ZFc58CAhdRTec7XyWRZTXQA6H54pB57b7AJwqKsR4w7rANYWVxE7idLqIYITOgE0Wt7x/0X6
        hssE5YAkBVQ4tBqvswE/qg3AjdEU1oNTHRgcLv6OsYIvFQ+Ns2uAZT61Hz5r+CVgWUSdgivG
        r0KuTQLnp8twNgwpsxAu6ScAJ5yABtsjPse+cNlucQeC4Z+BZoxjBuoqDW7/beisanR7ouCo
        fYZgF8WpA9A0GMEipOLge8M+Dr3hx28+rBnfxpr+Wpy7FsHSEjE3IxRaKt66ewJgZ/cT92wZ
        LDY14dyDXoCrxb38aiCp/1/VAoARBNK5jCqDZo6o6fxwRq5ictUZ4enZKjPY/j2TW3aXFQxu
        Xh4BFAmkXiKotKaKCXkeU6AaAZDEpX6iOIUlVSxSyAtu0prsS5rcLJoZAXtIvjRQdIv3+byY
        ypBr6Ws0nUNrdlSM9AjSAaVEq5bGhKz4JFwZCKut2LpqSF1sGqudD01q4fW6/Dp8EniFeq1X
        7PzmVL46TBXwuMTvqalNH7o3CSVm+06EUieViRclDn1822SIy7w7wqEpX4+qma2ac/KiS46d
        GzcURdbFpIns1M/0xlKsIHlj7Hgyb2HKX9SuiJRH5JyW8plM+eEwXMPI/wL4zxJ+OQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t/xe7ova3fEGFz7I2GxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6GUv/rmcq2MhXsWNDE1sDYxt3FyMnh4SAiUTHhL2sILaQwFJGiQ3LJSHiYhKT9m1n
        h7CFJf5c62LrYuQCqvnEKPHgai9QAwcHm4CexI5VhSBxEYHljBLHVr1lBnGYBbYxSey5spsR
        pFtYwFti1eV3YDaLgKrE7Dm/2UBsXgEviderXkBtkJO4ea6TeQIjzwJGhlWMIqmlxbnpucVG
        esWJucWleel6yfm5mxiBgb/t2M8tOxi73gUfYhTgYFTi4ZXI3BEjxJpYVlyZe4hRgoNZSYTX
        MWVLjBBvSmJlVWpRfnxRaU5q8SFGU6DlE5mlRJPzgVGZVxJvaGpobmFpaG5sbmxmoSTOe96g
        MkpIID2xJDU7NbUgtQimj4mDU6qBcePUD5W/nBakVqzdrml4vjDh0ZZlMb1KZTNLO14c78s9
        ce/mtjc9HHO3sO4J+750u/1RpcXTvx3e3x8ulrDx/qa4j58vihyyPFFgI/iu1ntJkskxLX/W
        lymu83hSvY6vKNuxai7Prf9ndW67zFr/0v7idE+zvQteXOWK3HuL9V5pe+2t79NWNexTYinO
        SDTUYi4qTgQAGIV8nJICAAA=
X-CMS-MailID: 20190418133849eucas1p11666819084daed6e9585a4f6faa124ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190418133849eucas1p11666819084daed6e9585a4f6faa124ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190418133849eucas1p11666819084daed6e9585a4f6faa124ed
References: <CGME20190418133849eucas1p11666819084daed6e9585a4f6faa124ed@eucas1p1.samsung.com>
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

