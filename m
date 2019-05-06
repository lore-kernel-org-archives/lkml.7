Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F171C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9DF214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153513;
	bh=Se1UYjdv/oxKz9idkt8C+cBvkrjTu635luiJ9L5APx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EjTPaLqXfayPeGOH42M9Tk73yJwMfTJ+VaqRiO8MmbmwYbTeLYty0DOKcj58s4n2V
	 BC4ej0mm15d7lOFpzTxwxk6lOKxGNEowCeYijhZw+6ovvnMfJ/cg5SPj93DSzKtFIY
	 TbOoyoX+GljCsMCp+h1/cJOfAmb3pCInZRwjFfMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfEFOic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfEFOi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:38:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95FB320449;
        Mon,  6 May 2019 14:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153509;
        bh=Se1UYjdv/oxKz9idkt8C+cBvkrjTu635luiJ9L5APx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrEG4t7MPVD7osJuAtjJfoL8gm9AovLfXn0mK6GFdEasFIAdnDanRibrivKy+5tAS
         iYOmMhaLQVRC8dS1DJJ4SLzmjb5hao5PW5iJbKHIbTi53mdRDwS0avH2vyu7nVP1cx
         5wX9i7Ku2C6lEMbFVAfB7HFD2Mtrr02EDJrFEOeM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Pu Wen <puwen@hygon.cn>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: [PATCH 5.0 116/122] x86/mce: Improve error message when kernel cannot recover, p2
Date:   Mon,  6 May 2019 16:32:54 +0200
Message-Id: <20190506143104.790501326@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

commit 41f035a86b5b72a4f947c38e94239d20d595352a upstream.

In

  c7d606f560e4 ("x86/mce: Improve error message when kernel cannot recover")

a case was added for a machine check caused by a DATA access to poison
memory from the kernel. A case should have been added also for an
uncorrectable error during an instruction fetch in the kernel.

Add that extra case so the error message now reads:

  mce: [Hardware Error]: Machine check: Instruction fetch error in kernel

Fixes: c7d606f560e4 ("x86/mce: Improve error message when kernel cannot recover")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190225205940.15226-1-tony.luck@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mce/severity.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -165,6 +165,11 @@ static struct severity {
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
 		KERNEL
 		),
+	MCESEV(
+		PANIC, "Instruction fetch error in kernel",
+		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_INSTR),
+		KERNEL
+		),
 #endif
 	MCESEV(
 		PANIC, "Action required: unknown MCACOD",


