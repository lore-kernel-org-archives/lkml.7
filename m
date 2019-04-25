Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE0BC282E5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03419217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbfDYL4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:56:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387500AbfDYL4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:56:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PBntXO134725
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 07:56:21 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s3b2g430r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 07:56:20 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 25 Apr 2019 12:56:18 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 12:56:03 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3PBu2w229949952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 11:56:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7061052051;
        Thu, 25 Apr 2019 11:56:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.60])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9D1F35204F;
        Thu, 25 Apr 2019 11:56:01 +0000 (GMT)
Subject: Re: [PATCH v2] KEYS: Make use of platform keyring for module
 signature verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Robert Holmes <robeholmes@gmail.com>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        stable@vger.kernel.org
Date:   Thu, 25 Apr 2019 07:55:50 -0400
In-Reply-To: <1556116431-7129-1-git-send-email-robeholmes@gmail.com>
References: <1556116431-7129-1-git-send-email-robeholmes@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042511-4275-0000-0000-0000032D92EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042511-4276-0000-0000-0000383CDF76
Message-Id: <1556193350.3894.92.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-24 at 14:33 +0000, Robert Holmes wrote:
> This patch completes commit 278311e417be ("kexec, KEYS: Make use of
> platform keyring for signature verify") which, while adding the
> platform keyring for bzImage verification, neglected to also add
> this keyring for module verification.
> 
> As such, kernel modules signed with keys from the MokList variable
> were not successfully verified.

Using the platform keyring keys for verifying kernel modules was not
neglected, but rather intentional.  This patch description should
clearly explain the reason for needing to verify kernel module
signatures based on the pre-boot keys.  (Hint: verifying kernel
modules based on the pre-boot keys was previously rejected.)

Mimi

> 
> Signed-off-by: Robert Holmes <robeholmes@gmail.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: keyrings@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  kernel/module_signing.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> index 6b9a926fd86b..cf94220e9154 100644
> --- a/kernel/module_signing.c
> +++ b/kernel/module_signing.c
> @@ -49,6 +49,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
>  {
>  	struct module_signature ms;
>  	size_t sig_len, modlen = info->len;
> +	int ret;
> 
>  	pr_devel("==>%s(,%zu)\n", __func__, modlen);
> 
> @@ -82,8 +83,15 @@ int mod_verify_sig(const void *mod, struct load_info *info)
>  		return -EBADMSG;
>  	}
> 
> -	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> -				      VERIFY_USE_SECONDARY_KEYRING,
> -				      VERIFYING_MODULE_SIGNATURE,
> -				      NULL, NULL);
> +	ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> +				     VERIFY_USE_SECONDARY_KEYRING,
> +				     VERIFYING_MODULE_SIGNATURE,
> +				     NULL, NULL);
> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> +		ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> +					     VERIFY_USE_PLATFORM_KEYRING,
> +					     VERIFYING_MODULE_SIGNATURE,
> +					     NULL, NULL);
> +	}
> +	return ret;
>  }

