Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7FFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6128E20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xrud4aes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfCZNMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:12:23 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55386 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCZNMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:12:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2QD3sHo185426;
        Tue, 26 Mar 2019 13:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=VG36/NktXjB1U/a+gHTVu5iFnhtk8979yzArM7G/WC8=;
 b=xrud4aespGXDTxjHpKOrT55LnVXtdGEP3Jvj5hmEUaLPITLLuxsaRQJa+cwABf9xRcDx
 dCeCbrWxVd4OrVrGVXw0toGO2bL353C08plQzJqjbYf5yr5DdYmsYS7wEKJk/NQo6aPl
 zTtOeHYzijQLsWZoRFUWJsx5UO5VoMRdxsDDwaNaukp64OoFU+cwCeFP/mjvJPHbp30S
 z9Hncu/jCE8U1QSGji4KqAuta/6jLLz6ERzanoscQr7fpQK0uLq1gJZeAgfOyULpOrii
 VnFe5wAWMyOoQtm7Jmr3wClOmJKxcjUDzNxx17UU744cw5SByb5T/EH4ZEUkYfPZMKz+ sQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2re6g0t8v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 13:12:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2QDC1vu010614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 13:12:01 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2QDC0tG030477;
        Tue, 26 Mar 2019 13:12:01 GMT
Received: from [10.0.5.57] (/213.57.127.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 06:12:00 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] KVM: x86: nVMX: allow RSM to restore VMXE CR4 flag
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190326130746.28748-1-vkuznets@redhat.com>
Date:   Tue, 26 Mar 2019 15:11:56 +0200
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jon Doron <arilou@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DFD60850-CD9B-4FF3-9C46-EF4AF53C76CA@oracle.com>
References: <20190326130746.28748-1-vkuznets@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 26 Mar 2019, at 15:07, Vitaly Kuznetsov <vkuznets@redhat.com> =
wrote:
>=20
> Commit 5bea5123cbf0 ("KVM: VMX: check nested state and CR4.VMXE =
against
> SMM") introduced a check to vmx_set_cr4() forbidding to set VMXE from =
SMM.
> The check is correct, however, there is a special case when RSM is =
called
> to leave SMM: rsm_enter_protected_mode() is called with HF_SMM_MASK =
still
> set and in case VMXE was set before entering SMM we're failing to =
return.
>=20
> Resolve the issue by temporary dropping HF_SMM_MASK around set_cr4() =
calls
> when ops->set_cr() is called from RSM.
>=20
> Reported-by: Jon Doron <arilou@gmail.com>
> Suggested-by: Liran Alon <liran.alon@oracle.com>
> Fixes: 5bea5123cbf0 ("KVM: VMX: check nested state and CR4.VMXE =
against SMM")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Patch looks good to me.
Reviewed-by: Liran Alon <liran.alon@oracle.com>

> ---
> - Instread of putting the temporary HF_SMM_MASK drop to
>  rsm_enter_protected_mode() (as was suggested by Liran), move it to
>  emulator_set_cr() modifying its interface. emulate.c seems to be
>  vcpu-specifics-free at this moment, we may want to keep it this way.
> - It seems that Hyper-V+UEFI on KVM is still broken, I'm observing =
sporadic
>  hangs even with this patch. These hangs, however, seem to be =
unrelated to
>  rsm.

Feel free to share details on these hangs ;)

Great work,
-Liran

> ---
> arch/x86/include/asm/kvm_emulate.h |  3 ++-
> arch/x86/kvm/emulate.c             | 27 ++++++++++++++-------------
> arch/x86/kvm/x86.c                 | 12 +++++++++++-
> 3 files changed, 27 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/kvm_emulate.h =
b/arch/x86/include/asm/kvm_emulate.h
> index 93c4bf598fb0..6c33caa82fa5 100644
> --- a/arch/x86/include/asm/kvm_emulate.h
> +++ b/arch/x86/include/asm/kvm_emulate.h
> @@ -203,7 +203,8 @@ struct x86_emulate_ops {
> 	void (*set_gdt)(struct x86_emulate_ctxt *ctxt, struct desc_ptr =
*dt);
> 	void (*set_idt)(struct x86_emulate_ctxt *ctxt, struct desc_ptr =
*dt);
> 	ulong (*get_cr)(struct x86_emulate_ctxt *ctxt, int cr);
> -	int (*set_cr)(struct x86_emulate_ctxt *ctxt, int cr, ulong val);
> +	int (*set_cr)(struct x86_emulate_ctxt *ctxt, int cr, ulong val,
> +		      bool from_rsm);
> 	int (*cpl)(struct x86_emulate_ctxt *ctxt);
> 	int (*get_dr)(struct x86_emulate_ctxt *ctxt, int dr, ulong =
*dest);
> 	int (*set_dr)(struct x86_emulate_ctxt *ctxt, int dr, ulong =
value);
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c338984c850d..a6204105d4d7 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -2413,7 +2413,7 @@ static int rsm_enter_protected_mode(struct =
x86_emulate_ctxt *ctxt,
> 		cr3 &=3D ~0xfff;
> 	}
>=20
> -	bad =3D ctxt->ops->set_cr(ctxt, 3, cr3);
> +	bad =3D ctxt->ops->set_cr(ctxt, 3, cr3, true);
> 	if (bad)
> 		return X86EMUL_UNHANDLEABLE;
>=20
> @@ -2422,20 +2422,20 @@ static int rsm_enter_protected_mode(struct =
x86_emulate_ctxt *ctxt,
> 	 * Then enable protected mode.	However, PCID cannot be enabled
> 	 * if EFER.LMA=3D0, so set it separately.
> 	 */
> -	bad =3D ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE);
> +	bad =3D ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE, true);
> 	if (bad)
> 		return X86EMUL_UNHANDLEABLE;
>=20
> -	bad =3D ctxt->ops->set_cr(ctxt, 0, cr0);
> +	bad =3D ctxt->ops->set_cr(ctxt, 0, cr0, true);
> 	if (bad)
> 		return X86EMUL_UNHANDLEABLE;
>=20
> 	if (cr4 & X86_CR4_PCIDE) {
> -		bad =3D ctxt->ops->set_cr(ctxt, 4, cr4);
> +		bad =3D ctxt->ops->set_cr(ctxt, 4, cr4, true);
> 		if (bad)
> 			return X86EMUL_UNHANDLEABLE;
> 		if (pcid) {
> -			bad =3D ctxt->ops->set_cr(ctxt, 3, cr3 | pcid);
> +			bad =3D ctxt->ops->set_cr(ctxt, 3, cr3 | pcid, =
true);
> 			if (bad)
> 				return X86EMUL_UNHANDLEABLE;
> 		}
> @@ -2581,7 +2581,7 @@ static int em_rsm(struct x86_emulate_ctxt *ctxt)
>=20
> 		/* Zero CR4.PCIDE before CR0.PG.  */
> 		if (cr4 & X86_CR4_PCIDE) {
> -			ctxt->ops->set_cr(ctxt, 4, cr4 & =
~X86_CR4_PCIDE);
> +			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE, =
true);
> 			cr4 &=3D ~X86_CR4_PCIDE;
> 		}
>=20
> @@ -2595,11 +2595,12 @@ static int em_rsm(struct x86_emulate_ctxt =
*ctxt)
> 	/* For the 64-bit case, this will clear EFER.LMA.  */
> 	cr0 =3D ctxt->ops->get_cr(ctxt, 0);
> 	if (cr0 & X86_CR0_PE)
> -		ctxt->ops->set_cr(ctxt, 0, cr0 & ~(X86_CR0_PG | =
X86_CR0_PE));
> +		ctxt->ops->set_cr(ctxt, 0, cr0 & ~(X86_CR0_PG | =
X86_CR0_PE),
> +				  true);
>=20
> 	/* Now clear CR4.PAE (which must be done before clearing =
EFER.LME).  */
> 	if (cr4 & X86_CR4_PAE)
> -		ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PAE);
> +		ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PAE, true);
>=20
> 	/* And finally go back to 32-bit mode.  */
> 	efer =3D 0;
> @@ -3131,7 +3132,7 @@ static int load_state_from_tss32(struct =
x86_emulate_ctxt *ctxt,
> 	int ret;
> 	u8 cpl;
>=20
> -	if (ctxt->ops->set_cr(ctxt, 3, tss->cr3))
> +	if (ctxt->ops->set_cr(ctxt, 3, tss->cr3, false))
> 		return emulate_gp(ctxt, 0);
> 	ctxt->_eip =3D tss->eip;
> 	ctxt->eflags =3D tss->eflags | 2;
> @@ -3331,7 +3332,7 @@ static int emulator_do_task_switch(struct =
x86_emulate_ctxt *ctxt,
> 		write_segment_descriptor(ctxt, tss_selector, =
&next_tss_desc);
> 	}
>=20
> -	ops->set_cr(ctxt, 0,  ops->get_cr(ctxt, 0) | X86_CR0_TS);
> +	ops->set_cr(ctxt, 0,  ops->get_cr(ctxt, 0) | X86_CR0_TS, false);
> 	ops->set_segment(ctxt, tss_selector, &next_tss_desc, 0, =
VCPU_SREG_TR);
>=20
> 	if (has_error_code) {
> @@ -3633,7 +3634,7 @@ static int em_movbe(struct x86_emulate_ctxt =
*ctxt)
>=20
> static int em_cr_write(struct x86_emulate_ctxt *ctxt)
> {
> -	if (ctxt->ops->set_cr(ctxt, ctxt->modrm_reg, ctxt->src.val))
> +	if (ctxt->ops->set_cr(ctxt, ctxt->modrm_reg, ctxt->src.val, =
false))
> 		return emulate_gp(ctxt, 0);
>=20
> 	/* Disable writeback. */
> @@ -3766,7 +3767,7 @@ static int em_clts(struct x86_emulate_ctxt =
*ctxt)
>=20
> 	cr0 =3D ctxt->ops->get_cr(ctxt, 0);
> 	cr0 &=3D ~X86_CR0_TS;
> -	ctxt->ops->set_cr(ctxt, 0, cr0);
> +	ctxt->ops->set_cr(ctxt, 0, cr0, false);
> 	return X86EMUL_CONTINUE;
> }
>=20
> @@ -3866,7 +3867,7 @@ static int em_smsw(struct x86_emulate_ctxt =
*ctxt)
> static int em_lmsw(struct x86_emulate_ctxt *ctxt)
> {
> 	ctxt->ops->set_cr(ctxt, 0, (ctxt->ops->get_cr(ctxt, 0) & =
~0x0eul)
> -			  | (ctxt->src.val & 0x0f));
> +			  | (ctxt->src.val & 0x0f), false);
> 	ctxt->dst.type =3D OP_NONE;
> 	return X86EMUL_CONTINUE;
> }
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a419656521b6..f2745e3170b6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5739,7 +5739,8 @@ static unsigned long emulator_get_cr(struct =
x86_emulate_ctxt *ctxt, int cr)
> 	return value;
> }
>=20
> -static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, =
ulong val)
> +static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, =
ulong val,
> +			   bool from_rsm)
> {
> 	struct kvm_vcpu *vcpu =3D emul_to_vcpu(ctxt);
> 	int res =3D 0;
> @@ -5755,7 +5756,16 @@ static int emulator_set_cr(struct =
x86_emulate_ctxt *ctxt, int cr, ulong val)
> 		res =3D kvm_set_cr3(vcpu, val);
> 		break;
> 	case 4:
> +		/*
> +		 * set_cr4() may forbid to set certain flags (e.g. VMXE) =
from
> +		 * SMM but we're actually leaving it; temporary drop =
HF_SMM_MASK
> +		 * when setting CR4.
> +		 */
> +		if (from_rsm)
> +			vcpu->arch.hflags &=3D ~HF_SMM_MASK;
> 		res =3D kvm_set_cr4(vcpu, mk_cr_64(kvm_read_cr4(vcpu), =
val));
> +		if (from_rsm)
> +			vcpu->arch.hflags |=3D HF_SMM_MASK;
> 		break;
> 	case 8:
> 		res =3D kvm_set_cr8(vcpu, val);
> --=20
> 2.20.1
>=20

