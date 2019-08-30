Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67119C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D51B22CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfH3Tq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:46:29 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55567 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfH3Tq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:46:28 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i3mqo-0002rY-QA; Fri, 30 Aug 2019 13:46:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i3mqC-0002tz-B5; Fri, 30 Aug 2019 13:46:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Jing Xiangfeng <jingxiangfeng@huawei.com>,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, bhelgaas@google.com, tglx@linutronix.de,
        sakari.ailus@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1567171877-101949-1-git-send-email-jingxiangfeng@huawei.com>
        <20190830133522.GZ13294@shell.armlinux.org.uk>
Date:   Fri, 30 Aug 2019 14:45:36 -0500
In-Reply-To: <20190830133522.GZ13294@shell.armlinux.org.uk> (Russell King's
        message of "Fri, 30 Aug 2019 14:35:22 +0100")
Message-ID: <87d0gmwi73.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i3mqC-0002tz-B5;;;mid=<87d0gmwi73.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18NMO9dKN/ZIv2eAbj5eODKvFQtgC+w5Xg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] arm: fix page faults in do_alignment
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:

> On Fri, Aug 30, 2019 at 09:31:17PM +0800, Jing Xiangfeng wrote:
>> The function do_alignment can handle misaligned address for user and
>> kernel space. If it is a userspace access, do_alignment may fail on
>> a low-memory situation, because page faults are disabled in
>> probe_kernel_address.
>> 
>> Fix this by using __copy_from_user stead of probe_kernel_address.
>> 
>> Fixes: b255188 ("ARM: fix scheduling while atomic warning in alignment handling code")
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>
> NAK.
>
> The "scheduling while atomic warning in alignment handling code" is
> caused by fixing up the page fault while trying to handle the
> mis-alignment fault generated from an instruction in atomic context.
>
> Your patch re-introduces that bug.

And the patch that fixed scheduling while atomic apparently introduced a
regression.  Admittedly a regression that took 6 years to track down but
still.

So it looks like the code needs to do something like:

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 04b36436cbc0..5e2b8623851e 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -784,6 +784,9 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	instrptr = instruction_pointer(regs);
 
+	if (user_mode(regs))
+		goto user;
+
 	if (thumb_mode(regs)) {
 		u16 *ptr = (u16 *)(instrptr & ~1);
 		fault = probe_kernel_address(ptr, tinstr);
@@ -933,6 +936,34 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	return 1;
 
  user:
+	if (thumb_mode(regs)) {
+		u16 *ptr = (u16 *)(instrptr & ~1);
+		fault = get_user(tinstr, ptr);
+		tinstr = __mem_to_opcode_thumb16(tinstr);
+		if (!fault) {
+			if (cpu_architecture() >= CPU_ARCH_ARMv7 &&
+			    IS_T32(tinstr)) {
+				/* Thumb-2 32-bit */
+				u16 tinst2 = 0;
+				fault = get_user(ptr + 1, tinst2);
+				tinst2 = __mem_to_opcode_thumb16(tinst2);
+				instr = __opcode_thumb32_compose(tinstr, tinst2);
+				thumb2_32b = 1;
+			} else {
+				isize = 2;
+				instr = thumb2arm(tinstr);
+			}
+		}
+	} else {
+		fault = get_user(instr, (u32*)instrptr);
+		instr = __mem_to_opcode_arm(instr);
+	}
+
+	if (fault) {
+		type = TYPE_FAULT;
+		goto bad_or_fault;
+	}
+
 	ai_user += 1;
 
 	if (ai_usermode & UM_WARN)

Eric
