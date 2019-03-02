Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AA3C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 21:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDB020836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 21:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LpVzfaHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfCBVJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 16:09:16 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:41618 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfCBVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 16:09:16 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 9C37D78A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 21:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bo29jq8z38xi for <linux-kernel@vger.kernel.org>;
        Sat,  2 Mar 2019 15:09:14 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 74B54828
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 15:09:14 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id 190so1662853itv.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 13:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1TRUIjFY0f/8rv7vnlDfvrnlRzzApzrPDwcr+VzHvIw=;
        b=LpVzfaHp9ry4mfas1XgKpjEVSWy6A+CNdGbE8RNxdgm+5ibI76TZRdMNre9o5RTrFR
         UHVYvpb2AhlHzszBDZ0AOQ+5i2JGZ2bhGGN3WQ78r/js4O0nFPZuJm8zLSa1J58H1DFz
         EOibTRsgJHznjToq4wazT/Lw71yOKAHInGKaCmDmsipGhbSmAeomKVqviSCFltTnCtFQ
         y9Gp65e4szp+bUpEmZHTnHEOTtTjrMKo32iO9Qb8VJZ/eMNxAGb/xQEEnA89jQBzhJbY
         A1PBstXtrwwrgUWv2+VKFLNWQrTT0xTBg1xyff5Q+SY+QjMVQVmTBfAaHfeUA1DwG/W5
         PmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1TRUIjFY0f/8rv7vnlDfvrnlRzzApzrPDwcr+VzHvIw=;
        b=aQB+7nwmuEFUrqPsXpjuyhlXV1DlfIiPAkn21JoYRA8y6m4SpSFimszT0VNtSdEbkB
         Xgyv0VF3PFvf/5SUV9NYDt98cmqHCphuU24DpNPb5PgFo4Ir6b6F4Y0Oh24n3iG8UCKb
         j7PNdNrAQZ85Ramx8Xw+twI1w5RdLFH8gO11F4CERJ9JxJ9DZYSOPjCyx/EKzPpZ6nFu
         TBApNs99uw2Bulmi5otdjlbu75vj2f3OdDLSAhev5P2vvatAMMVYT+eY382cbD3GjNja
         ITgl7bCvmV+yvszdgs3se3p+2ZofpD7r7pkOVOvVnJWidpkUVF52gkq3HQfsMkgYAIAa
         KNJg==
X-Gm-Message-State: AHQUAuaObhx6EoeIZc6wJ2L2H17vNZQF1PsM95cINlNY8HJuplkh1b8G
        elol7GWdNiZPuK3Nz60MBTUzjuUVo2Ib3JEc3txWPs11TZev0x53gZlRovz/qKdu5Ta0oTnaX+t
        qhCGT5gSV+EruNYhMtNAW+vOmjsF1
X-Received: by 2002:a24:4a8f:: with SMTP id k137mr6713251itb.8.1551560954009;
        Sat, 02 Mar 2019 13:09:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBNHzgoIXs+qxio8KHl+meElblBuectpUnCFyhGlTymX1COyCoIdhv3TuLMe9yvXZ2BvefrQ==
X-Received: by 2002:a24:4a8f:: with SMTP id k137mr6713236itb.8.1551560953780;
        Sat, 02 Mar 2019 13:09:13 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id 203sm932212itm.30.2019.03.02.13.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 13:09:13 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nicolai Stange <nstange@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Banman <abanman@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        Varsha Rao <rvarsha016@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: uv: Fix potential NULL pointer dereference of kmalloc_node
Date:   Sat,  2 Mar 2019 15:09:04 -0600
Message-Id: <20190302210905.13032-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc_node might fail to allocate memory for thp field. This fix
attempts to avoid a potential NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 arch/x86/platform/uv/tlb_uv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index a4130b84d1ff..5a6d51e30a36 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -2011,6 +2011,9 @@ static void make_per_cpu_thp(struct bau_control *smaster)
 	size_t hpsz = sizeof(struct hub_and_pnode) * num_possible_cpus();
 
 	smaster->thp = kmalloc_node(hpsz, GFP_KERNEL, smaster->osnode);
+	if (!smaster->thp)
+		return;
+
 	memset(smaster->thp, 0, hpsz);
 	for_each_present_cpu(cpu) {
 		smaster->thp[cpu].pnode = uv_cpu_hub_info(cpu)->pnode;
-- 
2.17.1

