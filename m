Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B332C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34E320B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SETFWpf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfHEI7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:59:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37366 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfHEI7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:59:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so36238221plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 01:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+678Xv5ru8PcQuczzEyKD2Pw0q4hQ1y6t38q+jHCNZs=;
        b=SETFWpf1pGWtdko7OtD3ayrl1WSWedVCqelsWrsXNZD7qdtqrydYeUvt63gQf8c0XW
         2+qLly9qS7DXaxGBuiX0VA9GT8sX+E95/H/rv5RUnLOLlnVSRlMwnKjLyNS5zK7ldl+d
         +Df+R1Uij9BXHLr3qt1EkzXxccWtwqFGVe6Noxl8C3d1Nb6gX3W7t1HXHGSDEOA/JFpL
         VachMO2puIbrAXTcvnHjcCGTY1AYuxhDwWX5saQ6jfWykaZgk9GyBYrg5ssHv/Dk5H7y
         QzjwMR97gjFqrxR+wH7OjviZX0crivWjBmWoS3dgeMb+RuiG13HlJFY6zffoBjJIf1Ix
         JErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+678Xv5ru8PcQuczzEyKD2Pw0q4hQ1y6t38q+jHCNZs=;
        b=RwWmqM6NJ1vqqZUK8jPWqdv9o6DPB9Sump4dX1+/xPylbIFxtcATK9rB/JREVluGGZ
         KlilXGYIT7V/OQao2lJKDFn5Lr6qLBXRy7mMXfJvQFzu5ihJcKyToLgZcqsPhjGnHvfy
         MSMs0k/Bys6F7dPSVB95WbZ9a5OW81f8dGfNzdvfZc9a9QH6qGR/XPXbWmXALFUkRyiP
         qosfeccUj2pY6F7oYdrV/3+KTaEz7DRTK78461/R5wub+25MSSZHk4XIjIwXWH5vsrdB
         DG0ynXHHQ0Nft2kzt3Z4mZtT8bfREeAVR6EURb0JcKSut+DhkYS7v2stK3JDNjwNeb3X
         eRuw==
X-Gm-Message-State: APjAAAV/1Wx7ACANgbQF0q3/8mHT8xgtlp2LgP+r107LDQ+wWMWodkCJ
        gBK4RWLpCTkZt9+W5LfVmQ==
X-Google-Smtp-Source: APXvYqyybjEoyBO34PmwMvc8RZn1OZ7z3xl+R3cQYmnXM9isVLFEBCUP3xP72xI2C2JnYZZTInBU7g==
X-Received: by 2002:a17:902:324:: with SMTP id 33mr139155465pld.340.1564995585890;
        Mon, 05 Aug 2019 01:59:45 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v184sm82428375pfb.82.2019.08.05.01.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 01:59:45 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Drake <drake@endlessm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH 1/4] x86/apic: correct the ENO in generic_processor_info()
Date:   Mon,  5 Aug 2019 16:58:56 +0800
Message-Id: <1564995539-29609-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1564995539-29609-1-git-send-email-kernelfans@gmail.com>
References: <1564995539-29609-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When capped by nr_cpu_ids, the current code return -EINVAL or -ENODEV. It
is better to return -EINVAL for both cases.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
---
 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f529136..f4f603a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2346,7 +2346,7 @@ int generic_processor_info(int apicid, int version)
 			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
 
 		disabled_cpus++;
-		return -ENODEV;
+		return -EINVAL;
 	}
 
 	if (num_processors >= nr_cpu_ids) {
-- 
2.7.5

