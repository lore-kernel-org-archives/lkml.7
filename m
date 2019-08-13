Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5EFC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A168B20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtaX+hFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfHMKXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:23:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36149 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbfHMKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:23:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id j17so22364690lfp.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JiG7tm9Z5rwpqHuMdG7CvzyzUiI5hxVxzGrPHfDQgmw=;
        b=rtaX+hFh3NZYIl2FqWzNHd/6C6CtWqKILZgq5tlbkHvWcLrCQlhW6hkU+WfWB4V2ml
         Np628Vxo2IUFwpj+pu+hv/p5257DdL3l9f/q3BwfHqpjbE1TJbqKxfi8DuNxPk0hENTF
         z9FzqyUzjPhJre+2QO9ejYV44pfD+PRBE//to4jllPatN/0t0sXNIswP+1zVTDxBiriU
         /o2xZA52ry2VahmVBC8ehDRdhcVMTHhavH7fH0svDj+INDWi0eFh+jn4cdajbf/4e79b
         wrrrP6uURrQhtgd2zWTC+jbLlSymBcFBwx34yNLT3Yj7SoMpzQ8ONV7AYaY0VBOlodWP
         93YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JiG7tm9Z5rwpqHuMdG7CvzyzUiI5hxVxzGrPHfDQgmw=;
        b=TQZXmMjBykB49EV+A/prwLfJxiEz18sgKQ0ZWk+LZztDy6O4XH3EqysJjiDv55rwRQ
         r9lj8tKQ73TtpLnrqn2tj0H9wA1L3yckcQn9sSQOpxx71pOTNclLF5Ll/PvEKTM7GZW8
         2Ircw5RehQDGrJECrBoEeeMoMm07a4vbfn5KdeYlB0OODH5YG/texH/7tMsdl1vKdIW5
         0Q9tE8wmBUyjFqqGhRJzosRNPsSQ2AiPY2goGrqyh5jBav265KamApEHPHSD5XhR6aiJ
         Pu8KwKEFOUoOlGnEYJxt8UXKM6GT3rJyZdeWI2pK55oujX397NKZiIK4gayELAPk0drh
         rCQw==
X-Gm-Message-State: APjAAAWSqhAUA1zDExEyF6EI1NrPWp319xyJsXCjEQqTolo8/IlA3wXr
        VCwUhikyjc5tA8i59klJ+ddTLg==
X-Google-Smtp-Source: APXvYqznpU2Z0cHt+Qv8XFCTp5H+9clx1iMM8ge9jpygefUtgclMUWWDW6oM4wTN2Sa2t7bvtZCW3A==
X-Received: by 2002:ac2:5442:: with SMTP id d2mr23328237lfn.70.1565691828425;
        Tue, 13 Aug 2019 03:23:48 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id e87sm24796942ljf.54.2019.08.13.03.23.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 03:23:47 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Cc:     davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        jakub.kicinski@netronome.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 2/3] xdp: xdp_umem: replace kmap on vmap for umem map
Date:   Tue, 13 Aug 2019 13:23:17 +0300
Message-Id: <20190813102318.5521-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
References: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 64-bit there is no reason to use vmap/vunmap, so use page_address
as it was initially. For 32 bits, in some apps, like in samples
xdpsock_user.c when number of pgs in use is quite big, the kmap
memory can be not enough, despite on this, kmap looks like is
deprecated in such cases as it can block and should be used rather
for dynamic mm.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 net/xdp/xdp_umem.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index a0607969f8c0..907c9019fe21 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -14,7 +14,7 @@
 #include <linux/netdevice.h>
 #include <linux/rtnetlink.h>
 #include <linux/idr.h>
-#include <linux/highmem.h>
+#include <linux/vmalloc.h>
 
 #include "xdp_umem.h"
 #include "xsk_queue.h"
@@ -167,10 +167,12 @@ void xdp_umem_clear_dev(struct xdp_umem *umem)
 
 static void xdp_umem_unmap_pages(struct xdp_umem *umem)
 {
+#if BITS_PER_LONG == 32
 	unsigned int i;
 
 	for (i = 0; i < umem->npgs; i++)
-		kunmap(umem->pgs[i]);
+		vunmap(umem->pages[i].addr);
+#endif
 }
 
 static void xdp_umem_unpin_pages(struct xdp_umem *umem)
@@ -378,8 +380,14 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 		goto out_account;
 	}
 
-	for (i = 0; i < umem->npgs; i++)
-		umem->pages[i].addr = kmap(umem->pgs[i]);
+	for (i = 0; i < umem->npgs; i++) {
+#if BITS_PER_LONG == 32
+		umem->pages[i].addr = vmap(&umem->pgs[i], 1, VM_MAP,
+					   PAGE_KERNEL);
+#else
+		umem->pages[i].addr = page_address(umem->pgs[i]);
+#endif
+	}
 
 	return 0;
 
-- 
2.17.1

