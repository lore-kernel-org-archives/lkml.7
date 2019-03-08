Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28A7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33EA20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050485;
	bh=tClcOF43QhFDFE5HDL0EU9dQMb+JlHjZtLDBMHWdrGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PZN3IN5ONy4RI18WlLNc9G5dG3SRBrMjK7Mks4fQFN5CmjQCU6B63lBHx5fp72pE5
	 TJjX99R3yA7xUq2TLXyIncluXFyk6OaqIubzliRWU+/2AEknDez/T5oHPWjXd9D26G
	 gK+MEzomM4JMigO+bviRHMFFDU6DnF0H5cnQ1wg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfCHMxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfCHMxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:53:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E09C20684;
        Fri,  8 Mar 2019 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049603;
        bh=tClcOF43QhFDFE5HDL0EU9dQMb+JlHjZtLDBMHWdrGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fk1AV9z6SGKfWhUg4YMPQiSGte/ujjxBJVDDfwLRQr22RPp9r0dN5xCjBxMcSkOP0
         YOVtI/UUf3+Zox31xrT6h6cMQ6cFBujGyXeuH1ibIvutEpAEKnHFoWmC58j+MU3KEy
         eYdlfxBeyvG5dGH6iuX3omoN9BrHP08FEyGEqiAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 5.0 43/46] selftests: firmware: fix verify_reqs() return value
Date:   Fri,  8 Mar 2019 13:50:16 +0100
Message-Id: <20190308124905.013568662@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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


