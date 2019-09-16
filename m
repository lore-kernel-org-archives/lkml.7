Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F33C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD1021920
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zqzL4Jzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbfIPKyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:54:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41129 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732442AbfIPKyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so1272114ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 03:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=myQi7tUoXKWvWu2Otr2cMzZrUikwx9p5w927Z5U7K18=;
        b=zqzL4JzwdgYet7wSFB53zjRItWpS1hdeN0ygAfE9AmPl/tgeJ6oyvRLjQXycdwZXvW
         0LkJJSRAf4imSOLOE29XGY2MZ3eqllofQcObiDHWP0n70jafz5Etprt2/18so9bAoNTR
         PAxrU/Zo2hoAsOPF39JndhObn/PUwZAIGsIAbIudvGDm7SINJLoGj6UWh+CSx6AR54CG
         cqRWHQ/B4qTgGzo7uNYmgSSKMEPe9rgAJFIAtbz5BnbBBB1x1PXd9E9GZFdPz3dzbqwH
         8ftOXF8bhIMPmwb3IKjgxhtoyYYyFPxole8xysIfutsFzMyg7yF01NS6KpCla5EtW1LM
         4LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=myQi7tUoXKWvWu2Otr2cMzZrUikwx9p5w927Z5U7K18=;
        b=FrzUFfLbx6ipIbR4EACKnQQ4UQ0BnqT5QYZdYKgSQdgow9JJEXjkpbGMx3YBby+7ta
         NTwvMtoZCTQlC3V/Y/ijXqbLXMI1uQe3CE7cSyz+W6lE5ZaIVdrQ/GRtAmFrF3dCZxcm
         g86fNk6a0xMFaERqabQ0aekVIufhqLxoZL45Zsm7gPloJVD8Bs6jQcmW/+f+0sV7MfbZ
         WlW5Ia6M/7k2XO68urSOMk9Hob29q9Yz8z2q08U/ScY4RTBoKminhE542h6foyxIH84V
         8gIChJwJvZmD/Mji0vh4SY0Ign1hISevuAN6JeGDAs/dv61gghPDrFHJNdEF/qqX+Nz1
         BHow==
X-Gm-Message-State: APjAAAV7/IKhqPUITUKHhU+x/yUj2D0wCHbs8r7xVJVrKvBM/YacM5Hq
        1/+xPnx4dEGEfUYYwyp/bfhZoA==
X-Google-Smtp-Source: APXvYqzNr13KKv1AIr7OpHjlQSQcSa/f7Y9MYJkeX7w54sCZf3/vtF9w89HiJUF4vYPD+fo2fgIN4g==
X-Received: by 2002:a2e:b0c2:: with SMTP id g2mr1900577ljl.217.1568631282996;
        Mon, 16 Sep 2019 03:54:42 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:42 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 02/14] samples: bpf: makefile: fix cookie_uid_helper_example obj build
Date:   Mon, 16 Sep 2019 13:54:21 +0300
Message-Id: <20190916105433.11404-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't list userspace "cookie_uid_helper_example" object in list for
bpf objects.

'always' target is used for listing bpf programs, but
'cookie_uid_helper_example.o' is a user space ELF file, and covered
by rule `per_socket_stats_example`, so shouldn't be in 'always'.
Let us remove `always += cookie_uid_helper_example.o`, which avoids
breaking cross compilation due to mismatched includes.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index f50ca852c2a8..43dee90dffa4 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -145,7 +145,6 @@ always += sampleip_kern.o
 always += lwt_len_hist_kern.o
 always += xdp_tx_iptunnel_kern.o
 always += test_map_in_map_kern.o
-always += cookie_uid_helper_example.o
 always += tcp_synrto_kern.o
 always += tcp_rwnd_kern.o
 always += tcp_bufs_kern.o
-- 
2.17.1

