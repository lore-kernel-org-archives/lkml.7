Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0826C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658D82084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfDLMvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:51:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43512 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLMvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:51:24 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hEvds-00077m-HD; Fri, 12 Apr 2019 12:50:52 +0000
Date:   Fri, 12 Apr 2019 13:50:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "wanghai (M)" <wanghai26@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        davem@davemloft.net, idosch@mellanox.com, eric.dumazet@gmail.com,
        alexander.h.duyck@intel.com, tyhicks@canonical.com,
        f.fainelli@gmail.com, amritha.nambiar@intel.com, joe@perches.com,
        dmitry.torokhov@gmail.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net-sysfs: Fix memory leak in netdev_register_kobject
Message-ID: <20190412125052.GJ2217@ZenIV.linux.org.uk>
References: <20190412203634.30392-1-wanghai26@huawei.com>
 <20190412203634.30392-3-wanghai26@huawei.com>
 <20190412083835.GG9224@smile.fi.intel.com>
 <1c9542c4-08ba-24e6-6bb3-1aecc9741eec@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c9542c4-08ba-24e6-6bb3-1aecc9741eec@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 08:08:32PM +0800, wanghai (M) wrote:
> 
> 在 2019/4/12 16:38, Andy Shevchenko 写道:
> > On Fri, Apr 12, 2019 at 04:36:34PM -0400, Wang Hai wrote:
> > 
> > > +error_register:
> > > +	device_del(dev);
> > > +error_device_add:
> > > +	kfree_const(dev->kobj.name);
> > >   	return error;
> > When put_device() will be called on this it will go to double free (in case of
> > dynamically allocated dev->kobj.name.
> > 
> > Al Viro and me suggested earlier that the correct fix is to call put_device()
> > in a places where it is appropriate.
> Thanks. I'll take a closer look at the code to see when it's time to call
> put_device(). It's really not easy to fix.

Depends upon the driver, obviously...  Note that if it's a built-in
with device never destroyed, that allocation is no leak at all -
reference to the object remains around.
