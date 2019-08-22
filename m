Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F65C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5861E20856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495759;
	bh=us8t8FZaxlpy3EoUzjVp7bS/5o23Op4UE1+ikVze0I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zLlJR0d1JVrCjdDFZneyXIRJieXK4KeGgUP2cl8RMMR+M3ljfPMkERlkPBg4M/Uun
	 OJ3rtkejFM+CZ5Ec4FD8UI1tfkjNhPBbz8DuIaObXoN3zOY6wSpE9pcSwOkueuf+AS
	 EJuOPNwBTWhLuHCimZqaMDJWdPIJusZ6NHqEc/D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405227AbfHVRmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404002AbfHVRXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:23:47 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E3A23427;
        Thu, 22 Aug 2019 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494627;
        bh=us8t8FZaxlpy3EoUzjVp7bS/5o23Op4UE1+ikVze0I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpjLeacJXQ9dGCejCPUq2C9oRx7m7a+3i9isYKTNZbRmXPe0I5dReudhC2RvHkb7v
         DDWj/wvtmSkrdhFOKNhr87U2emASRmf5oP3u8cp+94Qdzb5iTMyoTwB4Z/V71hFZ8G
         yFEhIQLCi5gFIKUiq84BTe+4j3id1UofqkMHvcdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.9 058/103] xtensa: add missing isync to the cpu_reset TLB code
Date:   Thu, 22 Aug 2019 10:18:46 -0700
Message-Id: <20190822171731.137216556@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

commit cd8869f4cb257f22b89495ca40f5281e58ba359c upstream.

ITLB entry modifications must be followed by the isync instruction
before the new entries are possibly used. cpu_reset lacks one isync
between ITLB way 6 initialization and jump to the identity mapping.
Add missing isync to xtensa cpu_reset.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/kernel/setup.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -626,6 +626,7 @@ void cpu_reset(void)
 				      "add	%2, %2, %7\n\t"
 				      "addi	%0, %0, -1\n\t"
 				      "bnez	%0, 1b\n\t"
+				      "isync\n\t"
 				      /* Jump to identity mapping */
 				      "jx	%3\n"
 				      "2:\n\t"


