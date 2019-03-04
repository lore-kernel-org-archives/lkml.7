Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027F5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B1820818
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfCDCJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:09:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbfCDCJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:09:47 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2429e5b006544
        for <linux-kernel@vger.kernel.org>; Sun, 3 Mar 2019 21:09:46 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r0qdaxhge-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 21:09:46 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 4 Mar 2019 02:09:43 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Mar 2019 02:09:40 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2429dbQ46137468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Mar 2019 02:09:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D74AA405C;
        Mon,  4 Mar 2019 02:09:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E1EAA405B;
        Mon,  4 Mar 2019 02:09:38 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.148.129])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Mar 2019 02:09:38 +0000 (GMT)
Date:   Mon, 4 Mar 2019 03:09:35 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v4 3/7] s390: ap: associate a ap_vfio_queue and a matrix
 mdev
In-Reply-To: <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
        <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030402-0012-0000-0000-000002FE1151
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030402-0013-0000-0000-000021351185
Message-Id: <20190304030935.525f4223@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 16:29:56 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We need to associate the ap_vfio_queue, which will hold the
> per queue information for interrupt with a matrix mediated device
> which hold the configuration and the way to the CRYCB.
[..]
> +static int vfio_ap_get_all_domains(struct ap_matrix_mdev *matrix_mdev, int apid)
> +{
> +	int apqi, apqn;
> +	int ret = 0;
> +	struct vfio_ap_queue *q;
> +	struct list_head q_list;
> +
> +	INIT_LIST_HEAD(&q_list);
> +
> +	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
> +		apqn = AP_MKQID(apid, apqi);
> +		q = vfio_ap_get_queue(apqn, &matrix_dev->free_list);
> +		if (!q) {
> +			ret = -EADDRNOTAVAIL;
> +			goto rewind;
> +		}
> +		if (q->matrix_mdev) {
> +			ret = -EADDRINUSE;

You tried to get the q from matrix_dev->free_list thus modulo races
q->matrix_mdev should be 0. This change breaks the error codes in a
sense that it becomes impossible to provoke EADDRINUSE (the proper
error code for taken by another matrix_mdev). 

> +			goto rewind;
> +		}
> +		list_move(&q->list, &q_list);
> +	}
> +	move_and_set(&q_list, &matrix_mdev->qlist, matrix_mdev);
>  	return 0;
> +rewind:
> +	move_and_set(&q_list, &matrix_dev->free_list, NULL);
> +	return ret;
>  }
> -
>  /**
> - * vfio_ap_mdev_verify_no_sharing
> + * vfio_ap_get_all_cards:
>   *
> - * Verifies that the APQNs derived from the cross product of the AP adapter IDs
> - * and AP queue indexes comprising the AP matrix are not configured for another
> - * mediated device. AP queue sharing is not allowed.
> + * @matrix_mdev: the matrix mediated device for which we want to associate
> + *		 all available queues with a given apqi.
> + * @apqi:	 The apqi which associated with all defined APID of the
> + *		 mediated device will define a AP queue.
>   *
> - * @matrix_mdev: the mediated matrix device
> + * We define a local list to put all queues we find on the matrix device
> + * free list when associating the apqi with all already defined apid for
> + * this matrix mediated device.
>   *
> - * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
> + * If we can get all the devices we roll them to the mediated device list
> + * If we get errors we unroll them to the free list.
>   */
> -static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
> +static int vfio_ap_get_all_cards(struct ap_matrix_mdev *matrix_mdev, int apqi)
>  {
> -	struct ap_matrix_mdev *lstdev;
> -	DECLARE_BITMAP(apm, AP_DEVICES);
> -	DECLARE_BITMAP(aqm, AP_DOMAINS);
> -
> -	list_for_each_entry(lstdev, &matrix_dev->mdev_list, node) {
> -		if (matrix_mdev == lstdev)
> -			continue;
> -
> -		memset(apm, 0, sizeof(apm));
> -		memset(aqm, 0, sizeof(aqm));
> -
> -		/*
> -		 * We work on full longs, as we can only exclude the leftover
> -		 * bits in non-inverse order. The leftover is all zeros.
> -		 */
> -		if (!bitmap_and(apm, matrix_mdev->matrix.apm,
> -				lstdev->matrix.apm, AP_DEVICES))
> -			continue;
> -
> -		if (!bitmap_and(aqm, matrix_mdev->matrix.aqm,
> -				lstdev->matrix.aqm, AP_DOMAINS))
> -			continue;
> -
> -		return -EADDRINUSE;
> +	int apid, apqn;
> +	int ret = 0;
> +	struct vfio_ap_queue *q;
> +	struct list_head q_list;
> +	struct ap_matrix_mdev *tmp = NULL;
> +
> +	INIT_LIST_HEAD(&q_list);
> +
> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
> +		apqn = AP_MKQID(apid, apqi);
> +		q = vfio_ap_get_queue(apqn, &matrix_dev->free_list);
> +		if (!q) {
> +			ret = -EADDRNOTAVAIL;
> +			goto rewind;
> +		}
> +		if (q->matrix_mdev) {
> +			ret = -EADDRINUSE;

Same here!

Regards,
Halil

> +			goto rewind;
> +		}
> +		list_move(&q->list, &q_list);
>  	}

[..]

