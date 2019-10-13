Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7E1C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 18:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F19206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 18:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfJMS5r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 14:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbfJMS5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 14:57:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25CC4206A3;
        Sun, 13 Oct 2019 18:57:46 +0000 (UTC)
Date:   Sun, 13 Oct 2019 14:57:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDg8K2bmln?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [for-linus][PATCH 08/11] recordmcount: Fix nop_mcount()
 function
Message-ID: <20191013145743.6fdef005@gandalf.local.home>
In-Reply-To: <20191013174419.228868312@goodmis.org>
References: <20191013174342.381019558@goodmis.org>
        <20191013174419.228868312@goodmis.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One problem with quilt, is that it doesn't like non-ASCII characters
(I'm looking at you Kleine-König!)

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The removal of the longjmp code in recordmcount.c mistakenly made the
return of make_nop() being negative an exit of nop_mcount(). It should
not exit the routine, but instead just not process that part of the
code. By exiting with an error code, it would cause the update of
recordmcount to fail some files which would fail the build if ftrace
function tracing was enabled.

Link: http://lkml.kernel.org/r/20191009110538.5909fec6@gandalf.local.home

Reported-by: Uwe Kleine-önig <u.kleine-koenig@pengutronix.de>
Tested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Fixes: 3f1df12019f3 ("recordmcount: Rewrite error/success handling")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/recordmcount.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 8f0a278ce0af..74eab03e31d4 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -389,11 +389,8 @@ static int nop_mcount(Elf_Shdr const *const relhdr,
 			mcountsym = get_mcountsym(sym0, relp, str0);
 
 		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
-			if (make_nop) {
+			if (make_nop)
 				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + _w(relp->r_offset));
-				if (ret < 0)
-					return -1;
-			}
 			if (warn_on_notrace_sect && !once) {
 				printf("Section %s has mcount callers being ignored\n",
 				       txtname);
-- 
2.23.0

