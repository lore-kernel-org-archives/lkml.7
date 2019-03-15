Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3B3218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfCORaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:30:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727075AbfCORaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:30:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2FHTmBJ002354
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:29:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r8eegybkj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:29:54 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 15 Mar 2019 17:28:44 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Mar 2019 17:28:42 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2FHSfra33489142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Mar 2019 17:28:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10E6FAE045;
        Fri, 15 Mar 2019 17:28:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1B9AAE051;
        Fri, 15 Mar 2019 17:28:40 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.177])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Mar 2019 17:28:40 +0000 (GMT)
Date:   Fri, 15 Mar 2019 18:28:39 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, borntraeger@de.ibm.com,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
In-Reply-To: <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
        <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
        <20190315112032.13b259c2.cohuck@redhat.com>
        <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031517-0012-0000-0000-000003035FCB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031517-0013-0000-0000-0000213A62F0
Message-Id: <20190315182839.4f7c0a73@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-15_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903150122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 14:26:34 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 15/03/2019 11:20, Cornelia Huck wrote:
> > On Wed, 13 Mar 2019 17:04:58 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> > 
> >> +/*
> >> + * handle_pqap: Handling pqap interception
> >> + * @vcpu: the vcpu having issue the pqap instruction
> >> + *
> >> + * We now support PQAP/AQIC instructions and we need to correctly
> >> + * answer the guest even if no dedicated driver's hook is available.
> >> + *
> >> + * The intercepting code calls a dedicated callback for this instruction
> >> + * if a driver did register one in the CRYPTO satellite of the
> >> + * SIE block.
> >> + *
> >> + * For PQAP/AQIC instructions only, verify privilege and specifications.
> >> + *
> >> + * If no callback available, the queues are not available, return this to
> >> + * the caller.
> >> + * Else return the value returned by the callback.
> >> + */
> >> +static int handle_pqap(struct kvm_vcpu *vcpu)
> >> +{
> >> +	uint8_t fc;
> >> +	struct ap_queue_status status = {};
> >> +	int ret;
> >> +	/* Verify that the AP instruction are available */
> >> +	if (!ap_instructions_available())
> >> +		return -EOPNOTSUPP;
> >> +	/* Verify that the guest is allowed to use AP instructions */
> >> +	if (!(vcpu->arch.sie_block->eca & ECA_APIE))
> >> +		return -EOPNOTSUPP;
> >> +	/* Verify that the function code is AQIC */
> >> +	fc = vcpu->run->s.regs.gprs[0] >> 24;
> >> +	/* We do not want to change the behavior we had before this patch*/
> >> +	if (fc != 0x03)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	/* PQAP instructions are allowed for guest kernel only */
> >> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> >> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> >> +	/* AQIC instruction is allowed only if facility 65 is available */
> >> +	if (!test_kvm_facility(vcpu->kvm, 65))
> >> +		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> >> +	/* Verify that the hook callback is registered and call it */
> >> +	if (vcpu->kvm->arch.crypto.pqap_hook) {
> >> +		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> >> +			return -EOPNOTSUPP;
> >> +		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
> >> +		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
> >> +		return ret;
> >> +	}
> >> +	/*
> >> +	 * It is the duty of the vfio_driver to register a hook
> >> +	 * If it does not and we get an exception on AQIC we must
> >> +	 * guess that there is no vfio_ap_driver at all and no one
> >> +	 * to handle the guests's CRYCB and the CRYCB is empty.
> >> +	 */
> >> +	status.response_code = 0x01;
> > 
> > I'm still confused here, sorry. From previous discussions I recall that
> > this indicates "no crypto device" (please correct me if I'm wrong.)
> > 
> > Before this patch, we had:
> > - guest issues PQAP/AQIC -> drop to userspace
> > 
> > With a correct implementation, we get:
> > - guest issues PQAP/AQIC -> callback does what needs to be done
> > 
> > With an incorrect implementation (no callback), we get:
> > - guest issues PQAP/AQIC -> guest gets response code 0x01
> > 
> > Why not drop to userspace in that case?
> 
> This is what I had in the previous patches.
> Hum, I do not remember which discussion lead me to modify this.
> 
> Anyway, now that you put the finger on this problem, I think the problem 
> is worse.
> 
> The behavior with old / new Linux, vfio driver and qemu is:
> 
> LINUX	VFIO_AP	QEMU	PGM
> OLD	x	x	OPERATION

Isn't OPERATION a bad answer if ap=on? It should not happen
with a well behaved guest because facility 65 is not indicated,
but if it does, I guess we give the wrong answer.

> NEW	-	OLD	SPECIFICATION
> NEW	-	NEW/aqic=off	SPECIFICATION
> NEW	x	NEW/aqic=on	-
> 

AFAICT with LINUX == NEW we get the correct answer. OPERATION exception
is only good if ap=off.

> x = whatever
> - = absent/none
> 
> So yes there is a change in behavior for the userland for the case QEMU 
> do not set the AQIC facility 65, OLD QEMU or NEW QEMU wanting to behave 
> like an older one.
> 
> I fear we have the same problem with the privileged operation...
> 

IMHO this boils down to:
* either OLD QEMU or 
* OLD LINUX
should have taken care of handling the mandatory intercept for PQAP/AQIC
if ap=on (i.e. guest has AP instructions), and does not have facility 65
which was the case for OLD.

Things get complicated when one considers that ECA.28 is an effective
control.

> For the last case, when the kvm_facility(65) is set, the explication is 
> the following:
> 
> This is related to the handling of PQAP AQIC which is now authorized by 
> this patch series.
> If we authorize PQAP AQIC, by setting the bit for facility 65, the guest 
> can use this instruction.
> If the instruction follows the specifications we must answer something 
> realistic and since there is nothing in the CRYCB (no driver) we answer 
> that there is no queue.
> 
> Conclusion:  we must handle this in userland, it will have the benefit 
> to keep old behavior when there is no callback.
> OLD QEMU will not see change as they will not set aqic facility

That would mean we remain quirky.

> NEW QEMU will handle this correctly.
> 
> In this case we also do not need to handle all other tests here but can 
> move it to the callback as Tony wanted.
> 
> Would you agree with something simple like:
> 
> static int handle_pqap(struct kvm_vcpu *vcpu)
> {
>          int ret = -EOPNOTSUPP;
> 
>          /* Verify that the hook callback is registered and call it */
>          if (pqap_hook)
>                  if (try_module_get(pqap_hook->owner)) {
>                          ret = pqap_hook->hook(vcpu);
>                          module_put(pqap_hook->owner);
>                  }
>          return ret;
> }
> 
> All other tests in QEMU and in the callback.
> 

You stated in another email that the conclusion is wrong. I'm not sure
what is the cleanest solution here. This effective control thing does
make my head spin.

Regards,
Halil

