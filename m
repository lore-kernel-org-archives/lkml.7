Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8288AC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D6D2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C3ShdxcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfF1FUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:20:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33769 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1FUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:20:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5S5JoVr614463
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 22:19:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5S5JoVr614463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561699191;
        bh=0c84f0VNa272ilGhAug3o2TBEClGUFNWp9Q+kZeE0a4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=C3ShdxcCRcOMibmjT6YNgFWybmGO+neMLm+n/d/GAW1bworRau+5xXRreU9fXoIOD
         YnAl9OheLBLc6ao1aJY++/Zni9uiOLrJ65TA5ujYUh32DwxoMSsZMwgw1A7laU7Kx2
         gb/pdXMv50Kn8FotRzclktYuTnMGv3aFA/yLpMRPO1hzS+cZTxujhDYWmmPBu/s2/U
         fkLFlgGghlnK4kk3i7foL9y5e4KKbgxLSoYUMA+5aqmcTcZl/3BoToJDD3vXZ/H4DZ
         p3sSOAizwODewfa0uiQ6dOapb9pPp+mOdzj8VAF1S8udoP7eeh6xxjOzW+cd5eiMqg
         A4pQeGdDFqwiw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5S5Jouc614460;
        Thu, 27 Jun 2019 22:19:50 -0700
Date:   Thu, 27 Jun 2019 22:19:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-ee338b9ee2822e65a85750da6129946c14962410@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mingo@kernel.org, bhe@redhat.com, hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
          hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          bhe@redhat.com
In-Reply-To: <20190524073810.24298-3-bhe@redhat.com>
References: <20190524073810.24298-3-bhe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/kexec/64: Prevent kexec from 5-level paging to a
 4-level only kernel
Git-Commit-ID: ee338b9ee2822e65a85750da6129946c14962410
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ee338b9ee2822e65a85750da6129946c14962410
Gitweb:     https://git.kernel.org/tip/ee338b9ee2822e65a85750da6129946c14962410
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Fri, 24 May 2019 15:38:09 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 07:14:59 +0200

x86/kexec/64: Prevent kexec from 5-level paging to a 4-level only kernel

If the running kernel has 5-level paging activated, the 5-level paging mode
is preserved across kexec. If the kexec'ed kernel does not contain support
for handling active 5-level paging mode in the decompressor, the
decompressor will crash with #GP.

Prevent this situation at load time. If 5-level paging is active, check the
xloadflags whether the kexec kernel can handle 5-level paging at least in
the decompressor. If not, reject the load attempt and print out an error
message.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: dyoung@redhat.com
Link: https://lkml.kernel.org/r/20190524073810.24298-3-bhe@redhat.com

---
 arch/x86/kernel/kexec-bzimage64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 22f60dd26460..7f439739ea3d 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -321,6 +321,11 @@ static int bzImage64_probe(const char *buf, unsigned long len)
 		return ret;
 	}
 
+	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
+		pr_err("bzImage cannot handle 5-level paging mode.\n");
+		return ret;
+	}
+
 	/* I've got a bzImage */
 	pr_debug("It's a relocatable bzImage64\n");
 	ret = 0;
