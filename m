Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18596C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63242089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfJKWkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 18:40:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37830 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfJKWkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 18:40:13 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1iJ3a0-0005jY-6Z
        for linux-kernel@vger.kernel.org; Fri, 11 Oct 2019 22:40:12 +0000
Received: by mail-pg1-f198.google.com with SMTP id 195so1923233pgc.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 15:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bFQOsU0Yw2SX6audeMgxRQZjWA+ky677CyE7FshJP3k=;
        b=F+6unRpTEA1ThIXznLayrpA14n4fWx6OfIhzq+kXt6nCJGLGrNFWtnI87fgByz03MW
         yJQvv1VL1Mmxu/xfWW7iHtIl0VKd9w9AwKJbOD1OA0Sl18qB8P3foA7lamQ833pbLAGf
         Dp3WND0MmaPM6FDxsahxeoPue387X9HkBNKSWmDPf8UwmUGrxILnvlat6re2Xk5UXBRj
         Jan2miiH4QF5Gt0p6KhLiI1lHe1jRkFkLl67t7kyVM+GvrPTaUHc+nq539NFgOd5JRgn
         baadEm/AmD7xHZBlqJqSVUTe0qszvFJAW3o7y02w+SF5Di/aqRgzwf4qj9JO6k3IQUHa
         I15A==
X-Gm-Message-State: APjAAAWbmx3CsFBib/UwCM7JL5U8MfgAGScb7b7zGXjMU/t8XoEYCtdz
        iyIHuvgyxmUnNSpuj4Bn6f3WfrmDar30dF55MxwhDGfoE9bb9perujy7A+dUl7lXny/ts7ZPTv+
        6um3xNi3Cz2iREZo0gyl9Un2vEMVDeKUFmTLEZV6oJA==
X-Received: by 2002:a17:90a:cb88:: with SMTP id a8mr20411311pju.85.1570833610433;
        Fri, 11 Oct 2019 15:40:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyooSuvk39320EB5pXd8iQc4RdUqGq6tYyCPa/eZWG8r9ggKLSkR6rfbGDRKVfzLQEAMCAGKw==
X-Received: by 2002:a17:90a:cb88:: with SMTP id a8mr20411269pju.85.1570833610073;
        Fri, 11 Oct 2019 15:40:10 -0700 (PDT)
Received: from localhost (201-92-249-168.dsl.telesp.net.br. [201.92.249.168])
        by smtp.gmail.com with ESMTPSA id 7sm8656370pgj.35.2019.10.11.15.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 15:40:09 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-mm@kvack.org
Cc:     mike.kravetz@oracle.com, linux-kernel@vger.kernel.org,
        jay.vosburgh@canonical.com, gpiccoli@canonical.com,
        kernel@gpiccoli.net
Subject: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages creation
Date:   Fri, 11 Oct 2019 19:39:55 -0300
Message-Id: <20191011223955.1435-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are 2 ways for setting HugeTLB hugepages in kernel; either
users pass parameters on kernel command-line or they can write to sysfs
files (which is effectively the sysctl way).

Kdump kernels won't benefit from hugepages - in fact it's quite opposite,
it may be the case hugepages on kdump kernel can lead to OOM if kernel
gets unable to allocate demanded pages due to the fact the preallocated
hugepages are consuming a lot of memory.

This patch proposes a new kernel parameter to prevent the creation of
HugeTLB hugepages - we currently don't have a way to do that. We can
even have kdump scripts removing the kernel command-line options to
set hugepages, but it's not straightforward to prevent sysctl/sysfs
configuration, given it happens in later boot or anytime when the
system is running.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---

About some decisions took in this patch:

* early_param() was used because I couldn't find a way to enforce
parameters' ordering when using __setup(), and we need nohugepages
processed before all other hugepages options.

* The return when sysctl handler is prevented to progress due to
nohugepages is -EINVAL, but could be changed; I've just followed
present code there, but I'm OK changing that if we have suggestions.

Thanks in advance for the review!
Cheers,


Guilherme

 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 mm/hugetlb.c                                    | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c7ac2f3ac99f..eebe0e7b30cf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2982,6 +2982,10 @@
 
 	nohugeiomap	[KNL,x86,PPC] Disable kernel huge I/O mappings.
 
+	nohugepages	[KNL] Disable HugeTLB hugepages completely, preventing
+			its setting either by kernel parameter or sysfs;
+			useful specially in kdump kernel.
+
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ef37c85423a5..a6c7a68152e5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -43,6 +43,7 @@
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
+static int disable_hugepages;
 /*
  * Minimum page order among possible hugepage sizes, set to a proper value
  * at boot time.
@@ -2550,6 +2551,9 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 	int err;
 	nodemask_t nodes_allowed, *n_mask;
 
+	if (disable_hugepages)
+		return -EINVAL;
+
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return -EINVAL;
 
@@ -2978,6 +2982,9 @@ static int __init hugetlb_nrpages_setup(char *s)
 	unsigned long *mhp;
 	static unsigned long *last_mhp;
 
+	if (disable_hugepages)
+		return 1;
+
 	if (!parsed_valid_hugepagesz) {
 		pr_warn("hugepages = %s preceded by "
 			"an unsupported hugepagesz, ignoring\n", s);
@@ -3022,6 +3029,15 @@ static int __init hugetlb_default_setup(char *s)
 }
 __setup("default_hugepagesz=", hugetlb_default_setup);
 
+static int __init nohugepages_setup(char *str)
+{
+	disable_hugepages = 1;
+	pr_info("HugeTLB: hugepages disabled by kernel parameter\n");
+
+	return 0;
+}
+early_param("nohugepages", nohugepages_setup);
+
 static unsigned int cpuset_mems_nr(unsigned int *array)
 {
 	int node;
-- 
2.23.0

