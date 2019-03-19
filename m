Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E40C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDFC20811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfCSP1Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:27:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727368AbfCSP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:27:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JFJxQ5077155
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 11:27:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rb0rd85xb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 11:27:22 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 19 Mar 2019 15:27:16 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 15:27:12 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JFRDkN45809848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 15:27:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE3C9AE053;
        Tue, 19 Mar 2019 15:27:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A293AE045;
        Tue, 19 Mar 2019 15:27:13 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.98.162])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 15:27:13 +0000 (GMT)
Date:   Tue, 19 Mar 2019 16:27:12 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v5 4/7] s390: ap: setup relation betwen KVM and mediated
 device
In-Reply-To: <dc32eea1-31c9-790e-f012-71259e51cb8c@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
        <1552493104-30510-5-git-send-email-pmorel@linux.ibm.com>
        <20190315191557.6c8d7668@oc2783563651>
        <7c199329-0e82-ff61-46b7-78237a0f01ce@linux.ibm.com>
        <20190319125425.0cf5324e@oc2783563651>
        <2c459ebe-2b37-72bc-1ede-b196e54dc78d@linux.ibm.com>
        <dc32eea1-31c9-790e-f012-71259e51cb8c@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19031915-0008-0000-0000-000002CF318C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031915-0009-0000-0000-0000223B455D
Message-Id: <20190319162712.37f804f8@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=957 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 15:47:05 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> >>>>>        if (matrix_mdev->kvm)
> >>>>>            kvm_arch_crypto_clear_masks(matrix_mdev->kvm);  
> >>>>
> >>>> This still conditional?  
> >>>
> >>> Yes, nothing to clear if there is no KVM.
> >>>  
> >>
> >> Since we have ensured the open only works if there is a KVM at that
> >> point in time, and we have taken a reference to KVM, I would expect
> >> KVM can not go away before we give up our reference.  
> > 
> > Right.  
> 
> Right but based on the assumption we do a kvm_get_kvm() during open.
> 
> But now we will do it inside the notifier, so the logic is to do a 
> kvm_put_kvm in the notifier too.
> This is important because userland will ask us to release the KVM/VFIO 
> link through this notifier.
> So I will have to rework this part where KVM==NULL in the notifier too.
> 
> Regards,
> Pierre

I think it can be done both ways. If you ensure KVM != NULL if the open
succeeds and take the reference in the notifier. I suppose if open()
fails release() won't be called. But the logic/code in open() would get
quite ugly because the callback could be called assync so that it
overlaps with the rest of open().

Not failing open() in case of no KVM is there yet is in my opinion
cleaner anyway.

Regards,
Halil 

