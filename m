Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A0FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B91C206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TbGt75o/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfFMP1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:27:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37798 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbfFMLc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:32:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so20368646wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AF1205N89OZNViaP6acWXh6mHKPDql5m0Yi3tu1T8h8=;
        b=TbGt75o/WSp1OSUJTHNYCciigYJKAYY6solbnb+OPu7egwRHpZFyTp57t0BC1acpgS
         TAPKFVoWfjLIyWlG5lM6ccnEx04BY1qZTdskF0iD/gBFok1EC4Jb4k98qIWfHxkzKXFg
         UCMZerFSt04ZfSvT63r76NMFvJdbfCUTVST3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AF1205N89OZNViaP6acWXh6mHKPDql5m0Yi3tu1T8h8=;
        b=ZQI7oA+bIQ9cJMuJqgRYU5xqlmoAOhwhCTiQt0NJey/ktFB99uj5kA+NfhT9Q777v/
         21g5ql12z1vYxkCiSTbc40rpS5e2zNPX6vjJpgcyDk0trXraTY2jyw2B72QY/fYMbL4h
         7TqJV+opDBoaGb9E4t02Gh0plbrnRejpmJKtmTvUHtKTqpuWG+EcGMdg0FQblMJCgVeS
         gNRlPPg+Gtu2PvqdXHP0A0+lv6oP5wS0FEBYo4VtQbrAo3x1GS84rGU2mQ/e7mgTpn2D
         9QtiAbg2rVmuh+GDVymw570dVXNfZKAMcsN7O1ObJvGt2tBsz9maQLGCBAP+PhdVAOBA
         n6zg==
X-Gm-Message-State: APjAAAUDWFQ7f/BpdWqU2KKGRhQ1OORt+k/5timQHVBfuwnYT6EkU6np
        kmt/yt2O4x0KPGCW0Mo/hjGGtw==
X-Google-Smtp-Source: APXvYqyrdLnXSnjStU6hbkGo3KfeeAceiBKHAZw2YLa7AT/MAbzkQIg0WRzmMIvQXvl4kd3Mo2rHUA==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr5748511wrx.196.1560425577814;
        Thu, 13 Jun 2019 04:32:57 -0700 (PDT)
Received: from localhost.localdomain ([147.12.216.9])
        by smtp.gmail.com with ESMTPSA id f2sm2646740wmc.34.2019.06.13.04.32.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 04:32:57 -0700 (PDT)
From:   Arthur Fabre <afabre@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arthur Fabre <afabre@cloudflare.com>
Subject: [PATCH] bpf: selftests: Fix warning in flow_dissector
Date:   Thu, 13 Jun 2019 12:27:09 +0100
Message-Id: <20190613112709.7215-1-afabre@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the userspace part of the flow_dissector resulted in:

prog_tests/flow_dissector.c: In function ‘tx_tap’:
prog_tests/flow_dissector.c:176:9: warning: implicit declaration
of function ‘writev’; did you mean ‘write’? [-Wimplicit-function-declaration]
  return writev(fd, iov, ARRAY_SIZE(iov));
         ^~~~~~
         write

Include <sys/uio.h> to fix this.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index fbd1d88a6095..c938283ac232 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -3,6 +3,7 @@
 #include <error.h>
 #include <linux/if.h>
 #include <linux/if_tun.h>
+#include <sys/uio.h>
 
 #define CHECK_FLOW_KEYS(desc, got, expected)				\
 	CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) != 0,		\
-- 
2.20.1

