Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0D3C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997E1204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355739;
	bh=rzy736CsgS0Y3zt/uwrEMZnuY8Zf2XnsR1lqWDYGqlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iT4ijHCs9YFw8Q+nGq5hfsbTd3ZycdJXDT/Qab2k3hxjLIybi4r57dKYMHMCw5+Qk
	 fF8SY0q05nfQIa745lvviYx9jTQjEG2QKkJPmoBCZWtlSUAaK0GKPgKpiaZdYbjaZA
	 RSXXKbXEhbQDHzB0yjjROQ8IDtAZrMtBNUUF84Wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391115AbfETMfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:35:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403845AbfETMfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:35:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A69A2173E;
        Mon, 20 May 2019 12:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355735;
        bh=rzy736CsgS0Y3zt/uwrEMZnuY8Zf2XnsR1lqWDYGqlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVv//OXnWr3s8d7CXPwraXMeoDa4aOS5ayx5YKUHBCBmDQPdG2p7fhZH2genciDny
         EIAMJF/vuYHJNJ/yrGa9tAR3TEmoAbAhoLo63S1gEzu4rvOsdhk9t0c9Zb0YfvhsYu
         d7x9jDbXF9hT+eNiji6wOhAHUdE1xsnPaRUDGwUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: [PATCH 5.1 106/128] tty: Dont force RISCV SBI console as preferred console
Date:   Mon, 20 May 2019 14:14:53 +0200
Message-Id: <20190520115256.232904660@linuxfoundation.org>
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

From: Anup Patel <Anup.Patel@wdc.com>

commit f91253a3d005796404ae0e578b3394459b5f9b71 upstream.

The Linux kernel will auto-disables all boot consoles whenever it
gets a preferred real console.

Currently on RISC-V systems, if we have a real console which is not
RISCV SBI console then boot consoles (such as earlycon=sbi) are not
auto-disabled when a real console (ttyS0 or ttySIF0) is available.
This results in duplicate prints at boot-time after kernel starts
using real console (i.e. ttyS0 or ttySIF0) if "earlycon=" kernel
parameter was passed by bootloader.

The reason for above issue is that RISCV SBI console always adds
itself as preferred console which is causing other real consoles
to be not used as preferred console.

Ideally "console=" kernel parameter passed by bootloaders should
be the one selecting a preferred real console.

This patch fixes above issue by not forcing RISCV SBI console as
preferred console.

Fixes: afa6b1ccfad5 ("tty: New RISC-V SBI console driver")
Cc: stable@vger.kernel.org
Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/hvc/hvc_riscv_sbi.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -53,7 +53,6 @@ device_initcall(hvc_sbi_init);
 static int __init hvc_sbi_console_init(void)
 {
 	hvc_instantiate(0, 0, &hvc_sbi_ops);
-	add_preferred_console("hvc", 0, NULL);
 
 	return 0;
 }


