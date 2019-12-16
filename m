Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B2EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3E52064B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfLPKjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:39:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:55326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727319AbfLPKjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:39:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D08FABF4;
        Mon, 16 Dec 2019 10:39:37 +0000 (UTC)
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH v2] x86-64/entry: add instruction suffix to SYSRET
To:     Andy Lutomirski <luto@kernel.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Message-ID: <038a7c35-062b-a285-c6d2-653b56585844@suse.com>
Date:   Mon, 16 Dec 2019 11:40:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ignore_sysret contains an unsuffixed 'sysret' instruction.  gas
correctly interprets this as sysretl, but leaving it up to gas to
guess when there is no register operand that implies a size is bad
practice, and upstream gas is likely to warn about this in the future.
Use 'sysretl' explicitly.  This does not change the assembled output.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
v2: Use re-written description from Andy.

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1728,7 +1728,7 @@ END(nmi)
 SYM_CODE_START(ignore_sysret)
 	UNWIND_HINT_EMPTY
 	mov	$-ENOSYS, %eax
-	sysret
+	sysretl
 SYM_CODE_END(ignore_sysret)
 #endif
 
