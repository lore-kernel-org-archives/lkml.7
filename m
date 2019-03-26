Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35324C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F260020830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CYvUaBzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfCZINF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:13:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41530 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCZINF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:13:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q7xGE9118688;
        Tue, 26 Mar 2019 08:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=W7BnsQJKvVdGHz8muJQ6ayHXVrB4dnpkCPC4dIfX9hE=;
 b=CYvUaBzWceElA9TJiOVQ+JJfPlsvYNh4QrM16tpgHE7qDICfxQGHYC6ls+CO4R3l62+C
 fKzLtk4AO0HUBkbAJm41xcTI8nLCKUPpR13aVZwzP1pdHCipmRum5A1qZd8RpJVwoSuP
 2EhTVG07w/xPmauJtf0dIuQp5WncoG/kFCxv01MziUyY0jScyyYCSfsDMdBTHbyAh3/U
 2AcyAk0gMP/6Snh4fEyQiRcjtWHLC5xVyh1fRxrP1CNR29+zIavsJYnXspgoTuKNinHq
 PopgkTyZp002JHbSZeBuZaaqk/HFHmeiZlcOxMECFvCtFTjo/9SnG9Ebnhu99GfdLhiv Dw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2re6g0rqb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 08:13:01 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q8D0rm025865
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 08:13:00 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q8CxSn012935;
        Tue, 26 Mar 2019 08:12:59 GMT
Received: from kadam (/197.157.0.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 01:12:59 -0700
Date:   Tue, 26 Mar 2019 11:12:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     qiaozhou <qiaozhou@asrmicro.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add support for ASR AquilaC SoC
Message-ID: <20190326081251.GE32613@kadam>
References: <1553389083-13237-1-git-send-email-qiaozhou@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553389083-13237-1-git-send-email-qiaozhou@asrmicro.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not the right person to send this to...

$ ./scripts/get_maintainer.pl -f arch/arm64/Kconfig.platforms
Catalin Marinas <catalin.marinas@arm.com> (maintainer:ARM64 PORT (AARCH64 ARCHITECTURE))
Will Deacon <will.deacon@arm.com> (maintainer:ARM64 PORT (AARCH64 ARCHITECTURE))
linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE))
linux-kernel@vger.kernel.org (open list)


On Sun, Mar 24, 2019 at 08:58:03AM +0800, qiaozhou wrote:
> From: Qiao Zhou <qiaozhou@asrmicro.com>
> 
> Add ARCH_ASR

You'll need to expand this.

> 
> Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
                 ^^^^^^^^
Use Qiao Zhou so it matches the From header.


> ---
>  arch/arm64/Kconfig.platforms | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 70498a0..da8d43a 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -278,4 +278,10 @@ config ARCH_ZYNQMP
>  	help
>  	  This enables support for Xilinx ZynqMP Family
>  
> +config ARCH_ASR
> +	bool "ASR Microelectronics chip Family"
> +	select PINCTRL
> +	help
> +	  This enables support for ASR Microelectronics chip Family, including:
> +	  - ASR 8751C SoC
>  endmenu

Was this supposed to be part of the patch you sent earlier?  You will
need to resend that one as a v2 patch.

regards,
dan carpenter

