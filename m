Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0967CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D277020675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355301;
	bh=tYzvmzxlgCAbu7295+HojwnrPPuXKNiISilXMntA4Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X5F8s5RYndyKIbHyi98+1GdnpI0EjJOttHofED099mcvFjCgR8YUrfs6dd1TF2bLx
	 zmqeUaMi37nDuodywdcY2NBiUV+tM4nLcIK6Ra61ugzoHCak7Pb0IS28yRDuIwt6Fm
	 D0kpgxJVENW3xAhZe/wsf/INYhTsJqGF6N83MBVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389655AbfETM2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389644AbfETM2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:28:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6214C20645;
        Mon, 20 May 2019 12:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355294;
        bh=tYzvmzxlgCAbu7295+HojwnrPPuXKNiISilXMntA4Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CF/735w5b5Ksle5ba3que3kM8RfG1AgG8GqUmBnjxyt3P6O4tDNphjRdAtydpdA8f
         c0IOV7YgD9NXZ1Hj8o+5j0AVCHX5n7SC9PogwzFCn9VcSk6j6BmslNvqxv9AQqCwNP
         G4I0p8r4Fq4WE/jDYSd7ctK9U7uprQhrGmzvlzSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boyang Zhou <zhouby_cn@126.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 5.0 014/123] arm64: mmap: Ensure file offset is treated as unsigned
Date:   Mon, 20 May 2019 14:13:14 +0200
Message-Id: <20190520115246.007140417@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115245.439864225@linuxfoundation.org>
References: <20190520115245.439864225@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boyang Zhou <zhouby_cn@126.com>

commit f08cae2f28db24d95be5204046b60618d8de4ddc upstream.

The file offset argument to the arm64 sys_mmap() implementation is
scaled from bytes to pages by shifting right by PAGE_SHIFT.
Unfortunately, the offset is passed in as a signed 'off_t' type and
therefore large offsets (i.e. with the top bit set) are incorrectly
sign-extended by the shift. This has been observed to cause false mmap()
failures when mapping GPU doorbells on an arm64 server part.

Change the type of the file offset argument to sys_mmap() from 'off_t'
to 'unsigned long' so that the shifting scales the value as expected.

Cc: <stable@vger.kernel.org>
Signed-off-by: Boyang Zhou <zhouby_cn@126.com>
[will: rewrote commit message]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/sys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -31,7 +31,7 @@
 
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 		unsigned long, prot, unsigned long, flags,
-		unsigned long, fd, off_t, off)
+		unsigned long, fd, unsigned long, off)
 {
 	if (offset_in_page(off) != 0)
 		return -EINVAL;


