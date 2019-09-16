Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D1FC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC544214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="renlPhv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbfIPKzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:55:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36827 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732499AbfIPKyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so5649636ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 03:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICv/vY4XAwe136r6/MDdnRXmmJJ1JFeohZKBWO948JI=;
        b=renlPhv6Vx5CNHYksA5WzO20FVIYXEGpjJn5/YGtCgnC0BCwjUvLBlAbeS2QWSwpah
         jcbI6KeCWf9WpTaXKqzoATiWjCG2prOysrOtXjGAuLCXoTntdh4Qt/9m80BBL8QN4pzD
         XadY611DPWHua3DwZGOlRJTNUpZN6TrPk0Qwv6sDmublMKNGDX/eMekRKEEMHAPLynHN
         5myrlSfFkSMecyixXnfJtcPFSkWkbeUOkkzmZn0e084lNX5MEANYr1m0mJB052RjofTA
         cKvGdlGjvGxXUcAUQef27FEQY1g72gk+N/QCID6XsEJxukpv5MfPHG1nANwRFzRONI4R
         ysPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICv/vY4XAwe136r6/MDdnRXmmJJ1JFeohZKBWO948JI=;
        b=SEKVvt9PVIjrOJ0euzxr6AA9sW5LBudLqJfCGUXrMjHFxjuc+1d0mNLz7NUsTMKX9z
         rZw29NTVawUhd4LWUhpA5rY/BPesep3PZHPe3QPa7+IGQJsbur9gwzdAPB4j64+/uM+/
         CKVPBep9Ba4SHtLfLpy2NsmI5NC8dqTjrJdbw/uHqYvEvUaI5WgO9219m8DLDw4VaNbw
         xt6dFCq9jI01hZRUFmZJOBm/w2DCWwAyNQ0ZypZKjEkNQn3jB4yaXEySJIh4FjhsY8aj
         gbvWn25aX2IGV+o+yKH9AsDC7UpetDxWo8p9Mb08W1/6MicS7Q2lpXFzoeCO3RnkAiOT
         ajTg==
X-Gm-Message-State: APjAAAVox9371/gw1khg1aZdszBNOz4IAtcrrOHr97yeij/sse/tzq9R
        1P6d62Fcwx3WPWDmMSmLoJODeQ==
X-Google-Smtp-Source: APXvYqxSBkjyrfAdAo3XLVu9mwgNU46b8BtP9TI1G+SDVPq/GRexV8qvD6bjRrTR9lMP98abCOCLiQ==
X-Received: by 2002:a2e:9881:: with SMTP id b1mr19271028ljj.134.1568631288103;
        Mon, 16 Sep 2019 03:54:48 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:47 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 06/14] samples: bpf: makefile: drop unnecessarily inclusion for bpf_load
Date:   Mon, 16 Sep 2019 13:54:25 +0300
Message-Id: <20190916105433.11404-7-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop inclusion for bpf_load -I$(objtree)/usr/include as it is
included for all objects anyway, with above line:
KBUILD_HOSTCFLAGS += -I$(objtree)/usr/include

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index d3c8db3df560..9d923546e087 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -176,7 +176,7 @@ KBUILD_HOSTCFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
 KBUILD_HOSTCFLAGS += -I$(srctree)/tools/lib/ -I$(srctree)/tools/include
 KBUILD_HOSTCFLAGS += -I$(srctree)/tools/perf
 
-HOSTCFLAGS_bpf_load.o += -I$(objtree)/usr/include -Wno-unused-variable
+HOSTCFLAGS_bpf_load.o += -Wno-unused-variable
 
 KBUILD_HOSTLDLIBS		+= $(LIBBPF) -lelf
 HOSTLDLIBS_tracex4		+= -lrt
-- 
2.17.1

