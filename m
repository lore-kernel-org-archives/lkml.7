Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85E8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E88204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iN4b2rHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfH0Kbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:31:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33698 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfH0Kbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:31:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RAT0RO058815;
        Tue, 27 Aug 2019 10:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=oGYQP2VZn2SCFbDq3nx+ZjXzvwaVi7rnVe0kqrcJ4sk=;
 b=iN4b2rHoaX1ztLEVaoimZsIur8Dp1y0OTBD3QFj9cnzn8UxR4zuXHtm4RJ7fBz2ICt71
 N2fbBE1n3y5cHk+B0W7YFO3Bk9xLEc9WkTLNfgLSo/RrPrzCwpb8VQC3vvcGJzSE/VHX
 Ii9mbL1zzJ4L0otEMxs54yVhJIUCYqID0nE4AXbgC8ddoDe6nuy73iSRpCabWVXNZ4lA
 9+HYR0/nB0B+bPtAkMv71HJIIWZKCFjhW6QcnpM7UwV8A8arQ2LnAH9Z2ymrVoYtnxRH
 2a11nN6OClPOD29sXdS5YoBEQW0KSFKv4rxfmpkPpqJfn1qPfcS/wTyhUbfbjkLH7uP9 RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2un2570914-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 10:31:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RASxEN027397;
        Tue, 27 Aug 2019 10:31:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2umhu8jwua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 10:31:45 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7RAVgcP005510;
        Tue, 27 Aug 2019 10:31:43 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 03:31:41 -0700
Date:   Tue, 27 Aug 2019 13:31:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanjana Sanikommu <sanjana99reddy99@gmail.com>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] r8188eu: use skb_put_data instead of skb_put/memcpy pair
Message-ID: <20190827103134.GC23584@kadam>
References: <4c9e1e66-5ffc-c04b-9ea8-39cec5fd9b2a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c9e1e66-5ffc-c04b-9ea8-39cec5fd9b2a@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 11:48:58PM +0300, Ivan Safonov wrote:
> skb_put_data is shorter and clear.
> 

Please don't start the commit message in the middle of a sentence.  It
often gets split from the start of the sentence.  See how it looks here.
https://marc.info/?l=linux-driver-devel&m=156676594611401&w=2


> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_recv.c        | 6 +-----
>  drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 3 +--
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c
> b/drivers/staging/rtl8188eu/core/rtw_recv.c
> index 620da6c003d8..d4278361e002 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_recv.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
> @@ -1373,11 +1373,7 @@ static struct recv_frame *recvframe_defrag(struct
> adapter *adapter,
>                 /* append  to first fragment frame's tail (if privacy frame,
> pull the ICV) */
>                 skb_trim(prframe->pkt, prframe->pkt->len -
> prframe->attrib.icv_len);


Your email client corrupted the patch so it can't be applied.

regards,
dan carpenter

