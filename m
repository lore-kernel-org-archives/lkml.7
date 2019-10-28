Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894F3CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C89321734
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bh8hnmGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389226AbfJ1Mmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:42:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54440 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389163AbfJ1Mmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:42:54 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9SCgrhd067016;
        Mon, 28 Oct 2019 07:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572266573;
        bh=CXZBLVs16lsTdOcw1G+j84Zl3El0VgK+ujWfvioNpWY=;
        h=From:To:CC:Subject:Date;
        b=bh8hnmGd43dMlk/0XjiEMoJqENQezobucAZzk6kiV9Lm+QjVK1n5ccK7VYN53Szu9
         QgpajpWrTE/+Yg1QhWYXl1kZDCj1gFXHZ+7kYsTMybuvlpkPGv0XRmfwe1DcLPU1R0
         Al+dLZCYkUJ1a3kxDUxg09u1cAMHOHCvTzxJHyZs=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9SCgrFZ068845
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Oct 2019 07:42:53 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 28
 Oct 2019 07:42:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 28 Oct 2019 07:42:41 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9SCgogq063574;
        Mon, 28 Oct 2019 07:42:51 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <s-anna@ti.com>
Subject: [PATCH 00/17] remoteproc: omap changes on top of v5.4-rc1
Date:   Mon, 28 Oct 2019 14:42:21 +0200
Message-ID: <20191028124238.19224-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mostly this is a facelift of the pretty old OMAP remoteproc code base,
supporting now DT, runtime PM, ti-sysc, and dropping legacy omap hwmod
support. Also timer + watchdog support is added, and couple of bugfixes.

The series hasn't been posted before mostly due to missing OMAP reset
support, which has just been lately posted out and is getting merged to
5.5.

For proper functionality, this series depends at least on the clock [1]
and reset [2] series sent out by me, but to compile, it only needs [1].

-Tero

[1] TI Clock series: https://patchwork.kernel.org/cover/11143025/
[2] TI Reset series: https://patchwork.kernel.org/cover/11179573/


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
