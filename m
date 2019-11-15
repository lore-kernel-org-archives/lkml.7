Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FEDC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48DF2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573798921;
	bh=84h4FQt6SJOXzFlgVAQq65w3ASczpQabMyKt2XJ2IA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zN2mq2b0OOk9J72I0OvieT9C1JTYJ7adKhflE6Z9MxUB7K9cjGTFtB8YgMMor8sZh
	 WMTbfAo1AU+U277jxpTnnxx16GjnA2in+yUqU96B00GRNdxdFiM9pXDJihKHm5g8cT
	 9lKm8KmEbCPU896S5hPTkv201RbXtYmtwZBUzy78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfKOGWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:22:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbfKOGV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:21:57 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E0BC2073B;
        Fri, 15 Nov 2019 06:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798916;
        bh=84h4FQt6SJOXzFlgVAQq65w3ASczpQabMyKt2XJ2IA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJGv+B4PdIpRcuQFWHlnVDVEoBQMvtdcI7tLbxUK31lmMcCyi7T2IsyXxKU9RI3RS
         jowgsEQQqTNaBrcKZ0wp/mN5LVW5XlVMSmCRbmtagOH+8EO/ST+NrSaN3BiOk901CA
         J8Lbky8ZuDo2FCRpAQcSJjWkiubt+sTEgb2coTrg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neelima Krishnan <neelima.krishnan@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 10/31] x86/speculation/taa: Add sysfs reporting for TSX Async Abort
Date:   Fri, 15 Nov 2019 14:20:39 +0800
Message-Id: <20191115062013.337944928@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115062009.813108457@linuxfoundation.org>
References: <20191115062009.813108457@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit 6608b45ac5ecb56f9e171252229c39580cc85f0f upstream.

Add the sysfs reporting file for TSX Async Abort. It exposes the
vulnerability and the mitigation state similar to the existing files for
the other hardware vulnerabilities.

Sysfs file path is:
/sys/devices/system/cpu/vulnerabilities/tsx_async_abort

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   23 +++++++++++++++++++++++
 drivers/base/cpu.c         |    9 +++++++++
 include/linux/cpu.h        |    3 +++
 3 files changed, 35 insertions(+)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1418,6 +1418,21 @@ static ssize_t mds_show_state(char *buf)
 		       sched_smt_active() ? "vulnerable" : "disabled");
 }
 
+static ssize_t tsx_async_abort_show_state(char *buf)
+{
+	if ((taa_mitigation == TAA_MITIGATION_TSX_DISABLED) ||
+	    (taa_mitigation == TAA_MITIGATION_OFF))
+		return sprintf(buf, "%s\n", taa_strings[taa_mitigation]);
+
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+		return sprintf(buf, "%s; SMT Host state unknown\n",
+			       taa_strings[taa_mitigation]);
+	}
+
+	return sprintf(buf, "%s; SMT %s\n", taa_strings[taa_mitigation],
+		       sched_smt_active() ? "vulnerable" : "disabled");
+}
+
 static char *stibp_state(void)
 {
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
@@ -1483,6 +1498,9 @@ static ssize_t cpu_show_common(struct de
 	case X86_BUG_MDS:
 		return mds_show_state(buf);
 
+	case X86_BUG_TAA:
+		return tsx_async_abort_show_state(buf);
+
 	default:
 		break;
 	}
@@ -1519,4 +1537,9 @@ ssize_t cpu_show_mds(struct device *dev,
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_MDS);
 }
+
+ssize_t cpu_show_tsx_async_abort(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_TAA);
+}
 #endif
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -537,12 +537,20 @@ ssize_t __weak cpu_show_mds(struct devic
 	return sprintf(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_tsx_async_abort(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
 static DEVICE_ATTR(spec_store_bypass, 0444, cpu_show_spec_store_bypass, NULL);
 static DEVICE_ATTR(l1tf, 0444, cpu_show_l1tf, NULL);
 static DEVICE_ATTR(mds, 0444, cpu_show_mds, NULL);
+static DEVICE_ATTR(tsx_async_abort, 0444, cpu_show_tsx_async_abort, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -551,6 +559,7 @@ static struct attribute *cpu_root_vulner
 	&dev_attr_spec_store_bypass.attr,
 	&dev_attr_l1tf.attr,
 	&dev_attr_mds.attr,
+	&dev_attr_tsx_async_abort.attr,
 	NULL
 };
 
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -56,6 +56,9 @@ extern ssize_t cpu_show_l1tf(struct devi
 			     struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_mds(struct device *dev,
 			    struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_tsx_async_abort(struct device *dev,
+					struct device_attribute *attr,
+					char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,


