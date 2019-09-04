Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369C6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDE923402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620209;
	bh=KyYFRC2YPlV7RJJS1Qd06yJJTT56vE789LqQGqj3ijE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kKOzHXVlMthKzZ3V0ICIFJ9q4MzPSOP+sA1VCv/SGcesLVuxd5Jhvk9dKG+sN2ODm
	 ByQ8k8CVgTmy2iUT7Rp704TR5c2hUBWfF03YHCSuujvm6D6xvxm/zz4DuZpBG543c+
	 Eg339E87z0dvv5OGAFuNcwYRuBpbAPo19Tcj44Wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbfIDSD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388934AbfIDSD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:03:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED20523400;
        Wed,  4 Sep 2019 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620206;
        bh=KyYFRC2YPlV7RJJS1Qd06yJJTT56vE789LqQGqj3ijE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l77NWAKcb7ImgOMPnuywIqQcPi+k6wJHBlemkOUgnJWGeMCbf05CRApqDdq60SXqf
         bKLo/Uugn1fe9wseSOgDqtBTHrNqEE5lGD26/mxLaK4Yhu+q9GJgWT56cpncFftsmh
         xXPtiSKeP+Gntn15QGb3dqsHwA4jilf8P1aoAIas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 29/57] ftrace: Check for successful allocation of hash
Date:   Wed,  4 Sep 2019 19:53:57 +0200
Message-Id: <20190904175304.759175558@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175301.777414715@linuxfoundation.org>
References: <20190904175301.777414715@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

commit 5b0022dd32b7c2e15edf1827ba80aa1407edf9ff upstream.

In register_ftrace_function_probe(), we are not checking the return
value of alloc_and_copy_ftrace_hash(). The subsequent call to
ftrace_match_records() may end up dereferencing the same. Add a check to
ensure this doesn't happen.

Link: http://lkml.kernel.org/r/26e92574f25ad23e7cafa3cf5f7a819de1832cbe.1562249521.git.naveen.n.rao@linux.vnet.ibm.com

Cc: stable@vger.kernel.org
Fixes: 1ec3a81a0cf42 ("ftrace: Have each function probe use its own ftrace_ops")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ftrace.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4390,6 +4390,11 @@ register_ftrace_function_probe(char *glo
 	old_hash = *orig_hash;
 	hash = alloc_and_copy_ftrace_hash(FTRACE_HASH_DEFAULT_BITS, old_hash);
 
+	if (!hash) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	ret = ftrace_match_records(hash, glob, strlen(glob));
 
 	/* Nothing found? */


