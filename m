Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0435A20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCGKGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:06:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:42162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbfCGKGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:06:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F271ACC6;
        Thu,  7 Mar 2019 10:06:07 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 4AC60E1175; Thu,  7 Mar 2019 11:06:05 +0100 (CET)
Date:   Thu, 7 Mar 2019 11:06:05 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Wenwen Wang <wang6495@umn.edu>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Edward Cree <ecree@solarflare.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethtool: reduce stack usage with clang
Message-ID: <20190307100605.GA20309@unicorn.suse.cz>
References: <20190307093408.3425010-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307093408.3425010-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:33:35AM +0100, Arnd Bergmann wrote:
> clang inlines the dev_ethtool() more aggressively than gcc does, leading
> to a larger amount of used stack space:
> 
> net/core/ethtool.c:2536:24: error: stack frame size of 1216 bytes in function 'dev_ethtool' [-Werror,-Wframe-larger-than=]
> 
> Marking the sub-functions that require the most stack space as
> noinline_for_stack gives us reasonable behavior on all compilers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/core/ethtool.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/net/core/ethtool.c b/net/core/ethtool.c
> index d4918ffddda8..fcbed78172a0 100644
> --- a/net/core/ethtool.c
> +++ b/net/core/ethtool.c
...
> @@ -2533,7 +2535,7 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
>  
>  /* The main entry point in this file.  Called from net/core/dev_ioctl.c */
>  
> -int dev_ethtool(struct net *net, struct ifreq *ifr)
> +int noinline_for_stack dev_ethtool(struct net *net, struct ifreq *ifr)
>  {
>  	struct net_device *dev = __dev_get_by_name(net, ifr->ifr_name);
>  	void __user *useraddr = ifr->ifr_data;

Is this part really needed? AFAICS dev_ethtool() is only called from
dev_ioctl() which is in a different compilation unit so that
dev_ethtool() won't be inlined anyway.

Michal Kubecek
