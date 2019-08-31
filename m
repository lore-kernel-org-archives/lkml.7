Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA00C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D8923429
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoHZR9AO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfHaCZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 22:25:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35083 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfHaCZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 22:25:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so3268662pfw.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 19:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7GGohDtFIzadHRK9qlBFqyaUQq3IDsI0G9jsiYfLeIA=;
        b=RoHZR9AOQVftWcIO7bJGMrXpE/nIQAT8sYbyqtg2OX3OIHuU2phYl0hwHj4mdbiT0a
         TNsMxoc/4q8mV7q0Xoey9q8Xe6Wle8Q6ON3ZLZa6vp0DmpMJv6MeQ6ft1k7Xsv2WiXEM
         TebXTKo2jnj03IX2x/qJoITVMqBgG/0wv4wkccAgpVdQWluZUGlspulf1nvMXTp6bGY9
         aJQV6Q9OUheeO/VEhKnjWsZRpRElyvTVGP6yd4w/rbr/QrpYYncrWdw42YMqsarxdakS
         rGyZ2bC9+g9TKghXv/05M+7KWnGZDe2j2v24mz5uZJVJmg+k9BzuAaUhT/l507oefGhM
         giZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7GGohDtFIzadHRK9qlBFqyaUQq3IDsI0G9jsiYfLeIA=;
        b=WHPR/gcacdyaSUdCOkWQEo606uITz1aE7h8XqRyeKWrEhSJ0vPJ3xJDaziOWJJivzb
         Hszq0SMLCQdxwTfBGaIf7wqzXSVSRsGn51ACN07Cpclf1gjKnBgJp2aR+An7JvBYXgoe
         j4ZATHzthwgsmlJX8XWGTkXWed47OVQHC/5VUajiiTKZJpPFZsEA2TAmKx2HyHuLJ0YK
         8cEwMtEzFSDpuYwUC+Ws8ErQQ33MjxD7K9GN1EWTO5OUZsPNFVsXQWc4Hks6b48MsBVc
         3vI44wW5CXcjaSw5ApaBtwGyvX4OaHwkP1eFGz7sGbHi0pBiZJY8NcZhlAkMqs8aFDuJ
         NCeg==
X-Gm-Message-State: APjAAAVGRtGv0pzYgz03Q19+OXPj2c8Jg/8uurjMV3e2R5qASbEiC5Jb
        cQD8ImOnbQHLRDCBP5/rRyd4+ZmUdmY=
X-Google-Smtp-Source: APXvYqwf/18nVOeRvdxzV0EYlJDBqTSPZ6dykzvlguaUwp12T3UpnfvaO5EsS7NXZ6aoekiVbIatOg==
X-Received: by 2002:aa7:92d1:: with SMTP id k17mr20872378pfa.160.1567218331386;
        Fri, 30 Aug 2019 19:25:31 -0700 (PDT)
Received: from dell-inspiron ([117.220.112.196])
        by smtp.gmail.com with ESMTPSA id s13sm8076449pfm.12.2019.08.30.19.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 19:25:30 -0700 (PDT)
Date:   Sat, 31 Aug 2019 07:55:15 +0530
From:   P SAI PRASANTH <saip2823@gmail.com>
To:     gregkh@linuxfoundation.org, kim.jamie.bradley@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rts5208: Fix checkpath warning
Message-ID: <20190831022515.GA4917@dell-inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpath warning
in the file drivers/staging/rts5208/rtsx_transport.c:546

WARNING: line over 80 characters
+                               option = RTSX_SG_VALID | RTSX_SG_END |
RTSX_SG_TRANS_DATA;

Signed-off-by: P SAI PRASANTH <saip2823@gmail.com>
---
Changes in v3:
 -Fixes the following error in da59abd45efc
  >> drivers/staging//rts5208/rtsx_transport.c:548:4: error: expected
     ';' before 'rtsx_add_sg_tbl'
       rtsx_add_sg_tbl(chip, (u32)addr, (u32)len, option);
       ^~~~~~~~~~~~~~~

 drivers/staging/rts5208/rtsx_transport.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 8277d78..3c67656 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -540,11 +540,10 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 
 			dev_dbg(rtsx_dev(chip), "DMA addr: 0x%x, Len: 0x%x\n",
 				(unsigned int)addr, len);
-
+
+			option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
 			if (j == (sg_cnt - 1))
-				option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
-			else
-				option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
+				option |= RTSX_SG_END;
 
 			rtsx_add_sg_tbl(chip, (u32)addr, (u32)len, option);
 
-- 
2.7.4

