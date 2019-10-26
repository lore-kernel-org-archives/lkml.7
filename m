Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB45CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1137214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfJZTke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 15:40:34 -0400
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:42911 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726342AbfJZTkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 15:40:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3C59D180357D1;
        Sat, 26 Oct 2019 19:40:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stone20_785fe5ad57825
X-Filterd-Recvd-Size: 3871
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat, 26 Oct 2019 19:40:27 +0000 (UTC)
Message-ID: <c790578751dd69fb1080b355f5847c9ea5fb0e15.camel@perches.com>
Subject: Re: [PATCH] net: Zeroing the structure ethtool_wolinfo in
 ethtool_get_wol()
From:   Joe Perches <joe@perches.com>
To:     zhanglin <zhang.lin16@zte.com.cn>, davem@davemloft.net,
        cocci <cocci@systeme.lip6.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com, mkubecek@suse.cz,
        jiri@mellanox.com, pablo@netfilter.org, f.fainelli@gmail.com,
        maxime.chevallier@bootlin.com, lirongqing@baidu.com,
        vivien.didelot@gmail.com, linyunsheng@huawei.com,
        natechancellor@gmail.com, arnd@arndb.de, dan.carpenter@oracle.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn
Date:   Sat, 26 Oct 2019 12:40:23 -0700
In-Reply-To: <1572076456-12463-1-git-send-email-zhang.lin16@zte.com.cn>
References: <1572076456-12463-1-git-send-email-zhang.lin16@zte.com.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-10-26 at 15:54 +0800, zhanglin wrote:
> memset() the structure ethtool_wolinfo that has padded bytes
> but the padded bytes have not been zeroed out.
[]
> diff --git a/net/core/ethtool.c b/net/core/ethtool.c
[]
> @@ -1471,11 +1471,13 @@ static int ethtool_reset(struct net_device *dev, char __user *useraddr)
>  
>  static int ethtool_get_wol(struct net_device *dev, char __user *useraddr)
>  {
> -	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
> +	struct ethtool_wolinfo wol;
>  
>  	if (!dev->ethtool_ops->get_wol)
>  		return -EOPNOTSUPP;
>  
> +	memset(&wol, 0, sizeof(struct ethtool_wolinfo));
> +	wol.cmd = ETHTOOL_GWOL;
>  	dev->ethtool_ops->get_wol(dev, &wol);
>  
>  	if (copy_to_user(useraddr, &wol, sizeof(wol)))

It seems likely there are more of these.

Is there any way for coccinelle to find them?

There are ~4000 structs in include/uapi and
there are ~3000 uses of copy_to_user in the tree.

$ git grep -P '\bstruct\s+\w+\s*{' include/uapi/ | cut -f2 -d" "|sort|uniq|wc -l
3785
$ git grep -w copy_to_user|wc -l
2854

A trivial grep and manual search using:

$ git grep -B20 -w copy_to_user | grep -A20 -P '\bstruct\s+\w+\s*=\s*{'

shows at least 1 (I didn't look very hard and stopped after finding 1):

   include/uapi/linux/utsname.h:struct oldold_utsname {
   include/uapi/linux/utsname.h-   char sysname[9];
   include/uapi/linux/utsname.h-   char nodename[9];
   include/uapi/linux/utsname.h-   char release[9];
   include/uapi/linux/utsname.h-   char version[9];
   include/uapi/linux/utsname.h-   char machine[9];
   include/uapi/linux/utsname.h-};

and 

   kernel/sys.c-	struct oldold_utsname tmp = {};
   kernel/sys.c-
   kernel/sys.c-	if (!name)
   kernel/sys.c-		return -EFAULT;
   kernel/sys.c-
   kernel/sys.c-	down_read(&uts_sem);
   kernel/sys.c-	memcpy(&tmp.sysname, &utsname()->sysname, __OLD_UTS_LEN);
   kernel/sys.c-	memcpy(&tmp.nodename, &utsname()->nodename, __OLD_UTS_LEN);
   kernel/sys.c-	memcpy(&tmp.release, &utsname()->release, __OLD_UTS_LEN);
   kernel/sys.c-	memcpy(&tmp.version, &utsname()->version, __OLD_UTS_LEN);
   kernel/sys.c-	memcpy(&tmp.machine, &utsname()->machine, __OLD_UTS_LEN);
   kernel/sys.c-	up_read(&uts_sem);
   kernel/sys.c:	if (copy_to_user(name, &tmp, sizeof(tmp)))

where there is likely 3 bytes of padding after 45 bytes of data
in the struct.


