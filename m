Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDDEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71CB20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfCEWRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:17:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728253AbfCEWRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:17:47 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x25MEq8T100125
        for <linux-kernel@vger.kernel.org>; Tue, 5 Mar 2019 17:17:46 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r1y5f78s7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 17:17:45 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 5 Mar 2019 22:17:44 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Mar 2019 22:17:40 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x25MHbNs17236086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 22:17:37 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29BB8124053;
        Tue,  5 Mar 2019 22:17:37 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72B47124052;
        Tue,  5 Mar 2019 22:17:36 +0000 (GMT)
Received: from [9.80.194.182] (unknown [9.80.194.182])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  5 Mar 2019 22:17:36 +0000 (GMT)
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
Date:   Tue, 5 Mar 2019 17:17:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190304030935.525f4223@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030522-0064-0000-0000-000003B46000
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010711; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01170145; UDB=6.00611529; IPR=6.00950779;
 MB=3.00025848; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-05 22:17:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030522-0065-0000-0000-00003C9FC2C3
Message-Id: <24030714-fb55-9cd0-7d75-b5e9f6658e3e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903050143
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

I don't understand what you are saying here. AFIU, the idea here is to
pull the q from the free list. If there is no q for the apqn on the free
list, then that would indicate the queue has not been bound to a driver
in which case the appropriate rc is EADDRNOTAVAIL. If the queue has
been bound, then a check is done to see whether the queue has been
associated with an mdev device. If so, the rc is -EADDRINUSE, which is
also appropriate. What am I missing?

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

