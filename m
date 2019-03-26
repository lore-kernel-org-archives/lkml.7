Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26952084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cuvbwz8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbfCZS24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:56 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42284 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732881AbfCZS2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:53 -0400
Received: by mail-pf1-f201.google.com with SMTP id f67so12469631pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H3HRoHYDWMArQkaxv1MNV9sbVAN4QTLQDsX3m+S9eoU=;
        b=Cuvbwz8H/UPT74uyS/N/4qnzLflOCWavMy5nGUSyYS7YEzjkinR90BjdsCrgcJkE3I
         nx4KbkC9dnoe9GkBObKBMRpDYEdqno8HqIh6XA2YCeqV6CvG7JzzRNQF6q8pd5BERf2L
         RFxm3yO2wG89tTrr53Mp5FuBliWeQ+U4jl6R2mVmbyq/irL9EVf0dyxEQAXY+gsnOrUa
         sjp/qtKV1gEMDqiY5H2Ik89SIJ7l/HNOQiiyV055Dk+vHQVGGJnndcLvaKRB3EJIEJ7P
         b5O2WEtybYZzvX3/wEfbV1lJ62nVHR0Vg+h1YgKtbRZ41TCuXQBY+ohnhrP2W4Cl8SFS
         GMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H3HRoHYDWMArQkaxv1MNV9sbVAN4QTLQDsX3m+S9eoU=;
        b=jnKhZnZrGrt6pBB2jz3jAh5ZYhoFxR0fuaveYJ/JQiYZyVMMWOsJ7cqmL5hz4Qjffw
         Q4vpmo2BALPqDDrf6tHQnb+MYOqII1eMGAaAn9dUvCGGbZDKduEwSVKFzzcP3CyTSbUM
         uk2Mc0Qu10W3dI74kHze4SjTj5kPO18avjOHuVRu0Be3GaufBiczdH+Fw564Nv0vr7RU
         uSgEQsbAhMUVS7wuPUHerSKipN3EzFktLLjC6MdPqu1OHwwqCSnZultxPAjRVq4DH7UR
         4nyGNgqzOdUrB3yzfUe9cjAfa0lwKnqfdKniI95rn/vtbxwualP3A8zspjvFmo+9hMXu
         u/eg==
X-Gm-Message-State: APjAAAUmPl3SujxayNoTm1MXWk2EnBgr9J8WSqm8Wp4/2ZWq1YIVDLfH
        Ryo1YszD+1O3edMAo4V4PDatoJLrosSOFV87yX36bg==
X-Google-Smtp-Source: APXvYqwphmFpi3T6TN1vNeRaZ63APL0Md38wVERg+esYXiBHNy7zUZ/YoDtb9yiRRaTqqwrQlnsrIfBnrwPddl2w0CiOFw==
X-Received: by 2002:a63:f146:: with SMTP id o6mr29796370pgk.360.1553624932579;
 Tue, 26 Mar 2019 11:28:52 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:39 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 23/25] Lock down perf when in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow the use of certain perf facilities that might allow userspace to
access kernel data.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 kernel/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a30f732..6ad3d83c091c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10461,6 +10461,12 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
+	if ((attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    kernel_is_locked_down("PERF_SAMPLE_REGS_INTR",
+				  LOCKDOWN_CONFIDENTIALITY))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return -EPERM;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-- 
2.21.0.392.gf8f6787159e-goog

