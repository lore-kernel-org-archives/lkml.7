Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B16C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6122084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfFQOFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:05:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbfFQOFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:05:04 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HE2ZoI054058
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 10:05:02 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t6bfraj7f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 10:05:02 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Mon, 17 Jun 2019 15:05:01 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 15:04:58 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5HE4v4Y20119844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 14:04:57 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B00E78063;
        Mon, 17 Jun 2019 14:04:57 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3852478064;
        Mon, 17 Jun 2019 14:04:56 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.160.209])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 14:04:55 +0000 (GMT)
Subject: Re: [PATCH] integrity: Fix __integrity_init_keyring() section
 mismatch
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nayna Jain <nayna@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190617074452.12901-1-geert@linux-m68k.org>
From:   Nayna <nayna@linux.vnet.ibm.com>
Date:   Mon, 17 Jun 2019 10:04:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190617074452.12901-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19061714-8235-0000-0000-00000EA93BDE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011278; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01219285; UDB=6.00641324; IPR=6.01000426;
 MB=3.00027344; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-17 14:05:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061714-8236-0000-0000-0000460CBB70
Message-Id: <1f2d599b-77dd-18eb-3e99-e93cc79cfddf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=870 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/17/2019 03:44 AM, Geert Uytterhoeven wrote:
> With gcc-4.6.3:
>
>      WARNING: vmlinux.o(.text.unlikely+0x24c64): Section mismatch in reference from the function __integrity_init_keyring() to the function .init.text:set_platform_trusted_keys()
>      The function __integrity_init_keyring() references
>      the function __init set_platform_trusted_keys().
>      This is often because __integrity_init_keyring lacks a __init
>      annotation or the annotation of set_platform_trusted_keys is wrong.
>
> Indeed, if the compiler decides not to inline __integrity_init_keyring(),
> a warning is issued.
>
> Fix this by adding the missing __init annotation.
>
> Fixes: 9dc92c45177ab70e ("integrity: Define a trusted platform keyring")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks for fixing it.

Reviewed-by: Nayna Jain <nayna@linux.ibm.com>

Thanks & Regards,
          - Nayna

