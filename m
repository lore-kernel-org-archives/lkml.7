Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2649DC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39AA20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpG/4/be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbfJIUln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:41:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40758 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731763AbfJIUln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so3868291ljw.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2DEOdiE8/KIZvnfCC36ibwWDO7fSHTP8+q9sblSZNeo=;
        b=wpG/4/be0Dkrcg2e3d2Y6P+Upb+QU97CDfnDDCAn0RZufZUtdAx4AGsbcIMxg82aDO
         hw0WOfvamsi/rNt1zNO5fb14dk0jx3eyiTZFvuTkb0d9KpIqNcCWRxb46uHn5Qil4BlD
         q6vA7R/HM5QpM2awInIHF3ZgnYuF8dILcbK676IpP36a7RSZLIpipstVdglbWxnYbUD/
         /JNFNNkTlXTtk9xHGsIqLXwztiHgyArDwz2jGOpFIVC8hw+R8sN7gXdyvC8M9qowpQ6A
         9Z2k0uxxen5TorR1/0SCZlZ2ku4Exm6NIObX4s/A/Zaq3jcK8MtfnX3qBOM/6QSXGZ4O
         nmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2DEOdiE8/KIZvnfCC36ibwWDO7fSHTP8+q9sblSZNeo=;
        b=LYhyNU1+YenQQDQC4wh99RWjNOTqtMGGLOFLokK5PxAwJfTncYtnoImVRPCBmcOrUY
         G0BGgVu7gevd8fvx0glq9/R5Sw8ql/pXlktoDrO6DXpupsldwJfj7LITfn52KFKkj4oy
         stdXOI3Lts725MOCaCehgI6OA0EvyZLvjpkn78srQ3UEikFVyvkepIHkuaIhNctR4E1Q
         UcwVcUZil/r1zbApUdq93tVElsPezmiZwrBCTeyBptuFQNJZwFXesiOsEatjWa6IKZpv
         bGKontH/EQ7HQLjmin5fnm8ZF4eoZmxxSTnAejld5ysHt/8vdtzkv7/KtpEuxzoJPlo7
         oSlw==
X-Gm-Message-State: APjAAAVHt+nPqPrRESMgiSuPAv/FNJDZu/zBTS49XSeTnr/z6xiLySzB
        G23gHA9K8lnP4ONhMeu4xmPgUg==
X-Google-Smtp-Source: APXvYqzfdNQcKNb+0Fk97HCYp3ZKM7+7iwvsPqRRRdUaq4tl3T6RNrhhjpFD0xted4NWuEGDG8qFOA==
X-Received: by 2002:a2e:286:: with SMTP id y6mr3679786lje.184.1570653701016;
        Wed, 09 Oct 2019 13:41:41 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:40 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 01/15] samples/bpf: fix HDR_PROBE "echo"
Date:   Wed,  9 Oct 2019 23:41:20 +0300
Message-Id: <20191009204134.26960-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

echo should be replaced with echo -e to handle '\n' correctly, but
instead, replace it with printf as some systems can't handle echo -e.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index a11d7270583d..4f61725b1d86 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -201,7 +201,7 @@ endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
 ifneq ($(src),)
-HDR_PROBE := $(shell echo "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
+HDR_PROBE := $(shell printf "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
 	$(HOSTCC) $(KBUILD_HOSTCFLAGS) -x c - -o /dev/null 2>/dev/null && \
 	echo okay)
 
-- 
2.17.1

