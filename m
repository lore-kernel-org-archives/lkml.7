Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8947C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBD120879
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582349;
	bh=LyI094+zkmHeEY3UHBwOkO7Ui4LxtSUMsFrTUROdVqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ERK1/8e0fhbASOiLWFrwvvWmDXAxiIjhNbZjWeleNvlYNVHxqCFngXM2f+/NSVmn4
	 KwDmz8d5FFuqr7aGWWTdeMYAqsNb6BmSAygJpc5ZwAhrArF7PRH+BgVyqVXMm9/LDp
	 HirMEXCNn2a54IjwZRVaC3CcNFI032IQ1Y4Fa8MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbfCZGjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732620AbfCZGjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:39:05 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B431A2087C;
        Tue, 26 Mar 2019 06:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582344;
        bh=LyI094+zkmHeEY3UHBwOkO7Ui4LxtSUMsFrTUROdVqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtVV2bHIgoMG3cSb2uwY3H7/YIswzY93CXL4BQN/EcKeU535MCR7z9yl14KgNR6iq
         7kC9w9n7orDgYaMJKRVnKe2f2iHXGj15GbVpS7+Hbr4Hs9pBB1chkzMuaNgt7W0xKx
         E1v/GvDD9p94bX6gYuRbWKvRf0KRz3gB8ZxxDtRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vassili Karpov <moosotc@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.0 27/52] objtool: Move objtool_file struct off the stack
Date:   Tue, 26 Mar 2019 15:30:14 +0900
Message-Id: <20190326042702.309899847@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 0c671812f152b628bd87c0af49da032cc2a2c319 upstream.

Objtool uses over 512k of stack, thanks to the hash table embedded in
the objtool_file struct.  This causes an unnecessarily large stack
allocation and breaks users with low stack limits.

Move the struct off the stack.

Fixes: 042ba73fe7eb ("objtool: Add several performance improvements")
Reported-by: Vassili Karpov <moosotc@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/df92dcbc4b84b02ffa252f46876df125fb56e2d7.1552954176.git.jpoimboe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2184,9 +2184,10 @@ static void cleanup(struct objtool_file
 	elf_close(file->elf);
 }
 
+static struct objtool_file file;
+
 int check(const char *_objname, bool orc)
 {
-	struct objtool_file file;
 	int ret, warnings = 0;
 
 	objname = _objname;


