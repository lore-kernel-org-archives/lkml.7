Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9E5C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FA220717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDOtLbxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfE1TC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:02:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44550 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfE1TCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:02:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id g9so12036332pfo.11;
        Tue, 28 May 2019 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=ZBw/tQUR3N++vfWCWRHOlyMoJfJVoXaITb7wqbYIEwU=;
        b=SDOtLbxOfqFOsS3tfWf/NPMQ9agnoEnzEmJwhDansmY94g8VfpV+K/aK98EF0FGzOB
         QRm5N4O9EYRfrQ054SLOZWXH0nFk2FN0ccKjRlfXwzyikmBGApI+BPcXEm9a4pfzWAm8
         bY10bMLwoMQbG/scodaCfipQxzoWAWNMNmN7v0dqRtPzqvQ0kvA/e6MUKGF0iYgNmwHi
         FTLhnW6VZyFouBCBr1oEt5eEX2ToFmH1hyDIT1VB7gXYC1ubI2tDzFtw4wl9sWqGDSF+
         OWrkyyhkW5xkv8ei+mwLRNn8oooU985YF5oDGV/bSatVdgNq/47+R3q61lq4rlEHtCH9
         A9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=ZBw/tQUR3N++vfWCWRHOlyMoJfJVoXaITb7wqbYIEwU=;
        b=FtEdkp+u73PEfx9QeYUSn85egtAvBM6iAgUZF9kahvjYJlqMdwgdAKD3XHEYgyVxTP
         L22SJN3WzLIEfLvnU6QtC4FWRGI2OWSbdI+0jS9JLXjB84dchykvagUO/0WRkBhlE+Z4
         iR+I8c2x+JrMWms7VafAYfrj5m0I1e+ZTzIh0G7ENZGZW3Xosi8TenqNbfMByW6tEmN0
         Ns3Ix7KXVTW/Zvm2oTs/VUxxM3eRQOE3FcgFEHPiPKvCp8cTaFnFFYg5MV07w8NWI5ys
         64ZPdq+q0Hq8tAq8z6vCzzTHG9o9uva+3fIdrF6eBg+QI6WobiVHPx9AcbmJFy84U86X
         IWfw==
X-Gm-Message-State: APjAAAUK4zWHHG7hdulPet872YoCG9u/55Lphl6a9xWYKWZnObjzRG5H
        aJ5DXfN44YdDU5m5Ufs30ksoxqgTToc=
X-Google-Smtp-Source: APXvYqxAa+2eW4sDFyzdz7rQk/+G3nl/DKbvFLVCpB/Y6eqzAcCw/hbo/pUs+DOywsXNrTY3o5r0NQ==
X-Received: by 2002:a63:6bc3:: with SMTP id g186mr122564882pgc.21.1559070141977;
        Tue, 28 May 2019 12:02:21 -0700 (PDT)
Received: from ip-172-31-44-144.us-west-2.compute.internal (ec2-54-186-128-88.us-west-2.compute.amazonaws.com. [54.186.128.88])
        by smtp.gmail.com with ESMTPSA id 124sm16374430pfe.124.2019.05.28.12.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 12:02:20 -0700 (PDT)
Date:   Tue, 28 May 2019 19:02:18 +0000
From:   Alakesh Haloi <alakesh.haloi@gmail.com>
To:     linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf v2] selftests: bpf: fix compiler warning
Message-ID: <20190528190218.GA6950@ip-172-31-44-144.us-west-2.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing header file following compiler warning

prog_tests/flow_dissector.c: In function ‘tx_tap’:
prog_tests/flow_dissector.c:175:9: warning: implicit declaration of function ‘writev’; did you mean ‘write’? [-Wimplicit-function-declaration]
  return writev(fd, iov, ARRAY_SIZE(iov));
         ^~~~~~
         write

Fixes: 0905beec9f52 ("selftests/bpf: run flow dissector tests in skb-less mode")
Signed-off-by: Alakesh Haloi <alakesh.haloi@gmail.com>
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
2.17.1

