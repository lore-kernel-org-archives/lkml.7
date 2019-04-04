Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5928C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820032064A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lRwJh+DE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfDDPF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:05:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32770 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbfDDPF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:05:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34ExDis019529;
        Thu, 4 Apr 2019 15:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=pEOqO5IwUn6lfdhHxHhS+5hcuhsf4w8bOu9lP5bbvB0=;
 b=lRwJh+DEyLSO+PyJNQra61R+xs6GBJ1U8FGS6zm6YJvbeASWubGD26Z1PnbxcQqNtrkb
 NuQi2V2mfAwHCbUvtODNr+DOg7EpSY+39mtwO9qd4bkRfrLEntiVs092z6B2JJ6hjhSK
 RqDHae+jhG2SiiXHO5gDZurbP6feB2+g6IuahZtYTC3IaF2b5jTzOJ9k6aQFT6dIZ/I0
 2/FFlrRG1MWM3TYvEU+lbVLsWtvAbF9TClZCicbnVhZ+894W0kuT/7CmEjrQGGhya2C4
 1A8uIrXga73mnZ/qEmcmqLssKvf0l4Wv4DQw16zIDaNB96wzEEkWxIBlwxgh4cBEWcG2 eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2rhyvtfred-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 15:05:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34F5Lk8116540;
        Thu, 4 Apr 2019 15:05:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2rm8f5yu7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 15:05:21 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x34F5Ir1028255;
        Thu, 4 Apr 2019 15:05:19 GMT
Received: from kadam (/41.202.241.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 08:05:18 -0700
Date:   Thu, 4 Apr 2019 18:05:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp: remove redundant check on tskb
Message-ID: <20190404150508.GL32590@kadam>
References: <20190404144603.27682-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404144603.27682-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040097
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 03:46:03PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The non-null check on tskb is always false because it is in an else
> path of a check on tskb and hence tskb is null in this code block.
> This is check is therefore redundant and can be removed as well
> as the label coalesc.
> 
> if (tsbk) {
>         ...
> } else {
>         ...
>         if (unlikely(!skb)) {
>                 if (tskb)       /* can never be true, redundant code */
>                         goto coalesc;
>                 return;
>         }
> }
> 
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This was fallout from commit 75c119afe14f ("tcp: implement rb-tree based
retransmit queue").

regards,
dan carpenter

