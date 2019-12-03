Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C676FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B081206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfLCLUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 06:20:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725907AbfLCLUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:20:43 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3BGxIx116545
        for <linux-kernel@vger.kernel.org>; Tue, 3 Dec 2019 06:20:42 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wnje9bhbe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 06:20:41 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Tue, 3 Dec 2019 11:20:39 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 11:20:35 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB3BKYtl36110340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 11:20:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB18611C050;
        Tue,  3 Dec 2019 11:20:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BFF311C054;
        Tue,  3 Dec 2019 11:20:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.31])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 11:20:33 +0000 (GMT)
Subject: Re: [PATCH v3 2/4] powerpc/fadump: reorganize /sys/kernel/fadump_*
 sysfs files
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     corbet@lwn.net, mahesh@linux.vnet.ibm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, hbathini@linux.ibm.com
References: <20191109122339.20484-1-sourabhjain@linux.ibm.com>
 <20191109122339.20484-3-sourabhjain@linux.ibm.com>
 <20191109125933.GF1384@kitsune.suse.cz>
 <8c1ec297-0c34-12de-2528-be436697215a@linux.ibm.com>
 <20191124184059.GP11661@kitsune.suse.cz>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
Date:   Tue, 3 Dec 2019 16:50:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191124184059.GP11661@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120311-4275-0000-0000-0000038A6BF5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120311-4276-0000-0000-0000389E092D
Message-Id: <a279ce08-89a4-d8e2-1364-b2b29f9a6433@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_02:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>  DEFINE_SHOW_ATTRIBUTE(fadump_region);
>>>>  
>>>>  static void fadump_init_files(void)
>>>> @@ -1435,6 +1448,11 @@ static void fadump_init_files(void)
>>>>  	struct dentry *debugfs_file;
>>>>  	int rc = 0;
>>>>  
>>>> +	fadump_kobj = kobject_create_and_add("fadump", kernel_kobj);
>>>> +	if (!fadump_kobj) {
>>>> +		pr_err("failed to create fadump kobject\n");
>>>> +		return;
>>>> +	}
>>>>  	rc = sysfs_create_file(kernel_kobj, &fadump_attr.attr);
>>>>  	if (rc)
>>>>  		printk(KERN_ERR "fadump: unable to create sysfs file"
>>>> @@ -1458,6 +1476,26 @@ static void fadump_init_files(void)
>>>>  			printk(KERN_ERR "fadump: unable to create sysfs file"
>>>>  				" fadump_release_mem (%d)\n", rc);
>>>>  	}
>>>> +	/* Replicating the following sysfs attributes under FADump kobject.
>>>> +	 *
>>>> +	 *	- fadump_enabled -> enabled
>>>> +	 *	- fadump_registered -> registered
>>>> +	 *	- fadump_release_mem -> release_mem
>>>> +	 */
>>>> +	rc = sysfs_create_file(fadump_kobj, &enable_attr.attr);
>>>> +	if (rc)
>>>> +		pr_err("unable to create enabled sysfs file (%d)\n",
>>>> +		       rc);
>>>> +	rc = sysfs_create_file(fadump_kobj, &register_attr.attr);
>>>> +	if (rc)
>>>> +		pr_err("unable to create registered sysfs file (%d)\n",
>>>> +		       rc);
>>>> +	if (fw_dump.dump_active) {
>>>> +		rc = sysfs_create_file(fadump_kobj, &release_attr.attr);
>>>> +		if (rc)
>>>> +			pr_err("unable to create release_mem sysfs file (%d)\n",
>>>> +			       rc);
>>>> +	}
>>>>  	return;
>>>>  }
>>> Hello,
>>>
>>
>> I’m so sorry for taking this long to write you back. 
>>
>>> wouldn't it make more sense to create the files in the new location and
>>> add a symlink at the old location?
>>
>> There are APIs which allow to create a symlink for an entire kobject but
>> I did not find a way to create symlink of an individual sysfs file.
>>
>> Do you have any approach in mind to achieve the same?
> 
> There is at least one example of plain symlink:
> 
> find /sys -type l -xtype f
> /sys/kernel/security/evm
> 
> If there is no interface to do one sanely duplicationg the files is
> better than nothing.

Hello Michal,

I found a function (__compat_only_sysfs_link_entry_to_kobj) that adds a symlink
to a kobject.

But the problem is __compat_only_sysfs_link_entry_to_kobj function keeps the
symlink file name similar to sysfs file and has no option to change it.

We can't use the __compat_only_sysfs_link_entry_to_kobj function directly because
our symlink file name must be different from the target file name.

	fadump_enabled -> fadump/enabled

But the good thing is we can tweak the __compat_only_sysfs_link_entry_to_kobj
function and allow the caller to change the sysmlink file name.

So I am writing a separate patch that adds a wrapper function around the __compat_only_sysfs_link_entry_to_kobj function which will allow to have a custom symlink file name.

Thanks,
Sourabh Jain

