Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EDDC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B629B20693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZtlcWM9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfDDJmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:42:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43848 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbfDDJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:42:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x349coBt132101;
        Thu, 4 Apr 2019 09:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=uaFbvxjxOQMcxI7Ji/KZlWXetyEb/afRw5K3+JGnp6o=;
 b=ZtlcWM9obCZzpbdNCbFLEmkaMxjmh8BAySvSUv32KlEst3hCWWNpJ8dqLdVu/ayGCnHf
 TCbwtuHtoFPwcSVbnX9E+f+C3MJ18cEplpWhX0B939kOkd4ajz0C0khxZ7m65VGyRxYG
 x+xFpd32/97ZfFSLSfSiaXDY0E4ayHsysBkU1CYJJcFF/5sfU73RiqA67ppamHVOmiWx
 dUw/USYl9HRXqgcEfQkiDr1lilfBjY4s3xBtHkJIUk7U1YTCZ9M/YPhh2AWys6F9DOzh
 GHHcn4PXGKOI3JgcDCSWipBPa+l8Y173oS+IGcMXI2Aro/tuos1tkRXjRPqeemFpijMY FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2rhyvte288-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 09:41:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x349fNcm066207;
        Thu, 4 Apr 2019 09:41:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rm9mjgw72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 09:41:52 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x349fpuh025596;
        Thu, 4 Apr 2019 09:41:51 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 02:41:51 -0700
Date:   Thu, 4 Apr 2019 12:41:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: remove redundant null check on array
 'data'
Message-ID: <20190404094141.GJ32590@kadam>
References: <20190404093257.18757-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404093257.18757-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040067
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:32:57AM +0100, Colin King wrote:
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> index 944c8894f9ff..c4a4f118f547 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> @@ -2659,8 +2659,7 @@ static int ieee80211_wpa_set_wpa_ie(struct ieee80211_device *ieee,
>  {
>  	u8 *buf;
>  
> -	if (param->u.wpa_ie.len > MAX_WPA_IE_LEN ||
> -	    (param->u.wpa_ie.len && param->u.wpa_ie.data == NULL))
> +	if (param->u.wpa_ie.len > MAX_WPA_IE_LEN || param->u.wpa_ie.len)
>  		return -EINVAL;

Nope...  :P  Don't do that...

regards,
dan carpenter

