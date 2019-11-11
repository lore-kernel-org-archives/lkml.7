Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4D6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E438921655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKKOpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:45:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:51084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726915AbfKKOpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:45:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14105ACB7;
        Mon, 11 Nov 2019 14:45:29 +0000 (UTC)
Subject: [PATCH 1/3] xen/mcelog: drop __MC_MSR_MCGCAP
From:   Jan Beulich <jbeulich@suse.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <a83f42ad-c380-c07f-7d22-7f19107db5d5@suse.com>
Message-ID: <ce1a10f7-ecd1-e4ee-72c3-bc29d914c0e0@suse.com>
Date:   Mon, 11 Nov 2019 15:45:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <a83f42ad-c380-c07f-7d22-7f19107db5d5@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has never been part of Xen's public interface, and there's therefore
no guarantee for MCG_CAP's value to always be present in array entry 0.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/drivers/xen/mcelog.c
+++ b/drivers/xen/mcelog.c
@@ -222,7 +222,7 @@ static int convert_log(struct mc_info *m
 	struct mcinfo_global *mc_global;
 	struct mcinfo_bank *mc_bank;
 	struct xen_mce m;
-	uint32_t i;
+	unsigned int i, j;
 
 	mic = NULL;
 	x86_mcinfo_lookup(&mic, mi, MC_TYPE_GLOBAL);
@@ -248,7 +248,12 @@ static int convert_log(struct mc_info *m
 	m.socketid = g_physinfo[i].mc_chipid;
 	m.cpu = m.extcpu = g_physinfo[i].mc_cpunr;
 	m.cpuvendor = (__u8)g_physinfo[i].mc_vendor;
-	m.mcgcap = g_physinfo[i].mc_msrvalues[__MC_MSR_MCGCAP].value;
+	for (j = 0; j < g_physinfo[i].mc_nmsrvals; ++j)
+		switch (g_physinfo[i].mc_msrvalues[j].reg) {
+		case MSR_IA32_MCG_CAP:
+			m.mcgcap = g_physinfo[i].mc_msrvalues[j].value;
+			break;
+		}
 
 	mic = NULL;
 	x86_mcinfo_lookup(&mic, mi, MC_TYPE_BANK);
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -183,7 +183,6 @@ struct mc_info {
 DEFINE_GUEST_HANDLE_STRUCT(mc_info);
 
 #define __MC_MSR_ARRAYSIZE 8
-#define __MC_MSR_MCGCAP 0
 #define __MC_NMSRS 1
 #define MC_NCAPS 7
 struct mcinfo_logical_cpu {

