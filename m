Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38010C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B192077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbfIDPJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:09:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729944AbfIDPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:09:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x84F90d3041709;
        Wed, 4 Sep 2019 11:09:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utdrudc2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 11:09:06 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x84F95pW041840;
        Wed, 4 Sep 2019 11:09:05 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utdrudbhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 11:09:04 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x84F5KDw007894;
        Wed, 4 Sep 2019 15:08:21 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 2us9fn3hk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 15:08:21 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x84F8GRO54264292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Sep 2019 15:08:16 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B845E6A04F;
        Wed,  4 Sep 2019 15:08:16 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7DB86A04D;
        Wed,  4 Sep 2019 15:08:15 +0000 (GMT)
Received: from [9.80.231.166] (unknown [9.80.231.166])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  4 Sep 2019 15:08:15 +0000 (GMT)
Subject: Re: [PATCH 1/1] s390: vfio-ap: fix warning reset not completed
To:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20190903133618.9122-1-pasic@linux.ibm.com>
 <20190903184542.2d955111.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <633ff646-de9b-9d6b-2d35-b09a60d33eee@linux.ibm.com>
Date:   Wed, 4 Sep 2019 11:08:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190903184542.2d955111.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 12:45 PM, Cornelia Huck wrote:
> On Tue,  3 Sep 2019 15:36:18 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> "fix warning for not completed reset"?
> 
>> The intention seems to be to warn once when we don't wait enough for the
>> reset to complete. Let's use the right retry counter to accomplish that
>> semantic.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 0604b49a4d32..5c0f53c6dde7 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -1143,7 +1143,7 @@ int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>>   				msleep(20);
>>   				status = ap_tapq(apqn, NULL);
>>   			}
>> -			WARN_ON_ONCE(retry <= 0);
>> +			WARN_ON_ONCE(retry2 <= 0);
>>   			return 0;
>>   		case AP_RESPONSE_RESET_IN_PROGRESS:
>>   		case AP_RESPONSE_BUSY:
> 
> Makes sense.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Agreed:
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> 

