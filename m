Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7804CC17461
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4416921D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SQQ6Y5aA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbfKENR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:17:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39318 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388782AbfKENRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:17:25 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5DED5b107142;
        Tue, 5 Nov 2019 13:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=zCxj2FypOGa+nB0i3E2EHjqmNc927yWEmUrHT+72n5c=;
 b=SQQ6Y5aApPKgJEnS/ha0anIYdLmFSfo+4WUfKxNbhciq1/7JrC8FYIrsVtuF0o5iZNvF
 bqTp0g1Zf7b3pe1YbHD9HG0HXzyl0gAqezrc2n+7hXxY1HWSgoyFPCcU+Srrl99xD93p
 BGGGkTEhe2ttolx528xGiE8UMwAn1bk4V6v9oXvbvcfv0H+p3F72wpZoBmks1P92RJIh
 kKZW6vHRF5NypWTIJEQdl//or7IVtfnwvhb7pGvv/bbmFW74zpfYK93D0K9JT4Nng8Gw
 ET8cQho6Plh/9+LccGMsTZ237b2VNJnSOv2EnmZ3fNGorNigtQeG9vEzWAWgyYYIMUWJ Hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w11rpx4g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 13:16:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5DFjwx190493;
        Tue, 5 Nov 2019 13:16:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2w31619xcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 13:16:13 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA5DGCZM018918;
        Tue, 5 Nov 2019 13:16:12 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Nov 2019 05:16:11 -0800
Date:   Tue, 5 Nov 2019 16:16:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Mao Wenan <maowenan@huawei.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] usb: roles: Hide option USB_ROLE_SWITCH
Message-ID: <20191105131605.GF10409@kadam>
References: <20191104135312.GD996639@ulmo>
 <20191104144850.91305-1-maowenan@huawei.com>
 <20191105124218.GB12204@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105124218.GB12204@kuha.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911050109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911050109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 02:42:18PM +0200, Heikki Krogerus wrote:
> On Mon, Nov 04, 2019 at 10:48:50PM +0800, Mao Wenan wrote:
> > The USB role switch class is, after all,
> > not useful by itself. Hiding USB_ROLE_SWITCH
> > so we can avoid any of the pitfalls associated
> > with user-visible symbols and "select".
> > 
> > Signed-off-by: Mao Wenan <maowenan@huawei.com>
> > ---
> >  drivers/usb/roles/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/roles/Kconfig b/drivers/usb/roles/Kconfig
> > index f8b31aa..1da58d4 100644
> > --- a/drivers/usb/roles/Kconfig
> > +++ b/drivers/usb/roles/Kconfig
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  
> >  config USB_ROLE_SWITCH
> > -	tristate "USB Role Switch Support"
> > +	tristate
> >  	help
> >  	  USB Role Switch is a device that can select the USB role - host or
> >  	  device - for a USB port (connector). In most cases dual-role capable
> 
> You didn't actually convert the "depends on USB_ROLE_SWTICH" to
> "select USB_ROLE_SWITCH" before this. You also left the help text that
> is now useless.
> 
> I really think that instead of this, we should just convert all
> "select USB_ROLE_SWTICH" to "depends on USB_ROLE_SWITCH".

The you have to find USB_ROLE_SWITCH first when you want to enable your
hardware...  It's feels really confusing when you want to create a
.config file...

I sometimes think maybe I'm too stupid to configure a kernel these days
and that's sort of sad because how is Aunt Tillie supposed to manage?

regards,
dan carpenter

