Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183B7C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D3821835
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576529272;
	bh=zLDuk+iqG/QwoL1dVSRWMOwgNWBx3OEn0K7EFUh877k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DTY+novM9H8G1nkgSAryEGZ8G7Gsr/18J5HSlW6QCA9Fc+pvlhA7ZAhDGDoROggf8
	 QuhzO31JlEV7zIwb0kMD09rFzOHgfWgWoqNEsHEZsMaAKdNWGCL/GDxMvJwT89lFq5
	 Whh2a4MWOnhBAG93qzuUmh/UNIjSLskQVQ80Xugs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfLPUrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLPUrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:47:49 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940E3218AC;
        Mon, 16 Dec 2019 20:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576529269;
        bh=zLDuk+iqG/QwoL1dVSRWMOwgNWBx3OEn0K7EFUh877k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrKmQkqSIefuhnUgxJ63AQgqhkfLiXLfHOb6xyWaW9mnmJAwDwk9Tj5YZjpZyD5F/
         ehHopTUvgHH+eh0naKIiwIE3SJ/Q9NbDyIePPfyCNpgBdxtAWRJcVl8wqfDj8/LCfY
         mjT4Dz79NsWGvsI4Xd4jewQgXQc8SrLopJKZD8TM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 1/9] tools headers kvm: Sync linux/kvm.h with the kernel sources
Date:   Mon, 16 Dec 2019 17:47:30 -0300
Message-Id: <20191216204738.12107-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
References: <20191216204738.12107-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  22945688acd4 ("KVM: PPC: Book3S HV: Support reset of secure guest")

No tools changes are caused by this, as the only defines so far used
from these files are for syscall arg pretty printing are:

  $ grep KVM tools/perf/trace/beauty/*.sh
  tools/perf/trace/beauty/kvm_ioctl.sh:regex='^#[[:space:]]*define[[:space:]]+KVM_(\w+)[[:space:]]+_IO[RW]*\([[:space:]]*KVMIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
  $

This addresses these tools/perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Bharata B Rao <bharata@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Link: https://lkml.kernel.org/n/tip-bdbe4x02johhul05a03o27zj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index e6f17c8e2dba..f0a16b4adbbd 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1348,6 +1348,7 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_char)
 /* Available with KVM_CAP_PMU_EVENT_FILTER */
 #define KVM_SET_PMU_EVENT_FILTER  _IOW(KVMIO,  0xb2, struct kvm_pmu_event_filter)
+#define KVM_PPC_SVM_OFF		  _IO(KVMIO,  0xb3)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.21.0

