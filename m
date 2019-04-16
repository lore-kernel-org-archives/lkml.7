Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1147C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB6D20675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfDPIkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:40:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726208AbfDPIkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:40:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3G8V3UE074159
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:40:18 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rwavv2c7d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:40:18 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Tue, 16 Apr 2019 09:40:16 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Apr 2019 09:40:11 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3G8eAvD53674088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 08:40:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BE7552057;
        Tue, 16 Apr 2019 08:40:10 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 26EA552050;
        Tue, 16 Apr 2019 08:40:10 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id DD492A0147;
        Tue, 16 Apr 2019 18:40:08 +1000 (AEST)
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the
 running kernel image
To:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>, cmr <cmr@informatik.wtf>
References: <20190404003249.14356-1-matthewgarrett@google.com>
 <20190404003249.14356-2-matthewgarrett@google.com>
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date:   Tue, 16 Apr 2019 18:40:08 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404003249.14356-2-matthewgarrett@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041608-0012-0000-0000-0000030F4C95
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041608-0013-0000-0000-000021478484
Message-Id: <059c523e-926c-24ee-0935-198031712145@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 11:32 am, Matthew Garrett wrote:
> diff --git a/Documentation/ABI/testing/lockdown b/Documentation/ABI/testing/lockdown
> new file mode 100644
> index 000000000000..5bd51e20917a
> --- /dev/null
> +++ b/Documentation/ABI/testing/lockdown
> @@ -0,0 +1,19 @@
> +What:		security/lockdown
> +Date:		March 2019
> +Contact:	Matthew Garrett <mjg59@google.com>
> +Description:
> +		If CONFIG_LOCK_DOWN_KERNEL is enabled, the kernel can be
> +		moved to a more locked down state at runtime by writing to
> +		this attribute. Valid values are:
> +
> +		integrity:
> +			The kernel will disable functionality that allows
> +			userland to modify the running kernel image, other
> +			than through the loading or execution of appropriately
> +			signed objects.
> +
> +		confidentiality:
> +			The kernel will disable all functionality disabled by
> +			the integrity mode, but additionally will disable
> +			features that potentially permit userland to obtain
> +			confidential information stored within the kernel.

[+ linuxppc, mpe, dja, cmr]

I'm thinking about whether we should lock down the powerpc xmon debug 
monitor - intuitively, I think the answer is yes if for no other reason 
than Least Astonishment, when lockdown is enabled you probably don't 
expect xmon to keep letting you access kernel memory.

Semantically though, xmon is not a userspace process - it's in kernel 
and reads debug commands/outputs debug data directly from/to the 
console. Is that a threat vector that this series cares about?


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

