Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4488AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149F120856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139291;
	bh=rkMbvPlw/Deo2TEUlhdRNQAwXnCGiQtBJv648V/uWlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NG04Cvd5HdnSIE4Ip0BOYT8eHxauHqPNULZmOPUecciODK0JMLs/Ie2pAq2Ww9+AW
	 EzHFFn9V573MnhxXR5W1ZNZuF0PHgMQzGxwhD8jkYJJ2F0SjSBdG+EuTy5GsA5x/5L
	 +2BVsV7paOPBFiI86I5dJ6Dg2sBYg5cdjHkxsG74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfDARV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731546AbfDARV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:21:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 076392133D;
        Mon,  1 Apr 2019 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139285;
        bh=rkMbvPlw/Deo2TEUlhdRNQAwXnCGiQtBJv648V/uWlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmdHvY18fLpr/y67LXjZQLrmP3hyKmerOeX0YtSeSwmHvIKxTBwIJywlfMjxSk1Nw
         xMxFyLftrZsj9YdC2fMMv7yJy4KrG9j7UjZhgrzAOAEpCwdL7PsajzxVmmJ9Qs0vAT
         mzWPS0rxixsoPsGtVQZUhBWEzD31IW/QkDOJBS14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 030/107] powerpc64s: Show ori31 availability in spectre_v1 sysfs file not v2
Date:   Mon,  1 Apr 2019 19:01:45 +0200
Message-Id: <20190401170048.471975042@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 6d44acae1937b81cf8115ada8958e04f601f3f2e upstream.

When I added the spectre_v2 information in sysfs, I included the
availability of the ori31 speculation barrier.

Although the ori31 barrier can be used to mitigate v2, it's primarily
intended as a spectre v1 mitigation. Spectre v2 is mitigated by
hardware changes.

So rework the sysfs files to show the ori31 information in the
spectre_v1 file, rather than v2.

Currently we display eg:

  $ grep . spectre_v*
  spectre_v1:Mitigation: __user pointer sanitization
  spectre_v2:Mitigation: Indirect branch cache disabled, ori31 speculation barrier enabled

After:

  $ grep . spectre_v*
  spectre_v1:Mitigation: __user pointer sanitization, ori31 speculation barrier enabled
  spectre_v2:Mitigation: Indirect branch cache disabled

Fixes: d6fbe1c55c55 ("powerpc/64s: Wire up cpu_show_spectre_v2()")
Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -117,25 +117,35 @@ ssize_t cpu_show_meltdown(struct device
 
 ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	if (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR))
-		return sprintf(buf, "Not affected\n");
+	struct seq_buf s;
+
+	seq_buf_init(&s, buf, PAGE_SIZE - 1);
+
+	if (security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR)) {
+		if (barrier_nospec_enabled)
+			seq_buf_printf(&s, "Mitigation: __user pointer sanitization");
+		else
+			seq_buf_printf(&s, "Vulnerable");
 
-	if (barrier_nospec_enabled)
-		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+		if (security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31))
+			seq_buf_printf(&s, ", ori31 speculation barrier enabled");
 
-	return sprintf(buf, "Vulnerable\n");
+		seq_buf_printf(&s, "\n");
+	} else
+		seq_buf_printf(&s, "Not affected\n");
+
+	return s.len;
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	bool bcs, ccd, ori;
 	struct seq_buf s;
+	bool bcs, ccd;
 
 	seq_buf_init(&s, buf, PAGE_SIZE - 1);
 
 	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
 	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
-	ori = security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31);
 
 	if (bcs || ccd) {
 		seq_buf_printf(&s, "Mitigation: ");
@@ -151,9 +161,6 @@ ssize_t cpu_show_spectre_v2(struct devic
 	} else
 		seq_buf_printf(&s, "Vulnerable");
 
-	if (ori)
-		seq_buf_printf(&s, ", ori31 speculation barrier enabled");
-
 	seq_buf_printf(&s, "\n");
 
 	return s.len;


