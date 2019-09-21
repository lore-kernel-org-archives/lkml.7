Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26304C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 03:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F016A217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 03:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfIUDLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 23:11:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46996 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfIUDLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 23:11:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBVnp-0007l7-Nf; Sat, 21 Sep 2019 03:11:18 +0000
Date:   Sat, 21 Sep 2019 04:11:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] microoptimizing hlist_add_{before,behind}
Message-ID: <20190921031117.GA22426@ZenIV.linux.org.uk>
References: <20190920231233.GP1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920231233.GP1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2019 at 12:12:33AM +0100, Al Viro wrote:
> 	Neither hlist_add_before() nor hlist_add_behind() should ever
> be called with both arguments pointing to the same hlist_node.
> However, gcc doesn't know that, so it ends up with pointless reloads.
> AFAICS, the following generates better code, is obviously equivalent
> in case when arguments are different and actually even in case when
> they are same, the end result is identical (if the hlist hadn't been
> corrupted even earlier than that).
> 
> 	Objections?
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

*gyah*

git diff >/tmp/y1
<build>
<fix a braino>
<test>
scp-out /tmp/y1
<send mail with the original diff>
<several hours later: reread the sent mail>

My apologies ;-/  Correct diff follows:

diff --git a/include/linux/list.h b/include/linux/list.h
index 85c92555e31f..5c84383675bc 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -793,21 +793,21 @@ static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 static inline void hlist_add_before(struct hlist_node *n,
 					struct hlist_node *next)
 {
-	n->pprev = next->pprev;
+	struct hlist_node **p = n->pprev = next->pprev;
 	n->next = next;
 	next->pprev = &n->next;
-	WRITE_ONCE(*(n->pprev), n);
+	WRITE_ONCE(*p, n);
 }
 
 static inline void hlist_add_behind(struct hlist_node *n,
 				    struct hlist_node *prev)
 {
-	n->next = prev->next;
+	struct hlist_node *p = n->next = prev->next;
 	prev->next = n;
 	n->pprev = &prev->next;
 
-	if (n->next)
-		n->next->pprev  = &n->next;
+	if (p)
+		p->pprev  = &n->next;
 }
 
 /* after that we'll appear to be on some hlist and hlist_del will work */
