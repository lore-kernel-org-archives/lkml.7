Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB51C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2C32075C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033655;
	bh=kEHKA4EUTrNeERxwRQ+APkr3hFEhUC2gW5svMuPHzJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DHAmZYjU+2aZ/zZ3FwgArPA7U7brsQX0lHvGoECY7NLfA8QzuCTg3z0hhTQwQrZhk
	 7nE7PT60zv5Ljs5Cp/wxTDLf9zkzZsvWMFmaGOKZ6kErM3ak7X+RdMrZZg6J8FGJUM
	 O+3UPpj6fz6/dC1V58c5eit/+fSeTkGm+hTWZgJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfGYFre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391561AbfGYFr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:47:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 011F220657;
        Thu, 25 Jul 2019 05:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033646;
        bh=kEHKA4EUTrNeERxwRQ+APkr3hFEhUC2gW5svMuPHzJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItYyDMwj9EWZRt5sq+MqOJJtQD2Tdqq2D5J7/nCMt46e3hgJSVjLyZ62Cp4p2aaCz
         v+BL4to4v9xXMRQ6d5HE2VR5kKU+2uI/SQAttwbKLmpaNeb0ZEhpjmBJ+stWm8h2tI
         tbUD1F46jk/LPp/3h1aRpLD719D5BBH4m7BW0+Ic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.19 253/271] parisc: Ensure userspace privilege for ptraced processes in regset functions
Date:   Wed, 24 Jul 2019 21:22:02 +0200
Message-Id: <20190724191716.885680591@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit 34c32fc603311a72cb558e5e337555434f64c27b upstream.

On parisc the privilege level of a process is stored in the lowest two bits of
the instruction pointers (IAOQ0 and IAOQ1). On Linux we use privilege level 0
for the kernel and privilege level 3 for user-space. So userspace should not be
allowed to modify IAOQ0 or IAOQ1 of a ptraced process to change it's privilege
level to e.g. 0 to try to gain kernel privileges.

This patch prevents such modifications in the regset support functions by
always setting the two lowest bits to one (which relates to privilege level 3
for user-space) if IAOQ0 or IAOQ1 are modified via ptrace regset calls.

Link: https://bugs.gentoo.org/481768
Cc: <stable@vger.kernel.org> # v4.7+
Tested-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/ptrace.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -496,7 +496,8 @@ static void set_reg(struct pt_regs *regs
 			return;
 	case RI(iaoq[0]):
 	case RI(iaoq[1]):
-			regs->iaoq[num - RI(iaoq[0])] = val;
+			/* set 2 lowest bits to ensure userspace privilege: */
+			regs->iaoq[num - RI(iaoq[0])] = val | 3;
 			return;
 	case RI(sar):	regs->sar = val;
 			return;


