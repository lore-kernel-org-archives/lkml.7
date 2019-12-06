Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027FBC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96EC2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfLFS2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:28:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbfLFS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:28:03 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6IIn68047455
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 13:28:02 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq9gr0cf7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 13:28:02 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Fri, 6 Dec 2019 18:28:00 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 18:27:57 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB6IRujK46203136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 18:27:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CED3552052;
        Fri,  6 Dec 2019 18:27:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.202])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E5A8752050;
        Fri,  6 Dec 2019 18:27:54 +0000 (GMT)
Subject: Re: [PATCH v4 2/6] sysfs: wrap __compat_only_sysfs_link_entry_to_kobj
 function to change the symlink name
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com,
        hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, corbet@lwn.net, linux-doc@vger.kernel.org
References: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
 <20191206122434.29587-3-sourabhjain@linux.ibm.com>
 <20191206124642.GB1360047@kroah.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
Date:   Fri, 6 Dec 2019 23:57:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191206124642.GB1360047@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120618-0016-0000-0000-000002D25BFE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120618-0017-0000-0000-0000333467BE
Message-Id: <3aabdf19-ccbf-e99a-c560-2b110e8b536a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_06:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/19 6:16 PM, Greg KH wrote:
> On Fri, Dec 06, 2019 at 05:54:30PM +0530, Sourabh Jain wrote:
>> The __compat_only_sysfs_link_entry_to_kobj function creates a symlink to a
>> kobject but doesn't provide an option to change the symlink file name.
>>
>> This patch adds a wrapper function create_sysfs_symlink_entry_to_kobj that
>> extends the __compat_only_sysfs_link_entry_to_kobj functionality which
>> allows function caller to customize the symlink name.
>>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>  fs/sysfs/group.c      | 28 +++++++++++++++++++++++++---
>>  include/linux/sysfs.h | 12 ++++++++++++
>>  2 files changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
>> index d41c21fef138..5eb38145b957 100644
>> --- a/fs/sysfs/group.c
>> +++ b/fs/sysfs/group.c
>> @@ -424,6 +424,25 @@ EXPORT_SYMBOL_GPL(sysfs_remove_link_from_group);
>>  int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
>>  				      struct kobject *target_kobj,
>>  				      const char *target_name)
>> +{
>> +	return create_sysfs_symlink_entry_to_kobj(kobj, target_kobj,
>> +						target_name, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(__compat_only_sysfs_link_entry_to_kobj);
>> +
>> +/**
>> + * create_sysfs_symlink_entry_to_kobj - add a symlink to a kobject pointing
>> + * to a group or an attribute
>> + * @kobj:		The kobject containing the group.
>> + * @target_kobj:	The target kobject.
>> + * @target_name:	The name of the target group or attribute.
>> + * @symlink_name:	The name of the symlink file (target_name will be
>> + *			considered if symlink_name is NULL).
>> + */
>> +int create_sysfs_symlink_entry_to_kobj(struct kobject *kobj,
>> +				       struct kobject *target_kobj,
>> +				       const char *target_name,
>> +				       const char *symlink_name)
>>  {
>>  	struct kernfs_node *target;
>>  	struct kernfs_node *entry;
>> @@ -448,12 +467,15 @@ int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
>>  		return -ENOENT;
>>  	}
>>  
>> -	link = kernfs_create_link(kobj->sd, target_name, entry);
>> +	if (!symlink_name)
>> +		symlink_name = target_name;
>> +
>> +	link = kernfs_create_link(kobj->sd, symlink_name, entry);
>>  	if (IS_ERR(link) && PTR_ERR(link) == -EEXIST)
>> -		sysfs_warn_dup(kobj->sd, target_name);
>> +		sysfs_warn_dup(kobj->sd, symlink_name);
>>  
>>  	kernfs_put(entry);
>>  	kernfs_put(target);
>>  	return PTR_ERR_OR_ZERO(link);
>>  }
>> -EXPORT_SYMBOL_GPL(__compat_only_sysfs_link_entry_to_kobj);
>> +EXPORT_SYMBOL_GPL(create_sysfs_symlink_entry_to_kobj);
>> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
>> index 5420817ed317..123c6f10333a 100644
>> --- a/include/linux/sysfs.h
>> +++ b/include/linux/sysfs.h
>> @@ -300,6 +300,10 @@ void sysfs_remove_link_from_group(struct kobject *kobj, const char *group_name,
>>  int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
>>  				      struct kobject *target_kobj,
>>  				      const char *target_name);
>> +int create_sysfs_symlink_entry_to_kobj(struct kobject *kobj,
>> +				       struct kobject *target_kobj,
>> +				       const char *target_name,
>> +				       const char *symlink_name);
> 
> sysfs_create_symlink_entry_to_kobj()?
> 
> I can't remember why we put __compat_only there, perhaps because we do
> not want people to really use this unless you really really have to?

We don't have much option here. I tried replicating the sysfs files
in older patch series but creating symlink at old location is much
better approach.

The __compat_only_sysfs_link_entry_to_kobj function is pretty generic,
unable to understand the reason behind restricting its usage.

> 
> So then keep compat_only here as well?

Sure, I will rename the wrapper function.

But how about changing the function signature instead of creating
a wrapper function?

Considering the fact that there are only two places this function
has called.

> 
> What breaks if you remove those undocumented sysfs files?  What
> userspace tool do you have that will even notice?

The scripts used in kdump service need those sysfs files to control
the dump collection. So we can't just move the sysfs files to the
new location.

Thanks,
Sourabh Jain

