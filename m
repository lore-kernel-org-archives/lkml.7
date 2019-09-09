Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1507CC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09A7206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA6Y2gps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbfIIOSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:18:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43608 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbfIIOSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:18:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id u72so7909632pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVzAji3GW1QKfy7eDTvui/A8m2Rjy2R5WVJhQA7E3lY=;
        b=FA6Y2gps0ifX4uvnMDS0DOiT+Fgh3UqtUE72ZWqOu8lwrz0rbfDuEq1Otp/RC4ymAE
         QnicVLMtN9dR6FciZ8oeyYzfJxSXpvmqh2DthA2zxib/0mtBfvwKi1lIFk3Fw15LCaIz
         nP+yXwI6LC+5srReh5dwKLtthYueXmWqI3HilJSbX+7cKh7rEHVvlEaFn+072/1BwhiD
         t6NNv6ypve4lOYDsvbn+Xc5S19KFBJZGJAwsv30kQOju2pmFyvnwrOhpxmFSJoSdLW5p
         hS6AbUV8sti03LRs59bq2s6AhcBqiD2Ie8q/pw0S4snbMat7pi40iAvbp2SgX7sSwhfe
         riUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVzAji3GW1QKfy7eDTvui/A8m2Rjy2R5WVJhQA7E3lY=;
        b=H5/rtEupUAsfTV8hF8MWnzgpo98yCMgGY9WNT2gijo78bvz7IOZ4ecfrqBDGhb3yrb
         cgcv7TEY6A5bdoZf9+47x4fgETYQNGtfT15EwTHmm46lqZHg+Te7yxPx8Afx1ReVWN3i
         9kvgLtSVGNELRi1OcI7J22lmViyV3bmKNxYV18Iy5GrjGGUyHKdFfdxM+qU5doLyB5Np
         VHy0MYCiRgTTKx9/Ku94qxPgaNO3G+eLuqHc8InVOZjKxt9Lya/5xyJQEQsFuXlfSmuM
         bb//40TcS59clEGyP5RxzH7jcwT6O7C/HeSiS+oPtM+3u/VD8yQqYDnQuuIQtYml7rpU
         bOsw==
X-Gm-Message-State: APjAAAXKxW5uqmeWdxLkYgAjlNbYX6wRIQi8CRy9YJ1AC5oCeW9s73Xm
        +6asxT7PUIFM0QAuLT/otOs=
X-Google-Smtp-Source: APXvYqwdbB6CWMglQSa76xI9Is7f1tJvZppvX5qyUBkzi7rtSCrJBhiDNgKK6aLfryD5FcxtdRbc/Q==
X-Received: by 2002:a62:1cd2:: with SMTP id c201mr28282621pfc.51.1568038726507;
        Mon, 09 Sep 2019 07:18:46 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id w6sm34574695pfw.84.2019.09.09.07.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:18:46 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 1/9] kconfig/hacking: Group sysrq/kgdb/ubsan into 'Generic Kernel Debugging Instruments'
Date:   Mon,  9 Sep 2019 22:18:15 +0800
Message-Id: <20190909141823.8638-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909141823.8638-1-changbin.du@gmail.com>
References: <20190909141823.8638-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group generic kernel debugging instruments sysrq/kgdb/ubsan together into
a new submenu.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 10023dbac8e4..bd3938483514 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -419,6 +419,8 @@ config DEBUG_FORCE_WEAK_PER_CPU
 
 endmenu # "Compiler options"
 
+menu "Generic Kernel Debugging Instruments"
+
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on !UML
@@ -452,6 +454,12 @@ config MAGIC_SYSRQ_SERIAL
 	  This option allows you to decide whether you want to enable the
 	  magic SysRq key.
 
+source "lib/Kconfig.kgdb"
+
+source "lib/Kconfig.ubsan"
+
+endmenu
+
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
@@ -2111,10 +2119,6 @@ config BUG_ON_DATA_CORRUPTION
 
 source "samples/Kconfig"
 
-source "lib/Kconfig.kgdb"
-
-source "lib/Kconfig.ubsan"
-
 config ARCH_HAS_DEVMEM_IS_ALLOWED
 	bool
 
-- 
2.20.1

