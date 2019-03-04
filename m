Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C18C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA8620823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfCDKTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:19:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726032AbfCDKTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:19:50 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24AF267021661
        for <linux-kernel@vger.kernel.org>; Mon, 4 Mar 2019 05:19:49 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r11782t7w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 05:19:48 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 4 Mar 2019 10:19:47 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Mar 2019 10:19:43 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x24AJf5628246086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Mar 2019 10:19:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D3FF42045;
        Mon,  4 Mar 2019 10:19:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D399542042;
        Mon,  4 Mar 2019 10:19:40 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Mar 2019 10:19:40 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 3/7] s390: ap: associate a ap_vfio_queue and a matrix
 mdev
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
 <20190304030935.525f4223@oc2783563651>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 4 Mar 2019 11:19:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304030935.525f4223@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030410-0028-0000-0000-0000034FA4F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030410-0029-0000-0000-0000240E0A07
Message-Id: <b18828eb-0fd1-2fdc-f104-16c5ed8fd8cb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=944 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2019 03:09, Halil Pasic wrote:
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
> 

right.
I will change this.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

