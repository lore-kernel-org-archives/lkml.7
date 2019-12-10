Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9D920663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfLJKsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:48:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:45536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726957AbfLJKsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:48:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89A02B49B;
        Tue, 10 Dec 2019 10:48:13 +0000 (UTC)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] x86-64/entry: add instruction suffix to SYSRET
Message-ID: <cbecab05-9e95-5dec-ef81-499617c153a6@suse.com>
Date:   Tue, 10 Dec 2019 11:48:33 +0100
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

Omitting suffixes from instructions in AT&T mode is bad practice when
operand size cannot be determined by the assembler from register
operands, and is likely going to be warned about by upstream gas in the
future. Add the missing suffix here.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

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
 
