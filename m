Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5DA21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfC1KK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:10:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:36112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfC1KK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:10:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E91DAD25;
        Thu, 28 Mar 2019 10:10:55 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 68F14E1404; Thu, 28 Mar 2019 11:10:54 +0100 (CET)
Date:   Thu, 28 Mar 2019 11:10:54 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 19/22] ethtool: provide WoL information in
 GET_SETTINGS request
Message-ID: <20190328101054.GE26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <be5ce3381f30d7c3fe14ba6d98a58a31c57b851b.1553532199.git.mkubecek@suse.cz>
 <7580e650-565a-a7e2-35cc-6cce1c3f5ba6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7580e650-565a-a7e2-35cc-6cce1c3f5ba6@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 08:42:26PM -0700, Florian Fainelli wrote:
> On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> >  
> > +	data->privileged = ethnl_is_privileged(skb);
> 
> Is not this potentially creating a time of check/time of use issue? Can
> you check for ethnl_is_privileged() at the time where you fill in the
> reply skb?

I'm not sure what kind of race you have in mind but if this is a
problem, we might have even bigger one for any "SET" request where the
privilege check is performed even earlier by the genetlink dispatcher
(by setting GENL_UNS_ADMIN_PERM or GENL_ADMIN_PERM flag in genl_ops).

Michal
