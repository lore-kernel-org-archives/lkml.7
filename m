Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BBAC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515E1206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VDew2XyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfCFHnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:43:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57796 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbfCFHnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:43:23 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x267YD2Y063280;
        Wed, 6 Mar 2019 07:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=oQqKpD0JFLE8LoJQfS4i7IYGxZOfTK7ijaGN4O2K5Iw=;
 b=VDew2XyHRl+A1sEP/NKW14cRiSPXX4EQ4CEF3r0DZJOAz2ThXtr9CpPPWbGMcfqiwWna
 i9fIf1uo67WwXNR2iUrUKetvQBwip3i3PYIeYACk/LLUNwdIReRq4u8rKNVQ3CUdCVpB
 K0pVRRLuFfEbCfGfj4e3BByEF07fiXSHy66acS5Yo0mPr6i+IGxGkP++rQLs3OUeuWZG
 A6kM44HxV7f/WkjAeAffN7VOTw2L+0UKfsJjPfiZhTrM1hgqJ8MAgvGvTsQTc5oWz6dw
 rcj/JEfFsJ2eN8a4tR3dP1eaxdP70JfW+bQFIx5aJgYL9DsehJhdquLDPN1wltZN5oEz mQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qyfbeab8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Mar 2019 07:43:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x267hIG0021906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Mar 2019 07:43:18 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x267hHNs025146;
        Wed, 6 Mar 2019 07:43:18 GMT
Received: from kadam (/41.202.241.15)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Mar 2019 23:43:16 -0800
Date:   Wed, 6 Mar 2019 10:43:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnold J Chand <chand.arnold@hotmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging/board/board.c: Fix compiler error
 of_find_all_nodes()
Message-ID: <20190306074309.GC13474@kadam>
References: <BN6PR15MB12029830C1D653341368F2FA9B720@BN6PR15MB1202.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR15MB12029830C1D653341368F2FA9B720@BN6PR15MB1202.namprd15.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9186 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903060053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the subsystem prefix to: [PATCH] Staging: board: ...

On Tue, Mar 05, 2019 at 11:39:30PM +0000, Arnold J Chand wrote:
> Fix implicit-function-declaration error by 'extern'-ing the function in
> the file
> 
> Signed-off-by: Arnold Chand <chand.arnold@hotmail.com>
> ---
>  drivers/staging/board/board.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
> index cb6feb34dd40..3025ee9f5517 100644
> --- a/drivers/staging/board/board.c
> +++ b/drivers/staging/board/board.c
> @@ -22,6 +22,8 @@
>  static struct device_node *irqc_node __initdata;
>  static unsigned int irqc_base __initdata;
>  
> +extern struct device_node *of_find_all_nodes(struct device_node *prev);
> +

We already include <linux/of.h> so what's going on here?  The driver
compiles for me.  Anyway, fix the includes, don't do this.

regards,
dan carpenter

