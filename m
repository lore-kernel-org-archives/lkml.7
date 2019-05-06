Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC82C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E80E2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178107;
	bh=k1Jv58Df73YZhzI+gHs65MvR/WrxoEvI2Or//tv2pU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=U91EsOpZ9PdF5xB4bi45bY4Ud1YqTpEusZhuXtYO/Iag9bqiYWMDea665/4rzheo0
	 HdJHt4FLT6vcWLnpDTKdhjwHoYTag6BZk6qjW7pyjtLUi3Zt0352X9yY4/FRD12mGS
	 oGPQn8A/UktTfT5VDlabuY9F2rrU3SmShLlqFDmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfEFV2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:28:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46804 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfEFV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:29 -0400
Received: by mail-io1-f66.google.com with SMTP id m14so12404034ion.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=uD3OvFcls30SXN52XBWKTLWJTDIBIfXTSrwZineFKm8=;
        b=KecmMkSm4FviQCmpyzZxmkmq2BMwIBwlT88l0HgP2+BvRj59UQXrDOs8IYfkN2NV18
         z/rn5EhcU1sBKCvRigWnhrxzNFbeB7KdLawnGtrFue+pdaLBYP2mndyo1EEmmNF5J+sr
         11+BCO1E5X/ZbKRZ+kwIYxacG05SMEatZsQf0dxWwqHBhKqyojTDEEbletySXrnIlJLX
         INEIJmmHxeWDub0y4VQzzmfevcLsxTg/atg01QfyN2oDlxVCx5KgHoyVLJiExjuv1iUd
         PAwhNk/Re09DW6iZ/jD6wMfHdng6AA1343MxIDBV+m2xfGwjlb1kXnlIqIPvRZO7WWCY
         Decw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=uD3OvFcls30SXN52XBWKTLWJTDIBIfXTSrwZineFKm8=;
        b=XkU63/xQRRqkBYN2H/QYJ5vfmSsP3s3iMsSS3d62pZ1gthcWRshbWJvXcxvLBYcCT2
         hb6IBDB5WYnAYwVovcm5cfxF1ut2fXjTYVFBmeYzM/YTUC8irrug14U5/PiwKw8fHT+T
         05sH+/mKF5Jt0rbvdTDz4Z8Zrasv5RTLMjiKocIkFT3dyIVDC88ZpSOkh1e2r7uxaQci
         MMksxJ+Rq+OtRbxI5C3YvsfUtls1J1rWSc9Errl3wAm1Ms9tkuCzdXOdcodqEnMsiw1T
         dRpa5WCvpXsO3aZBOfvDJaqwP2rFexV4FOeaMwY2ENjHeu41Yc7fGsuV2KlieAXRl8g0
         7+vg==
X-Gm-Message-State: APjAAAVML9aol75qyi9UR5Jab8FO8iROWc4qZ7UqvemG+cUrFQJTosU9
        2Bpkp0WEEspQQXmdmhl1HDk=
X-Google-Smtp-Source: APXvYqxwTwgCTCgpqv1CAKqVgRMZWKuAfo1e0dt4pkBhrUMJpVdB56kGPlIqrucA5XhwJ6uXz75CwA==
X-Received: by 2002:a5d:990d:: with SMTP id x13mr2219388iol.248.1557177988794;
        Mon, 06 May 2019 14:26:28 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:28 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 03/22] x86 smpboot: Rename match_die() to match_pkg()
Date:   Mon,  6 May 2019 17:25:58 -0400
Message-Id: <44a39ba11153106d2b029d9cffee1b062bdbce4b.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Syntax only, no functional or semantic change.

This routine matches packages, not die, so name it thus.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ce1a67b70168..3f8bbfb26c18 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -455,7 +455,7 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  * multicore group inside a NUMA node.  If this happens, we will
  * discard the MC level of the topology later.
  */
-static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
 	if (c->phys_proc_id == o->phys_proc_id)
 		return true;
@@ -546,7 +546,7 @@ void set_cpu_sibling_map(int cpu)
 	for_each_cpu(i, cpu_sibling_setup_mask) {
 		o = &cpu_data(i);
 
-		if ((i == cpu) || (has_mp && match_die(c, o))) {
+		if ((i == cpu) || (has_mp && match_pkg(c, o))) {
 			link_mask(topology_core_cpumask, cpu, i);
 
 			/*
@@ -570,7 +570,7 @@ void set_cpu_sibling_map(int cpu)
 			} else if (i != cpu && !c->booted_cores)
 				c->booted_cores = cpu_data(i).booted_cores;
 		}
-		if (match_die(c, o) && !topology_same_node(c, o))
+		if (match_pkg(c, o) && !topology_same_node(c, o))
 			x86_has_numa_in_package = true;
 	}
 
-- 
2.18.0-rc0

