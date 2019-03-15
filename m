Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B3DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5652B21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="nH67x9+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfCOGOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:14:42 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:43710 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfCOGOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:14:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 09736D43
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:14:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ezrpIWrf70l5 for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 01:14:40 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id CB33FD16
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:14:40 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id h3so6885690itb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=q5oZbQ9UUS68hhqIoA0MfNM64hHRaI5be2MMs2/s5OY=;
        b=nH67x9+4nvrretgaGo4VFm0BlsysVLmfRQabWXvV5Trbc5LqMyL4rq3pzUPN1NmdwB
         zgjNG8mClN9fmjGA7+w8FSeCKdf3aV9O7gJz2WxE0w9+aT6BrYZDPR3ZjxxgZLW7vbZG
         GZRMmuLv1woOUSlOwxlwivWGrjehbbaaiIZtmiiQU3RC/Q1VBXU+nBa8Q+2eIZfReu7Y
         +Wa+cU22SYl++daoGgh0kHyalN1OB3L1hIWpeF3BdLfRGunoQAp7HuTkJHnvgHe0e7u6
         usdP5avdPNnXWhJhxiFIPyKhnvQuUA2GIpUF2n2fG8fxCiJLxKihnWDkYgorXUX9iW/h
         NERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q5oZbQ9UUS68hhqIoA0MfNM64hHRaI5be2MMs2/s5OY=;
        b=WLF/yE2XpjWPgXbEGraJtKgW09aE+DoXMgAOLMg+FgI+2gcED/lJknTK6tUbHqmYu2
         flT5hnM4khnYbtUwtO4VmG9auFTmZ0auHpHcK5Yf9dB6hbaydIiMA+AyOfEyui79lV1I
         939LyOzJKy7IvFeQh8hiepaAdBmjn2g0u/+86E7SRsMCXJSQzR9q5in39S1l/r4BXXbS
         FxPu4iJlk848GmnrjymOYnx42YsvQRq08hgOYZxudpgKdGVwlhsA4xm3NW7DcWop9t0x
         +T6G84ka6HBbsfizlQY+mV00FAnjLVhS/w2hlrwy0ICPUXI3uEQZzsaEvmYv8Rca4ewQ
         1uBQ==
X-Gm-Message-State: APjAAAUlxngbB4GZwQTV5GttC1Imu4W1oHiTLH0ILIuRbqEO4IHX9PLz
        +lWvqb6pCcAEsKdKpXiKKgKDy/FHJPttuywpelS0C/mfCaOKMLTAxNVzbcS2y0W0yXnUsrwcUVN
        L5G4qT+t8ra8JUIJ8ChbShuTmAPHF
X-Received: by 2002:a24:2c48:: with SMTP id i69mr953716iti.27.1552630480430;
        Thu, 14 Mar 2019 23:14:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzebVn8iHT03QjUrGRkf8ljxhDH+LmPfM2EXn7PPzAAUmq+/xFmhKsjjxNcusZaA1GLCrxckw==
X-Received: by 2002:a24:2c48:: with SMTP id i69mr953700iti.27.1552630480054;
        Thu, 14 Mar 2019 23:14:40 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id k2sm514475ion.11.2019.03.14.23.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 23:14:39 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ncsi: fix a missing check for nla_nest_start
Date:   Fri, 15 Mar 2019 01:14:33 -0500
Message-Id: <20190315061433.15662-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nla_nest_start may fail and thus deserves a check.

The fix returns -EMSGSIZE in case it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/ncsi/ncsi-netlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 5d782445d2fc..bad17bba8ba7 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -251,6 +251,10 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 	}
 
 	attr = nla_nest_start(skb, NCSI_ATTR_PACKAGE_LIST);
+	if (!attr) {
+		rc = -EMSGSIZE;
+		goto err;
+	}
 	rc = ncsi_write_package_info(skb, ndp, package->id);
 	if (rc) {
 		nla_nest_cancel(skb, attr);
-- 
2.17.1

