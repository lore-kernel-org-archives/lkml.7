Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA7CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CBF20659
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVqFjUBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408005AbfJWXEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 19:04:35 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:41362 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733196AbfJWXEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 19:04:35 -0400
Received: by mail-qk1-f202.google.com with SMTP id c13so8260876qko.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 16:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NalAL07f5HutXXwa+1Q4X8qy6hVKEN+PzqVoDq+V0Uc=;
        b=fVqFjUBlr6WYdeW8nfpaSXUvftzYUbrImmEdERDjPUyQDfW0iAnu5Tq3IkJmWctpxj
         LJ6qGO7PBSpKC/nTaigcHmYD5jmo3yNToB1i9Y/Yy7FNPjYnr2uElafDiGubQf0bx9pH
         2uZH6zm4zFnizaRySLxRApWRh9dW/2NPbr5OC1F8RaMcopR//eMP5EOwMhCo2kQ/0mK3
         QCoIaqBYlW1NxwoRptyjEnr+2g8XNQDRpbnsZyQjhnprN/Td4eE6Mgl+KFRLEIbQWpvS
         i/nKt+kO9HmysD8EpE54gGqeSI4UuY4UOFpQEAYRo7D/bjudKLD2GxH84o8ql4XvrsMV
         OgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NalAL07f5HutXXwa+1Q4X8qy6hVKEN+PzqVoDq+V0Uc=;
        b=cq6atjMH2LJ4Fa6lzJcFdpKaeTwO74tkRKHPFcIPSvZp4etGItJCSYcLTmsrH8f0e+
         ZGXXFOupPylV7rp2lqPWIAVb5LC+zGtl4/PYIEjlwF8C8Mnavdud6TycqDxgNAoFxhaB
         GIWq1geggfyuDG5X/fZ6KwA3pk2sldHMM4Xh9VzZE9bDLQNyKqyjR3/n4DNkWwg3nyOZ
         vI48B9tBjTR6jshEXh6nHaamucUEEIt5wttlnr/RkdpTAHd2+VxKBgV9XWJvmqbQYUg/
         dn+T2ywIOlc2/W2ayX0rP8IfrXsNjAAB/U5NPRbOP7ht2cZvZ0VQLRQyproa+HS5nhvf
         G9tA==
X-Gm-Message-State: APjAAAWn55aGJ/pugpEMsYNjPGxmYJPqUJ+Vya09UmrGq9ClbKokZB6M
        BQFw8hjhkUrCsztknCuXyma5Q6bHX6yzew+oR6qsHEXfyVUmpZuJ11mdwOEYa/p7jVjV8Guv1DP
        zBPoe2wF5ZGDx1CPqoyIP6lgKSLNsRAjHD2/2qGJDbUmp2jTp2sZQ/etRGmeoU0ee6sXo8oIMy7
        UYTGs1PHvS
X-Google-Smtp-Source: APXvYqw0XcENs739XemqxMsyAI0zMQW+5s+voNGA4/V6aHUSXDoe2yz7YVHcOPpKrtgCOJv41QD9HgBQ9LZerfb43rA=
X-Received: by 2002:ad4:4503:: with SMTP id k3mr11282482qvu.155.1571871872076;
 Wed, 23 Oct 2019 16:04:32 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:04:26 -0700
Message-Id: <20191023230426.200068-1-asteinhauser@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH] SYSFS reporting of L1TF on PowerPC.
From:   Anthony Steinhauser <asteinhauser@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Anthony Steinhauser <asteinhauser@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L1TF affects PowerPC of the same range as Meltdown-US.
I tested it personally:
https://github.com/google/safeside/pull/52
and it is also admitted in the IBM report:
https://www.ibm.com/blogs/psirt/potential-impact-processors-power-family/
Similarly to Meltdown it is effectively mitigated by the rfi_flush.

Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
---
 arch/powerpc/kernel/security.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 7cfcb294b11c..410232e79371 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -167,6 +167,18 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, cha
 
 	return sprintf(buf, "Vulnerable\n");
 }
+
+ssize_t cpu_show_l1tf(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (rfi_flush)
+		return sprintf(buf, "Mitigation: RFI Flush");
+
+	if (!security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV) &&
+	    !security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR))
+		return sprintf(buf, "Not affected\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
 #endif
 
 ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.23.0.866.gb869b98d4c-goog

