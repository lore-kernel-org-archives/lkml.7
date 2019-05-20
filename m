Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB908C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEEF216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355501;
	bh=any/DlHXg37Ff7AbRPFC1GetjoVK2j3ZkSLPNafzbrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r6ceenq8D611Irtm0cYIv6tMjR+SAifpK53fVvqm2jPXXndh/fbEvVWZF6QXOvF3e
	 N/fwu8yE5wnn7UDFbnQXnuQRLSH6Zkb7s3RataADetO5gFg0xM6oJ1N6/iCW2wQsIo
	 wXclUHr0XtmJFW/pAV8ZeeumdZ5DYRAaR9t2qnFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390389AbfETMbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:31:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390351AbfETMbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:31:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA4152171F;
        Mon, 20 May 2019 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355498;
        bh=any/DlHXg37Ff7AbRPFC1GetjoVK2j3ZkSLPNafzbrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y++/50uqLjXXJd2LUzVFTIYCXasIis0CGLaQnjuTYau9zmQDWzgzQLkEFKjbZgTxA
         HRiJuCV1UiYM/8cUSs+dI8MAIjGvWxDLuD3Vobmk2IShKzPr1eDf2oCSU/XrnNbUdX
         aTc74m9j0z3aVSLfDCkgZ8Sjg44uDnIO68NSsdYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 5.1 018/128] arm64: Clear OSDLR_EL1 on CPU boot
Date:   Mon, 20 May 2019 14:13:25 +0200
Message-Id: <20190520115250.719711304@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

commit 6fda41bf12615ee7c3ddac88155099b1a8cf8d00 upstream.

Some firmwares may reboot CPUs with OS Double Lock set. Make sure that
it is unlocked, in order to use debug exceptions.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/debug-monitors.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -135,6 +135,7 @@ NOKPROBE_SYMBOL(disable_debug_monitors);
  */
 static int clear_os_lock(unsigned int cpu)
 {
+	write_sysreg(0, osdlr_el1);
 	write_sysreg(0, oslar_el1);
 	isb();
 	return 0;


