Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F9ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1318220854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="D6xYwFac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436817AbfJPUAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:00:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38892 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfJPUAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:00:41 -0400
Received: by mail-qk1-f196.google.com with SMTP id p4so3436035qkf.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7bTbY9wWGaJLNQvZeFd+1QuaD6S0qAHt0InnROLT/Os=;
        b=D6xYwFacfqrSDzdKiZLP/TzT9Pqm/HyN3qCUyAhl++JnfcJj1zNrvqFXj80G7H0YAD
         0oC7ITgJ1jpBh7bsno8amd9UDUDHZErELokqD3GaD1kg4LXtwLv8dPsn78AHP6ZqKH39
         E8M8n9Kv/DO9i8z90OKfTCngljmk0SNTy9xLhlawUp/NcuhYiPwsq6O7qxMXWh3quoUI
         Wd3TUbPEqiUxf2/4gs4CixenvdexjxXEEDtAz27okuFTHV9DnryTqfEq528hdjMcsw+b
         Omy3Z+4qDZeopuxmjCIHzRvgaTIHLFvL3pr1YdfXc+Z0AclbWLrPwyI7DwzdMFju98+p
         vf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bTbY9wWGaJLNQvZeFd+1QuaD6S0qAHt0InnROLT/Os=;
        b=Mf3/1HTRnh/f4BBxW+oPBN6Q29OgbSUyYt/11Z+PS2ETjTK4FYMMOCTDUyl0nXvHF5
         r3d1HdLQVmpOyTGVxK+wrXfukr9OL+1yCdLK1R7Db4M6EMDeTH+e/KxYVN0ls/Hpw28i
         Qt9bS3+sjtbZNBlx4okkZiXl8m7rlV4B0+yWTWHJCO9+mfNrPBCjKsJ+G6AdB4PJZVVI
         VQB4TbZcQFJJSAAjS+Lylic+MLHX8IoDsK69YlXAmSIXJyDyxkOkGEFHuC87h9UjF87F
         sD8opEt9xSTj/gvKkxl8gKy1+j7RVWdfrJ3QY5K7m7UrDn0DVFHvALUB2v9bg/h7x1VQ
         jfCQ==
X-Gm-Message-State: APjAAAXFnZX/hdeVz2YzrhXdOOEgktphxWHBEN14AZBqGoHAt8zj4gbz
        TRIGe0Oo7x+5E7h5macogTphXA==
X-Google-Smtp-Source: APXvYqw/em1XYN8TtYqp0Zy3p+LEV2iCbYfwJbzFt0I3YCF5Whypfh4NQtzdx8ssjs/HvNqnpuzRmg==
X-Received: by 2002:a37:9b81:: with SMTP id d123mr5380291qke.410.1571256038811;
        Wed, 16 Oct 2019 13:00:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:00:38 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v7 01/25] kexec: quiet down kexec reboot
Date:   Wed, 16 Oct 2019 16:00:10 -0400
Message-Id: <20191016200034.1342308-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
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

