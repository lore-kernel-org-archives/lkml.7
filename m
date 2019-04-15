Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A21C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1164A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfDOWnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:43:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727243AbfDOWnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:43:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FMY60B027407
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 18:43:34 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rw1ws25we-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 18:43:33 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 15 Apr 2019 23:43:32 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 23:43:28 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FMhPBp21889252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 22:43:25 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68FBEAE05F;
        Mon, 15 Apr 2019 22:43:25 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF962AE05C;
        Mon, 15 Apr 2019 22:43:24 +0000 (GMT)
Received: from [9.80.223.51] (unknown [9.80.223.51])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 22:43:24 +0000 (GMT)
Subject: Re: [PATCH 1/7] s390: zcrypt: driver callback to indicate resource in
 use
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Reinhard Buendgen <buendgen@de.ibm.com>,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        pmorel@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
 <1555016604-2008-2-git-send-email-akrowiak@linux.ibm.com>
 <223c82c7-6a75-7209-3652-c2341c83878f@linux.ibm.com>
 <20190412114313.0156c01b.cohuck@redhat.com>
 <89f09e58-eab6-94d4-c5aa-937162d60744@linux.ibm.com>
 <20190415115030.1df61182.cohuck@redhat.com>
 <3d762e51-7210-529f-61de-98d80689bff6@linux.ibm.com>
 <20190415205950.7655cee3@oc2783563651>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Mon, 15 Apr 2019 18:43:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190415205950.7655cee3@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041522-0060-0000-0000-0000032D490A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010934; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189626; UDB=6.00623318; IPR=6.00970412;
 MB=3.00026458; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-15 22:43:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041522-0061-0000-0000-000048F6FB6D
Message-Id: <0c7dbcd5-295c-8dc1-7223-01866694ebc4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=903 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 2:59 PM, Halil Pasic wrote:
> On Mon, 15 Apr 2019 12:51:23 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> Having said that, I understand your concern about a driver hogging
>> resources. I think I can provide a solution that serves both the
>> purpose of preventing problems associated with accidental removal
>> of AP resources as well as allowing root to remove them
>> forcefully. I'll work on that for v2.
> 
> Can you tell us some more about this solution? Should we stop reviewing
> v1 because v2 is going to be different anyway?

Patch 1 and 2 will be removed. There will not be a major design change
between these patches and v2. In order to avoid a long explanation of
my proposed changes, I'd prefer to state that the patch set will 
establish and enforce the following rules:

     1. An APQN can be assigned to an mdev device iff it is NOT
        reserved for use by a zcrypt driver and is not assigned to
        another mdev device.

     2. Once an APQN is assigned to an mdev device, it will remain
        assigned until it is explicitly unassigned.

     3. A queue's APQN can be set in the guest's CRYCB iff the APQN is
        assigned to the mdev device used by the guest; however, if the
        queue is also in the host configuration (i.e., online), it MUST
        also be bound to the vfio_ap device driver.

     4. When a queue is bound to the vfio_ap driver and its APQN
        is assigned to an mdev device in use by a guest, the guest will
        be given access to the queue.

     5. When a queue is unbound from the vfio_ap driver and its APQN
        is assigned to an mdev device in use by the guest, access to
        the card containing the queue will be removed from the guest.
        Keep in mind that we can not deny access to a specific queue
        due to the architecture (i.e., clearing a bit in the AQM
        removes access to the queue for all adapters)

     6. When an adapter is assigned to an mdev device that is in use
        by a guest, the guest will be given access to the adapter.

     7. When an adapter is unassigned from an mdev device that is in use
        by a guest, access to the adapter will removed from the guest.

     8. When a domain is assigned to an mdev device that is in use
        by a guest, the guest will be given access to the domain.

     9. When a domain is unassigned from an mdev device that is in use
        by a guest, access to the domain will removed from the guest.

> 
> Regards,
> Halil
> 

