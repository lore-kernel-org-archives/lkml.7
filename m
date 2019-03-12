Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0C6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED21D213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfCLVkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:40:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfCLVkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:40:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CLdGJD034584
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 17:40:05 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r6ksj33k0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 17:40:05 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 12 Mar 2019 21:40:03 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 21:40:01 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2CLdvbu21954764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 21:39:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF661B2064;
        Tue, 12 Mar 2019 21:39:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B99DB205F;
        Tue, 12 Mar 2019 21:39:57 +0000 (GMT)
Received: from [9.60.75.235] (unknown [9.60.75.235])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Mar 2019 21:39:56 +0000 (GMT)
Subject: Re: [PATCH v4 3/7] s390: ap: associate a ap_vfio_queue and a matrix
 mdev
To:     Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
 <20190304030935.525f4223@oc2783563651>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 12 Mar 2019 17:39:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190304030935.525f4223@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031221-0040-0000-0000-000004D0C0CC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010746; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173463; UDB=6.00606765; IPR=6.00954122;
 MB=3.00025952; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-12 21:40:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031221-0041-0000-0000-000008DBD59B
Message-Id: <17fc3369-2496-2113-5a1a-1630df84f067@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/19 9:09 PM, Halil Pasic wrote:
> On Fri, 22 Feb 2019 16:29:56 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We need to associate the ap_vfio_queue, which will hold the
>> per queue information for interrupt with a matrix mediated device
>> which hold the configuration and the way to the CRYCB.
> [..]
>> +static int vfio_ap_get_all_domains(struct ap_matrix_mdev *matrix_mdev, int apid)
>> +{
>> +	int apqi, apqn;
>> +	int ret = 0;
>> +	struct vfio_ap_queue *q;
>> +	struct list_head q_list;
>> +
>> +	INIT_LIST_HEAD(&q_list);
>> +
>> +	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
>> +		apqn = AP_MKQID(apid, apqi);
>> +		q = vfio_ap_get_queue(apqn, &matrix_dev->free_list);
>> +		if (!q) {
>> +			ret = -EADDRNOTAVAIL;
>> +			goto rewind;
>> +		}
>> +		if (q->matrix_mdev) {
>> +			ret = -EADDRINUSE;
> 
> You tried to get the q from matrix_dev->free_list thus modulo races
> q->matrix_mdev should be 0. This change breaks the error codes in a
> sense that it becomes impossible to provoke EADDRINUSE (the proper
> error code for taken by another matrix_mdev).

It is necessary to determine if the queue is in use by another mdev, so
it will still be necessary to traverse all of the matrix_mdev structs to
see if q is in matrix_mdev->qlist. It seems that maintaining the qlist
does not buy us much.

> 
>> +			goto rewind;
>> +		}
>> +		list_move(&q->list, &q_list);
>> +	}
>> +	move_and_set(&q_list, &matrix_mdev->qlist, matrix_mdev);
>>   	return 0;
>> +rewind:
>> +	move_and_set(&q_list, &matrix_dev->free_list, NULL);
>> +	return ret;
>>   }
>> -
>>   /**
>> - * vfio_ap_mdev_verify_no_sharing
>> + * vfio_ap_get_all_cards:
>>    *
>> - * Verifies that the APQNs derived from the cross product of the AP adapter IDs
>> - * and AP queue indexes comprising the AP matrix are not configured for another
>> - * mediated device. AP queue sharing is not allowed.
>> + * @matrix_mdev: the matrix mediated device for which we want to associate
>> + *		 all available queues with a given apqi.
>> + * @apqi:	 The apqi which associated with all defined APID of the
>> + *		 mediated device will define a AP queue.
>>    *
>> - * @matrix_mdev: the mediated matrix device
>> + * We define a local list to put all queues we find on the matrix device
>> + * free list when associating the apqi with all already defined apid for
>> + * this matrix mediated device.
>>    *
>> - * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
>> + * If we can get all the devices we roll them to the mediated device list
>> + * If we get errors we unroll them to the free list.
>>    */
>> -static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
>> +static int vfio_ap_get_all_cards(struct ap_matrix_mdev *matrix_mdev, int apqi)
>>   {
>> -	struct ap_matrix_mdev *lstdev;
>> -	DECLARE_BITMAP(apm, AP_DEVICES);
>> -	DECLARE_BITMAP(aqm, AP_DOMAINS);
>> -
>> -	list_for_each_entry(lstdev, &matrix_dev->mdev_list, node) {
>> -		if (matrix_mdev == lstdev)
>> -			continue;
>> -
>> -		memset(apm, 0, sizeof(apm));
>> -		memset(aqm, 0, sizeof(aqm));
>> -
>> -		/*
>> -		 * We work on full longs, as we can only exclude the leftover
>> -		 * bits in non-inverse order. The leftover is all zeros.
>> -		 */
>> -		if (!bitmap_and(apm, matrix_mdev->matrix.apm,
>> -				lstdev->matrix.apm, AP_DEVICES))
>> -			continue;
>> -
>> -		if (!bitmap_and(aqm, matrix_mdev->matrix.aqm,
>> -				lstdev->matrix.aqm, AP_DOMAINS))
>> -			continue;
>> -
>> -		return -EADDRINUSE;
>> +	int apid, apqn;
>> +	int ret = 0;
>> +	struct vfio_ap_queue *q;
>> +	struct list_head q_list;
>> +	struct ap_matrix_mdev *tmp = NULL;
>> +
>> +	INIT_LIST_HEAD(&q_list);
>> +
>> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
>> +		apqn = AP_MKQID(apid, apqi);
>> +		q = vfio_ap_get_queue(apqn, &matrix_dev->free_list);
>> +		if (!q) {
>> +			ret = -EADDRNOTAVAIL;
>> +			goto rewind;
>> +		}
>> +		if (q->matrix_mdev) {
>> +			ret = -EADDRINUSE;
> 
> Same here!
> 
> Regards,
> Halil
> 
>> +			goto rewind;
>> +		}
>> +		list_move(&q->list, &q_list);
>>   	}
> 
> [..]
> 

