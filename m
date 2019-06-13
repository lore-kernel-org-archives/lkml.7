Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2198C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A46221721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DELSMDQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392597AbfFMQkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:40:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44399 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbfFMHHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:07:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so29610959edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 00:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3XH+XvSSdt+0M6n67F8uO788uZlWAtnvxIXQiaw/IR4=;
        b=DELSMDQe7XJ0TMJ6DnlL7AW8Brl4v7z7Y0Q+xvU5Ivd8ijh98pvN6mWR5TIpo6T9pR
         6EZvcsHpt/j2NMRM9Xz/kYDzUGw7NFXyku81YdVCy9C++GvT/b/t3V1/rCd7ptrRwQKe
         mnCKEE0lBPYwioRciPNmpOZxSzSw246ydf5zK2QwxTMu+2FR22ogFse3RJ1AZsPOSSxP
         iZHxqjIJN0H85XJSr0mSmy6BH1iwAXJoOKAeosA4y2WqMVQi4hh/ZEZloBmbkm4iqdxl
         wCUsNRb4pn5U0T71n/Lgst/h+wZ3P7NaAb6AAF5gRksrQvZuJa6GZVbvXflbaZAwpPNI
         vFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3XH+XvSSdt+0M6n67F8uO788uZlWAtnvxIXQiaw/IR4=;
        b=Pg+wDNvAlR5avWiJkFnIzHZ02iEcL0A3lhj9NZXHFtx9uuoXmR0CMydtVKy87WSVN0
         5KGSWEDQP4FTur7LSTXsQ5Kmz6uK8UP2aR/pgbZNtR20JlPLSZLpRsoR+yH9Q9K8NtY+
         8J4y+rDEC4T7s3ku5V4nPdStFWruw5EQgVg5VJLCT9H+3OXjgI+a+4Stxgytz3+KWooS
         7oZ1cgcJdnYlKvvWXxUC2ZCAIRanqTpdw3pOPI6Hiv2u1aHGSybiL3qYTdO2XTIreZDn
         ew7y7LSV6UKkoI4gHTc8u85+WVsxH+sVGhq+bwVEScQD4k2/tBz6iRNEVCWyVF/2Ob3L
         nhIQ==
X-Gm-Message-State: APjAAAU6kW0aYI4+WCJ2yDzB/rLz2eF4r2p+R9Lt1eRCQjgxyb6TwtjR
        2Y46A5W/uepkitXfGUylXT41IanNjDw=
X-Google-Smtp-Source: APXvYqzr2SStLNdfff6Ri34lOVzhgnk6X0VViA/E/OlTxqB7DK5t8gFHo7O2fVrIoWf1NQJawd8iTg==
X-Received: by 2002:a50:a205:: with SMTP id 5mr8215024edl.211.1560409643481;
        Thu, 13 Jun 2019 00:07:23 -0700 (PDT)
Received: from viisi.d.ethz.ch (mpp-cp1-natpool-1-013.ethz.ch. [82.130.71.13])
        by smtp.gmail.com with ESMTPSA id b53sm641976edd.45.2019.06.13.00.07.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 00:07:22 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org
Subject: [PATCH] MAINTAINERS: change the arch/riscv git tree to the new shared tree
Date:   Thu, 13 Jun 2019 00:07:21 -0700
Message-Id: <20190613070721.8341-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer, with Konstantin's gracious help, set up a shared kernel.org
git tree for arch/riscv patches going forward.  Change the MAINTAINERS
file accordingly.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..290359a46bbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13476,7 +13476,7 @@ RISC-V ARCHITECTURE
 M:	Palmer Dabbelt <palmer@sifive.com>
 M:	Albert Ou <aou@eecs.berkeley.edu>
 L:	linux-riscv@lists.infradead.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 S:	Supported
 F:	arch/riscv/
 K:	riscv
-- 
2.20.1

