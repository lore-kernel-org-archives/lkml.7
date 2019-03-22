Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6839AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DC62075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259635;
	bh=qq/bz6Z2MbVFsxKlh8biKRahJ9lsSxr8Ein4HVBI8JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JsJzEHmC7fKmtc5qvPR5WMEBeRpCLFy8ktjoMaa5mCQ4njCKXNtV9ZPOv8rzUEFk/
	 wokANZPO9gMwrrnAQQFHQHrnTRQHqleP5nBIqbM5OcKll80HBUNOFTYvqgzPUIeS2b
	 ASBe7cA3RdBCJB6+ydqAHHLumYJuUzUGb1CSb44s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbfCVNAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731412AbfCVLoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:44:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D7252075E;
        Fri, 22 Mar 2019 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255039;
        bh=qq/bz6Z2MbVFsxKlh8biKRahJ9lsSxr8Ein4HVBI8JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVJtfZDTz8DS6squF/fcV7pH0HJT9WPYLaNYbm2y1FWKqtM8Nzl5yP6OwMJCcTdvm
         U3RWSKb0hKETZTPEW0XtLRgmFCt0jz1jjxp6ag98zAM6unPlrHwDqRPn5wGVX50hIa
         Phe3M81PyKY/I6v+OnutQ/E+T7oStBBk9f3nznMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zev Weiss <zev@bewilderbeest.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 080/118] kernel/sysctl.c: add missing range check in do_proc_dointvec_minmax_conv
Date:   Fri, 22 Mar 2019 12:15:52 +0100
Message-Id: <20190322111222.344175860@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zev Weiss <zev@bewilderbeest.net>

commit 8cf7630b29701d364f8df4a50e4f1f5e752b2778 upstream.

This bug has apparently existed since the introduction of this function
in the pre-git era (4500e91754d3 in Thomas Gleixner's history.git,
"[NET]: Add proc_dointvec_userhz_jiffies, use it for proper handling of
neighbour sysctls.").

As a minimal fix we can simply duplicate the corresponding check in
do_proc_dointvec_conv().

Link: http://lkml.kernel.org/r/20190207123426.9202-3-zev@bewilderbeest.net
Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: <stable@vger.kernel.org>	[2.6.2+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sysctl.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2377,7 +2377,16 @@ static int do_proc_dointvec_minmax_conv(
 {
 	struct do_proc_dointvec_minmax_conv_param *param = data;
 	if (write) {
-		int val = *negp ? -*lvalp : *lvalp;
+		int val;
+		if (*negp) {
+			if (*lvalp > (unsigned long) INT_MAX + 1)
+				return -EINVAL;
+			val = -*lvalp;
+		} else {
+			if (*lvalp > (unsigned long) INT_MAX)
+				return -EINVAL;
+			val = *lvalp;
+		}
 		if ((param->min && *param->min > val) ||
 		    (param->max && *param->max < val))
 			return -EINVAL;


