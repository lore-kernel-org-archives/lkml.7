Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD3CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F86218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfDWNzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:55:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727500AbfDWNzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:55:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NDs4G6121315
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:55:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s221nx1ph-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:55:07 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 23 Apr 2019 14:55:05 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 14:55:02 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NDt06C57081908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 13:55:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F4A552051;
        Tue, 23 Apr 2019 13:55:00 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.116])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F11CA52065;
        Tue, 23 Apr 2019 13:54:59 +0000 (GMT)
Date:   Tue, 23 Apr 2019 15:54:58 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        pmorel@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com
Subject: Re: [PATCH v2 7/8] s390: vfio-ap: handle bind and unbind of AP
 queue device
In-Reply-To: <1555796980-27920-8-git-send-email-akrowiak@linux.ibm.com>
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
        <1555796980-27920-8-git-send-email-akrowiak@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19042313-0020-0000-0000-00000332C442
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042313-0021-0000-0000-00002185254D
Message-Id: <20190423155458.65966ebf.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=765 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Apr 2019 17:49:39 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> +void vfio_ap_mdev_probe_queue(unsigned long apid, unsigned long apqi)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = vfio_ap_mdev_find_matrix_mdev(apid, apqi);
> +
> +	/*
> +	 * If the queue is assigned to the mdev device and the mdev device
> +	 * is in use by a guest
> +	 */
> +	if (matrix_mdev && matrix_mdev->kvm) {
> +		/* Plug the adapter into the guest */
> +		set_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
> +
> +		/* Make sure the queue is also plugged in to the guest */
> +		if (!test_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm))
> +			set_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
> +
> +		vfio_ap_mdev_update_crycb(matrix_mdev);

With this you effectively grant access to all the assigned domains on
the AP identified by the apid, not only to the domain identified by
apqi! But some of these queues may still not be bound to the vfio_ap
driver.

IMHO you should only set the apid-th bit in apm if all queues (apid, q)
such that q-th bit is set in aqm are bound to the vfio_ap driver.

BTW a 'shadow' (or effective) apm would perfectly suffice. I don't think
you fiddle with shadow_crycb->a[qd]m, and if you do, I don't think that's
a good idea.

Regards,
Halil

> +	}
> +}

