Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53D8C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4053206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfH2F2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 01:28:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbfH2F2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 01:28:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7T5RThf041550
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:28:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2up31jg2b3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:28:23 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <hbathini@linux.ibm.com>;
        Thu, 29 Aug 2019 06:28:21 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Aug 2019 06:28:19 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7T5SIQY56492196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 05:28:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0700A405C;
        Thu, 29 Aug 2019 05:28:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CDF5A405B;
        Thu, 29 Aug 2019 05:28:17 +0000 (GMT)
Received: from [9.124.31.87] (unknown [9.124.31.87])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 05:28:17 +0000 (GMT)
Subject: Re: [PATCH v2] powerpc/fadump: when fadump is supported register the
 fadump sysfs files.
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <e7fad352-48f3-f01d-1b19-a589a3b95c07@linux.ibm.com>
 <20190828172742.18378-1-msuchanek@suse.de>
From:   Hari Bathini <hbathini@linux.ibm.com>
Date:   Thu, 29 Aug 2019 10:58:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828172742.18378-1-msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082905-0028-0000-0000-0000039521B8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082905-0029-0000-0000-00002457606B
Message-Id: <15be95b0-4cb2-1cf1-2fc1-ec313b9aa6f0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/08/19 10:57 PM, Michal Suchanek wrote:
> Currently it is not possible to distinguish the case when fadump is
> supported by firmware and disabled in kernel and completely unsupported
> using the kernel sysfs interface. User can investigate the devicetree
> but it is more reasonable to provide sysfs files in case we get some
> fadumpv2 in the future.
> 
> With this patch sysfs files are available whenever fadump is supported
> by firmware.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---

[...]

> -	if (!fw_dump.fadump_supported) {
> +	if (!fw_dump.fadump_supported && fw_dump.fadump_enabled) {
>  		printk(KERN_ERR "Firmware-assisted dump is not supported on"
>  			" this hardware\n");
> -		return 0;
>  	}

The above hunk is redundant with similar message already logged during
early boot in fadump_reserve_mem() function. I am not strongly against
this though. So...


Acked-by: Hari Bathini <hbathini@linux.ibm.com>

