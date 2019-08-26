Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6623C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B072F2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfHZKAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:00:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730385AbfHZKAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:00:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7Q9wkJS094377
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 06:00:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2umbjbc49e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 06:00:00 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <hbathini@linux.ibm.com>;
        Mon, 26 Aug 2019 10:59:59 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 26 Aug 2019 10:59:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7Q9xXT334931192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 09:59:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92AEAAE04D;
        Mon, 26 Aug 2019 09:59:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10DE5AE045;
        Mon, 26 Aug 2019 09:59:53 +0000 (GMT)
Received: from [9.109.217.45] (unknown [9.109.217.45])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Aug 2019 09:59:52 +0000 (GMT)
Subject: Re: [PATCH v3] powerpc/fadump: sysfs for fadump memory reservation
To:     Sourabh Jain <sourabhjain@linux.ibm.com>, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, mahesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net
References: <20190810175905.7761-1-sourabhjain@linux.ibm.com>
From:   Hari Bathini <hbathini@linux.ibm.com>
Date:   Mon, 26 Aug 2019 15:29:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810175905.7761-1-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082609-0012-0000-0000-000003430F79
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082609-0013-0000-0000-0000217D4383
Message-Id: <53311fa4-2cce-1eb6-1aae-0c835e06eb24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908260110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/08/19 11:29 PM, Sourabh Jain wrote:
> Add a sys interface to allow querying the memory reserved by
> fadump for saving the crash dump.
> 
> Add an ABI doc entry for new sysfs interface.
>    - /sys/kernel/fadump_mem_reserved
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> Changelog:
> v1 -> v2:
>   - Added ABI doc for new sysfs interface.
> 
> v2 -> v3:
>   - Updated the ABI documentation.
> ---
> 
>  Documentation/ABI/testing/sysfs-kernel-fadump    |  6 ++++++

Shouldn't this be Documentation/ABI/testing/sysfs-kernel-fadump_mem_reserved?

> +++ b/Documentation/ABI/testing/sysfs-kernel-fadump
> @@ -0,0 +1,6 @@
> +What:		/sys/kernel/fadump_mem_reserved
> +Date:		August 2019
> +Contact:	linuxppc-dev@lists.ozlabs.org
> +Description:	read only
> +		Provide information about the amount of memory
> +		reserved by fadump to save the crash dump.

Split this up into a separate patch and have ABI documentation for
fadump_reserved & fadump_registered as well..

Thanks
Hari

