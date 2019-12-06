Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94303C2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732CA24673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfLFTNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:13:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbfLFTNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:13:15 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6JBvtC159073
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 14:13:14 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq905x292-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:13:14 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Fri, 6 Dec 2019 19:13:12 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 19:13:10 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB6JD9FC66584592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 19:13:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CC4E4203F;
        Fri,  6 Dec 2019 19:13:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FA8342041;
        Fri,  6 Dec 2019 19:13:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.71.21])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Dec 2019 19:13:07 +0000 (GMT)
Subject: Re: [PATCH v4 3/6] powerpc/fadump: reorganize /sys/kernel/fadump_*
 sysfs files
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com,
        hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, corbet@lwn.net, linux-doc@vger.kernel.org
References: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
 <20191206122434.29587-4-sourabhjain@linux.ibm.com>
 <20191206124508.GA1360047@kroah.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
Date:   Sat, 7 Dec 2019 00:43:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191206124508.GA1360047@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120619-0028-0000-0000-000003C61602
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120619-0029-0000-0000-000024893CB2
Message-Id: <9efa9a4b-b0ce-f9b7-88b0-a74a767bbe81@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_06:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912060154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/19 6:15 PM, Greg KH wrote:
> On Fri, Dec 06, 2019 at 05:54:31PM +0530, Sourabh Jain wrote:
>> +static struct kobj_attribute release_attr = __ATTR(release_mem,
>>  						0200, NULL,
>>  						fadump_release_memory_store);
>> -static struct kobj_attribute fadump_attr = __ATTR(fadump_enabled,
>> +static struct kobj_attribute enable_attr = __ATTR(enabled,
>>  						0444, fadump_enabled_show,
>>  						NULL);
> 
> __ATTR_RO()?
> 
>> -static struct kobj_attribute fadump_register_attr = __ATTR(fadump_registered,
>> +static struct kobj_attribute register_attr = __ATTR(registered,
>>  						0644, fadump_register_show,
>>  						fadump_register_store);
> 
> __ATTR_RW()?

Thanks I was not aware of these macros.

> 
> And then use an ATTRIBUTE_GROUP() macro to create a group so that you
> then can do:
> 
>> @@ -1452,11 +1450,47 @@ static void fadump_init_files(void)
>>  		printk(KERN_ERR "fadump: unable to create debugfs file"
>>  				" fadump_region\n");
>>  
>> +	rc = sysfs_create_file(fadump_kobj, &enable_attr.attr);
>> +	if (rc)
>> +		pr_err("unable to create enabled sysfs file (%d)\n",
>> +		       rc);
>> +	rc = sysfs_create_file(fadump_kobj, &register_attr.attr);
>> +	if (rc)
>> +		pr_err("unable to create registered sysfs file (%d)\n",
>> +		       rc);
>> +	if (fw_dump.dump_active) {
>> +		rc = sysfs_create_file(fadump_kobj, &release_attr.attr);
>> +		if (rc)
>> +			pr_err("unable to create release_mem sysfs file (%d)\n",
>> +			       rc);
>> +	}
> 
> a single call to sysfs_create_groups() here instead of trying to unwind
> the mess if something went wrong.
> 

Sure, I will replace the individual calls with a single group call.

Thanks,
Sourabh Jain

