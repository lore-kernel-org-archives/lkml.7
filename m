Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9165C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 14:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FBB206DB
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 14:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfKPOhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 09:37:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727655AbfKPOhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 09:37:39 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAGEVp0l018948
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 09:37:37 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wae606rum-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 09:37:37 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Sat, 16 Nov 2019 14:37:35 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 16 Nov 2019 14:37:33 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAGEbWvw54001876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Nov 2019 14:37:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67ACBA405C;
        Sat, 16 Nov 2019 14:37:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B1A9A4054;
        Sat, 16 Nov 2019 14:37:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.71.109])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 16 Nov 2019 14:37:30 +0000 (GMT)
Subject: Re: [PATCH v3 2/4] powerpc/fadump: reorganize /sys/kernel/fadump_*
 sysfs files
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     mpe@ellerman.id.au, corbet@lwn.net, mahesh@linux.vnet.ibm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, hbathini@linux.ibm.com
References: <20191109122339.20484-1-sourabhjain@linux.ibm.com>
 <20191109122339.20484-3-sourabhjain@linux.ibm.com>
 <20191109125933.GF1384@kitsune.suse.cz>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
Date:   Sat, 16 Nov 2019 20:07:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191109125933.GF1384@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111614-0028-0000-0000-000003B7EE84
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111614-0029-0000-0000-0000247B0282
Message-Id: <8c1ec297-0c34-12de-2528-be436697215a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-16_04:2019-11-15,2019-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911160137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/19 6:29 PM, Michal Suchánek wrote:
> On Sat, Nov 09, 2019 at 05:53:37PM +0530, Sourabh Jain wrote:
>> As the number of FADump sysfs files increases it is hard to manage all of
>> them inside /sys/kernel directory. It's better to have all the FADump
>> related sysfs files in a dedicated directory /sys/kernel/fadump. But in
>> order to maintain the backward compatibility the /sys/kernel/fadump_*
>> sysfs files are replicated inside /sys/kernel/fadump/ and eventually get
>> removed in future.
>>
>> As the FADump sysfs files are now part of dedicated directory there is no
>> need to prefix their name with fadump_, hence sysfs file names are also
>> updated. For example fadump_enabled sysfs file is now referred as enabled.
>>
>> Also consolidate ABI documentation for all the FADump sysfs files in a
>> single file Documentation/ABI/testing/sysfs-kernel-fadump.
>>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>  Documentation/ABI/testing/sysfs-kernel-fadump | 41 +++++++++++++++++++
>>  arch/powerpc/kernel/fadump.c                  | 38 +++++++++++++++++
>>  arch/powerpc/platforms/powernv/opal-core.c    | 10 +++--
>>  3 files changed, 86 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump
>>
>> diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump b/Documentation/ABI/testing/sysfs-kernel-fadump
>> new file mode 100644
>> index 000000000000..a77f1a5ba389
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-kernel-fadump
>> @@ -0,0 +1,41 @@
>> +What:		/sys/kernel/fadump/*
>> +Date:		Nov 2019
>> +Contact:	linuxppc-dev@lists.ozlabs.org
>> +Description:
>> +		The /sys/kernel/fadump/* is a collection of FADump sysfs
>> +		file provide information about the configuration status
>> +		of Firmware Assisted Dump (FADump).
>> +
>> +What:		/sys/kernel/fadump/enabled
>> +Date:		Nov 2019
>> +Contact:	linuxppc-dev@lists.ozlabs.org
>> +Description:	read only
>> +		Primarily used to identify whether the FADump is enabled in
>> +		the kernel or not.
>> +User:		Kdump service
>> +
>> +What:		/sys/kernel/fadump/registered
>> +Date:		Nov 2019
>> +Contact:	linuxppc-dev@lists.ozlabs.org
>> +Description:	read/write
>> +		Helps to control the dump collect feature from userspace.
>> +		Setting 1 to this file enables the system to collect the
>> +		dump and 0 to disable it.
>> +User:		Kdump service
>> +
>> +What:		/sys/kernel/fadump/release_mem
>> +Date:		Nov 2019
>> +Contact:	linuxppc-dev@lists.ozlabs.org
>> +Description:	write only
>> +		This is a special sysfs file and only available when
>> +		the system is booted to capture the vmcore using FADump.
>> +		It is used to release the memory reserved by FADump to
>> +		save the crash dump.
>> +
>> +What:		/sys/kernel/fadump/release_opalcore
>> +Date:		Nov 2019
>> +Contact:	linuxppc-dev@lists.ozlabs.org
>> +Description:	write only
>> +		The sysfs file is available when the system is booted to
>> +		collect the dump on OPAL based machine. It used to release
>> +		the memory used to collect the opalcore.
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index ed59855430b9..a9591def0c84 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -1418,6 +1418,9 @@ static int fadump_region_show(struct seq_file *m, void *private)
>>  	return 0;
>>  }
>>  
>> +struct kobject *fadump_kobj;
>> +EXPORT_SYMBOL_GPL(fadump_kobj);
>> +
>>  static struct kobj_attribute fadump_release_attr = __ATTR(fadump_release_mem,
>>  						0200, NULL,
>>  						fadump_release_memory_store);
>> @@ -1428,6 +1431,16 @@ static struct kobj_attribute fadump_register_attr = __ATTR(fadump_registered,
>>  						0644, fadump_register_show,
>>  						fadump_register_store);
>>  
>> +static struct kobj_attribute release_attr = __ATTR(release_mem,
>> +						0200, NULL,
>> +						fadump_release_memory_store);
>> +static struct kobj_attribute enable_attr = __ATTR(enabled,
>> +						0444, fadump_enabled_show,
>> +						NULL);
>> +static struct kobj_attribute register_attr = __ATTR(registered,
>> +						0644, fadump_register_show,
>> +						fadump_register_store);
>> +
>>  DEFINE_SHOW_ATTRIBUTE(fadump_region);
>>  
>>  static void fadump_init_files(void)
>> @@ -1435,6 +1448,11 @@ static void fadump_init_files(void)
>>  	struct dentry *debugfs_file;
>>  	int rc = 0;
>>  
>> +	fadump_kobj = kobject_create_and_add("fadump", kernel_kobj);
>> +	if (!fadump_kobj) {
>> +		pr_err("failed to create fadump kobject\n");
>> +		return;
>> +	}
>>  	rc = sysfs_create_file(kernel_kobj, &fadump_attr.attr);
>>  	if (rc)
>>  		printk(KERN_ERR "fadump: unable to create sysfs file"
>> @@ -1458,6 +1476,26 @@ static void fadump_init_files(void)
>>  			printk(KERN_ERR "fadump: unable to create sysfs file"
>>  				" fadump_release_mem (%d)\n", rc);
>>  	}
>> +	/* Replicating the following sysfs attributes under FADump kobject.
>> +	 *
>> +	 *	- fadump_enabled -> enabled
>> +	 *	- fadump_registered -> registered
>> +	 *	- fadump_release_mem -> release_mem
>> +	 */
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
>>  	return;
>>  }
> Hello,
> 

I’m so sorry for taking this long to write you back. 

> wouldn't it make more sense to create the files in the new location and
> add a symlink at the old location?

There are APIs which allow to create a symlink for an entire kobject but
I did not find a way to create symlink of an individual sysfs file.

Do you have any approach in mind to achieve the same?


> Also your error messages aren't really readeable. Without the fadump_
> prefix it's not clear what's going on here. Perhaps quoting the file
> name and saying fadump somewhere in the message would be useful.

The pr_err function will prefix the error message with fadump: string.
I think that will solve the above issue.


Thanks,

Sourabh Jain

