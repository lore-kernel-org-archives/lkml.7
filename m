Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F0CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 04:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DAC20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 04:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yTUEZRuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCRERc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 00:17:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35146 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfCRERc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 00:17:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2I4Fvil134344;
        Mon, 18 Mar 2019 04:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=vdIvrAC/87i9UKDZmuPjIlnElIVUjiUw5rDxJVWUXfc=;
 b=yTUEZRuI+/SmE2vPFk6Q63HViP/jVPsGp7fQ3CdktyGf3hzpHAmlpRRWR6o1OY5cVSue
 I0P0ruEE6iZwtpYDvzKBpzLWXfIqfmTcJ0sdv/1tcjXzHQ4GBH5OverorHSOUfneuBpx
 87ob1jwc8ZFjIZt7+H/I//OPIrI/tReT8QG3NKIrE/Dg/5XlxVPpwu2sfqUonLE1FU9q
 s1t0RtYqOrHGNDvm7AvdABRQRbzWOns3HnBw8Bpo5dKYCuUPdBmiyE7+hXy/vYqyaABj
 1sHbUeaROzm2znYHzs+oMovHHZxDBSfrDZTG1uSLOCyvA7FDQCoqyQjLW996sKR7INsT gQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2r8ssr3yst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 04:17:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2I4HRs0024618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 04:17:27 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2I4HQtd013067;
        Mon, 18 Mar 2019 04:17:26 GMT
Received: from [10.8.169.172] (/10.8.169.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 17 Mar 2019 21:17:26 -0700
Subject: Re: [BUG] scsi: ses: out of bound accessing in
 ses_enclosure_data_process
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        diego.gonzalez@oracle.com
References: <78dd3eca-7e8a-72f9-07f9-e2c7cc4569b0@oracle.com>
 <40646609-8298-2d76-2f0c-e732404a23d4@oracle.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <b193ebee-5ea0-0041-aff2-570065a328b4@oracle.com>
Date:   Mon, 18 Mar 2019 12:17:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <40646609-8298-2d76-2f0c-e732404a23d4@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9198 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903180032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lpfc maintainer James & Dick.  Could you help take a look?

Thanks,

Junxiao.

On 3/18/19 11:13 AM, jianchao.wang wrote:
> Would anyone please give some suggestions ?
>
> It looks like there somethings wrong in the read-in data,
>
> 	/* skip all the enclosure descriptors */
> 	for (i = 0; i < num_enclosures && type_ptr < buf + len; i++) {
> 		types += type_ptr[2];
> 		type_ptr += type_ptr[3] + 4; ----> here
> 	}
> Then the typr_ptr got out of bound of the buffer.
>
>
> Thanks
> Jianchao
>
> On 3/14/19 11:19 AM, jianchao.wang wrote:
>> Dear all
>>
>> When our customer probe the lpfc devices, they encountered odd memory corruption issues,
>> and we get 'out of bound' access warning at following position after open KASAN
>>
>> ses_enclosure_data_process
>>
>> for (i = 0; i < types; i++, type_ptr += 4) {
>>    for (j = 0; j < type_ptr[1]; j++) {
>>                     ^^^^^^^^^^^
>>                     out of bound
>>
>> With some debug log, I got following,
>>
>> page1 ffff88042d1aad20 len 32 types 5 type_ptr ffff88042d1aad64
>>
>> Would anyone please give some suggestions on this ?
>>
>> Thanks
>> Jianchao
>>
