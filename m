Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF21B218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257504;
	bh=YkjagHRAlD6nBd+xWeh2QU4bJVBUhbk250LFHw6WVfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qKhkc4AIf7byroUUdaiw/2B/G/li3kAJQ9lk+wpX8l36LpLAvilZXMfB2s/fxKYIJ
	 NAN5YWM2zORAaHJywYAsSOFSGfitD2gfGH82aetnb43fmxjRPftM8nytMJIx4lHFWP
	 8aIygXiymded0FLXSfK36454bfF5PGKKzTU0ij74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390967AbfCVMZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390738AbfCVMYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:24:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC3B2070D;
        Fri, 22 Mar 2019 12:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257478;
        bh=YkjagHRAlD6nBd+xWeh2QU4bJVBUhbk250LFHw6WVfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2lxfYKxyy0wtJfQdxiYD1eve7ksTi+LZJwWIzyowAGZ0ocOBO0kCZPfX5Dy4l4FSL
         Z9qiRbYqb5JsVDzkz+/86pcNLrXLB6Q2AcdHmNSml3/Kda+iXXf93GR0fN/1bniBvf
         iF3Kmk5DFlSYhVog4Ms3KHChc0CRPML8TjMrMWU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Cornelia Huck <cohuck@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 5.0 235/238] s390/setup: fix boot crash for machine without EDAT-1
Date:   Fri, 22 Mar 2019 12:17:34 +0100
Message-Id: <20190322111312.270759139@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

commit 86a86804e4f18fc3880541b3d5a07f4df0fe29cb upstream.

The fix to make WARN work in the early boot code created a problem
on older machines without EDAT-1. The setup_lowcore_dat_on function
uses the pointer from lowcore_ptr[0] to set the DAT bit in the new
PSWs. That does not work if the kernel page table is set up with
4K pages as the prefix address maps to absolute zero.

To make this work the PSWs need to be changed with via address 0 in
form of the S390_lowcore definition.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Fixes: 94f85ed3e2f8 ("s390/setup: fix early warning messages")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/setup.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -451,13 +451,12 @@ static void __init setup_lowcore_dat_off
 
 static void __init setup_lowcore_dat_on(void)
 {
-	struct lowcore *lc;
-
-	lc = lowcore_ptr[0];
-	lc->external_new_psw.mask |= PSW_MASK_DAT;
-	lc->svc_new_psw.mask |= PSW_MASK_DAT;
-	lc->program_new_psw.mask |= PSW_MASK_DAT;
-	lc->io_new_psw.mask |= PSW_MASK_DAT;
+	__ctl_clear_bit(0, 28);
+	S390_lowcore.external_new_psw.mask |= PSW_MASK_DAT;
+	S390_lowcore.svc_new_psw.mask |= PSW_MASK_DAT;
+	S390_lowcore.program_new_psw.mask |= PSW_MASK_DAT;
+	S390_lowcore.io_new_psw.mask |= PSW_MASK_DAT;
+	__ctl_set_bit(0, 28);
 }
 
 static struct resource code_resource = {


