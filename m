Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18773C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DE421738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SGpPuOBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfDEIOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:14:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44928 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEIOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:14:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3584FEW015419;
        Fri, 5 Apr 2019 08:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=GcNZapxshH6bJXZg2BqpL7gD+XzURYGWNGldESdzyDA=;
 b=SGpPuOBpgjr2aCJDVpBFVCopuDtZzskvmMhn8C5mF7RZeLIKtK55thTE6+/YW4IbIHvV
 yaZ6ZRqo1Z/Cm6RsrS8JQQJTqf+WZvo2a8dYT/0kisJY5x95XdSKcoad6DMbUKPmGZqS
 3b/hniin73sZXsqrDb/qmtc6kL7debTTRFwejsPkH1YSBTs5BUiJq12kHkALgikcFJYZ
 HT/HchsZeT+nvO27T/v3zzhwpOOy4Vdi7uNPSmIYpbtDAwTC4ZweuoS2WcwkvguCf0BN
 0TLxW/X7QFwUkkwFnqSOdwvBvA0w7dRiWfwOIDeOX6kLfOviahWTX6xDUxnPcE/Oujhb pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2rhyvtke6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 08:13:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x358Dgk2119501;
        Fri, 5 Apr 2019 08:13:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2rp3698595-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 08:13:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x358Dpxo009534;
        Fri, 5 Apr 2019 08:13:51 GMT
Received: from kadam (/41.202.241.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Apr 2019 01:13:50 -0700
Date:   Fri, 5 Apr 2019 11:13:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <John.Linn@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH 1/3] net: xilinx: fix possible object reference leak
Message-ID: <20190405081339.GO32590@kadam>
References: <1553223849-7143-1-git-send-email-wen.yang99@zte.com.cn>
 <d2f169a0-b982-82ca-b2f1-963b8a579504@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2f169a0-b982-82ca-b2f1-963b8a579504@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904050061
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=841 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904050060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Please don't add kernel-janitors to the CC list in the middle of the
conversation.  Netdev people can review their own code.  We don't have a
copy of the patch your discussing and it's not even clear who you're
responding to.

regards,
dan carpenter

