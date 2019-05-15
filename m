Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6141DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B02206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922443;
	bh=5XOjZV2e5pFwSjKfFvSKi4Rf1UM727hp/xqj0N10Miw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rWUu0PNhFnRwbro6GUI4TAfV+0jWFG7KUgibXo3XRj6voozoxlGsMRXCbWaHW2ppR
	 FPMWalWUdSK29/apekWMl3viMPh83oAzIlw570RN7gU3wfyjzu+ilMu/QLzSK3kOUH
	 Q4AlExn+jJ8daBJ1zBBprEXdP7rJuisKrAxPvToc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfEOLEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbfEOLEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:04:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A952084F;
        Wed, 15 May 2019 11:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918276;
        bh=5XOjZV2e5pFwSjKfFvSKi4Rf1UM727hp/xqj0N10Miw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARnYSx5JP3UR1hZ5STuJRyZmJbSOLdeFOawXf2B6T5DThNAaf26rTmGnu70OvGEpB
         uR4eQdzDIHLPAvyHxAvWv6Nd4/BwofkgEow9LvRhKMxhDBLygWodayA3gyLWeKurul
         XTED0+T6BKKA5+gZUJsSgV5ikIWIuwUbhHe6SZqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 031/266] powerpc/64s: Wire up cpu_show_spectre_v2()
Date:   Wed, 15 May 2019 12:52:18 +0200
Message-Id: <20190515090723.596649407@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit d6fbe1c55c55c6937cbea3531af7da84ab7473c3 upstream.

Add a definition for cpu_show_spectre_v2() to override the generic
version. This has several permuations, though in practice some may not
occur we cater for any combination.

The most verbose is:

  Mitigation: Indirect branch serialisation (kernel only), Indirect
  branch cache disabled, ori31 speculation barrier enabled

We don't treat the ori31 speculation barrier as a mitigation on its
own, because it has to be *used* by code in order to be a mitigation
and we don't know if userspace is doing that. So if that's all we see
we say:

  Vulnerable, ori31 speculation barrier enabled

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -58,3 +58,36 @@ ssize_t cpu_show_spectre_v1(struct devic
 
 	return sprintf(buf, "Vulnerable\n");
 }
+
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	bool bcs, ccd, ori;
+	struct seq_buf s;
+
+	seq_buf_init(&s, buf, PAGE_SIZE - 1);
+
+	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
+	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
+	ori = security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31);
+
+	if (bcs || ccd) {
+		seq_buf_printf(&s, "Mitigation: ");
+
+		if (bcs)
+			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");
+
+		if (bcs && ccd)
+			seq_buf_printf(&s, ", ");
+
+		if (ccd)
+			seq_buf_printf(&s, "Indirect branch cache disabled");
+	} else
+		seq_buf_printf(&s, "Vulnerable");
+
+	if (ori)
+		seq_buf_printf(&s, ", ori31 speculation barrier enabled");
+
+	seq_buf_printf(&s, "\n");
+
+	return s.len;
+}


