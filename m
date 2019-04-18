Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FFB218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610805;
	bh=NdzKe5BDkBRIabUE+og0H+eosUElUxR8hVa0HSawUPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fMVTBh4sUbn6gB+g03km2YgLri0bumOdIQnKPziDMzOX0XrhIqlogAK3mSgV+z8ty
	 KV/xaDHIRBimM8+07qdjTpgfRlQab7sJb1SWRQLzliyqSXKPJyF+8O913K00UP4tId
	 wHfDQPPjRBbSGajSTgI0LofkPfC4M5OXGVM/YJM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391161AbfDRSGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391139AbfDRSGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1517206B6;
        Thu, 18 Apr 2019 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610800;
        bh=NdzKe5BDkBRIabUE+og0H+eosUElUxR8hVa0HSawUPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBxNInE+PKdGjL7Nv4JQ81QNQMuCxJotKdqQ71YLeGcu/EPURGDMIFq8IwlAPuX3g
         xIw1eUPZxOHr/XzdVwCzw2jQ+zxA7jWtDlk0Pf6uTtwjQErasSHGRst4LGwlCD/lKe
         gPJQkfPS4Q6DG73hkYduZMkQmO4tc9cP2vn89sJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 89/92] bpf: Fix selftests are changes for CVE 2019-7308
Date:   Thu, 18 Apr 2019 19:57:47 +0200
Message-Id: <20190418160438.269695961@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balbir Singh <sblbir@amzn.com>

The changes to fix the CVE 2019-7308 make the bpf verifier stricter
with respect to operations that were allowed earlier in unprivileged
mode. Fixup the test cases so that the error messages now correctly
reflect pointer arithmetic going out of range for tests.

Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/test_verifier.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1860,6 +1860,7 @@ static struct bpf_test tests[] = {
 		},
 		.result = REJECT,
 		.errstr = "invalid stack off=-79992 size=8",
+		.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
 	},
 	{
 		"PTR_TO_STACK store/load - out of bounds high",
@@ -2243,6 +2244,8 @@ static struct bpf_test tests[] = {
 			BPF_EXIT_INSN(),
 		},
 		.result = ACCEPT,
+		.result_unpriv = REJECT,
+		.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
 	},
 	{
 		"unpriv: cmp of stack pointer",
@@ -7013,6 +7016,7 @@ static struct bpf_test tests[] = {
 		},
 		.fixup_map1 = { 3 },
 		.errstr = "pointer offset 1073741822",
+		.errstr_unpriv = "R0 pointer arithmetic of map value goes out of range",
 		.result = REJECT
 	},
 	{
@@ -7034,6 +7038,7 @@ static struct bpf_test tests[] = {
 		},
 		.fixup_map1 = { 3 },
 		.errstr = "pointer offset -1073741822",
+		.errstr_unpriv = "R0 pointer arithmetic of map value goes out of range",
 		.result = REJECT
 	},
 	{
@@ -7203,6 +7208,7 @@ static struct bpf_test tests[] = {
 			BPF_EXIT_INSN()
 		},
 		.errstr = "fp pointer offset 1073741822",
+		.errstr_unpriv = "R1 stack pointer arithmetic goes out of range",
 		.result = REJECT
 	},
 	{


