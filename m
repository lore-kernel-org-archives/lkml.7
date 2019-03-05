Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C45C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AE320657
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCEHbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:31:20 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:51190 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfCEHbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:31:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 3AEFA201E1;
        Tue,  5 Mar 2019 08:31:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3xeTK7WOJRTJ; Tue,  5 Mar 2019 08:31:17 +0100 (CET)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id C776D2007E;
        Tue,  5 Mar 2019 08:31:17 +0100 (CET)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 5 Mar 2019
 08:31:17 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 5C6F93180F05;
 Tue,  5 Mar 2019 08:31:17 +0100 (CET)
Date:   Tue, 5 Mar 2019 08:31:17 +0100
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     "Su Yanjun <suyj.fnst@cn.fujitsu.com>" <suyj.fnst@cn.fujitsu.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: xfrm: Fix potential oops in xfrm_user_rcv_msg and
 array out of bounds
Message-ID: <20190305073117.GD14737@gauss3.secunet.de>
References: <1551671259-21311-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190305064920.gcpwvkp7yikq33cy@gondor.apana.org.au>
 <d401c74f-43cd-7abe-a02d-7397b09b1784@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d401c74f-43cd-7abe-a02d-7397b09b1784@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: F7486E8E-D8E8-44DE-8ED5-21B0E6A81038
X-G-Data-MailSecurity-for-Exchange-ProcessedOnRouted: True
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 03:08:49PM +0800, Su Yanjun <suyj.fnst@cn.fujitsu.com> wrote:
> On 2019/3/5 14:49, Herbert Xu wrote:
> 
> > On Sun, Mar 03, 2019 at 10:47:39PM -0500, Su Yanjun wrote:
> > > When i review xfrm_user.c code, i found some potentical bug in it.
> > > 
> > > In xfrm_user_rcvmsg if type parameter from user space is set to
> > > XFRM_MSG_MAX or  XFRM_MSG_NEWSADINFO or XFRM_MSG_NEWSPDINFO. It will cause
> > > xfrm_user_rcv_msg  referring to null entry in xfrm_dispatch array.
> > > 
> > > Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> > > ---
> > >   net/xfrm/xfrm_user.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > > index a131f9f..d832783 100644
> > > --- a/net/xfrm/xfrm_user.c
> > > +++ b/net/xfrm/xfrm_user.c
> > > @@ -2630,11 +2630,13 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
> > >   		return -EOPNOTSUPP;
> > >   	type = nlh->nlmsg_type;
> > > -	if (type > XFRM_MSG_MAX)
> > > +	if (type >= XFRM_MSG_MAX)
> > >   		return -EINVAL;
> > Your patch is wrong.  Please check the definition of XFRM_MSG_MAX.
> 
> I see, thanks for your reply.
> 
>  	type -= XFRM_MSG_BASE;
>  	link = &xfrm_dispatch[type];
> +	if (!link)
> +		return -EOPNOTSUPP;
> 
> Here **link** may refer to null entry for special types such as
> XFRM_MSG_MAX or  XFRM_MSG_NEWSADINFO or XFRM_MSG_NEWSPDINFO
> Am i miss something?

'link' is always a valid pointer into that array.
