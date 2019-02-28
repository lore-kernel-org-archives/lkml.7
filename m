Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E480CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D572184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbfB1Qvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:51:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727861AbfB1Qvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:51:42 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SGoSmP076004
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:51:41 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qxj3en159-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:51:41 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 28 Feb 2019 16:51:39 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 16:51:36 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1SGpYp054460642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Feb 2019 16:51:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 607E84203F;
        Thu, 28 Feb 2019 16:51:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E55DE42041;
        Thu, 28 Feb 2019 16:51:33 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.99.237])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Feb 2019 16:51:33 +0000 (GMT)
Date:   Thu, 28 Feb 2019 17:51:32 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
In-Reply-To: <c391ed0f-55f1-70cc-3b5f-058c1fce691c@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
        <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
        <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
        <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
        <9f1d9241-39b9-adbc-d0e9-cb702e609cbc@linux.ibm.com>
        <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
        <8526f468-9a4d-68d2-3868-0dad5ce16f46@linux.ibm.com>
        <6058a017-6404-af3c-62ef-2452214ac97c@de.ibm.com>
        <20190228133927.75de6849@oc2783563651>
        <c391ed0f-55f1-70cc-3b5f-058c1fce691c@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022816-0012-0000-0000-000002FB63C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022816-0013-0000-0000-0000213310B4
Message-Id: <20190228175132.0b5b6424@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 15:12:16 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 28/02/2019 13:39, Halil Pasic wrote:
> > On Thu, 28 Feb 2019 10:42:23 +0100
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
[..]
> >> Correct?
> > 
> > IMHO mostly.
> > 
> > I also doing the facility checks in kvm is easier, and I think this is
> > something we can change later if needed without any major trouble.
> > 
> > There are a couple of things I would do differently than Pierre does:
> > 1) Do the PGM_PRIVILEGED_OP before the fc == 3 check.
> 
> Idea was not to modify existing behavior for fc != 3
> 
> Also Christian already proposed to handle all FC codes. So in this idea, 
> this must be done as you say.
> 
> > 
> > 2) Do the test_kvm_facility(vcpu->kvm, 65) check in the context of fc ==
> > 3. I.e. decide if this hook is about pqap or just about pqap aqic and
> > make the code convey that decision to its reader.
> > 
> > 3) I would most probably test if the queue is available by looking at the
> > masks in CRYCB here. If not AP_RESPONSE_Q_NOT_AVAIL is what we need.
> 
> This I do not agree with, it is typically the responsibility of the part 
> in charge of the virtualization to do this, also the vfio_driver.
> 

See at 4) regarding the details. My guess is you disagree with checking
CRYCB explicitly but don't digress with AP_RESPONSE_Q_NOT_AVAIL if APCB
does not authorize the queue. Your idea was to infer APCB all zero from
the fact that pqap_hook is NULL.

If my assumption is right, then yes we can have an implicit coarse check
here and a fine grained check in the client code (vfio_ap).

> > 
> > 4) If we have APIE and queues authorized by the CRYCB (i.e. we have a
> > vfio_ap module loaded an an mdev associated with the kvm) the callback
> > not set (!(vcpu->kvm->arch.crypto.pqap_hook)) is a BUG!
> 
> I do not agree with this either, the maintainers ;) will not allow this.

After an offline discussion we came to the conclusion that I did not
understand your code.

Your train of thought was:

!(vcpu->kvm->arch.crypto.pqap_hook) _implies_ APCB all zero (i.e. the
masks in the CRYCB

This is *why* you respond with AP_RESPONSE_Q_NOT_AVAIL.

However if that is the case I would like that spelled out in a code
comment at least. Furthermore setting pqap_hook and APCB needs to happen
in the right sequence. Means client code (vfio_ap) may only set APCB
after the qpap_hook has been set. Currently we have a race there (as
you first do  kvm_arch_crypto_set_masks and only then
kvm->arch.crypto.pqap_hook. Furthermore I guess
kvm->arch.crypto.pqap_hook needs to be set with the kvm lock held, which
does not seem to be the case.

> 
> > In that case
> > lying that the queue is not available does not seem right. BTW this
> > is something Pierre changed since the last version quietly (I can't
> > recall a mention in the change log or somebody asking for this). If
> > we want to be very pedantic about this bug scenario our best bet is
> > probably response code 6.
> 
> 
> RC 06 means "Invalid address of AP-queue notification byte"
> 
> So you must have think about another code or I do not understand at
> all what you mean.
> 

I did not assume you decided to ignore the possibility of a programming
error (which you at least technically did commit yourself) for what I
described as a BUG.

My train of thought was, if we are very pedantic we can make things work
with degraded functionality in that case. I.e. without AP interrupts.
For that we need to tell the guest something like: yes your queue is
fine and there and all that but AQCI setup interrupts did not work. And
RC 06 is the only RC I see being suitable to convey that.

Detect and handle if the client code does not hold up their end of the
bargain or just ignore the possibility is a design decision. But at least
you should spell out your expectations against the client code.

Regards,
Halil

