Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10471C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D887D20651
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011578;
	bh=U0qe1jI0Qe1xImFHXsq+pAjMSMkxQ/xoidN/fbDpSLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VqiC/qTsUeKWKBR9Uw91aVH6Txtq/qCQWZ2c6kk0v7hnzsi7LGIEKwtqHPNdiVQ3v
	 tzkTqsrR4qA0HS7jNNSZCebN4xwJMqhUplgYzp/qNwHsb3d5jINqcs/SCbK6jDjJuL
	 ObKJnGXlAXRN6sOQ3P2ut9ajLPVVV6ZfYchsnIJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfHEN0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731388AbfHEN0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:26:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B829D20651;
        Mon,  5 Aug 2019 13:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011570;
        bh=U0qe1jI0Qe1xImFHXsq+pAjMSMkxQ/xoidN/fbDpSLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8xWpcb3mOHjytqH2V4KitIUObYuozlRhGuNPghaH9xY8GhMGKrxxrxM5v60e7sKQ
         f/zHL88bHZiI8n8R4pfHqQs/ARGh3M/HxR58lt2Sa3OdUuf/z9rx03l/1vXj/B9v7f
         GSLFqtZ1xlG6tlQ/+N10fWnFw0atERcibQ8IbEpo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: [PATCH 5.2 112/131] arm64: compat: Allow single-byte watchpoints on all addresses
Date:   Mon,  5 Aug 2019 15:03:19 +0200
Message-Id: <20190805124959.467768241@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
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
@@ -536,13 +536,14 @@ int hw_breakpoint_arch_parse(struct perf
 			/* Aligned */
 			break;
 		case 1:
-			/* Allow single byte watchpoint. */
-			if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
-				break;
 		case 2:
 			/* Allow halfword watchpoints and breakpoints. */
 			if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
 				break;
+		case 3:
+			/* Allow single byte watchpoint. */
+			if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
+				break;
 		default:
 			return -EINVAL;
 		}


