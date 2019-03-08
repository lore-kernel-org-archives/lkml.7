Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE36C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DBE20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050041;
	bh=8F4AalCUPH8qygl8D1NQHBuNxMKxtS/RyhokzLwoG2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNQXT0NL3f5u7R8bsOlp/h2G5lf/w+lWkow87Md4jaxcUpo8zu+aW9ytznrliIe2+
	 Aycthpw3eeoQSwYSYzit3bRMYgAT4+4fnKrSU4qAT0Jnr2T6I22VQEN+x/S74PAfyt
	 hVOA4/thusMlmj2HhuzKVksyegbNS8j/f7YhSO3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfCHNAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:00:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfCHNAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:00:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75BB820811;
        Fri,  8 Mar 2019 13:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050036;
        bh=8F4AalCUPH8qygl8D1NQHBuNxMKxtS/RyhokzLwoG2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlBmkyfIKePe61QEsM/Z2MZCqqps/R2/EXkB6oQ+0vc7ri+nU6DuQF3qzqm6JnrfC
         jDY3RtrkVCWbVvkgr7yf2Z7TMHHnGx5lYNyE41dhR3e8Nc31h1KOQotER14RfqJE5v
         BSi/OkaGjg0MkBDVkDJDNfTqASOtRXL2Y4/B1qh8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.19 63/68] selftests: firmware: fix verify_reqs() return value
Date:   Fri,  8 Mar 2019 13:50:33 +0100
Message-Id: <20190308124913.668799042@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

From: Luis Chamberlain <mcgrof@kernel.org>

commit 344c0152d878922365464b7140c74c2a5e073d99 upstream.

commit a6a9be9270c87 ("selftests: firmware: return Kselftest Skip code
for skipped tests") by Shuah modified failures to return the special
error code of $ksft_skip (4). We have a corner case issue where we
*do* want to verify_reqs().

Cc: <stable@vger.kernel.org> # >= 4.18
Fixes: a6a9be9270c87 ("selftests: firmware: return Kselftest Skip code for for skipped tests")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/firmware/fw_lib.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -91,7 +91,7 @@ verify_reqs()
 	if [ "$TEST_REQS_FW_SYSFS_FALLBACK" = "yes" ]; then
 		if [ ! "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
 			echo "usermode helper disabled so ignoring test"
-			exit $ksft_skip
+			exit 0
 		fi
 	fi
 }


