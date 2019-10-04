Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9458BC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C12520700
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tyry6+PZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbfJDNjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:39:08 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57163 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388270AbfJDNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:39:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191004133906euoutp01443360bf2b85816895d970e71b3afe25~KdUH13bXw3138831388euoutp01V
        for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2019 13:39:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191004133906euoutp01443360bf2b85816895d970e71b3afe25~KdUH13bXw3138831388euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570196346;
        bh=mfOpftgeLJfSOiF9nppj8jV7jEUqmOTaYlnFuAo6bis=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tyry6+PZjVBCQxVptB53utwXJbPVngeMehtAsckSOuVjRwXhkf+XHnZY704Tk1NPh
         MaNoqURN1K8kpK3NmFVC/aJuBuiMNu+Z1r1/p73UKnGBckO6ZTWjoLwvLb8LojudpD
         pgBiq0vr8MqksbH7qWbz5c2lzUE4T/ocpQVhyvqU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191004133905eucas1p238ca3d9428973ddbaed53318a480b9d1~KdUHkVY7w0349203492eucas1p2m;
        Fri,  4 Oct 2019 13:39:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B0.BE.04309.97B479D5; Fri,  4
        Oct 2019 14:39:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191004133905eucas1p1f002c9e76ceaef205b48e941707af726~KdUHGoRed2123421234eucas1p15;
        Fri,  4 Oct 2019 13:39:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191004133905eusmtrp18813590ccf93209a75d6e709d83c9316~KdUHF_iiY2251922519eusmtrp1-;
        Fri,  4 Oct 2019 13:39:05 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-25-5d974b798123
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 02.83.04166.97B479D5; Fri,  4
        Oct 2019 14:39:05 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191004133905eusmtip25a6331289fbc8965675f0709e659d8d4~KdUGslz662524825248eusmtip2U;
        Fri,  4 Oct 2019 13:39:04 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, lukasz.luba@polnum.com
Cc:     b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [RFC 0/2] SRAMFS a direct mapped SRAM pages into user space
Date:   Fri,  4 Oct 2019 15:38:53 +0200
Message-Id: <20191004133855.17474-1-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWy7djP87qV3tNjDV4+M7fYOGM9q8WtBhmL
        y7vmsFlMeveIyWLtkbvsFofftLM6sHkcfLeHyeNH50FGj74tqxg9Pm+SC2CJ4rJJSc3JLEst
        0rdL4Mr487qNpeACR8Wqh0vYGhhXs3UxcnBICJhIzFjl1sXIxSEksIJR4tyiRlYI5wujxN99
        B9kgnM+MEh/efmTvYuQE62hcNYkZIrGcUeLbxN3scC2fFr9lB5nLJqAnsWNVIYgpImAh8aS/
        HKSXWaBK4uCNn4wgtrCAi0TXum5WEJtFQFWi49IKsDivgL3E6vb9TBC75CVWbzgAtktC4Aib
        xKtrLYwQCReJLdt+skHYwhKvjm+BOk5G4vTkHhYIu1iioXchVH2NxOP+uVA11hKHj19kBbmN
        WUBTYv0ufYiwo8TrX7BQ4ZO48VYQ4mQ+iUnbpjNDhHklOtqEIKo1JLb0XIC6Ukxi+ZppUMM9
        JBZO7AA7QEggVmL+3Z9MExjlZiHsWsDIuIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMw
        3k//O/5lB+OuP0mHGAU4GJV4eD9YTI8VYk0sK67MPcQowcGsJMJ7af2UWCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2MEjYT1gYe0N+uvXvtcxML64l3
        0j9Nfimj3eupzJY9ZRVjO6NR+webx9dZZp0JOXFf/Z3p3+PNp+7cEPHkefxZV9Tn0cJ3rme5
        3cXPrigr8+ZaP0Fx5eYdAucZ+i2uJeRkbrz4TLll83GlFewaP2/M/GCj99uo2zxY69T1vZJn
        T89VZpIP+bIxQImlOCPRUIu5qDgRAJ3PeGbzAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsVy+t/xe7qV3tNjDe4eE7fYOGM9q8WtBhmL
        y7vmsFlMeveIyWLtkbvsFofftLM6sHkcfLeHyeNH50FGj74tqxg9Pm+SC2CJ0rMpyi8tSVXI
        yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mv487qNpeACR8Wqh0vY
        GhhXs3UxcnJICJhINK6axNzFyMUhJLCUUWLVkWZ2iISYxKR926FsYYk/17rYIIo+MUqsXHyI
        tYuRg4NNQE9ix6pCkBoRASuJeet/gQ1lFqiTaDgwE6xXWMBFomtdNyuIzSKgKtFxaQUjiM0r
        YC+xun0/E8R8eYnVGw4wT2DkWcDIsIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw2LYd+7l5
        B+OljcGHGAU4GJV4eD9YTI8VYk0sK67MPcQowcGsJMJ7af2UWCHelMTKqtSi/Pii0pzU4kOM
        pkDLJzJLiSbnAyMhryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD
        o37Ptc3HjvIf2pz1yG1y5Oo3qfo3NTSiug5O43DI+WL988Kihau2RDSdkH4cdea/CdehrkLv
        BdYHGldkBGTpvZOR2sn1p9knJFV6f07q7lP3TqrJd985HZbz83blLm/FH0fVJMIfxSx0mXb6
        zNQFeofVbMJyXRekL+5tDdW4uclrxo60iN7PlUosxRmJhlrMRcWJAOIjNOBMAgAA
X-CMS-MailID: 20191004133905eucas1p1f002c9e76ceaef205b48e941707af726
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191004133905eucas1p1f002c9e76ceaef205b48e941707af726
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191004133905eucas1p1f002c9e76ceaef205b48e941707af726
References: <CGME20191004133905eucas1p1f002c9e76ceaef205b48e941707af726@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch set tries to introduce a direct mapping mechanism of SRAM
memory regions directly into user space.
This is a draft of some reaserch work which I am going to continue.
Since it is my last day in the office I have publish it as a RFC.

Benefits of having SRAM memory in the user space:
- lower latency access
- lower power usage
- managable scratchpad which could be sharable between processes
- could be used toughether with dedicated instructions like dot product
  calculation

Regards,
Lukasz Luba

Lukasz Luba (2):
  DT: ARM: exynos: change SRAM device node
  dirvers & fs: add sram driver and sramfs

 arch/arm/boot/dts/exynos54xx.dtsi |  12 +-
 drivers/misc/Kconfig              |   7 +
 drivers/misc/Makefile             |   1 +
 drivers/misc/sram.h               |   1 +
 drivers/misc/sram_direct.c        | 863 ++++++++++++++++++++++++++++++
 include/uapi/linux/magic.h        |   1 +
 mm/memory.c                       |   5 +-
 7 files changed, 878 insertions(+), 12 deletions(-)
 create mode 100644 drivers/misc/sram_direct.c

-- 
2.17.1

