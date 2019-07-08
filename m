Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F47C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5E521537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="ZyD5dW8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391530AbfGHQci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:32:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43311 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389323AbfGHQb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:31:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so17828982wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzYpaDtUNAMchDHQ5mVavWSVxemrZT4NQs1IRkRW66Q=;
        b=ZyD5dW8nuNYNP+nX4Td3kyXt1a5K3nWXeOqKr8xVZP9rEglO8POBabo0xUar/gJ9Ty
         gfFpaGdGJEGTen/crmSnq/idDmP+4qdZ+MAnsH2SrX1GQPIozuLlLUyiZ7lSuxmjqo30
         oRB6kpJ1lWc7VsBn8xN7GZDGTm7uJLG7pWxoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzYpaDtUNAMchDHQ5mVavWSVxemrZT4NQs1IRkRW66Q=;
        b=e1DkTTbVPT8tiwOjJ027PcwgKUWsTKd03r0t1uSLaVQeIPozYDw403zVsNv93me5SJ
         cz+IBkVfACTh4qFIBVPUYDeZG6MWaieLhsmwEQF7pWWqT+7AgyGZAWCO12RXehRnMMv/
         b0OzKGaR2i0VzkAQJJA9+pGbOwAdmxhtZHJickqux8Naaf/zSinD+nqcg1YBqg8pm+Pl
         BC3s+LR5RdiwVe8qqsCN30MF5cp+KQbUoYfAUVCJcf/eZB5qUya8j3AILzlTjfPazdaI
         iOuX2gEy2L1vNklWghFy45Np4GBQzlgYmebsHhLm9xF/n8NJxRjJQx5DjqQg47DKlK9P
         IVEg==
X-Gm-Message-State: APjAAAXd8idMQ9lR4ZUTVpd4BSqR4soca6rpod4Btwmy+tRrZruQ85VK
        LeuSjM2QYlcReivU0kMuxyP6WX0UvES4kg==
X-Google-Smtp-Source: APXvYqzDVSViY5HVVYRgFb8v3N1wc1MFi5lzXRopegl9JYz0+mT8xKR31nPz40eySxSRzlooFazs6A==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr19075288wrn.197.1562603513828;
        Mon, 08 Jul 2019 09:31:53 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedbe.dynamic.kabel-deutschland.de. [95.90.237.190])
        by smtp.gmail.com with ESMTPSA id e6sm18255086wrw.23.2019.07.08.09.31.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:31:53 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Subject: [bpf-next v3 06/12] selftests/bpf: Make sure that preexisting tests for perf event work
Date:   Mon,  8 Jul 2019 18:31:15 +0200
Message-Id: <20190708163121.18477-7-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190708163121.18477-1-krzesimir@kinvolk.io>
References: <20190708163121.18477-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to introduce a test run implementation for perf event in
a later commit and it will not allow passing any data out or ctx out
to it, and requires their sizes to be specified to zero. To avoid test
failures when the feature is introduced, override the data out size to
zero. That will also cause NULL buffer to be sent to the kernel.

Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 .../testing/selftests/bpf/verifier/perf_event_sample_period.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/perf_event_sample_period.c b/tools/testing/selftests/bpf/verifier/perf_event_sample_period.c
index 471c1a5950d8..19f5d824b275 100644
--- a/tools/testing/selftests/bpf/verifier/perf_event_sample_period.c
+++ b/tools/testing/selftests/bpf/verifier/perf_event_sample_period.c
@@ -13,6 +13,7 @@
 	},
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_PERF_EVENT,
+	.override_data_out_len = true,
 },
 {
 	"check bpf_perf_event_data->sample_period half load permitted",
@@ -29,6 +30,7 @@
 	},
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_PERF_EVENT,
+	.override_data_out_len = true,
 },
 {
 	"check bpf_perf_event_data->sample_period word load permitted",
@@ -45,6 +47,7 @@
 	},
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_PERF_EVENT,
+	.override_data_out_len = true,
 },
 {
 	"check bpf_perf_event_data->sample_period dword load permitted",
@@ -56,4 +59,5 @@
 	},
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_PERF_EVENT,
+	.override_data_out_len = true,
 },
-- 
2.20.1

