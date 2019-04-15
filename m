Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0395BC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C705E218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfDOWSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:18:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727191AbfDOWSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:18:06 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FMEVNZ010630
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 18:18:05 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rw0eqwb31-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 18:18:04 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 15 Apr 2019 23:18:04 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 23:18:01 +0100
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FMI0xv24772760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 22:18:00 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F99A6A04F;
        Mon, 15 Apr 2019 22:18:00 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 560B26A04D;
        Mon, 15 Apr 2019 22:17:59 +0000 (GMT)
Received: from [9.80.192.157] (unknown [9.80.192.157])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 22:17:59 +0000 (GMT)
Subject: Re: [PATCH] hwmon (occ): Fix extended status bits
To:     Guenter Roeck <linux@roeck-us.net>, Lei YU <mine260309@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
References: <1555324640-152061-1-git-send-email-mine260309@gmail.com>
 <20190415202849.GA31243@roeck-us.net>
From:   Eddie James <eajames@linux.ibm.com>
Date:   Mon, 15 Apr 2019 17:17:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415202849.GA31243@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19041522-0016-0000-0000-000009A10C68
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010934; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189617; UDB=6.00623312; IPR=6.00970404;
 MB=3.00026458; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-15 22:18:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041522-0017-0000-0000-000042D3EB54
Message-Id: <cce91645-22c7-3c9d-fd2a-5271625b3e4a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/15/19 3:28 PM, Guenter Roeck wrote:
> On Mon, Apr 15, 2019 at 06:37:20PM +0800, Lei YU wrote:
>> The occ's extended status is checked and shown as sysfs attributes. But
>> the code was incorrectly checking the "status" bits.
>> Fix it by checking the "ext_status" bits.
>>
>> Signed-off-by: Lei YU <mine260309@gmail.com>
> Looks ok to me, but can I get a confirmation from someone at IBM ?


Yes. Thanks Lei.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Thanks,
> Guenter
>
>> ---
>>   drivers/hwmon/occ/sysfs.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
>> index fe3d15e..a71ca94 100644
>> --- a/drivers/hwmon/occ/sysfs.c
>> +++ b/drivers/hwmon/occ/sysfs.c
>> @@ -42,16 +42,16 @@ static ssize_t occ_sysfs_show(struct device *dev,
>>   		val = !!(header->status & OCC_STAT_ACTIVE);
>>   		break;
>>   	case 2:
>> -		val = !!(header->status & OCC_EXT_STAT_DVFS_OT);
>> +		val = !!(header->ext_status & OCC_EXT_STAT_DVFS_OT);
>>   		break;
>>   	case 3:
>> -		val = !!(header->status & OCC_EXT_STAT_DVFS_POWER);
>> +		val = !!(header->ext_status & OCC_EXT_STAT_DVFS_POWER);
>>   		break;
>>   	case 4:
>> -		val = !!(header->status & OCC_EXT_STAT_MEM_THROTTLE);
>> +		val = !!(header->ext_status & OCC_EXT_STAT_MEM_THROTTLE);
>>   		break;
>>   	case 5:
>> -		val = !!(header->status & OCC_EXT_STAT_QUICK_DROP);
>> +		val = !!(header->ext_status & OCC_EXT_STAT_QUICK_DROP);
>>   		break;
>>   	case 6:
>>   		val = header->occ_state;

