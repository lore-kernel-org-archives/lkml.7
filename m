Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B662C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F46521738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfDWP11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:27:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727180AbfDWP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:27:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NFQsNx091257
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:27:26 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s23rm551h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:27:25 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 23 Apr 2019 16:27:21 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 16:27:17 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NFRDRT58720436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 15:27:13 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59F48C6055;
        Tue, 23 Apr 2019 15:27:13 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F687C6059;
        Tue, 23 Apr 2019 15:27:12 +0000 (GMT)
Received: from [9.60.75.251] (unknown [9.60.75.251])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 15:27:12 +0000 (GMT)
Subject: Re: [PATCH v2 7/8] s390: vfio-ap: handle bind and unbind of AP queue
 device
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        pmorel@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
 <1555796980-27920-8-git-send-email-akrowiak@linux.ibm.com>
 <20190423155458.65966ebf.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 23 Apr 2019 11:27:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190423155458.65966ebf.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19042315-0036-0000-0000-00000AAC0C96
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010981; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193273; UDB=6.00625527; IPR=6.00974094;
 MB=3.00026559; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 15:27:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042315-0037-0000-0000-00004B7F7A27
Message-Id: <604cb4b6-5baa-16f9-4e6e-1459453376b6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/19 9:54 AM, Halil Pasic wrote:
> On Sat, 20 Apr 2019 17:49:39 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> +void vfio_ap_mdev_probe_queue(unsigned long apid, unsigned long apqi)
>> +{
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +
>> +	matrix_mdev = vfio_ap_mdev_find_matrix_mdev(apid, apqi);
>> +
>> +	/*
>> +	 * If the queue is assigned to the mdev device and the mdev device
>> +	 * is in use by a guest
>> +	 */
>> +	if (matrix_mdev && matrix_mdev->kvm) {
>> +		/* Plug the adapter into the guest */
>> +		set_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
>> +
>> +		/* Make sure the queue is also plugged in to the guest */
>> +		if (!test_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm))
>> +			set_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
>> +
>> +		vfio_ap_mdev_update_crycb(matrix_mdev);
> 
> With this you effectively grant access to all the assigned domains on
> the AP identified by the apid, not only to the domain identified by
> apqi! But some of these queues may still not be bound to the vfio_ap
> driver.

I have been doing some more testing since I last visited and discovered
that there needs to be additional checking here.

> 
> IMHO you should only set the apid-th bit in apm if all queues (apid, q)
> such that q-th bit is set in aqm are bound to the vfio_ap driver.

This is partially correct. It is not necessary to verify that the
affected queues are bound to the vfio_ap driver. It is only necessary
to verify they are not reserved for use by a zcrypt driver since we
are allowing assignment of APQNs for queues that are not available (see
patch 3/8).

> 
> BTW a 'shadow' (or effective) apm would perfectly suffice. I don't think
> you fiddle with shadow_crycb->a[qd]m, and if you do, I don't think that's
> a good idea.

I do not think it is accurate to refer to the APM in the shadow CRYCB as
an effective mask. Effective masking is a firmware construct. The CRYCB
of the guest may be configured with APQNs that are not available.

The shadow CRYCB is in fact a copy of the guest CRYCB. Whenever the
masks in the guest CRYCB are set, they are set from the masks in the
shadow CRYCB. The lifespan of the shadow CRYCB is synonymous with the
lifespan of the guest.

Each of the mdev device sysfs assignment/unassignment interfaces does
fiddle with the masks in the shadow CRYCB if a guest is using the mdev
device. This allows us to hot plug/unplug AP resources for the guest.
Recall that an adapter or domain can not be assigned unless each
new APQN created is NOT reserved for use by the zcrypt drivers via
the AP bus's apmask/aqmask sysfs interfaces, and the APQN is not 
assigned to any other mdev device. That is how protection is
provided against inadvertently sharing AP queues between guests or
the guest and the host. I do have to add that verification to
the vfio_ap_mdev_probe_queue function though.



> 
> Regards,
> Halil
> 
>> +	}
>> +}
> 

