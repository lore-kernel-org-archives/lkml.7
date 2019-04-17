Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C8FC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9FC20674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbfDQPiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:38:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732723AbfDQPiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:38:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3HFWNbr097161
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:38:09 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rx4j37dax-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:38:08 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 17 Apr 2019 16:38:05 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Apr 2019 16:38:03 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3HFc18J59506816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 15:38:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86278A4051;
        Wed, 17 Apr 2019 15:38:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00706A404D;
        Wed, 17 Apr 2019 15:38:01 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.99.136])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Apr 2019 15:38:00 +0000 (GMT)
Date:   Wed, 17 Apr 2019 17:37:59 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Reinhard Buendgen <buendgen@de.ibm.com>,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        pmorel@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com
Subject: Re: [PATCH 1/7] s390: zcrypt: driver callback to indicate resource
 in use
In-Reply-To: <0c7dbcd5-295c-8dc1-7223-01866694ebc4@linux.ibm.com>
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
        <1555016604-2008-2-git-send-email-akrowiak@linux.ibm.com>
        <223c82c7-6a75-7209-3652-c2341c83878f@linux.ibm.com>
        <20190412114313.0156c01b.cohuck@redhat.com>
        <89f09e58-eab6-94d4-c5aa-937162d60744@linux.ibm.com>
        <20190415115030.1df61182.cohuck@redhat.com>
        <3d762e51-7210-529f-61de-98d80689bff6@linux.ibm.com>
        <20190415205950.7655cee3@oc2783563651>
        <0c7dbcd5-295c-8dc1-7223-01866694ebc4@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041715-0016-0000-0000-0000026FECE8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041715-0017-0000-0000-000032CC3F76
Message-Id: <20190417173759.3a7d20d7@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=641 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 18:43:24 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 4/15/19 2:59 PM, Halil Pasic wrote:
> > On Mon, 15 Apr 2019 12:51:23 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> > 
> >> Having said that, I understand your concern about a driver hogging
> >> resources. I think I can provide a solution that serves both the
> >> purpose of preventing problems associated with accidental removal
> >> of AP resources as well as allowing root to remove them
> >> forcefully. I'll work on that for v2.
> > 
> > Can you tell us some more about this solution? Should we stop reviewing
> > v1 because v2 is going to be different anyway?
> 
> Patch 1 and 2 will be removed. There will not be a major design change
> between these patches and v2. In order to avoid a long explanation of
> my proposed changes, I'd prefer to state that the patch set will 
> establish and enforce the following rules:
> 
>      1. An APQN can be assigned to an mdev device iff it is NOT
>         reserved for use by a zcrypt driver and is not assigned to
>         another mdev device.
> 
>      2. Once an APQN is assigned to an mdev device, it will remain
>         assigned until it is explicitly unassigned.
> 
>      3. A queue's APQN can be set in the guest's CRYCB iff the APQN is
>         assigned to the mdev device used by the guest; however, if the
>         queue is also in the host configuration (i.e., online), it MUST
>         also be bound to the vfio_ap device driver.
> 
>      4. When a queue is bound to the vfio_ap driver and its APQN
>         is assigned to an mdev device in use by a guest, the guest will
>         be given access to the queue.
> 
>      5. When a queue is unbound from the vfio_ap driver and its APQN
>         is assigned to an mdev device in use by the guest, access to
>         the card containing the queue will be removed from the guest.
>         Keep in mind that we can not deny access to a specific queue
>         due to the architecture (i.e., clearing a bit in the AQM
>         removes access to the queue for all adapters)
> 
>      6. When an adapter is assigned to an mdev device that is in use
>         by a guest, the guest will be given access to the adapter.
> 
>      7. When an adapter is unassigned from an mdev device that is in use
>         by a guest, access to the adapter will removed from the guest.
> 
>      8. When a domain is assigned to an mdev device that is in use
>         by a guest, the guest will be given access to the domain.
> 
>      9. When a domain is unassigned from an mdev device that is in use
>         by a guest, access to the domain will removed from the guest.
> 

Based on our off-the-list chat and this list I think I know
where are you heading :). I think it's actually the design that I
currently prefer the most. But in that case, it may be wise to touch
base with Reinhard -- AFAIR he was the strongest proponent of the 'do
not let a[pq]mask changes take away queues from guests' design.

Regards,
Halil

