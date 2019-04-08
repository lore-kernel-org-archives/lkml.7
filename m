Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A9BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7892320645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UfJFMHAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDHAmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 20:42:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45918 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDHAmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 20:42:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so6537844pfi.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 17:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qpPSSSnulACA409FLJSC/TQjhEqe+lmjYi0W+0SfqDY=;
        b=UfJFMHAKIH5bVC2+mSCcENFyVfVZE5Eo5zduJN2s9/hzwIwMib1DV1bzTrLa2VRSoc
         A8lukPwdcN3yuK3Xp0Z2S3R+i2HY9sz3FjFdAI48lEAP82CoC62BCNeY+HaPH2ujZsrr
         RzVRnmxpvkk4Lfb12Sdv5gGi8jWsgQcgfGBXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qpPSSSnulACA409FLJSC/TQjhEqe+lmjYi0W+0SfqDY=;
        b=oB1diraltnjNiQJd6Ff+zO4MCFmHkYG1bvASaeNYrdNHgIuEPbnKADQrzabEWOhJzk
         kLLgBurcq+UxO6syrw4cGgE94WtFfZmyNIF78MKFsY4A5ASTKvWj4ctQog81J+iT8/iG
         cfjCY//enURXcCr76tzGOBWnlhBGUUik8KNxgRrR7EwWGZKgTc2P63itkqd7VroLaBDP
         gmrxADziuBZKe+NbB8zanrANzMjNx8lIosmi2xnbNggwaNgn7Q8w4tLliGUhQ4ZKw5GU
         HRyAFt25vsnio8rVvwEFe7iUbfnS0MFOmf8ccL/QuJcMgtHfDR0lWymexwxtpf6AXdiR
         GzDg==
X-Gm-Message-State: APjAAAXNxsNug8LWPX8pmyMhjUM38nPFsaVpXhn7PLjjtozjeB5vi+/e
        mj47qihDmcRR3oLupeSE03GvaqrN5t0=
X-Google-Smtp-Source: APXvYqyaVwQ7ffjQANEqNkNQ+2ruJj4j1O9fakF+1E9/b/v3srKwnIgdl9dlxelS6RDoilZnIcOUbQ==
X-Received: by 2002:a62:1647:: with SMTP id 68mr26543714pfw.113.1554684154938;
        Sun, 07 Apr 2019 17:42:34 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y10sm43463710pfm.27.2019.04.07.17.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 17:42:34 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kernel-team@android.com, paulmck@linux.vnet.ibm.com,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: [PATCH] srcu: Remove unused vmlinux srcu linker entries
Date:   Sun,  7 Apr 2019 20:42:17 -0400
Message-Id: <20190408004217.176946-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRCU for modules optimization introduced vmlinux linker entries
which is unused since it applies only to the built-in vmlinux. So remove
it to prevent any space usage due to the 8 byte alignment it added.

Tested with SRCU torture_type and rcutorture. Put prints in module
loader to confirm it is able to find and initialize the srcu structures.

Cc: kernel-team@android.com
Cc: paulmck@linux.vnet.ibm.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 include/asm-generic/vmlinux.lds.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c2d919a1566e..f8f6f04c4453 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -338,10 +338,6 @@
 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
 		__stop___tracepoints_ptrs = .;				\
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
-		. = ALIGN(8);						\
-		__start___srcu_struct = .;				\
-		*(___srcu_struct_ptrs)					\
-		__end___srcu_struct = .;				\
 	}								\
 									\
 	.rodata1          : AT(ADDR(.rodata1) - LOAD_OFFSET) {		\
-- 
2.21.0.392.gf8f6787159e-goog

