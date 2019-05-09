Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED03C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22D621479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K3U7+e+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfEIVzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:55:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42430 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfEIVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:55:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id 13so2002895pfw.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZUfa8VfplcVybbgYX3pUwGODgqQ87P5srjgcZzGd6CU=;
        b=K3U7+e+IKVuUTjJHq/Hov2QZBkFVimUxfcd14NjisQEhDHLqgayikNFnkVnjQFmnXl
         /akCC0oFq2uVmtztdlUipA36q4u9QJfYf75qsjWND/6HiRZcVErmUPX+QsOykovmBvTh
         Lu2s8dtMLypq/bbf3+foNDTOvVxlYMWmy2P98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZUfa8VfplcVybbgYX3pUwGODgqQ87P5srjgcZzGd6CU=;
        b=UUnqIjV36cr+K3p+fExBye+fw/39yeRHwmx31kO4XD8hCixoBHExl2pDW19Hg2zi37
         y1MU/P32v9ABvS6m1Gnv3S+7add16LoAq20FEf2X+048Qu42rytWrb35NVazwLJ2hFcf
         mQOo1pvrBpbKe0iXbRvguUL7vQ9yTo9+RG8HZ6mXZvkeTKR8o7DLSTeavYCGHLdrK6+z
         meJolRCR0R51T7rXEnf7i0ZgHc4fSYZGEg2qe3BK8fq+gyUeRNQdlM4Ld6n4aCVEDBkW
         DLJFE9K1wQQEurhuKtARivcF/GEt6G9PltVzW2Acpc6vt3grWGflVrecN7EpxZ0tVxbp
         dJgQ==
X-Gm-Message-State: APjAAAUPYW3K3v5M3NAucX3d3jgfQBh8Hoh6RaRzL91d0slZEsvOHPuM
        waVlWZRD2LZ9CQ7YH4HOUAtS5g==
X-Google-Smtp-Source: APXvYqxoApZySaqgSVyIo//iSGJtRJzMW561OSbWhIZRPwED1AvUlJTAWkwaaDTGuwNbjF0kj4ZKXQ==
X-Received: by 2002:a62:544:: with SMTP id 65mr8679299pff.46.1557438940386;
        Thu, 09 May 2019 14:55:40 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l65sm7934163pfb.7.2019.05.09.14.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:55:39 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH 2/2] of/fdt: Mark initial_boot_params as __ro_after_init
Date:   Thu,  9 May 2019 14:55:38 -0700
Message-Id: <20190509215538.93346-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509215538.93346-1-swboyd@chromium.org>
References: <20190509215538.93346-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FDT pointer, i.e. initial_boot_params, shouldn't be changed after
init. It's only set by boot code and then the only user of the FDT is
the raw sysfs reading API. Mark this pointer with __ro_after_init so
that the pointer can't be changed after init.

Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/of/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 918098c9f72a..3d36b5afd9bd 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -516,7 +516,7 @@ EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
 int __initdata dt_root_addr_cells;
 int __initdata dt_root_size_cells;
 
-void *initial_boot_params;
+void *initial_boot_params __ro_after_init;
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
-- 
Sent by a computer through tubes

