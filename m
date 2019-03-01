Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E9AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCC620854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfCACGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:06:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727222AbfCACGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:06:12 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2124Sdm117702
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 21:06:11 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qxtk4jfyh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 21:06:10 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 1 Mar 2019 02:06:09 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Mar 2019 02:06:05 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x21264n616908422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Mar 2019 02:06:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E14FC4C052;
        Fri,  1 Mar 2019 02:06:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BCAF4C040;
        Fri,  1 Mar 2019 02:06:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.108.117])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Mar 2019 02:06:03 +0000 (GMT)
Subject: Re: [PATCH 08/27] kexec_file: Restrict at runtime if the kernel is
 locked down
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Thu, 28 Feb 2019 21:05:53 -0500
In-Reply-To: <20190228231203.212359-8-matthewgarrett@google.com>
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
         <20190228231203.212359-1-matthewgarrett@google.com>
         <20190228231203.212359-8-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030102-0008-0000-0000-000002C64A58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030102-0009-0000-0000-000022329DF1
Message-Id: <1551405953.10911.281.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Thank you for thinking about IMA.

On Thu, 2019-02-28 at 15:11 -0800, Matthew Garrett wrote:
> From: Jiri Bohac <jbohac@suse.cz>
> 
> When KEXEC_SIG is not enabled, kernel should not load images through
> kexec_file systemcall if the kernel is locked down unless IMA can be used
> to validate the image.

This patch is a partial solution, but it doesn't take into account the
architecture specific or custom policies.

Mimi

> [Modified by David Howells to fit with modifications to the previous patch
>  and to return -EPERM if the kernel is locked down for consistency with
>  other lockdowns]
> 
> Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jiri Bohac <jbohac@suse.cz>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> cc: Chun-Yi Lee <jlee@suse.com>
> cc: kexec@lists.infradead.org
> ---
>  include/linux/ima.h | 6 ++++++
>  kernel/kexec_file.c | 8 ++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index b5e16b8c50b7..b35ed0725a05 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -127,4 +127,10 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
>  	return 0;
>  }
>  #endif /* CONFIG_IMA_APPRAISE */
> +
> +static inline bool is_ima_kexec_appraise_enabled(void)
> +{
> +	return IS_ENABLED(CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS);
> +}
> +
>  #endif /* _LINUX_IMA_H */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 67f3a866eabe..b4e938dff4be 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -239,6 +239,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  		}
> 
>  		ret = 0;
> +		if (is_ima_kexec_appraise_enabled())
> +			break;
> +
> +		if (kernel_is_locked_down(reason)) {
> +			ret = -EPERM;
> +			goto out;
> +		}
> +
>  		break;
> 
>  		/* All other errors are fatal, including nomem, unparseable

