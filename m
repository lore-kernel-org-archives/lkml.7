Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87901C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDE420640
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H3z8CfhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbfJANMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:12:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36522 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfJANMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:12:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91D8xJT033466;
        Tue, 1 Oct 2019 13:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=kq5CKLXi/ptDXUTgrZI7EdqafVde7HbEbJ1WmPDhKSE=;
 b=H3z8CfhT++nA/qKbRVoauYuj4emUi5UzAHmHmcBxdmdlkIJxN/bJe5ti5eUHDlkbZTwL
 MuZdRzO7MjFEI0lGMuzsy9vlz5I8rrcC3vd8WGkM8L816oTU1nhm8Rg77GLfgqceW+Jk
 HGwObGmY+19spo0p6a3Uq55JyXC7q+zVcWJXNqZUHCXEg7GiUBS5gRm/TmXxZxo9zZ7Q
 QS0Fz9EUevk4H8kbrzq8Ua3hrIbkYY9pXgGeCaCzfHt0LPVp6Li2aVfXCwbN51FlvfAR
 IUwkGAybxjzaxdD46NV23y1oAAb9ZOlI39F7PnvMHxUxaofS853cmahYohMg8LdVW9BE Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2va05rnn5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 13:12:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91D96V1156536;
        Tue, 1 Oct 2019 13:12:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vbqd0ubw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 13:12:11 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x91DC6sv019624;
        Tue, 1 Oct 2019 13:12:08 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 06:12:06 -0700
Date:   Tue, 1 Oct 2019 16:11:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Connor Kuehl <connor.kuehl@canonical.com>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: fix null dereference when kzalloc
 fails
Message-ID: <20191001131122.GC22609@kadam>
References: <20190927214415.899-1-connor.kuehl@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927214415.899-1-connor.kuehl@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 02:44:15PM -0700, Connor Kuehl wrote:
> If kzalloc() returns NULL, the error path doesn't stop the flow of
> control from entering rtw_hal_read_chip_version() which dereferences the
> null pointer. Fix this by adding a 'goto' to the error path to more
> gracefully handle the issue and avoid proceeding with initialization
> steps that we're no longer prepared to handle.
> 
> Also update the debug message to be more consistent with the other debug
> messages in this function.
> 
> Addresses-Coverity: ("Dereference after null check")
> 
> Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
> ---
>  drivers/staging/rtl8188eu/os_dep/usb_intf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> index 664d93a7f90d..4fac9dca798e 100644
> --- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> @@ -348,8 +348,10 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>  	}
>  

There is another one earlier in the function as well.

drivers/staging/rtl8188eu/os_dep/usb_intf.c
   336  
   337          pnetdev = rtw_init_netdev(padapter);
   338          if (!pnetdev)
   339                  goto free_adapter;
   340          SET_NETDEV_DEV(pnetdev, dvobj_to_dev(dvobj));
   341          padapter = rtw_netdev_priv(pnetdev);
   342  
   343          if (padapter->registrypriv.monitor_enable) {
   344                  pmondev = rtl88eu_mon_init();
   345                  if (!pmondev)
   346                          netdev_warn(pnetdev, "Failed to initialize monitor interface");

goto free_adapter.

   347                  padapter->pmondev = pmondev;
   348          }
   349  
   350          padapter->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
   351          if (!padapter->HalData)
   352                  DBG_88E("cant not alloc memory for HAL DATA\n");
   353  

>  	padapter->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
> -	if (!padapter->HalData)
> -		DBG_88E("cant not alloc memory for HAL DATA\n");
> +	if (!padapter->HalData) {
> +		DBG_88E("Failed to allocate memory for HAL data\n");

Remove this debug printk.

> +		goto free_adapter;
> +	}


regards,
dan carpenter

