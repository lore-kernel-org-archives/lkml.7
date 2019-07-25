Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09153C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF77522C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="a/dwFcy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfGYOUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:20:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60299 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfGYOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:20:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEKTFZ1037068
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:20:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEKTFZ1037068
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064429;
        bh=82rKiENCDsGj2FgA5qfJGDDT1uO+iPGOUvxfxJCxzXQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=a/dwFcy8pCpUagubJHIMkpgZkLqVwdz0Rq5UR4RanDT9k5OsODJ+B5IppZHdZuGP/
         N4B8kicE80wrROGHeGjXJ0HP+UXW1TWBQvyfp9Fnl7WFgXwn1IWdp/+lgkXeIUvpGF
         j3MugxIhmu6uy4PyQpD+hDBBHp4c9f+EjtRPy6fsQax9+UD3MZp/De23ws9KCxgQY2
         AZ7gLonpCnhcZh732bQ05IYKltUyPmOzgUP2tZ++uDXnrVQxToLxxTif6Yu3BcOj8Q
         0CELZ0e7AtwKsz/Ihu2P3rKWKW07c/Z0hQICxL7PM55IcNOUyM4lBHbOTtNXKjdu1R
         CQhk0MdQaVl6g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEKTWm1037065;
        Thu, 25 Jul 2019 07:20:29 -0700
Date:   Thu, 25 Jul 2019 07:20:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2591bc4e8d70b4e1330d327fb7e3921f4e070a51@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, peterz@infradead.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190722105218.855189979@linutronix.de>
References: <20190722105218.855189979@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/kgbd: Use NMI_VECTOR not APIC_DM_NMI
Git-Commit-ID: 2591bc4e8d70b4e1330d327fb7e3921f4e070a51
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2591bc4e8d70b4e1330d327fb7e3921f4e070a51
Gitweb:     https://git.kernel.org/tip/2591bc4e8d70b4e1330d327fb7e3921f4e070a51
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:06 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:56 +0200

x86/kgbd: Use NMI_VECTOR not APIC_DM_NMI

apic->send_IPI_allbutself() takes a vector number as argument.

APIC_DM_NMI is clearly not a vector number. It's defined to 0x400 which is
outside the vector space.

Use NMI_VECTOR instead as that's what it is intended to be.

Fixes: 82da3ff89dc2 ("x86: kgdb support")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105218.855189979@linutronix.de

---
 arch/x86/kernel/kgdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 23297ea64f5f..a53dfb09880f 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -416,7 +416,7 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
  */
 void kgdb_roundup_cpus(void)
 {
-	apic->send_IPI_allbutself(APIC_DM_NMI);
+	apic->send_IPI_allbutself(NMI_VECTOR);
 }
 #endif
 
