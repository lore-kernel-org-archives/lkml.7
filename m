Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37ED2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfCSPPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:15:07 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:48952 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfCSPPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:15:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id C144320250;
        Tue, 19 Mar 2019 16:15:04 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bGpM2X8kgHpE; Tue, 19 Mar 2019 16:15:04 +0100 (CET)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 5F8942024F;
        Tue, 19 Mar 2019 16:15:04 +0100 (CET)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Mar 2019
 16:15:03 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 01A82318041E;
 Tue, 19 Mar 2019 16:15:03 +0100 (CET)
Date:   Tue, 19 Mar 2019 16:15:03 +0100
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
CC:     Su Yanjun <suyj.fnst@cn.fujitsu.com>, <davem@davemloft.net>,
        <fw@strlen.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: xfrm: Add '_rcu' tag for rcu protected pointer
 in netns_xfrm
Message-ID: <20190319151503.GW6035@gauss3.secunet.de>
References: <1551923648-17656-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190311101006.GK3758@gauss3.secunet.de>
 <b2beff03-f789-5c8b-bd69-57ece92372f8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b2beff03-f789-5c8b-bd69-57ece92372f8@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 5AFD50FB-37F6-4225-8465-5A6B9106DBFC
X-G-Data-MailSecurity-for-Exchange-ProcessedOnRouted: True
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:22:46AM -0700, Eric Dumazet wrote:
> 
> 
> On 03/11/2019 03:10 AM, Steffen Klassert wrote:
> > On Wed, Mar 06, 2019 at 08:54:08PM -0500, Su Yanjun wrote:
> >> For rcu protected pointers, we'd better add '__rcu' for them.
> >>
> >> Once added '__rcu' tag for rcu protected pointer, the sparse tool reports
> >> warnings.
> >>
> >> net/xfrm/xfrm_user.c:1198:39: sparse:    expected struct sock *sk
> >> net/xfrm/xfrm_user.c:1198:39: sparse:    got struct sock [noderef] <asn:4> *nlsk
> >> [...]
> >>
> >> So introduce a new wrapper function of nlmsg_unicast  to handle type
> >> conversions.
> >>
> >> This patch also fixes a direct access of a rcu protected socket.
> >>
> >> Fixes: be33690d8fcf("[XFRM]: Fix aevent related crash")
> >> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> > 
> > Patch applied, thanks!
> > 
> 
> Has this patch ever been tested ?

I had this on your testing system and it did
not complain. But maybe my testcases did not
trigger that codepath. Su, can you answer
on Eric question?
