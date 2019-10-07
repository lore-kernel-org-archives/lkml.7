Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC5CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D239206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="abNM6Spu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfJGTDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:03:10 -0400
Received: from mx3.ucr.edu ([138.23.248.64]:10802 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfJGTDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570474991; x=1602010991;
  h=mime-version:from:date:message-id:subject:to;
  bh=qKkd59j86O9FUZiM0WpoYxgW00QFfLIb89TLtsimzfI=;
  b=abNM6SpuOJ1ckFfRCccdOco9+87lPltP9lDSGN8OwegTeNd42UBkkKLe
   1WjEIN67yPtFuvFD7FBIIpLG+3kCRsOr22AtbfBYtwUDuu4BB3DwWY0i2
   Aatzcpddj3pihzl3lzVHNJ4ArfKtA4xv/xSNppGiwGuct1xWzpwzr3Fob
   vkUtpufe+aQuUNYQyiJ45/xYKuPkz+PAOE77Tb8A3+Pbl0cJOZPA0EeAg
   1lTuwytdLqAAdkj2uyMPoVHI9HUF/T2IMrJjKSzG/mUIB2a7d6IOj99/m
   akPnEhk5QqW2ZuY8NypYLYVMPKa44oZHXuh5WzVGR9yU2tVBSl2TNR2tk
   w==;
IronPort-SDR: /brpzDqukPUusNRekq9T1UwiCihwTb0HeuZZTOevJ/IbxdVKUY5glCSnhmOQORQblKaw8NSrQ2
 RrKGXrINK+0Qf8cVnx/K9Fd/6gt5k+d3YpezKCWmUGiYZEkogrMz4jW8omSBk1UMaM0OEQ6oPU
 nFsVxHE27LGrsDtHk45zRZ/m7hKWKSJoO7nwD8vXDo30fkoIqh8/gMRYEjaadc3bj9uPrzEoCe
 xDec6bRytbjlxOzi7cyvrH+yeXkEC6TkGT/dCxoWt1XpKNGH1YtIvYYZtCud3UFa31hqmr5yoU
 BWA=
IronPort-PHdr: =?us-ascii?q?9a23=3AcphXvREhV5wNoGsY0mdQ7Z1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76ps24bnLW6fgltlLVR4KTs6sC17ON9f2/EjVZsN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twXcu8sZjYd/N6o8zg?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFKH4GyYJYVD+cZMulWr4fzqVgToxWgGQahH//vxiNSi3PqwaE2z+?=
 =?us-ascii?q?YsHAfb1wIgBdIOt3HUoc33O6cTUOG1zLTIzTLeZPxV2Tfy8onIeQ0mrPCMXL?=
 =?us-ascii?q?NwcdDeyUgzGw/ZgFidspHlMC+P1ugXrWeU8vdgWPuphmU6qA9xuiCiytkwho?=
 =?us-ascii?q?TNnI4YyVDJ+T9kzIs0J9C0Ukx2bcCiHZBNrS+VLZF2TdknQ2xwvSY6zaAJto?=
 =?us-ascii?q?CjcSgRzZQn2wbfa/uac4iU+h7jVPieITN/hH99fbKwnRey8Uy5xu34WMm4zU?=
 =?us-ascii?q?9GriRHn9XSrHwN2BvT6s+ISvt54EitwyqA1wfW6u1cIEA0k7TUK4I5z7Iuip?=
 =?us-ascii?q?YetV7PEyz2lUnskaObd0cp9vKq5uj5ernmo4WTN45wigHwKKQuncm/DPw4Mw?=
 =?us-ascii?q?kPX2iU4+W82KH/8UD3W7hKk+E5krPDvJ/EOMsbu7a1AxVJ3YY79xa/EzCm3c?=
 =?us-ascii?q?wcnXkGKlJFZR2Gg5HqO17QOvD4C+mwg1C3nTd1yPDJIKfhDo/OLnfdirfhe6?=
 =?us-ascii?q?hy60pGxAo019Bf6MEcNrZUJfvpRk738sTVEhIjKAGy6+H9Ad5528UVXmfLSo?=
 =?us-ascii?q?yQLK6aikOF+es1P6HYZ5QJtSn0MeQN4//okG83nkIbcaC13JwRLneiEaIia3?=
 =?us-ascii?q?mZZn/lmZ8uFWoLrgwzVqS+lFKGQRZXZnCvQ7g74DArTo6rW8OLb4SpgaeG2m?=
 =?us-ascii?q?+BF5tab2QOXlmIFXbzcIOsX/AMdT6VIYlnnyBSEfC/QpU80zmltAL+0LtgaO?=
 =?us-ascii?q?HT/2lQmJT51dNyr9LelB4/8SA8W8Wb3WalSmxog3NOQTIqiuQ3q1J0zF6Yyq?=
 =?us-ascii?q?N4jtRRHtkV4OlGFk8+NJjB36lhAMvzchzOc83PS1u8RNiiRzYrQZZ539YUbE?=
 =?us-ascii?q?thXtmvkB3H9zSlDqVTlLGRApEwtKXG0Dy5I8d71maD16Q7iVQiatVAOHfgha?=
 =?us-ascii?q?Nl8QXXQYnTnAHRpaarZLkalBfM/WHLmXiOvVBFVhdYWr6DQHsFIEbasIK9rm?=
 =?us-ascii?q?jCQrmhGKlvCQxHxobWIbBNbNLBhk4AWfz5ftnSfjTitX23AEO5x6GMcY2iSW?=
 =?us-ascii?q?UU3W2JGVoEmgFLpS2uKAMkQCqtvjSNX3RVCVvzbha0oqFFo3ShQxpxllnSYg?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HFAgBoi5tdh0inVdFmDoIQhBCETY5?=
 =?us-ascii?q?ggw2CCgGGd4VZgRiKNAEIAQEBDi8BAYcfIzcGDgIDCQEBBQEBAQEBBQQBAQI?=
 =?us-ascii?q?QAQEBCA0JCCmFQII6KQGDVRF8DwImAiQSAQUBIgE0gwCCC6JngQM8iyaBMoQ?=
 =?us-ascii?q?LAYRZAQkNgUgSeiiMDoIXgRGCXQeIPYJYBIE4AQEBlSyWVAEGAoIQFIxUiEQ?=
 =?us-ascii?q?bgioBlxSOLJlLDyOBRYF8MxolfwZngU9PEBSBaY1xBFckkhwBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HFAgBoi5tdh0inVdFmDoIQhBCETY5ggw2CCgGGd4VZg?=
 =?us-ascii?q?RiKNAEIAQEBDi8BAYcfIzcGDgIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCmFQ?=
 =?us-ascii?q?II6KQGDVRF8DwImAiQSAQUBIgE0gwCCC6JngQM8iyaBMoQLAYRZAQkNgUgSe?=
 =?us-ascii?q?iiMDoIXgRGCXQeIPYJYBIE4AQEBlSyWVAEGAoIQFIxUiEQbgioBlxSOLJlLD?=
 =?us-ascii?q?yOBRYF8MxolfwZngU9PEBSBaY1xBFckkhwBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="85783611"
Received: from mail-lf1-f72.google.com ([209.85.167.72])
  by smtp3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2019 12:03:10 -0700
Received: by mail-lf1-f72.google.com with SMTP id r3so1671093lfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ESofDjYlaGWbuPOVSuea9qOggnj5mZzg5iY6K5NGehg=;
        b=oBU/2rOzfUvXqFOLeOlcg/UO6GDw+Nw3+YCmD2X4gEr6jJZzwMPB0ZnpifwRS3yrwo
         feUqCkUVDJnozWDQSB5nq9rOjBQOy5KIFWF/ungdssff3GjHoMciYyal2HJeYStZ+9F5
         f0szU8UKfEBdUvXXaIUtRBPhfD0K1M+iKWsKSR7WJOhzQ2Ckq2QmepphRuFUcxDCWP9z
         e+6LhBBtoXwe2/bLPON8rP+vKVa4MgRJ5Sh2SSIipb3MaaijdcR/tqah/INnNyfTsh9H
         CfLkVNlRQf5zbso3c061YPo+/9A0lT/3czNeDTrw11Ri/Gav/dasr4LjTrA2kKzG24h6
         Y6gw==
X-Gm-Message-State: APjAAAVAT/qRNMDqJVX2/n0HFKNU97lOae6ORIgULNph8SslaCDE/QkZ
        ouKO+kd2so78Kv6fIcVo81zk1MoABQ3Q84LPJPOMeUBTB4qGIn43V32M+1RQoLJrQfRfTuAt7Ei
        WH9/EeeF3e9ORcw61JXxr37gjl/z5i5pwCmOu1MRN/Q==
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr19382942ljk.92.1570474987354;
        Mon, 07 Oct 2019 12:03:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPt2y/kkUfF2dViia+Gw42gIv9azn/ATOBEVLWWAlSLPnIIR6FYLzrKHUfg/QEdwY0P6m32CFv87gaTDTQITI=
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr19382924ljk.92.1570474987121;
 Mon, 07 Oct 2019 12:03:07 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 7 Oct 2019 12:03:50 -0700
Message-ID: <CABvMjLQxcV5UE3_j84SV3u2LxJKVoQ2G+5CZCuKtAd6A_6FDNw@mail.gmail.com>
Subject: Potential NULL pointer deference in cxgbit
To:     martin.petersen@oracle.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>, varun@chelsio.com,
        Enrico Weigelt <info@metux.net>, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

drivers/target/iscsi/cxgbit/cxgbit_ddp.c:

Inside function cxgbit_ddp_sgl_check(), sg_next() could return NULL,
however, the return value of sg_next() is not checked and get
dereferenced. This could potentially be unsafe.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
