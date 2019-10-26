Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B2FCA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 15:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48D120863
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 15:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfJZPwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 11:52:44 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:42968 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbfJZPwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 11:52:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3BE0718002DDF;
        Sat, 26 Oct 2019 15:52:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: edge41_171fe4bc67f48
X-Filterd-Recvd-Size: 3064
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat, 26 Oct 2019 15:52:38 +0000 (UTC)
Message-ID: <ec9c36dddd1fb3d7cf339bcfba006f15f51b9120.camel@perches.com>
Subject: Re: [PATCH] net: Zeroing the structure ethtool_wolinfo in
 ethtool_get_wol()
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        zhanglin <zhang.lin16@zte.com.cn>
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, mkubecek@suse.cz, jiri@mellanox.com,
        pablo@netfilter.org, f.fainelli@gmail.com,
        maxime.chevallier@bootlin.com, lirongqing@baidu.com,
        vivien.didelot@gmail.com, linyunsheng@huawei.com,
        natechancellor@gmail.com, arnd@arndb.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn
Date:   Sat, 26 Oct 2019 08:52:35 -0700
In-Reply-To: <20191026142458.GJ23523@kadam>
References: <1572076456-12463-1-git-send-email-zhang.lin16@zte.com.cn>
         <20191026142458.GJ23523@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-10-26 at 17:24 +0300, Dan Carpenter wrote:
> On Sat, Oct 26, 2019 at 03:54:16PM +0800, zhanglin wrote:
> > memset() the structure ethtool_wolinfo that has padded bytes
> > but the padded bytes have not been zeroed out.
[]
> > diff --git a/net/core/ethtool.c b/net/core/ethtool.c
[]
> > @@ -1471,11 +1471,13 @@ static int ethtool_reset(struct net_device *dev, char __user *useraddr)
> >  
> >  static int ethtool_get_wol(struct net_device *dev, char __user *useraddr)
> >  {
> > -	struct ethtool_wolinf wol = { .cmd = ETHTOOL_GWOL };
> > +	struct ethtool_wolinfo wol;
> >  
> 
> How did you detect that they weren't initialized?  Is this a KASAN
> thing?
> 
> Most of the time GCC will zero out the padding bytes when you have an
> initializer like this, but sometimes it just makes the intialization a
> series of assignments which leaves the holes uninitialized.  I wish I
> knew the rules so that I could check for it in Smatch.  Or even better,
> I wish that there were an option to always zero the holes in this
> situation...

The standard doesn't specify what happens to the padding so
it's not just for gcc, it's compiler dependent.

So anything that's used in a copy_to_user with any possible
padding should either be zalloc'd or memset before assigned.

In this case:

include/uapi/linux/ethtool.h:#define SOPASS_MAX 6

and

include/uapi/linux/ethtool.h:struct ethtool_wolinfo {
include/uapi/linux/ethtool.h-   __u32   cmd;
include/uapi/linux/ethtool.h-   __u32   supported;
include/uapi/linux/ethtool.h-   __u32   wolopts;
include/uapi/linux/ethtool.h-   __u8    sopass[SOPASS_MAX];
include/uapi/linux/ethtool.h-};

so there's likely a couple bytes of trailing padding.


