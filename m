Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD29C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2376B20883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="LdfwSAPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfE1SrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:47:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39119 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfE1SrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:47:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so11512530pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 11:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cGc7AzHIWb52T88+bfjjefIMYH/WgJgz52/xY4DYYK8=;
        b=LdfwSAPBxBcJwmhMJQOxmloW3OxDFPmTupuWq8PqpCS31kUqpDSncrwkglC/PB2b9s
         EbAz7vik75nSZ6urGTsNx62NUGFwDr7i+S2FGdGvrA8NYTUaB7zqhNo6Va/lnfHChQxg
         JjzwqodY54W/b1C3rtSByXmDgvAHSgO6ndjQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cGc7AzHIWb52T88+bfjjefIMYH/WgJgz52/xY4DYYK8=;
        b=LPglsJkLrfgClnZ0ryIRVsetmDM56R7/XQwXcIBoNa7rEW5FgDND31u9TRvXcG2FXr
         tqmFzsuA8C2yHxnLGOTR7iedvgm7Hc4wywZaluaovmGHtA47oiW99LYNm3MqdjANMQFN
         8pHSsUn4BEjAJDMSUI59w7s8JY5S/Qbou6llKvCkii+uHU2pQrZCVp5AlyMsj/Oms9kd
         1hwtttpSszSb+qtXXU4GFlw53hAXPrh4FoTISRnzFOI6rosaGkcMquTNvLwfhW4G5oYH
         RAVPFHqeuoXFUjwn69+OQHdU4PbpFwv79bpfUC6Op8HVoTwddlJoeQ0QbMHoWxL9d+fc
         nI2Q==
X-Gm-Message-State: APjAAAV2Eb3h45QesuXFcLPLzjNk923LSa90M18x/Hkw340ZSsU6+4+q
        6yGql+9n8Af/f25W9ByYCYoJdg==
X-Google-Smtp-Source: APXvYqw6foEZcSu0UWBUGZHiUK+cl9+zdMn+NzRD3LctKUAqRLhJHaYeZX5TS6hknJ9xNgIx8lCO/Q==
X-Received: by 2002:a17:90a:2a85:: with SMTP id j5mr7726560pjd.107.1559069237397;
        Tue, 28 May 2019 11:47:17 -0700 (PDT)
Received: from linux-net-fred.jaalam.net ([2001:4958:15a0:24:5054:ff:fecb:7a95])
        by smtp.googlemail.com with ESMTPSA id m6sm3323766pjl.18.2019.05.28.11.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:47:16 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net-next v2 0/3] UDP GSO audit tests
Date:   Tue, 28 May 2019 11:47:05 -0700
Message-Id: <20190528184708.16516-1-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to UDP GSO selftests ot optionally stress test CMSG
subsytem, and report the reliability and performance of both
TX Timestamping and ZEROCOPY messages.

Fred Klassen (3):
  net/udpgso_bench_tx: options to exercise TX CMSG
  net/udpgso_bench.sh add UDP GSO audit tests
  net/udpgso_bench.sh test fails on error

 tools/testing/selftests/net/udpgso_bench.sh   |  51 +++-
 tools/testing/selftests/net/udpgso_bench_tx.c | 324 ++++++++++++++++++++++++--
 2 files changed, 357 insertions(+), 18 deletions(-)

-- 
2.11.0

