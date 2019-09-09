Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCAAC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7B021920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iXi0mRPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404717AbfIIMEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:04:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47997 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404215AbfIIMEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:04:49 -0400
Received: from [192.168.4.140] (38.85.69.148.rev.vodafone.pt [148.69.85.38] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x89C4WbF2372926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 9 Sep 2019 05:04:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x89C4WbF2372926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019081901; t=1568030675;
        bh=4zGD01O5GVyYuHnAx8oJOIENw6fScedLERsAFG9lv4g=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=iXi0mRPfGBdGjEvCf92gzf8wtcQmusIRPPcGAaVCcCVhKmEF3EY3XTlci87+amo3E
         MKa9Zx8giJr4t5taw6PJs7Slpx5AXw1Q/4yz305P4bb5J8AYdwA0KzG4PJhnCTWwiX
         UZH7V6NCiBeQ0HX9fZOHfpFl5JAGeeSBedTUXGo8+fNeXtLOth2mIykIF+QHnyXn1i
         W3QXX2flz2UafSmLCIGTfowjvrokWQKJO/AGI/vEIS9nT8DeRd4M8Ap8HFXrXbJqrh
         d5ZXZ1JRLDoNf+2jO1uxenNFEjZp0MMzSVnaHowM7xatU0cTkU6xCNddzgYBvMyRb4
         3owJZDpLZqq2A==
Date:   Mon, 09 Sep 2019 13:04:23 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190905232222.14900-1-bshanks@codeweavers.com>
References: <20190905232222.14900-1-bshanks@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/umip: Add emulation for 64-bit processes
To:     Brendan Shanks <bshanks@codeweavers.com>,
        linux-kernel@vger.kernel.org
CC:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
From:   hpa@zytor.com
Message-ID: <7BFFC7D1-6158-4237-AEF9-D10635F054FC@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 6, 2019 12:22:21 AM GMT+01:00, Brendan Shanks <bshanks@codewea=
vers=2Ecom> wrote:
>Add emulation of the sgdt, sidt, and smsw instructions for 64-bit
>processes=2E
>
>Wine users have encountered a number of 64-bit Windows games that use
>these instructions (particularly sgdt), and were crashing when run on
>UMIP-enabled systems=2E
>
>Originally-by: Ricardo Neri <ricardo=2Eneri-calderon@linux=2Eintel=2Ecom>
>Signed-off-by: Brendan Shanks <bshanks@codeweavers=2Ecom>
>---
> arch/x86/kernel/umip=2Ec | 55 +++++++++++++++++++++++++-----------------
> 1 file changed, 33 insertions(+), 22 deletions(-)
>
>diff --git a/arch/x86/kernel/umip=2Ec b/arch/x86/kernel/umip=2Ec
>index 5b345add550f=2E=2E1812e95d2f55 100644
>--- a/arch/x86/kernel/umip=2Ec
>+++ b/arch/x86/kernel/umip=2Ec
>@@ -51,9 +51,7 @@
>* The instruction smsw is emulated to return the value that the
>register CR0
>  * has at boot time as set in the head_32=2E
>  *
>- * Also, emulation is provided only for 32-bit processes; 64-bit
>processes
>- * that attempt to use the instructions that UMIP protects will
>receive the
>- * SIGSEGV signal issued as a consequence of the general protection
>fault=2E
>+ * Emulation is provided for both 32-bit and 64-bit processes=2E
>  *
>* Care is taken to appropriately emulate the results when segmentation
>is
>* used=2E That is, rather than relying on USER_DS and USER_CS, the
>function
>@@ -63,17 +61,18 @@
>  * application uses a local descriptor table=2E
>  */
>=20
>-#define UMIP_DUMMY_GDT_BASE 0xfffe0000
>-#define UMIP_DUMMY_IDT_BASE 0xffff0000
>+#define UMIP_DUMMY_GDT_BASE 0xfffffffffffe0000ULL
>+#define UMIP_DUMMY_IDT_BASE 0xffffffffffff0000ULL
>=20
> /*
>* The SGDT and SIDT instructions store the contents of the global
>descriptor
>* table and interrupt table registers, respectively=2E The destination is
>a
>* memory operand of X+2 bytes=2E X bytes are used to store the base
>address of
>- * the table and 2 bytes are used to store the limit=2E In 32-bit
>processes, the
>- * only processes for which emulation is provided, X has a value of 4=2E
>+ * the table and 2 bytes are used to store the limit=2E In 32-bit
>processes X
>+ * has a value of 4, in 64-bit processes X has a value of 8=2E
>  */
>-#define UMIP_GDT_IDT_BASE_SIZE 4
>+#define UMIP_GDT_IDT_BASE_SIZE_64BIT 8
>+#define UMIP_GDT_IDT_BASE_SIZE_32BIT 4
> #define UMIP_GDT_IDT_LIMIT_SIZE 2
>=20
> #define	UMIP_INST_SGDT	0	/* 0F 01 /0 */
>@@ -189,6 +188,7 @@ static int identify_insn(struct insn *insn)
>  * @umip_inst:	A constant indicating the instruction to emulate
>  * @data:	Buffer into which the dummy result is stored
>  * @data_size:	Size of the emulated result
>+ * @x86_64:     true if process is 64-bit, false otherwise
>  *
>* Emulate an instruction protected by UMIP and provide a dummy result=2E
>The
>* result of the emulation is saved in @data=2E The size of the results
>depends
>@@ -202,11 +202,8 @@ static int identify_insn(struct insn *insn)
>  * 0 on success, -EINVAL on error while emulating=2E
>  */
> static int emulate_umip_insn(struct insn *insn, int umip_inst,
>-			     unsigned char *data, int *data_size)
>+			     unsigned char *data, int *data_size, bool x86_64)
> {
>-	unsigned long dummy_base_addr, dummy_value;
>-	unsigned short dummy_limit =3D 0;
>-
> 	if (!data || !data_size || !insn)
> 		return -EINVAL;
> 	/*
>@@ -219,6 +216,9 @@ static int emulate_umip_insn(struct insn *insn, int
>umip_inst,
> 	 * is always returned irrespective of the operand size=2E
> 	 */
> 	if (umip_inst =3D=3D UMIP_INST_SGDT || umip_inst =3D=3D UMIP_INST_SIDT)=
 {
>+		u64 dummy_base_addr;
>+		u16 dummy_limit =3D 0;
>+
> 		/* SGDT and SIDT do not use registers operands=2E */
> 		if (X86_MODRM_MOD(insn->modrm=2Evalue) =3D=3D 3)
> 			return -EINVAL;
>@@ -228,13 +228,24 @@ static int emulate_umip_insn(struct insn *insn,
>int umip_inst,
> 		else
> 			dummy_base_addr =3D UMIP_DUMMY_IDT_BASE;
>=20
>-		*data_size =3D UMIP_GDT_IDT_LIMIT_SIZE + UMIP_GDT_IDT_BASE_SIZE;
>+		/*
>+		 * 64-bit processes use the entire dummy base address=2E
>+		 * 32-bit processes use the lower 32 bits of the base address=2E
>+		 * dummy_base_addr is always 64 bits, but we memcpy the correct
>+		 * number of bytes from it to the destination=2E
>+		 */
>+		if (x86_64)
>+			*data_size =3D UMIP_GDT_IDT_BASE_SIZE_64BIT;
>+		else
>+			*data_size =3D UMIP_GDT_IDT_BASE_SIZE_32BIT;
>+
>+		memcpy(data + 2, &dummy_base_addr, *data_size);
>=20
>-		memcpy(data + 2, &dummy_base_addr, UMIP_GDT_IDT_BASE_SIZE);
>+		*data_size +=3D UMIP_GDT_IDT_LIMIT_SIZE;
> 		memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
>=20
> 	} else if (umip_inst =3D=3D UMIP_INST_SMSW) {
>-		dummy_value =3D CR0_STATE;
>+		unsigned long dummy_value =3D CR0_STATE;
>=20
> 		/*
> 		 * Even though the CR0 register has 4 bytes, the number
>@@ -291,10 +302,9 @@ static void force_sig_info_umip_fault(void __user
>*addr, struct pt_regs *regs)
>  * @regs:	Registers as saved when entering the #GP handler
>  *
>* The instructions sgdt, sidt, str, smsw, sldt cause a general
>protection
>- * fault if executed with CPL > 0 (i=2Ee=2E, from user space)=2E If the
>offending
>- * user-space process is not in long mode, this function fixes the
>exception
>- * up and provides dummy results for sgdt, sidt and smsw; str and sldt
>are not
>- * fixed up=2E Also long mode user-space processes are not fixed up=2E
>+ * fault if executed with CPL > 0 (i=2Ee=2E, from user space)=2E This
>function fixes
>+ * the exception up and provides dummy results for sgdt, sidt and
>smsw; str
>+ * and sldt are not fixed up=2E
>  *
>* If operands are memory addresses, results are copied to user-space
>memory as
>* indicated by the instruction pointed by eIP using the registers
>indicated in
>@@ -373,13 +383,14 @@ bool fixup_umip_exception(struct pt_regs *regs)
>	umip_pr_warning(regs, "%s instruction cannot be used by
>applications=2E\n",
> 			umip_insns[umip_inst]);
>=20
>-	/* Do not emulate SLDT, STR or user long mode processes=2E */
>-	if (umip_inst =3D=3D UMIP_INST_STR || umip_inst =3D=3D UMIP_INST_SLDT |=
|
>user_64bit_mode(regs))
>+	/* Do not emulate SLDT or STR=2E */
>+	if (umip_inst =3D=3D UMIP_INST_STR || umip_inst =3D=3D UMIP_INST_SLDT)
> 		return false;
>=20
>	umip_pr_warning(regs, "For now, expensive software emulation returns
>the result=2E\n");
>=20
>-	if (emulate_umip_insn(&insn, umip_inst, dummy_data,
>&dummy_data_size))
>+	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
>+			      user_64bit_mode(regs)))
> 		return false;
>=20
> 	/*

I would strongly suggest that we change the term "emulation" to "spoofing"=
 for these instructions=2E We need to explain that we do *not* execute thes=
e instructions the was the CPU would have, and unlike the native instructio=
ns do not leak kernel information=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
