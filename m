Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40274C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A1020881
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tUh2nNFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfGBDsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:48:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35038 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGBDsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:48:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x623joE8164668;
        Tue, 2 Jul 2019 03:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=gdW0k6GFcvfCYhWjUDdQVw9IHGxp4MNf7humvJiGshw=;
 b=tUh2nNFH+tZX8xkAjB+238YKlYl2id8wnb91earTc7hbfSFPqqSGt5HIO80GshAj3Dk+
 JvnqaBBCB70zx6SD1MS+IKTwl6o59rC0T9384VjTi4BzgbmjxQgbP5S8/d2PJoWwWNkV
 q/80obpCDjTeBijh1Yha8Zk31/QZF98nKbplEFIOa4CZqPk9Fco+pDo4ODe47gHAnOIl
 +KV0LifNIxQNUofim3A7et/oyq5/keRs3YMP9mWxt2gvALpY9OJc5ZCGlDEUnmsvUAUy
 lX5dFm7eucbsj0N/uqLENuzPUOuj6CoRkOxbjVh05IoIkO1oWrdvVh4FXUK6KAMB9iII mQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2te5tbgw9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 03:48:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x623lxbX071550;
        Tue, 2 Jul 2019 03:47:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tebku0yg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 03:47:59 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x623lp4A024771;
        Tue, 2 Jul 2019 03:47:52 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 20:47:51 -0700
Date:   Mon, 1 Jul 2019 23:48:18 -0400
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.co, jgross@suse.com, sstabellini@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Subject: Re: [PATCH v3 3/4] Revert "xen: Introduce 'xen_nopv' to disable PV
 extensions for HVM guests."
Message-ID: <20190702034818.GB8003@bostrovs-us.us.oracle.com>
References: <1561947628-1147-1-git-send-email-zhenzhong.duan@oracle.com>
 <1561947628-1147-4-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561947628-1147-4-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 10:20:27AM +0800, Zhenzhong Duan wrote:
> This reverts commit 8d693b911bb9c57009c24cb1772d205b84c7985c.
> 
> Instead we use an unified parameter 'nopv' for all the hypervisor
> platforms.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 ----
>  arch/x86/xen/enlighten_hvm.c                    | 12 +-----------
>  2 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 21e08af..d5c3dcc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5251,10 +5251,6 @@
>  			Disables the ticketlock slowpath using Xen PV
>  			optimizations.
>  
> -	xen_nopv	[X86]
> -			Disables the PV optimizations forcing the HVM guest to
> -			run as generic HVM guest with no PV drivers.
> -


So someone upgrades the kernel and suddenly things work differently?

At least there should be a warning that the option has been replaced
with 'nopv' (but I would actually keep this option working as well).

-boris



>  	xen_scrub_pages=	[XEN]
>  			Boolean option to control scrubbing pages before giving them back
>  			to Xen, for use by other domains. Can be also changed at runtime
> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
> index ac4943c..7fcb4ea 100644
> --- a/arch/x86/xen/enlighten_hvm.c
> +++ b/arch/x86/xen/enlighten_hvm.c
> @@ -210,18 +210,8 @@ static void __init xen_hvm_guest_init(void)
>  #endif
>  }
>  
> -static bool xen_nopv;
> -static __init int xen_parse_nopv(char *arg)
> -{
> -       xen_nopv = true;
> -       return 0;
> -}
> -early_param("xen_nopv", xen_parse_nopv);
> -
>  bool __init xen_hvm_need_lapic(void)
>  {
> -	if (xen_nopv)
> -		return false;
>  	if (xen_pv_domain())
>  		return false;
>  	if (!xen_hvm_domain())
> @@ -233,7 +223,7 @@ bool __init xen_hvm_need_lapic(void)
>  
>  static uint32_t __init xen_platform_hvm(void)
>  {
> -	if (xen_pv_domain() || xen_nopv)
> +	if (xen_pv_domain())
>  		return 0;
>  
>  	return xen_cpuid_base();
> -- 
> 1.8.3.1
> 
