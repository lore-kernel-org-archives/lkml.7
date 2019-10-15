Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F9ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEAE2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QvK8ywLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfJOLq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:46:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfJOLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:46:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FBhkSG128247;
        Tue, 15 Oct 2019 11:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ioUB4OQf3/crC1d3UdNJzo0k+yaINfoF6RwTYIRdMeQ=;
 b=QvK8ywLH5JaiDsQE3ecSFMabz320gTsm4Sm0RdNVx5DmU2HrT9HxLW1ccMsVu4ecceMy
 e4d94b9IXtuR/3fbUySwJCXRQhk3NpIrSTLNbd55Mc2W6UpGD3apmDqf8nkRlqsb4oK+
 RqEPPKNsGzueaHwItZGFz3iFnxJ1Idgro778uwnwqFQl00s0fNGP4SxXiEVynXHgNoAk
 FYsd0yn4QHppJUKQtZ3MLH4oXOrMTe6/QocMyXjR4CUaIVtX1ZBbX3bam6gBZ/lhwox2
 pAvfFpqH823ddIWa3ksadguwRcdQDmw4okk3avH7ukgRhFLadPpSTYOA9de039qzoCBA ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vk7fr73e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 11:46:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FBhIWM154785;
        Tue, 15 Oct 2019 11:46:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vn7181c5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 11:46:30 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9FBkSab025252;
        Tue, 15 Oct 2019 11:46:28 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 11:46:27 +0000
Date:   Tue, 15 Oct 2019 14:46:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gregkh@linuxfoundation.org, jarias.linux@gmail.com,
        julia.lawall@lip6.fr, colin.king@canonical.com,
        hdegoede@redhat.com, hariprasad.kelam@gmail.com,
        nachukannan@gmail.com, pakki001@umn.edu, hardiksingh.k@gmail.com,
        nishkadg.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: rtl8723bs: remove unnecessary null check
Message-ID: <20191015114618.GG4774@kadam>
References: <20191015114053.23496-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015114053.23496-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 07:40:53PM +0800, YueHaibing wrote:
> Null check before kfree is redundant, so remove it.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_xmit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index 7011c2a..4597f4f 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -2210,8 +2210,7 @@ void rtw_free_hwxmits(struct adapter *padapter)
>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
>  
>  	hwxmits = pxmitpriv->hwxmits;
> -	if (hwxmits)
> -		kfree(hwxmits);
> +	kfree(hwxmits);

Just do:

	kfree(pxmitpriv->hwxmits);

regards,
dan carpenter

