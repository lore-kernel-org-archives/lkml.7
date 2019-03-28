Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42C621773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfC1QMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:12:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbfC1QMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:12:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SG9WI7119706
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:12:23 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rh1gv8b75-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:12:22 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 28 Mar 2019 16:12:21 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 16:12:18 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2SGCCrD14942384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 16:12:12 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F20678064;
        Thu, 28 Mar 2019 16:12:12 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CA4F7805C;
        Thu, 28 Mar 2019 16:12:11 +0000 (GMT)
Received: from [9.60.75.235] (unknown [9.60.75.235])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 16:12:10 +0000 (GMT)
Subject: Re: [PATCH v6 1/7] s390: ap: kvm: add PQAP interception for AQIC
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-2-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 28 Mar 2019 12:12:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1553265828-27823-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032816-0004-0000-0000-000014F45D05
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010829; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01180947; UDB=6.00618064; IPR=6.00961666;
 MB=3.00026196; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-28 16:12:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032816-0005-0000-0000-00008B0F5393
Message-Id: <32716ed4-559f-0c36-cdf3-4c6662e02f4b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 10:43 AM, Pierre Morel wrote:
> We prepare the interception of the PQAP/AQIC instruction for
> the case the AQIC facility is enabled in the guest.
> 
> First of all we do not want to change existing behavior when
> intercepting AP instructions without the SIE allowing the guest
> to use AP instructions.
> 
> In this patch we only handle the AQIC interception allowed by
> facility 65 which will be enabled when the complete interception
> infrastructure will be present.
> 
> We add a callback inside the KVM arch structure for s390 for
> a VFIO driver to handle a specific response to the PQAP
> instruction with the AQIC command and only this command.
> 
> But we want to be able to return a correct answer to the guest
> even there is no VFIO AP driver in the kernel.
> Therefor, we inject the correct exceptions from inside KVM for the
> case the callback is not initialized, which happens when the vfio_ap
> driver is not loaded.
> 
> We do consider the responsability of the driver to always initialize
> the PQAP callback if it defines queues by initializing the CRYCB for
> a guest.
> If the callback has been setup we call it.
> If not we setup an answer considering that no queue is available
> for the guest when no callback has been setup.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h      |  8 ++++
>   arch/s390/kvm/priv.c                  | 90 +++++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>   3 files changed, 100 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index a496276..624460b 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -18,6 +18,7 @@
>   #include <linux/kvm_host.h>
>   #include <linux/kvm.h>
>   #include <linux/seqlock.h>
> +#include <linux/module.h>
>   #include <asm/debug.h>
>   #include <asm/cpu.h>
>   #include <asm/fpu/api.h>
> @@ -721,8 +722,15 @@ struct kvm_s390_cpu_model {
>   	unsigned short ibc;
>   };
>   
> +struct kvm_s390_module_hook {
> +	int (*hook)(struct kvm_vcpu *vcpu);
> +	void *data;
> +	struct module *owner;
> +};
> +
>   struct kvm_s390_crypto {
>   	struct kvm_s390_crypto_cb *crycb;
> +	struct kvm_s390_module_hook *pqap_hook;
>   	__u32 crycbd;
>   	__u8 aes_kw;
>   	__u8 dea_kw;
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 8679bd7..793e48a 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -27,6 +27,7 @@
>   #include <asm/io.h>
>   #include <asm/ptrace.h>
>   #include <asm/sclp.h>
> +#include <asm/ap.h>
>   #include "gaccess.h"
>   #include "kvm-s390.h"
>   #include "trace.h"
> @@ -592,6 +593,93 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>   	}
>   }
>   
> +/*
> + * handle_pqap: Handling pqap interception
> + * @vcpu: the vcpu having issue the pqap instruction
> + *
> + * We now support PQAP/AQIC instructions and we need to correctly
> + * answer the guest even if no dedicated driver's hook is available.
> + *
> + * The intercepting code calls a dedicated callback for this instruction
> + * if a driver did register one in the CRYPTO satellite of the
> + * SIE block.
> + *
> + * For PQAP AQIC and TAPQ instructions, verify privilege and specifications.
> + *
> + * If no callback available, the queues are not available, return this to
> + * the caller.
> + * Else return the value returned by the callback.
> + */
> +static int handle_pqap(struct kvm_vcpu *vcpu)
> +{
> +	struct ap_queue_status status = {};
> +	unsigned long reg0;
> +	int ret;
> +	uint8_t fc;
> +
> +	/* Verify that the AP instruction are available */
> +	if (!ap_instructions_available())
> +		return -EOPNOTSUPP;
> +	/* Verify that the guest is allowed to use AP instructions */
> +	if (!(vcpu->arch.sie_block->eca & ECA_APIE))
> +		return -EOPNOTSUPP;
> +	/*
> +	 * The only possibly intercepted instructions when AP instructions are
> +	 * available for the guest are AQIC and TAPQ with the t bit set
> +	 * since we do not set IC.3 (FIII) we currently will not intercept
> +	 * TAPQ.
> +	 * The following code will only treat AQIC function code.
> +	 */
> +	reg0 = vcpu->run->s.regs.gprs[0];
> +	fc = reg0 >> 24;
> +	if (fc != 0x03) {
> +		pr_warn("%s: Unexpected interception code 0x%02x\n",
> +			__func__, fc);
> +		return -EOPNOTSUPP;
> +	}
> +	/* All PQAP instructions are allowed for guest kernel only */
> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> +	/*
> +	 * Common tests for PQAP instructions to generate a specification
> +	 * exception
> +	 */
> +	/* Zero bits overwrite produce a specification exception */
> +	if (reg0 & 0x007f0000UL)
> +		goto specification_except;
> +	/* If APXA is not installed APQN is limited */
> +	if (!(vcpu->kvm->arch.crypto.crycbd & 0x02))
> +		if (reg0 & 0x000030f0UL)
> +			goto specification_except;
> +	/* AQIC needs facility 65 */
> +	if (!test_kvm_facility(vcpu->kvm, 65))
> +		goto specification_except;
> +
> +	/*
> +	 * Verify that the hook callback is registered, lock the owner
> +	 * and call the hook.
> +	 */
> +	if (vcpu->kvm->arch.crypto.pqap_hook) {
> +		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> +			return -EOPNOTSUPP;
> +		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
> +		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
> +		return ret;
> +	}
> +	/*
> +	 * It is the duty of the vfio_driver to register a hook
> +	 * If it does not and we get an exception on AQIC we must
> +	 * guess that there is no vfio_ap_driver at all and no one
> +	 * to handle the guests's CRYCB and the CRYCB is empty.
> +	 */
> +	status.response_code = 0x01;
> +	memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
> +	return 0;
> +
> +specification_except:
> +	return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +}
> +
>   static int handle_stfl(struct kvm_vcpu *vcpu)
>   {
>   	int rc;
> @@ -878,6 +966,8 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
>   		return handle_sthyi(vcpu);
>   	case 0x7d:
>   		return handle_stsi(vcpu);
> +	case 0xaf:
> +		return handle_pqap(vcpu);
>   	case 0xb1:
>   		return handle_stfl(vcpu);
>   	case 0xb2:
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 76b7f98..a910be1 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -16,6 +16,7 @@
>   #include <linux/mdev.h>
>   #include <linux/delay.h>
>   #include <linux/mutex.h>
> +#include <linux/kvm_host.h>
>   
>   #include "ap_bus.h"
>   
> @@ -81,6 +82,7 @@ struct ap_matrix_mdev {
>   	struct ap_matrix matrix;
>   	struct notifier_block group_notifier;
>   	struct kvm *kvm;
> +	struct kvm_s390_module_hook pqap_hook;

I don't understand the purpose of adding this field. We set up the
the kvm->arch.crypto.pqap_hook in the vfio_ap_mdev_set_kvm which is
also in this same file, why not just use a static struct 
kvm_s390_module_hook and reuse it when setting up
kvm->arch.crypto.pqap_hook? It saves you from initializing it every
time an ap_matrix_mdev is created.

>   };
>   
>   extern int vfio_ap_mdev_register(void);
> 

