Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879A023402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495983;
	bh=PQdXEp1M2D7znItW2RwWXomYTTMJIELx+qPHFFaEajE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p0vcgHD1DzXtKRzMAbt4keIS/4A111lODqWkNDQec/7Sk/oUXzgbMyWCNw1ufxl9E
	 r82ozB/vJy17OLHxSeo5/7eqePPO6f/genmXuGsjJz3cq3eU8tWNQgRzUcr5UJUmXO
	 R5ncF3yORNAiyf1AE5/AN3OKhY5hMfFErGBRmpl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393089AbfHVRqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391667AbfHVRWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:22:54 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 674192341D;
        Thu, 22 Aug 2019 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494574;
        bh=PQdXEp1M2D7znItW2RwWXomYTTMJIELx+qPHFFaEajE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzPegdPtuvMz/mA0Pd6xxt9wxnXRKkVEBJuIINJRtd3H0P9wD5KaT+CAmwJr+UhaJ
         wHflGMGZWDVvpNdgJCypvGEx9Ish1mWSR++05nYVqtVZSL7jNqo6dXGUiupqtkZDsP
         17IicFk0+4gSF8Yn0WDTjhGxfEhiVYiYLLpf6jNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: [PATCH 4.4 65/78] arm64: compat: Allow single-byte watchpoints on all addresses
Date:   Thu, 22 Aug 2019 10:19:09 -0700
Message-Id: <20190822171833.914669081@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
References: <20190822171832.012773482@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit 849adec41203ac5837c40c2d7e08490ffdef3c2c upstream.

Commit d968d2b801d8 ("ARM: 7497/1: hw_breakpoint: allow single-byte
watchpoints on all addresses") changed the validation requirements for
hardware watchpoints on arch/arm/. Update our compat layer to implement
the same relaxation.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/hw_breakpoint.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -504,13 +504,14 @@ int arch_validate_hwbkpt_settings(struct
 			/* Aligned */
 			break;
 		case 1:
-			/* Allow single byte watchpoint. */
-			if (info->ctrl.len == ARM_BREAKPOINT_LEN_1)
-				break;
 		case 2:
 			/* Allow halfword watchpoints and breakpoints. */
 			if (info->ctrl.len == ARM_BREAKPOINT_LEN_2)
 				break;
+		case 3:
+			/* Allow single byte watchpoint. */
+			if (info->ctrl.len == ARM_BREAKPOINT_LEN_1)
+				break;
 		default:
 			return -EINVAL;
 		}


