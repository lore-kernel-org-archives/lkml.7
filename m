Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956B9C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727B0222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KXyyk/U3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbfJDSwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:52:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41467 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDSwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:52:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id d16so9913662qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7bTbY9wWGaJLNQvZeFd+1QuaD6S0qAHt0InnROLT/Os=;
        b=KXyyk/U3a3Ake5uIAGMpLeR7Q0kB8Wyp7yvAxZlB92sLZghjiV0BDpeYoj/wbGt1l5
         R3q6AjsnUJ6GLrTbwcmOjdnD4CfHBskZbK8TylbWz6ggsmCqOLReOj7ep29t7/s1EeMG
         KGyTKjJxepS8HkKhwSwFy8BmvkL8yDyMXA17xxIXrqwj6MbaKGqKD2QLoip8jD45Hegf
         4b2L8PDJJB/IHOltXinsIZSRf0VXkxxhBpgSD9OdK0kkj6VLz2CSySr0rYTU/+Mt/vHw
         q3shV+dlqn+vajvIWrEMx872Uhxs3k0r5vXSsN52gKNReVdOlx/YZVeqOKeqmQWibfwZ
         k5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bTbY9wWGaJLNQvZeFd+1QuaD6S0qAHt0InnROLT/Os=;
        b=L+2Z5aTt14hhEHXwyTtUoXywvVh7IbB0aG7dxpOSgZMgomad2M68tRxRZymdUVyTak
         isYVgJY399xsFq2nE7VktgaPY0dZYxLJjvLcPHNoKeCHX9Pd/r6oCuUznslqX7MbZZRO
         KhbA0Pg/ujbJx9auDIP9m5VlewRolyWJLGN2jInHaH0hsABI5cin3riQK9A0+1eR9Qr9
         sqENIPPBIof5pBNKUqm5Xd1S4SLFraUfB0kpogcVvClD6uVSj239b2W392bZpPJF4shd
         DdUc0Vugm51P5HDzMoAWc5pzJeWb5rraK3H1C0NWVnv93vZQYfGLk3ttwpFhtyf+5d0g
         ZGCg==
X-Gm-Message-State: APjAAAVat8PTNJvjcTk9GBBFL4/GDc2qIP24g23wGqyD7UZ1zxectH2T
        T/ydES9QcqY2On/6DgOHiVSTyQ==
X-Google-Smtp-Source: APXvYqyThUzTiS+dwSZXvbUyY+dR397sqlmVrBPBWuKY07TnEBwjhKxQlTHaFo2sBRO2G5DpOma8FQ==
X-Received: by 2002:ac8:3061:: with SMTP id g30mr17524356qte.46.1570215158266;
        Fri, 04 Oct 2019 11:52:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id p77sm4042514qke.6.2019.10.04.11.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:52:37 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v6 01/17] kexec: quiet down kexec reboot
Date:   Fri,  4 Oct 2019 14:52:18 -0400
Message-Id: <20191004185234.31471-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004185234.31471-1-pasha.tatashin@soleen.com>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a regular kexec command sequence and output:
=====
$ kexec --reuse-cmdline -i --load Image
$ kexec -e
[  161.342002] kexec_core: Starting new kernel

Welcome to Buildroot
buildroot login:
=====

Even when "quiet" kernel parameter is specified, "kexec_core: Starting
new kernel" is printed.

This message has  KERN_EMERG level, but there is no emergency, it is a
normal kexec operation, so quiet it down to appropriate KERN_NOTICE.

Machines that have slow console baud rate benefit from less output.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Simon Horman <horms@verge.net.au>
Acked-by: Dave Young <dyoung@redhat.com>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 15d70a90b50d..f7ae04b8de6f 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1171,7 +1171,7 @@ int kernel_kexec(void)
 		 * CPU hotplug again; so re-enable it here.
 		 */
 		cpu_hotplug_enable();
-		pr_emerg("Starting new kernel\n");
+		pr_notice("Starting new kernel\n");
 		machine_shutdown();
 	}
 
-- 
2.23.0

