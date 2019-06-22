Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58D5C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B4820820
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GvOCynNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfFVKSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:18:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60247 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfFVKSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:18:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MAIPNM2099144
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:18:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MAIPNM2099144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198706;
        bh=bYgHPItfFFDjImAJ/oIv3lH6aQ9oDyXmc6qOyUrF+wI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GvOCynNjx03QeWy6xEFqJHiyna6gWJsbb53VslB3lotDbAZmUiV1f0eowzb2xC9wZ
         PXB7PHIXHe1dRLBTKgy+vke8+/PUzZuPJyAUmIif55AZOGsjxhqHN0ol7XlHCAf09e
         +G+Mc5Nzz/nQv5OMp1cGc7+8skasg4ebuv1tq9biHbwKs3UwrE9UEJvC/+T7bW3Jbm
         xyYJRG0ruaWclooc+1nvjjz4QItUexx/Byu972bwK4Ai41HltYnu+E0SRFS03C8N4P
         8q8Q1j6Hkpkd9wmljEdWRFpJsJ8pcRTpY1MwaItSUdNXEVjR3zn7DAvtr52LqdnIZz
         yCwAJYAR+hkCw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MAIPGU2099141;
        Sat, 22 Jun 2019 03:18:25 -0700
Date:   Sat, 22 Jun 2019 03:18:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony W Wang-oc <tipbot@zytor.com>
Message-ID: <tip-f8c0e061cb83bd528ff0843e717bcebc846d4838@git.kernel.org>
Cc:     TonyWWang-oc@zhaoxin.com, hpa@zytor.com, tglx@linutronix.de,
        CooperYan@zhaoxin.com, gregkh@linuxfoundation.org, lenb@kernel.org,
        mingo@kernel.org, QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com,
        linux-kernel@vger.kernel.org, DavidWang@zhaoxin.com,
        rjw@rjwysocki.net
Reply-To: lenb@kernel.org, gregkh@linuxfoundation.org,
          CooperYan@zhaoxin.com, rjw@rjwysocki.net, DavidWang@zhaoxin.com,
          tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com, mingo@kernel.org,
          TonyWWang-oc@zhaoxin.com
In-Reply-To: <a370503660994669991a7f7cda7c5e98@zhaoxin.com>
References: <a370503660994669991a7f7cda7c5e98@zhaoxin.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/acpi/cstate: Add Zhaoxin processors support for
 cache flush policy in C3
Git-Commit-ID: f8c0e061cb83bd528ff0843e717bcebc846d4838
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

Commit-ID:  f8c0e061cb83bd528ff0843e717bcebc846d4838
Gitweb:     https://git.kernel.org/tip/f8c0e061cb83bd528ff0843e717bcebc846d4838
Author:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate: Tue, 18 Jun 2019 08:37:29 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:45:58 +0200

x86/acpi/cstate: Add Zhaoxin processors support for cache flush policy in C3

Same as Intel, Zhaoxin MP CPUs support C3 share cache and on all
recent Zhaoxin platforms ARB_DISABLE is a nop. So set related
flags correctly in the same way as Intel does.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "hpa@zytor.com" <hpa@zytor.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>
Cc: David Wang <DavidWang@zhaoxin.com>
Cc: "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>
Cc: "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>
Cc: "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Link: https://lkml.kernel.org/r/a370503660994669991a7f7cda7c5e98@zhaoxin.com

---
 arch/x86/kernel/acpi/cstate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index a5e5484988fd..caf2edccbad2 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -64,6 +64,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 		    c->x86_stepping >= 0x0e))
 			flags->bm_check = 1;
 	}
+
+	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
+		/*
+		 * All Zhaoxin CPUs that support C3 share cache.
+		 * And caches should not be flushed by software while
+		 * entering C3 type state.
+		 */
+		flags->bm_check = 1;
+		/*
+		 * On all recent Zhaoxin platforms, ARB_DISABLE is a nop.
+		 * So, set bm_control to zero to indicate that ARB_DISABLE
+		 * is not required while entering C3 type state.
+		 */
+		flags->bm_control = 0;
+	}
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
