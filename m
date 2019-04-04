Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21923C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C1C20693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BziY5QH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbfDDJM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:12:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43830 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387472AbfDDJMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:12:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3498dKp106900;
        Thu, 4 Apr 2019 09:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ooRjGljdHviFfmGky4Dy3X8VE6QgnWWfyaBMio4KVV8=;
 b=BziY5QH8JiAXF13/CpjnOyerM6gCJ126g7KctQbGh2NWmRDsFyjqUtz1OtfmY9+11VN4
 GeNaoH7+ednm9KfyM/i/TsgNVjKbhpge1YMDAFuQfa76+fChpp5gYXJ0a1Lc23aoUD20
 L4D0N7d78XOLvi9MoghyQ5xWuQF82AthBwH+7/D2uCrVcNIK5QUT3MlawWwPO25UhaXP
 GIBh13fn/h9reInfxWEiWHG8dsjjvvc1SfkYBVOIXkTR2hJVcqbGOjdHuueTLF7vVvp8
 H1/TRHcWxNNKpQxsxtbU2mgAsSPKX/5m3dfVt712/0DydqISIVAqCzleXFoxeF841WRv lA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rhyvtdwuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 09:12:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x349CLdw156462;
        Thu, 4 Apr 2019 09:12:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2rm8f5j05n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 09:12:22 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x349CHNF017487;
        Thu, 4 Apr 2019 09:12:17 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 02:12:16 -0700
Date:   Thu, 4 Apr 2019 12:12:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: cdc: ad7746: Replace bitshift by BIT
Message-ID: <20190404091206.GI32590@kadam>
References: <20190403204502.28917-1-lucasseikioshiro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403204502.28917-1-lucasseikioshiro@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=871
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040065
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=933 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 05:45:02PM -0300, Lucas Oshiro wrote:
>  #define AD7746_VTSETUP_VTMD_INT_TEMP	(0 << 5)
> -#define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
> +#define AD7746_VTSETUP_VTMD_EXT_TEMP	BIT(5)

No, the original is more readable.  Otherwise you can't see that it's
part of a set.

Just ignore checkpatch when it gives nonsense advice.

regards,
dan carpenter

