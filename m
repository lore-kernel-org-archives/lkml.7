Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97221C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E61720830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfDIJyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:54:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbfDIJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:54:39 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x399kvwv025993
        for <linux-kernel@vger.kernel.org>; Tue, 9 Apr 2019 05:54:38 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rrpve6h0m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 05:54:37 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Tue, 9 Apr 2019 10:54:35 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Apr 2019 10:54:33 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x399sWYc38273054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Apr 2019 09:54:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4778442054;
        Tue,  9 Apr 2019 09:54:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BBEF4204D;
        Tue,  9 Apr 2019 09:54:31 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.152.224.114])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Apr 2019 09:54:31 +0000 (GMT)
Subject: Re: [PATCH 05/12] s390: zcrypt: initialize variables before_use
To:     Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Ingo Franzki <ifranzki@de.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20190408212648.2407234-1-arnd@arndb.de>
 <20190408212648.2407234-5-arnd@arndb.de>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Tue, 9 Apr 2019 11:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408212648.2407234-5-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19040909-0028-0000-0000-0000035EDB17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040909-0029-0000-0000-0000241DF8AA
Message-Id: <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.19 23:26, Arnd Bergmann wrote:
> The 'func_code' variable gets printed in debug statements without
> a prior initialization in multiple functions, as reported when building
> with clang:
>
> drivers/s390/crypto/zcrypt_api.c:659:6: warning: variable 'func_code' is used uninitialized whenever 'if' condition is true
>       [-Wsometimes-uninitialized]
>         if (mex->outputdatalength < mex->inputdatalength) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/s390/crypto/zcrypt_api.c:725:29: note: uninitialized use occurs here
>         trace_s390_zcrypt_rep(mex, func_code, rc,
>                                    ^~~~~~~~~
> drivers/s390/crypto/zcrypt_api.c:659:2: note: remove the 'if' if its condition is always false
>         if (mex->outputdatalength < mex->inputdatalength) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/s390/crypto/zcrypt_api.c:654:24: note: initialize the variable 'func_code' to silence this warning
>         unsigned int func_code;
>                               ^
>
> Add initializations to all affected code paths to shut up the warning
> and make the warning output consistent.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/s390/crypto/zcrypt_api.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index eb93c2d27d0a..23472063d9a8 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -657,6 +657,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
>  	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
>  
>  	if (mex->outputdatalength < mex->inputdatalength) {
> +		func_code = -1;
>  		rc = -EINVAL;
>  		goto out;
>  	}
> @@ -739,6 +740,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
>  	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
>  
>  	if (crt->outputdatalength < crt->inputdatalength) {
> +		func_code = -1;
>  		rc = -EINVAL;
>  		goto out;
>  	}
> @@ -946,6 +948,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
>  
>  		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
>  		if (!targets) {
> +			func_code = -1;
>  			rc = -ENOMEM;
>  			goto out;
>  		}
> @@ -953,6 +956,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
>  		uptr = (struct ep11_target_dev __force __user *) xcrb->targets;
>  		if (copy_from_user(targets, uptr,
>  				   target_num * sizeof(*targets))) {
> +			func_code = -1;
>  			rc = -EFAULT;
>  			goto out_free;
>  		}
Thanks Arnd, but as Nathan already wrote, I'd prefer to have the
variable initialized with 0 instead of -1.
If you agree with this, I'll rewrite the patch and apply it to our
internal git and it will appear at kernel org with the next s390 code merge then.
regards Harald Freudenberger

