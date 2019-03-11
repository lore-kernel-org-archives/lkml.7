Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C9720657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfCKKKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:10:09 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:41978 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfCKKKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:10:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id EF0A720063;
        Mon, 11 Mar 2019 11:10:07 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7R4RZXAhydTb; Mon, 11 Mar 2019 11:10:07 +0100 (CET)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 1CEAE20253;
        Mon, 11 Mar 2019 11:10:07 +0100 (CET)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Mar 2019
 11:10:06 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id B8296318057E;
 Mon, 11 Mar 2019 11:10:06 +0100 (CET)
Date:   Mon, 11 Mar 2019 11:10:06 +0100
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>
CC:     <davem@davemloft.net>, <fw@strlen.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: xfrm: Add '_rcu' tag for rcu protected pointer
 in netns_xfrm
Message-ID: <20190311101006.GK3758@gauss3.secunet.de>
References: <1551923648-17656-1-git-send-email-suyj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1551923648-17656-1-git-send-email-suyj.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: FCCF8079-BE83-4AF7-8F05-C44B3C0A837B
X-G-Data-MailSecurity-for-Exchange-ProcessedOnRouted: True
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 08:54:08PM -0500, Su Yanjun wrote:
> For rcu protected pointers, we'd better add '__rcu' for them.
> 
> Once added '__rcu' tag for rcu protected pointer, the sparse tool reports
> warnings.
> 
> net/xfrm/xfrm_user.c:1198:39: sparse:    expected struct sock *sk
> net/xfrm/xfrm_user.c:1198:39: sparse:    got struct sock [noderef] <asn:4> *nlsk
> [...]
> 
> So introduce a new wrapper function of nlmsg_unicast  to handle type
> conversions.
> 
> This patch also fixes a direct access of a rcu protected socket.
> 
> Fixes: be33690d8fcf("[XFRM]: Fix aevent related crash")
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>

Patch applied, thanks!
