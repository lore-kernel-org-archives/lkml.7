Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D5EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4653B21655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKKOqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:46:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:51432 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbfKKOqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:46:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E088B02E;
        Mon, 11 Nov 2019 14:46:13 +0000 (UTC)
Subject: [PATCH 2/3] xen/mcelog: add PPIN to record when available
From:   Jan Beulich <jbeulich@suse.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <a83f42ad-c380-c07f-7d22-7f19107db5d5@suse.com>
Message-ID: <c1f58da4-0a05-5f77-13bd-a421582675d0@suse.com>
Date:   Mon, 11 Nov 2019 15:46:26 +0100
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

This is to augment commit 3f5a7896a5 ("x86/mce: Include the PPIN in MCE
records when available").

I'm also adding "synd" and "ipid" fields to struct xen_mce, in an
attempt to keep field offsets in sync with struct mce. These two fields
won't get populated for now, though.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -393,6 +393,8 @@
 #define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
+#define MSR_AMD_PPIN_CTL		0xc00102f0
+#define MSR_AMD_PPIN			0xc00102f1
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
 #define MSR_AMD64_BU_CFG2		0xc001102a
--- a/drivers/xen/mcelog.c
+++ b/drivers/xen/mcelog.c
@@ -253,6 +253,11 @@ static int convert_log(struct mc_info *m
 		case MSR_IA32_MCG_CAP:
 			m.mcgcap = g_physinfo[i].mc_msrvalues[j].value;
 			break;
+
+		case MSR_PPIN:
+		case MSR_AMD_PPIN:
+			m.ppin = g_physinfo[i].mc_msrvalues[j].value;
+			break;
 		}
 
 	mic = NULL;
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -332,7 +332,11 @@ struct xen_mc {
 };
 DEFINE_GUEST_HANDLE_STRUCT(xen_mc);
 
-/* Fields are zero when not available */
+/*
+ * Fields are zero when not available. Also, this struct is shared with
+ * userspace mcelog and thus must keep existing fields at current offsets.
+ * Only add new fields to the end of the structure
+ */
 struct xen_mce {
 	__u64 status;
 	__u64 misc;
@@ -353,6 +357,9 @@ struct xen_mce {
 	__u32 socketid;	/* CPU socket ID */
 	__u32 apicid;	/* CPU initial apic ID */
 	__u64 mcgcap;	/* MCGCAP MSR: machine check capabilities of CPU */
+	__u64 synd;	/* MCA_SYND MSR: only valid on SMCA systems */
+	__u64 ipid;	/* MCA_IPID MSR: only valid on SMCA systems */
+	__u64 ppin;	/* Protected Processor Inventory Number */
 };
 
 /*
