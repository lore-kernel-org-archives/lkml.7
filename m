Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6888FC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D202175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="UaMnrdv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbfEWVI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:08:57 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:45953 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbfEWVI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:08:56 -0400
Received: by mail-pg1-f169.google.com with SMTP id i21so3752993pgi.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wMax+lenzyUHPsKlaw2Xwz1J2fIjhyjCZs+l8WeZZIk=;
        b=UaMnrdv9kxUyUAoeV3obdkbGuhYqC5UwxazWF+3nuF1UF3pQcc1gr+roilgZcHYFp2
         bvy5U/V0Qg5qe2Vf8zvxxGxiM2RPdhg7SaQAWwaDSYiYW006jUvPXKh2pzgTXNEQqpEg
         lw0XlMmuZgMdv568WatuxBTKK0UtQYWf7pLN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wMax+lenzyUHPsKlaw2Xwz1J2fIjhyjCZs+l8WeZZIk=;
        b=V9umYtRiuYeyAcJpcWF5vUPGDJ0KUbWDv+1LSloPZ0w5y6wlzKOfmcDU8nfHILRhfT
         tGPpR+LxY8OYmK6xbVonD+DJkaLGLTeUen5/u93hz8UG5yfrsoAof5wfOVlzrDrVsABC
         JqPQWgsNNiV5V0ovaZQF/TLLty3W1t7+ye72ZY/AkGPbYPjyeQKZFcgzUs8x3u+4NC2w
         5Qv3CjAmdgo6Fitz93XbfOxJ4dOx8Xsq3ykn7WAf7GY+CkB9lkFWBJ0H5hKn2NOcP6iB
         l5hXvrvvnRGXxnOSMwhx9Dwn/0i+GyBFOyLsHYYul4lmcMrNIxA0lfsnFiWfHFpYAmEY
         cbDw==
X-Gm-Message-State: APjAAAW2nNZ+1NAnTOOjz391XWRtsEjAfpsukckyIGkhOncwNp+/I5w2
        sA44eePI6zbsCV7P9bvjNA2Wzg==
X-Google-Smtp-Source: APXvYqyjISI5Ny9VN8A309FwPymfZ7VE0AtfDET3WweMMKUW9iebMfPJRFf0OgH8RwPdpvmO2ZLLZw==
X-Received: by 2002:a17:90a:350d:: with SMTP id q13mr4321522pjb.20.1558645735962;
        Thu, 23 May 2019 14:08:55 -0700 (PDT)
Received: from localhost.localdomain (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.googlemail.com with ESMTPSA id y17sm333481pfn.79.2019.05.23.14.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 14:08:55 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net 0/4] Allow TX timestamp with UDP GSO
Date:   Thu, 23 May 2019 14:06:47 -0700
Message-Id: <20190523210651.80902-1-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an issue where TX Timestamps are not arriving on the error queue
when UDP_SEGMENT CMSG type is combined with CMSG type SO_TIMESTAMPING.

Also this updates the UDP GSO selftests to optionally stress test
this condition, and report the reliability and performance of both
TX Timestamping and ZEROCOPY messages.

Fred Klassen (4):
  net/udp_gso: Allow TX timestamp with UDP GSO
  net/udpgso_bench_tx: options to exercise TX CMSG
  net/udpgso_bench_tx: fix sendmmsg on unconnected socket
  net/udpgso_bench_tx: audit error queue

 net/ipv4/udp_offload.c                        |   4 +
 tools/testing/selftests/net/udpgso_bench_tx.c | 376 ++++++++++++++++++++++++--
 2 files changed, 358 insertions(+), 22 deletions(-)

-- 
2.11.0

