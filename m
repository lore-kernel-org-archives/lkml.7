Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024ABC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC248205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfEBNKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 09:10:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:37604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbfEBNKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:10:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8FF7AD3E;
        Thu,  2 May 2019 13:10:23 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 1DDCAE0117; Thu,  2 May 2019 15:10:23 +0200 (CEST)
Date:   Thu, 2 May 2019 15:10:23 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        David Ahern <dsahern@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] genetlink: do not validate dump requests if
 there is no policy
Message-ID: <20190502131023.GD21672@unicorn.suse.cz>
References: <cover.1556798793.git.mkubecek@suse.cz>
 <0a54a4db49c20e76a998ea3e4548b22637fbad34.1556798793.git.mkubecek@suse.cz>
 <031933f3fc4b26e284912771b480c87483574bea.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <031933f3fc4b26e284912771b480c87483574bea.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 02:51:33PM +0200, Johannes Berg wrote:
> On Thu, 2019-05-02 at 12:48 +0000, Michal Kubecek wrote:
> > Unlike do requests, dump genetlink requests now perform strict validation
> > by default even if the genetlink family does not set policy and maxtype
> > because it does validation and parsing on its own (e.g. because it wants to
> > allow different message format for different commands). While the null
> > policy will be ignored, maxtype (which would be zero) is still checked so
> > that any attribute will fail validation.
> > 
> > The solution is to only call __nla_validate() from genl_family_rcv_msg()
> > if family->maxtype is set.
> 
> D'oh. Which family was it that you found this on? I checked only ones
> with policy I guess.

It was with my ethtool netlink series (still work in progress).

Michal

> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> 
> johannes
> 
