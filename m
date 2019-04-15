Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64A8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8816E2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfDOJyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:54:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbfDOJyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:54:54 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3F9sQlv082017
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:54:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rvqjm0hby-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:54:52 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 15 Apr 2019 10:54:51 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 10:54:49 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3F9slSv61669410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 09:54:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 962A4A405B;
        Mon, 15 Apr 2019 09:54:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA50AA4054;
        Mon, 15 Apr 2019 09:54:46 +0000 (GMT)
Received: from [9.145.19.38] (unknown [9.145.19.38])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 09:54:46 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH 6/7] s390: vfio-ap: handle dynamic config/deconfig of AP
 adapter
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
 <1555016604-2008-7-git-send-email-akrowiak@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 15 Apr 2019 11:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555016604-2008-7-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041509-0012-0000-0000-0000030EE830
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041509-0013-0000-0000-000021471BFB
Message-Id: <8e6dbb48-3d8b-431f-4b62-f4d30e6635ce@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 23:03, Tony Krowiak wrote:
> Once an APQN is assigned to an mdev device it will remained assigned until
> it is explicitly unassigned from the mdev device. The associated AP queue
> devices, however, can come and go due to failures or deliberate actions by
> a sysadmin. For example, a sysadmin can dynamically remove an AP adapter
> card using the SE or by executing an SCLP command. This patch refactors
> the probe and remove callbacks of the vfio_ap driver to handle dynamic
> changes as follows:
> 
> * Probe callback changes:
> 
>    If the APQN of the queue being probed is assigned to an mdev device, the
>    mdev device is in use by a guest, and the APQN is not set in the guest's
>    CRYCB, the CRYCB will be dynamically updated to give the guest access to
>    the queue.
> 
> * Remove callback changes:
> 
>    If the APQN of the queue being removed is assigned to an mdev device,
>    the mdev
>    device is in use by a guest, and the APQN is set in the guest's CRYCB,
>    the CRYCB will be dynamically updated to remove the guest's access to
>    the adapter card associated with the queue. Keep in mind, the
>    architecture does not provide a way to remove access to a single queue
>    unless only one queue is in the guest's configuration, so it was decided
>    that it makes more sense to unplug the adapter from the guest.
> 
>    The APQN of the queue being removed will remain assigned to the mdev
>    device should the queue be dynamically returned to the configuration.
>    The queue will also be reset prior to returning control to the caller
>    (a.k.a., the AP bus).
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h      |  2 ++
>   arch/s390/kvm/kvm-s390.c              | 37 +++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_drv.c     | 16 +++++++--
>   drivers/s390/crypto/vfio_ap_ops.c     | 67 +++++++++++++++++++++++++++++++++--
>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>   5 files changed, 120 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index c47e22bba87f..0ce5d9b0df59 100644kvm_s390_crypto_cb
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -895,6 +895,8 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>   void kvm_arch_crypto_clear_masks(struct kvm *kvm);
>   void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
>   			       unsigned long *aqm, unsigned long *adm);
> +int kvm_arch_crypto_test_masks(struct kvm *kvm, unsigned long *apm,
> +			       unsigned long *aqm, unsigned long *adm);
>   
>   extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>   extern char sie_exit;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 4638303ba6a8..5f423cdd29ba 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2217,6 +2217,43 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
>   		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
>   }
>   

This function requires the big matrix lock, may be add a comment.

> +int kvm_arch_crypto_test_masks(struct kvm *kvm, unsigned long *apm,
> +			       unsigned long *aqm, unsigned long *adm)
> +{
> +	int ret;
> +	struct kvm_s390_crypto_cb *crycb = kvm->arch.crypto.crycb;
> +
> +	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
> +	case CRYCB_FORMAT2: /* APCB1 use 256 bits */
> +		ret = bitmap_equal(apm, (unsigned long *)crycb->apcb1.apm, 256);
> +		VM_EVENT(kvm, 3, "TEST CRYCB: apm %016lx %016lx %016lx %016lx",
> +			 apm[0], apm[1], apm[2], apm[3]);
> +		ret &= bitmap_equal(aqm,
> +				    (unsigned long *)crycb->apcb1.aqm, 256);
> +		VM_EVENT(kvm, 3, "TEST CRYCB: aqm %016lx %016lx %016lx %016lx",
> +			 aqm[0], aqm[1], aqm[2], aqm[3]);
> +		ret &= bitmap_equal(adm,
> +				    (unsigned long *)crycb->apcb1.adm, 256);
> +		VM_EVENT(kvm, 3, "TEST CRYCB: adm %016lx %016lx %016lx %016lx",
> +			 adm[0], adm[1], adm[2], adm[3]);
> +		break;
> +	case CRYCB_FORMAT1:
> +	case CRYCB_FORMAT0: /* Fall through both use APCB0 */
> +		ret = bitmap_equal(apm, (unsigned long *)crycb->apcb1.apm, 64);
> +		ret &= bitmap_equal(aqm, (unsigned long *)crycb->apcb1.aqm, 16);
> +		ret &= bitmap_equal(adm, (unsigned long *)crycb->apcb1.adm, 16);
> +		VM_EVENT(kvm, 3, "TEST CRYCB: apm %016lx aqm %04x adm %04x",
> +			 apm[0], *((unsigned short *)aqm),
> +			 *((unsigned short *)adm));
> +		break;
> +	default:	/* Can not happen */
> +		ret = 0;
> +		break;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kvm_arch_crypto_test_masks);

Wouldn't it be interesting to work on the ap_matrix structure instead of 
on the real CRYCB?
You could spare a lot of tests and wouldn't require to change this file.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

