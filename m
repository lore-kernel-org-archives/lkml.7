Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19685C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93C7206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jRB0bTsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbfKFLY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:24:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39136 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfKFLY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:24:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6BIoCk007402;
        Wed, 6 Nov 2019 11:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=dS9fPvp5JFtr7OtCyzHtVChNlktMu26XAdqZYEjFFTA=;
 b=jRB0bTsxKRqKXMi5qcaa+HoYJKKVD8K9XF+zZc5PUEs8jq2WW6DtYT7ndX95l+/iNGsE
 u6IzeZHtq7Rmnq/d3hrW6YVlSzw3U+zqRyi4bqccq6b+2gX60Fu0++ldAW7ETW2WwHoo
 Jgg7rEqL8NfeUFcchjQgqAXYxQ+EtCF/xupCnE+b1GS+ua++kXEVQi9UiHoCZ9Kl9AU6
 Ku/4meUoBTbXqg0slKYfSh3O0WnuFcg9KYgdeQj/35HHhHTeGQwAtDrj8aG2HIuaUto1
 0628zaUA4Lw1FtKb83TzjddoCLiL5zqFjK3fuXaPCJ8K8ewyCVGQp60lYOIOrN35+ssX 3Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w12erd805-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 11:23:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA6BNE8b128684;
        Wed, 6 Nov 2019 11:23:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w333x54cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 11:23:43 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA6BNE45017045;
        Wed, 6 Nov 2019 11:23:15 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 03:23:14 -0800
Date:   Wed, 6 Nov 2019 14:23:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Mao Wenan <maowenan@huawei.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] usb: roles: Hide option USB_ROLE_SWITCH
Message-ID: <20191106112303.GJ10409@kadam>
References: <20191104135312.GD996639@ulmo>
 <20191104144850.91305-1-maowenan@huawei.com>
 <20191105124218.GB12204@kuha.fi.intel.com>
 <20191105131605.GF10409@kadam>
 <20191105152624.GC12204@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105152624.GC12204@kuha.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=934
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911060117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911060117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 05:26:24PM +0200, Heikki Krogerus wrote:
> Hi Dan,
> 
> On Tue, Nov 05, 2019 at 04:16:05PM +0300, Dan Carpenter wrote:
> > On Tue, Nov 05, 2019 at 02:42:18PM +0200, Heikki Krogerus wrote:
> > > On Mon, Nov 04, 2019 at 10:48:50PM +0800, Mao Wenan wrote:
> > > > The USB role switch class is, after all,
> > > > not useful by itself. Hiding USB_ROLE_SWITCH
> > > > so we can avoid any of the pitfalls associated
> > > > with user-visible symbols and "select".
> > > > 
> > > > Signed-off-by: Mao Wenan <maowenan@huawei.com>
> > > > ---
> > > >  drivers/usb/roles/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/usb/roles/Kconfig b/drivers/usb/roles/Kconfig
> > > > index f8b31aa..1da58d4 100644
> > > > --- a/drivers/usb/roles/Kconfig
> > > > +++ b/drivers/usb/roles/Kconfig
> > > > @@ -1,7 +1,7 @@
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > >  
> > > >  config USB_ROLE_SWITCH
> > > > -	tristate "USB Role Switch Support"
> > > > +	tristate
> > > >  	help
> > > >  	  USB Role Switch is a device that can select the USB role - host or
> > > >  	  device - for a USB port (connector). In most cases dual-role capable
> > > 
> > > You didn't actually convert the "depends on USB_ROLE_SWTICH" to
> > > "select USB_ROLE_SWITCH" before this. You also left the help text that
> > > is now useless.
> > > 
> > > I really think that instead of this, we should just convert all
> > > "select USB_ROLE_SWTICH" to "depends on USB_ROLE_SWITCH".
> > 
> > The you have to find USB_ROLE_SWITCH first when you want to enable your
> > hardware...  It's feels really confusing when you want to create a
> > .config file...
> 
> Unfortunately selecting the class alone is not enough. The USB role
> switch on the system may be a dual-role capable USB controller, but it
> may also be a mux that has its own separate driver.
> 
> It's equally or even more confusing for the user if the USB drivers
> are enabled, including the dual-role mode, but the connector still
> works only in one role, or in worst case not at all (if there is no
> mux driver and the mux is left in "safe mode" so that the pins on the
> connector are not connected to anything).
> 
> I still think that we should make these drivers depend on the class
> instead of just selecting it. That way we at least give the user a
> hint that there are also separate USB role switch drivers that may be
> needed.
> 

I guess I see your point.  My problem then is just with the menuconfig
system, not really with this patch.

> > I sometimes think maybe I'm too stupid to configure a kernel these days
> > and that's sort of sad because how is Aunt Tillie supposed to manage?
> 
> We can always use something like conditional comments in the
> Kconfig files to make sure that the user is told that in order to
> select the driver, a dependency must be satisfied:
> 
>         config MY_AWESOME_DRIVER
>                 tristate "My awesome driver!"
>                 depends on USB_ROLE_SWITCH
>                 help
>                   That's right! IT REALLY IS AWESOME!
> 
>         comment "My awesome driver depends on USB_ROLE_SWITCH..."
>                 depends on USB_ROLE_SWITCH=n
> 

Those sorts of help don't show up unless you already meet the
dependencies or if you search for it.  And if you search for it then it
already lists the depnds so the comment isn't required...

I guess that in the olden days you used to go through the menus and
look at all the high level options and figure it out.  These days you
sort of have to know what you want already.  And then you use the search
feature to enable it.

The menuconfig system really is very broken.  I've looked at alternative
ways to do it, but it quite a bit of work involved...

regards,
dan carpenter

