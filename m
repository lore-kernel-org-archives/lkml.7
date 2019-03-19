Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39468C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094F12175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfCSOye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:54:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727679AbfCSOyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:54:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JEnc7G104481
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:54:31 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rb2fn8ggp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:54:30 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 19 Mar 2019 14:54:24 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 14:54:20 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JEsNEf40501426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 14:54:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9416DA4057;
        Tue, 19 Mar 2019 14:54:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35DD8A4053;
        Tue, 19 Mar 2019 14:54:23 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.98.162])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 14:54:23 +0000 (GMT)
Date:   Tue, 19 Mar 2019 15:54:21 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, borntraeger@de.ibm.com,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
In-Reply-To: <0351d631-b756-dd22-0848-6f30747dc5e2@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
        <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
        <20190315112032.13b259c2.cohuck@redhat.com>
        <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
        <20190315182839.4f7c0a73@oc2783563651>
        <0351d631-b756-dd22-0848-6f30747dc5e2@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031914-0020-0000-0000-00000325319A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031914-0021-0000-0000-000021774B89
Message-Id: <20190319155421.0f0e51c2@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 11:01:44 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 15/03/2019 18:28, Halil Pasic wrote:

[..]

> > 
> > Things get complicated when one considers that ECA.28 is an effective
> > control.
> 
> I don't think so, ECA_28 is not really a problem.
> We do not propagate ECA_AIV in VSIE and ECA_AIV is tested in the vfio 
> driver to support GISA.
> So that the guest 3 will not support interrupt.
> 

That was not my concern, but while we are at it... I guess you refer to
the check in handle_pqap(). That seems to do -EOPNOTSUPP, i.e. got to
userspace, i.e. with today's QEMU operation exception. Which does not
seem right.

My concern was the following. Let assume 
ECA.28 == 1 and EECA.28 == 0 != 1
and guest issues a PQAP (for simplicity AQIC).

Currently I guess we take a 0x04 interception and go to userspace, which
may or may not be the best thing to do.

With this patch we would take a 0x04, but (opposed to before) if guest
does not have facility 65 we go with a specification exception.
Operation exception should however take priority over this kind of
specification exception. So basically everything except PQAP/AQIC would
give you and operation exception (with current QEMU), but PQAP/AQIC would
give you a specification exception. Which is wrong!

AFAICT there is no way to tell if we got a 04 interception because
EECA.28 != 1 (and ECA.28 == 1) and FW won't interpret the AP
instructions for us, or because it PQAP/AQIC is a mandatory intercept.
In other words I don't see a way to tell if EECA.28 is 1 when
interpreting PQAP/AQIC.

Do you agree?

[..]

> 
> Yes, the alternative is:
> 
> 1) We do things right but this mean we change the ABI (SPECIFICATION 
> instead of OPERATION)
> 
> I thing this is the best thing to do, it is the implementation
> proposed by this patch where all is done in Kernel, so that we are
> right what ever the userland user is (QEMU or other).
> 
> 2) We want to preserve the old ABI for old QEMU
> Then I proposed the implementation here under.
> 
> 
> My personal opinion, is that we should change the ABI and do things 
> right now.

I tend to agree. Giving an operation exception instead of a specification
exception is a bug. If it is a kernel or qemu bug it ain't clear to me
at the moment. 

> We should also do it right for TAPQ with t bit set. I remember
> Christian already warned about this but we did not implement it.
> 

Yes, I have some blurry memories of something similar myself. I wonder
if there was a reason, or did we just forget to address this issue.

Regards,
Halil

