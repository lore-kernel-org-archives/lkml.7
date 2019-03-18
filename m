Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE26C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4301D2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902123;
	bh=x+kC1OEIt1L2YBCLpo16nz0Tll3Vd7dpPtOIuXjZGwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nWWeDQT8ypS8Nu9j0/JvH6xmOTWk62tHGHNNHTJU7h0igRaNtEzQKY5ksQrLn9TKt
	 yXKb88bS+rcakr0wf2DUf5QE/VBp4jMTQ5QgTdNimR5HDjhNwRWhg7pMzrQVmQeTJ3
	 nZ0ZRWRnXxDG3vMVAFjlg72SM4g9Pw7UJ3CFo78M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfCRJmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbfCRJd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:33:28 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D3D2175B;
        Mon, 18 Mar 2019 09:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901608;
        bh=x+kC1OEIt1L2YBCLpo16nz0Tll3Vd7dpPtOIuXjZGwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BavhWlwe/Q6OuJeRLtc7ElQLFgMookGy1tNq+AhoVR10QWojz16Ad+TI2drJzeyEr
         Upupoy61Y1txKdplPhehcG6C9GLA3L5l+zwufMSumlxoR6uCUgXHncX4Tnvx0b6YgD
         hYpVbJRRZL2kC5DrWcTe35teN5C1+FP2muwIa/Zs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, kbuild-all@01.org,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 4.19 47/52] perf/x86/intel: Make dev_attr_allow_tsx_force_abort static
Date:   Mon, 18 Mar 2019 10:25:44 +0100
Message-Id: <20190318084019.078727631@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: kbuild test robot <lkp@intel.com>

commit c634dc6bdedeb0b2c750fc611612618a85639ab2 upstream.

Fixes: 400816f60c54 ("perf/x86/intel: Implement support for TSX Force Abort")
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: kbuild-all@01.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190313184243.GA10820@lkp-sb-ep06
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3989,7 +3989,7 @@ static struct attribute *intel_pmu_caps_
        NULL
 };
 
-DEVICE_BOOL_ATTR(allow_tsx_force_abort, 0644, allow_tsx_force_abort);
+static DEVICE_BOOL_ATTR(allow_tsx_force_abort, 0644, allow_tsx_force_abort);
 
 static struct attribute *intel_pmu_attrs[] = {
 	&dev_attr_freeze_on_smi.attr,


