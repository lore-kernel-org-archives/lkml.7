Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B966FC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 09:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F41E2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 09:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfHQJAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 05:00:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbfHQJAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 05:00:33 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7H8uwJ1137644
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 05:00:32 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uedr11818-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 05:00:31 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sat, 17 Aug 2019 10:00:29 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 17 Aug 2019 10:00:26 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7H90Pst49807532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 09:00:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 282265206C;
        Sat, 17 Aug 2019 09:00:25 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.148])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2AA2C52050;
        Sat, 17 Aug 2019 09:00:24 +0000 (GMT)
Date:   Sat, 17 Aug 2019 12:00:22 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Berger <opendmb@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch : arm : add a criteria for pfn_valid
References: <1566010813-27219-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566010813-27219-1-git-send-email-huangzhaoyang@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19081709-0008-0000-0000-0000030A0077
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081709-0009-0000-0000-00004A281F4C
Message-Id: <20190817090021.GA10627@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908170099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 11:00:13AM +0800, Zhaoyang Huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> pfn_valid can be wrong while the MSB of physical address be trimed as pfn
> larger than the max_pfn.

How the overflow of __pfn_to_phys() is related to max_pfn?
Where is the guarantee that __pfn_to_phys(max_pfn) won't overflow?
 
> Signed-off-by: Zhaoyang Huang <huangzhaoyang@gmail.com>
> ---
>  arch/arm/mm/init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index c2daabb..9c4d938 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -177,7 +177,8 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>  int pfn_valid(unsigned long pfn)
>  {
> -	return memblock_is_map_memory(__pfn_to_phys(pfn));
> +	return (pfn > max_pfn) ?
> +		false : memblock_is_map_memory(__pfn_to_phys(pfn));
>  }
>  EXPORT_SYMBOL(pfn_valid);
>  #endif
> -- 
> 1.9.1
> 

-- 
Sincerely yours,
Mike.

