Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B74C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C9926C48
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfFCHs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:48:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbfFCHs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:48:57 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x537lS3Y082605
        for <linux-kernel@vger.kernel.org>; Mon, 3 Jun 2019 03:48:56 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2svx2vucn9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 03:48:56 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Mon, 3 Jun 2019 08:48:54 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Jun 2019 08:48:52 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x537mpGK18481326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jun 2019 07:48:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18ACA4203F;
        Mon,  3 Jun 2019 07:48:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAE7B42042;
        Mon,  3 Jun 2019 07:48:50 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.152.224.114])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jun 2019 07:48:50 +0000 (GMT)
Subject: Re: [PATCH v1] s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
To:     David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20190531093628.14766-1-david@redhat.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Mon, 3 Jun 2019 09:48:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531093628.14766-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19060307-0008-0000-0000-000002ED3534
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060307-0009-0000-0000-0000225A131F
Message-Id: <3dfea8fd-dbe7-f9d0-f7a7-2c65349c0a81@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906030058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.19 11:36, David Hildenbrand wrote:
> systemd-modules-load.service automatically tries to load the pkey module
> on systems that have MSA.
>
> Pkey also requires the MSA3 facility and a bunch of subfunctions.
> Failing with -EOPNOTSUPP makes "systemd-modules-load.service" fail on
> any system that does not have all needed subfunctions. For example,
> when running under QEMU TCG (but also on systems where protected keys
> are disabled via the HMC).
>
> Let's use -ENODEV, so systemd-modules-load.service properly ignores
> failing to load the pkey module because of missing HW functionality.
>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index 45eb0c14b880..ddfcefb47284 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -1695,15 +1695,15 @@ static int __init pkey_init(void)
>  	 * are able to work with protected keys.
>  	 */
>  	if (!cpacf_query(CPACF_PCKMO, &pckmo_functions))
> -		return -EOPNOTSUPP;
> +		return -ENODEV;
>  
>  	/* check for kmc instructions available */
>  	if (!cpacf_query(CPACF_KMC, &kmc_functions))
> -		return -EOPNOTSUPP;
> +		return -ENODEV;
>  	if (!cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_128) ||
>  	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_192) ||
>  	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_256))
> -		return -EOPNOTSUPP;
> +		return -ENODEV;
>  
>  	pkey_debug_init();
>  
I can't really agree to this: there are a lot more modules returning
EOPNOTSUPP, for example have a look into the arch/s390/crypto
subdirectory. The ghash_s390 module also registers for MSA feature
and also returns EOPNOTSUPPORTED when the required hardware extension
is not available. Same with the prng kernel module, sha1_s390, sha256_s390
and I assume there is a bunch of other kernel modules with same behavior.
I would prefer having this fixed on the systemd-modules-load.service side.

regards
Harald Freudenberger


