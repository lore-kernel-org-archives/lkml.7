Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3C2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911D7206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAl+m6Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbgAIQJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:09:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53356 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387411AbgAIQJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+WGb3puDmUzCYPuLm6oXYBSJ99/bjzxumOQhQE5nO+o=;
        b=gAl+m6JfDd+V/brq/fuFv1yjmQogMIDmbQtEaBUrBFv6IwBl/BK4wEJEdacHRjyxuApr3C
        +56w/DDkmKdbBhsgwczLKqUHv/NMer4wQ+Sflzqt/sQL32MmtUlk27zXrOrCePbSxfyjXC
        ulYa7/702CSiXrKpp1kdw3dMH+jjfUo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-USZzmGtgPr6Fk7uj8rinUw-1; Thu, 09 Jan 2020 11:09:33 -0500
X-MC-Unique: USZzmGtgPr6Fk7uj8rinUw-1
Received: by mail-wr1-f72.google.com with SMTP id t3so3024910wrm.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WGb3puDmUzCYPuLm6oXYBSJ99/bjzxumOQhQE5nO+o=;
        b=VGlkkPrp0vot/rJY15+GgSQE1V2KYVZdkB4aW0fXcnfB/h0uP8OGFaaUrRLYn7ewFE
         n60SdTIkwF8WmxJjbj8CvMVbJGuJjFJNKSdAOh8aokTcTSRZf9yJ8hrZChA4O2S57FoE
         RWUyZNK/0Vd6iNSISdudem0dl/RS6MQqtmhNCNhZKsGi7Xhqy2U1aLojfFItqXtj+Drf
         RBTGgqwVsbfTq2bidmOWTkNm4C1qpZw4+eCWS70ht/6/XFUnAiyyMkUbo0B7UG7ljb5I
         19McdQ08ebswodHqZJ32+OEamYNTgDH9Rv8CPdWISwm4PyGIjVCGVXq6HOib8vyiNd7O
         /evQ==
X-Gm-Message-State: APjAAAWdiX5GbmxxYYCgJvY71kA82/Y2g9mg1HQ88DZW6k8wVzHEyvDC
        rxTsjBOIhkVgeIxMvwFCFNoOKjdoQJc0ni/gwx/K0esTRwCok4ZWCU96BrrHGREcXi58BJWatyu
        pmp1oBG4t2OJx1i1snP+pfx0Q
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr11728061wru.40.1578586172085;
        Thu, 09 Jan 2020 08:09:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5V26QjGcxR+qc3PnQJZqKeHaPwzwzDGc3YkRawBmFtmaeyy4yWAZvPxOmJY0ku0p1ZNx85w==
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr11728054wru.40.1578586171944;
        Thu, 09 Jan 2020 08:09:31 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id e8sm8517707wrt.7.2020.01.09.08.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:09:31 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 50/57] arm64: kernel: Add exception on kuser32 to prevent stack analysis
Date:   Thu,  9 Jan 2020 16:02:53 +0000
Message-Id: <20200109160300.26150-51-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

kuser32 being used for compatibility, it contains a32 instructions
which are not recognised by objtool when trying to analyse arm64
object files. Thus, we add an exception to skip validation on this
particular file.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/kernel/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index fc6488660f64..f5994679db5f 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -33,6 +33,9 @@ ifneq ($(CONFIG_COMPAT_VDSO), y)
 obj-$(CONFIG_COMPAT)			+= sigreturn32.o
 endif
 obj-$(CONFIG_KUSER_HELPERS)		+= kuser32.o
+
+OBJECT_FILES_NON_STANDARD_kuser32.o := y
+
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
-- 
2.21.0

