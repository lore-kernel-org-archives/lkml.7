Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83637C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566B225973
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x+5Mxo/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfEaJ3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:29:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42066 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEaJ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:29:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4V9TCGJ055040;
        Fri, 31 May 2019 09:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=B/80Jbbdq5j+mezsLHBpZfOYUfPS/DTx5wYd1REElw0=;
 b=x+5Mxo/iFOaYGB6PxeQ6fjKAm1DRHRb7a9ce3Xv0K1GDid5835vLUk3loMPnkP2BiNRm
 enz0u4jZXswJZEha/tG7V0+6y/WWbiBuQb1qZSC0zMppyFvtxV/jtsX1qJlRMprwi64y
 Mi7G80UHqschyFu30a9ybAu2/udZjlM9hQifYpIo/RHXpjOa1eEj5vrGNwZnPN9VL5Y/
 3iC1uZzt5cPjZpyEn5vfXFGZF2z/rQcfQ+Q4uoVbdzYktm6HPst+pjsOIV0wrAQHaNEM
 u+sx0xnEPfZTlu6JPInnyM9VBaMaA4f+134BLaBsWZDBX/8s2Nvvf/CmupV3sa+B3XiN dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4tw6d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 09:29:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4V9RkNj122297;
        Fri, 31 May 2019 09:29:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ss1fphk0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 09:29:19 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4V9TG0F027392;
        Fri, 31 May 2019 09:29:17 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 May 2019 02:29:15 -0700
Date:   Fri, 31 May 2019 12:29:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, himadri18.07@gmail.com,
        colin.king@canonical.com, straube.linux@gmail.com,
        yangx92@hotmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Replace function r8712_init_mlme_priv
Message-ID: <20190531092907.GC31203@kadam>
References: <20190530205531.30016-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530205531.30016-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905310062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905310062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 02:25:31AM +0530, Nishka Dasgupta wrote:
> Delete r8712_init_mlme_priv as it does nothing except call
> _init_mlme_priv, and rename _init_mlme_priv to
> r8712_init_mlme_priv.
> Change the type of the new r8712_init_mlme_priv (formerly _init_mlme_priv)
> to (non-static) int, from static sint.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good, thanks.

regards,
dan carpenter

