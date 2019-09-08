Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A10C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C44421971
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946895;
	bh=LtTjOxgtRGF6LCCtjHjnp/619AMlBzyRmzOQMaARqIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AdJZh9LcByF95+N+TTwp75uNQmOXHzcvBVNNfZ+3YSquiX1bRp/LBdhhHU5VX7i/t
	 1mhhDWHv2k0ivQDYqaxTdB7ZOq9WJW0RrJquJAqOpGzJXrRUju6TsE+F+YWGKRYWWQ
	 ezOLCtzGlRxYdMhLMR3MVWhwVE/a9fMWD//vmL70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfIHMsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730906AbfIHMsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:48:09 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7674A21924;
        Sun,  8 Sep 2019 12:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946889;
        bh=LtTjOxgtRGF6LCCtjHjnp/619AMlBzyRmzOQMaARqIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vinwsjBEhay72i69lhxAyqZZZrQlQMAfvyGiVnQJxJ2nKQ/l4mEI5EVKlvl/N2V9z
         DSRTDdKEPoCQ87jOKRbUvNHLCR76/0kbX4WUsur8jc112JJmntUO+1sq4vyD/IUXUW
         ZoKOE6zJwWNSseyAxXvamFguggxfsqhj8XWQH7lA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "John S. Gruber" <JohnSGruber@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: [PATCH 4.19 09/57] x86/boot: Preserve boot_params.secure_boot from sanitizing
Date:   Sun,  8 Sep 2019 13:41:33 +0100
Message-Id: <20190908121128.536275429@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121125.608195329@linuxfoundation.org>
References: <20190908121125.608195329@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John S. Gruber <JohnSGruber@gmail.com>

commit 29d9a0b50736768f042752070e5cdf4e4d4c00df upstream.

Commit

  a90118c445cc ("x86/boot: Save fields explicitly, zero out everything else")

now zeroes the secure boot setting information (enabled/disabled/...)
passed by the boot loader or by the kernel's EFI handover mechanism.

The problem manifests itself with signed kernels using the EFI handoff
protocol with grub and the kernel loses the information whether secure
boot is enabled in the firmware, i.e., the log message "Secure boot
enabled" becomes "Secure boot could not be determined".

efi_main() arch/x86/boot/compressed/eboot.c sets this field early but it
is subsequently zeroed by the above referenced commit.

Include boot_params.secure_boot in the preserve field list.

 [ bp: restructure commit message and massage. ]

Fixes: a90118c445cc ("x86/boot: Save fields explicitly, zero out everything else")
Signed-off-by: John S. Gruber <JohnSGruber@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: stable <stable@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/CAPotdmSPExAuQcy9iAHqX3js_fc4mMLQOTr5RBGvizyCOPcTQQ@mail.gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/bootparam_utils.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -71,6 +71,7 @@ static void sanitize_boot_params(struct
 			BOOT_PARAM_PRESERVE(eddbuf_entries),
 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
+			BOOT_PARAM_PRESERVE(secure_boot),
 			BOOT_PARAM_PRESERVE(hdr),
 			BOOT_PARAM_PRESERVE(e820_table),
 			BOOT_PARAM_PRESERVE(eddbuf),


