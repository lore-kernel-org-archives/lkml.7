Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F7C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45D220872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABzAt76o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393806AbfIJKik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:38:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45931 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388984AbfIJKik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:38:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so5343711ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NGKQzll/A9IaEu36OmTkFVayy8Bwv+m3n0iuRSm1M6Y=;
        b=ABzAt76oNXU0+8r79M+Uq/vNmBPlKtTMxdiCXMEvHZE5RCKq3QqV2iBKiCEqCQMDfD
         5MRDIcIUmhICZ3oxwsncRXUExmaAd9uO3zO0pf2FzyrZMXEgHWGUsMrthX1YCuT8uNr8
         Fy0s+pdJsRFxY31Gq1uTHRY9vyjkZ4Lx/gplROpBnTB/nyNhoWEI9RhKa13TJTdcaqC9
         qsDUhmIGRXpmc/qhpPCYEP73F4LEXLy/8Q1Cw3S1pNBR2BYa3qjcBMPKNVQUbuY7MZyb
         DEINpV16u8PrEGM44UFFxvEoPR+mFi0diwU1Esg8Xd3hntXMUtO/QSHNxqgy9MXXYTPm
         aZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NGKQzll/A9IaEu36OmTkFVayy8Bwv+m3n0iuRSm1M6Y=;
        b=oJfX/eI7is2UBHuYKgTexX5+BkrydJuaOWeWNoD5JXSLGpuMR8bgIjxXYTSyW8KEC+
         rDwuR+RbLATCNCy6EnSGQbjLT34kS3cqHQG+Y2Ho8oOV1lvZpHwHMBbhGP5hv4077r/i
         TsvFvy1zj3P3wsY4MTQZ5EDM/Lw1oGkqOYsW1MN3OzQ3khE5P7BtoDFHfDBp2+OZptKk
         rijfgAEifWiRj3Gv5vcBoTXx2fzVUDJR7kcgXXDEWWXfiGbB+OpqNRdGYESC0mMYr5AL
         2QttP+TlTvlkjB/XvIQeRqA9cVB+sdUsB/0kwRyFLUIrHjDppkvRA64Nii9DKngjTAq6
         EqQQ==
X-Gm-Message-State: APjAAAWNsVfw1N6kyWksBLdWcREw9id7qTO3rwryPhmcLeFlNGoQs0u2
        a0Pz+Ei54Kf4icRP8BKi0y1zJA==
X-Google-Smtp-Source: APXvYqz0/JLIcR6H+rHFrDDr038ZGekYrfvl6BKTgPvWXfLvjHyS9lrOyEn6zwfVLEO1KhHL+BKEHQ==
X-Received: by 2002:a2e:5456:: with SMTP id y22mr19750906ljd.60.1568111918957;
        Tue, 10 Sep 2019 03:38:38 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id g5sm4005563lfh.2.2019.09.10.03.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:38:38 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 01/11] samples: bpf: makefile: fix HDR_PROBE "echo"
Date:   Tue, 10 Sep 2019 13:38:20 +0300
Message-Id: <20190910103830.20794-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

echo should be replaced on echo -e to handle \n correctly, but instead,
replace it on printf as some systems can't handle echo -e.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 1d9be26b4edd..f50ca852c2a8 100644
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

