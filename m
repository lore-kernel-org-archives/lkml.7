Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31AFC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7864421849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XIi8auNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391077AbfGRTMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:12:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRTMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:12:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJCgBP2124635
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:12:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJCgBP2124635
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477162;
        bh=XeELLpANJD7y2xcl8rQltNZA6wli/dVIt+REvEssjrM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XIi8auNdw8+mRudSKCslJRaNrY2zme4/vySEtV5BL4OWbTbhHCEn2x2Z3wfOngSdc
         SnLYAC4Yoj9oNqEUT0lpLxW07qKezpGMBNZuxVr37L30+zrDamvWTD2KktdShvcpjn
         g9pV7FG+cItV+L1kqnVty/86nIjRSIwN+Yh+d3RyffK0j4KXXq+Ixs14P6KfV/9ncU
         oXP+ZbcBxqNa1s7Bo8loy5L2rHCkYIJsdaZSfVmh5TTVZ3kv14THfctIVC7C8/dlOy
         d+6ZjWb7oT7/VHDzsi3qAQIm8C/Q/gJCYdfG2eKLb7JcjT8MMOMERex1eFMbtn3jB1
         DtfpCwciAs62A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJCfsg2124632;
        Thu, 18 Jul 2019 12:12:41 -0700
Date:   Thu, 18 Jul 2019 12:12:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-5e307a6bc7b600999742675dd182bcb8a6fe308e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, jpoimboe@redhat.com,
          peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <8e13d6f0da1c8a3f7603903da6cbf6d582bbfe10.1563413318.git.jpoimboe@redhat.com>
References: <8e13d6f0da1c8a3f7603903da6cbf6d582bbfe10.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] x86/uaccess: Don't leak AC flag into fentry from
 mcsafe_handle_tail()
Git-Commit-ID: 5e307a6bc7b600999742675dd182bcb8a6fe308e
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

Commit-ID:  5e307a6bc7b600999742675dd182bcb8a6fe308e
Gitweb:     https://git.kernel.org/tip/5e307a6bc7b600999742675dd182bcb8a6fe308e
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:43 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:05 +0200

x86/uaccess: Don't leak AC flag into fentry from mcsafe_handle_tail()

After adding mcsafe_handle_tail() to the objtool uaccess safe list,
objtool reports:

  arch/x86/lib/usercopy_64.o: warning: objtool: mcsafe_handle_tail()+0x0: call to __fentry__() with UACCESS enabled

With SMAP, this function is called with AC=1, so it needs to be careful
about which functions it calls.  Disable the ftrace entry hook, which
can potentially pull in a lot of extra code.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/8e13d6f0da1c8a3f7603903da6cbf6d582bbfe10.1563413318.git.jpoimboe@redhat.com

---
 arch/x86/lib/usercopy_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index e0e006f1624e..fff28c6f73a2 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -60,7 +60,7 @@ EXPORT_SYMBOL(clear_user);
  * but reuse __memcpy_mcsafe in case a new read error is encountered.
  * clac() is handled in _copy_to_iter_mcsafe().
  */
-__visible unsigned long
+__visible notrace unsigned long
 mcsafe_handle_tail(char *to, char *from, unsigned len)
 {
 	for (; len; --len, to++, from++) {
