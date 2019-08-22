Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB81C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BA123402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495616;
	bh=9o44ulriWXXkwnJBjHg4oBd96Y4y2e/U4b3CT7RffeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Br6QodD3hb6S/XD+DIyJ5XtJh6owwuf0FESk29v/Era21D7vdDgLLkqBCj5r+wCcv
	 ffdDJ9+TGBFDeP1AyN/k9mknKHlAxx//gMBsRwjKocMk7jip3mVerNj9Vh8G1QGN+j
	 VHfSeCCuAVmJxnZ/gd1bVd826yirI5LqLA8RKAk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404370AbfHVRkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404092AbfHVRYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:08 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31DF023407;
        Thu, 22 Aug 2019 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494648;
        bh=9o44ulriWXXkwnJBjHg4oBd96Y4y2e/U4b3CT7RffeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrEhNMiCObfSeddDZ0OZF4UeAkBuTT6QwCFt+FieN2Wi5i0SeitHdl14mxv16+OHd
         INjA2HUJH1KPiWHaW2408XaL5tjlmrTaKcClA3K5UrRngH7xPex7otDteYqwN0rTpu
         r072T36etop2+nk5kUd2Jmz7bQ6xDuxpnmMnC52A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 4.9 042/103] sh: kernel: hw_breakpoint: Fix missing break in switch statement
Date:   Thu, 22 Aug 2019 10:18:30 -0700
Message-Id: <20190822171730.506906597@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 1ee1119d184bb06af921b48c3021d921bbd85bac upstream.

Add missing break statement in order to prevent the code from falling
through to case SH_BREAKPOINT_WRITE.

Fixes: 09a072947791 ("sh: hw-breakpoints: Add preliminary support for SH-4A UBC.")
Cc: stable@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sh/kernel/hw_breakpoint.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -160,6 +160,7 @@ int arch_bp_generic_fields(int sh_len, i
 	switch (sh_type) {
 	case SH_BREAKPOINT_READ:
 		*gen_type = HW_BREAKPOINT_R;
+		break;
 	case SH_BREAKPOINT_WRITE:
 		*gen_type = HW_BREAKPOINT_W;
 		break;


