Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9937CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3282064B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0XcfnrP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfFTICr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:02:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46408 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfFTICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:02:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5K7wuLm117665;
        Thu, 20 Jun 2019 08:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=WD8qZqlJCku4ZNEH7HaiSAiWDKr9ZzUT+2oWjBB2W4k=;
 b=0XcfnrP+z2wgAHv2NFRpvjaQ6H5bpnp6JeewO8yLJ3E4wj0eMaSE7ZPAv1q9Jy8j0jAI
 zheZdy8T9FFrduox+ws+ZZzLD8JzEfmfmrTB5oSMAzcyiPI/cJfbkBVBGGJZ0ZbhdWzn
 D/T9qhnXzGG3Xiiz2i4cXxoyPRrecRv9cVMJZfM1vQM5HyATe/lf3GddCkZd+8V/fodU
 noHZHV0COL5AunNi4sGlc6RjWqN9qkrcnZ9sI4ynL7jZztOOzG2OVCGeIVDnq6s6i0PP
 VTMmm/6lUnTOGr0GLdEZzMkF33mEljpjoExpa6SgOTmsTSOFCVB21foNUhsaYOTN9ELR /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t7809fht5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 08:02:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5K81Bd3038345;
        Thu, 20 Jun 2019 08:02:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t77yngb6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 08:02:13 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5K827wo011415;
        Thu, 20 Jun 2019 08:02:08 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 01:00:09 -0700
Date:   Thu, 20 Jun 2019 10:59:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] x86/apic: fix integer overflow on 10 bit left shift
 of cpu_khz
Message-ID: <20190620075959.GQ28859@kadam>
References: <20190619181446.13635-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619181446.13635-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=849
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=900 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 07:14:46PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The left shift of unsigned int cpu_khz will overflow for large values
> of cpu_khz, so cast it to a long long before shifting it to avoid
> overvlow.  For example, this can happen when cpu_khz is 4194305 (just
> less than 4.2 GHz).  Also wrap line to avoid checkpatch wide line
> warning.
> 
> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: 8c3ba8d04924 ("x86, apic: ack all pending irqs when crashed/on kexec")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/x86/kernel/apic/apic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 8956072f677d..31426126e5e0 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1464,7 +1464,8 @@ static void apic_pending_intr_clear(void)
>  		if (queued) {
>  			if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
>  				ntsc = rdtsc();
> -				max_loops = (cpu_khz << 10) - (ntsc - tsc);
> +				max_loops = ((long long)cpu_khz << 10) -
> +					    (ntsc - tsc);
>  			} else {
>  				max_loops--;
>  			}
> -- 
> 
> V2: replace right with left in commit subject and message. Doh.
> 

Uh, why are you putting the v2 explanation here instead of between the
--- cut off and the diffstat/


regards,
dan carpenter

