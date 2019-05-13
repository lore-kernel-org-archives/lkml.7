Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879D2C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3055921019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="j17T7Of/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfEMQPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:15:03 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:42658 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727774AbfEMQPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:15:02 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 26950C01BA;
        Mon, 13 May 2019 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557764107; bh=1UIXnWpN2stn7OKWZRnkEbT0UgLrT0y/BoOBunS8G0I=;
        h=From:To:CC:Subject:Date:References:From;
        b=j17T7Of/hBOrNK38ZO2r/ci079+xtrEsdfAlqhGAuuSt/+4uDUhVyKBJ0ZMru6zSr
         y8gy6anSKZD6nLwxjyxUAeqcqvgpnO2z02fEkAuS6b7/Q4AjtTUcSrCIiroCuZkg5c
         ymsYyOWqRQ/jGs2cOYJbwn9xFTzgHeO51hfsZ0mc8HfGBAqF3fPziBjdjIvSJNZFXQ
         I0FT/qdnS7+RjhkcrSLsgCzcJSTYIxJzCOvmEXyAwwGpvF96lBcqOFkKJ7FLjyq2PW
         Ob3troL7ZgtnN7f1BodE3J6Xp18I7PtOxV3gyVUWjUE/Lk6VZGgtCsyOnxXOfpB2Ia
         rIZs/eooggzLg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 130F9A006B;
        Mon, 13 May 2019 16:15:01 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.22]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon, 13
 May 2019 09:15:02 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] ARC: Send SIGSEGV if userspace process accesses kernel
 virtual memory
Thread-Topic: [PATCH] ARC: Send SIGSEGV if userspace process accesses kernel
 virtual memory
Thread-Index: AQHVCZoEUnlBQBMrBkWcmOMjypie1w==
Date:   Mon, 13 May 2019 16:15:01 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2512567@us01wembx1.internal.synopsys.com>
References: <20190513144153.6112-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/19 7:41 AM, Eugeniy Paltsev wrote:=0A=
> As of today if userspace process tries to access address which belongs=0A=
> to kernel virtual memory area and kernel have mapping for this address=0A=
> that process hangs instead of receiving SIGSEGV and being killed.=0A=
>=0A=
> Steps to reproduce:=0A=
> Create userspace application which reads from the beginning of=0A=
> kernel-space virtual memory area (I.E. read from 0x7000_0000 on most=0A=
> of existing platforms):=0A=
> ------------------------>8-----------------=0A=
>  #include <stdlib.h>=0A=
>  #include <stdint.h>=0A=
>=0A=
>  int main(int argc, char *argv[])=0A=
>  {=0A=
>  	volatile uint32_t temp;=0A=
>=0A=
>  	temp =3D *(uint32_t *)(0x70000000);=0A=
>  }=0A=
> ------------------------>8-----------------=0A=
> That application hangs after such memory access.=0A=
>=0A=
> Fix that by checking which access (user or kernel) caused the exception=
=0A=
> before handling kernel virtual address fault.=0A=
>=0A=
> Cc: <stable@vger.kernel.org> # 4.20+=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
>  arch/arc/mm/fault.c | 6 +++++-=0A=
>  1 file changed, 5 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c=0A=
> index 8df1638259f3..53fb4ba6cd08 100644=0A=
> --- a/arch/arc/mm/fault.c=0A=
> +++ b/arch/arc/mm/fault.c=0A=
> @@ -66,7 +66,7 @@ void do_page_fault(unsigned long address, struct pt_reg=
s *regs)=0A=
>  	struct vm_area_struct *vma =3D NULL;=0A=
>  	struct task_struct *tsk =3D current;=0A=
>  	struct mm_struct *mm =3D tsk->mm;=0A=
> -	int si_code =3D 0;=0A=
> +	int si_code =3D SEGV_ACCERR;=0A=
>  	int ret;=0A=
>  	vm_fault_t fault;=0A=
>  	int write =3D regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */=0A=
> @@ -82,6 +82,10 @@ void do_page_fault(unsigned long address, struct pt_re=
gs *regs)=0A=
>  	 * nothing more.=0A=
>  	 */=0A=
>  	if (address >=3D VMALLOC_START) {=0A=
> +		/* Forbid userspace to access kernel-space virtual memory */=0A=
> +		if (unlikely(user_mode(regs)))=0A=
> +			goto bad_area_nosemaphore;=0A=
> +=0A=
>  		ret =3D handle_kernel_vaddr_fault(address);=0A=
>  		if (unlikely(ret))=0A=
>  			goto bad_area_nosemaphore;=0A=
=0A=
LGTM. However I have an old patch as part of do_page_fault cleanup - the id=
ea is=0A=
to delete one label, but hopefully it will fix ur case too - can u please g=
ive it=0A=
a spin with ur test case and report here. I will update the changelog=0A=
=0A=
---->=0A=
From 942c55d1ccbd3db12409a3dcdb1d20747041862b Mon Sep 17 00:00:00 2001=0A=
From: Vineet Gupta <vgupta@synopsys.com>=0A=
Date: Mon, 10 Dec 2018 18:15:17 -0800=0A=
Subject: [PATCH] ARC: mm: do_page_fault fixes #2: remove label=0A=
 bad_area_nosemaphore=0A=
=0A=
This is first step in untangling the code mess.=0A=
=0A=
VMALLOC_FAULT is only handled kernel mode so failure in its handling can=0A=
assume kernel mode, thus we can use @no_context label, removing the need=0A=
for @bad_area_nosemaphore=0A=
=0A=
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>=0A=
---=0A=
 arch/arc/mm/fault.c | 5 ++---=0A=
 1 file changed, 2 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c=0A=
index 8df1638259f3..342c0820c9e3 100644=0A=
--- a/arch/arc/mm/fault.c=0A=
+++ b/arch/arc/mm/fault.c=0A=
@@ -81,10 +81,10 @@ void do_page_fault(unsigned long address, struct pt_reg=
s *regs)=0A=
      * only copy the information from the master page table,=0A=
      * nothing more.=0A=
      */=0A=
-    if (address >=3D VMALLOC_START) {=0A=
+    if (address >=3D VMALLOC_START && !user_mode(regs)) {=0A=
         ret =3D handle_kernel_vaddr_fault(address);=0A=
         if (unlikely(ret))=0A=
-            goto bad_area_nosemaphore;=0A=
+            goto no_context;=0A=
         else=0A=
             return;=0A=
     }=0A=
@@ -198,7 +198,6 @@ void do_page_fault(unsigned long address, struct pt_reg=
s *regs)=0A=
 bad_area:=0A=
     up_read(&mm->mmap_sem);=0A=
 =0A=
-bad_area_nosemaphore:=0A=
     /* User mode accesses just cause a SIGSEGV */=0A=
     if (user_mode(regs)) {=0A=
         tsk->thread.fault_address =3D address;=0A=
-- =0A=
2.7.4=0A=
=0A=
