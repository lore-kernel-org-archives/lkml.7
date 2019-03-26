Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913FBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6660820823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbfCZRcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:32:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:51772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbfCZRcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:32:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEEA9AF45;
        Tue, 26 Mar 2019 17:32:18 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 1A71AE1404; Tue, 26 Mar 2019 18:32:15 +0100 (CET)
Date:   Tue, 26 Mar 2019 18:32:15 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/22] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190326173215.GM26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
 <20190326163640.GD4958@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326163640.GD4958@nanopsycho.orion>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:36:40PM +0100, Jiri Pirko wrote:
> Mon, Mar 25, 2019 at 06:08:09PM CET, mkubecek@suse.cz wrote:
> >+/* genetlink setup */
> >+
> >+static const struct genl_ops ethtool_genl_ops[] = {
> 
> Please be consistent with prefixes. Either use "ethtool_" or "ethnl_"
> for all functions and variables in this code.

OK

> >+/* module setup */
> >+
> >+static int __init ethnl_init(void)
> >+{
> >+	int ret;
> >+
> >+	ret = genl_register_family(&ethtool_genl_family);
> >+	if (WARN(ret < 0, "ethtool: genetlink family registration failed"))
> 
> Why do you need this warning? Please avoid it.

I'm confused now... few days ago you replied "+1" to the idea:

  http://lkml.kernel.org/r/20190321162105.GU2087@nanopsycho

I agreed that panic() (which is what e.g. rtnetlink does) would be an
overkill but I would be definitely opposed to not having anything in the
log at all and just silently going on without the interface (which may
result in misconfigured network). I believe that if this fails, it is
a sign of something going very wrong inside the kernel so that the "W"
taint flag would be appropriate.

Michal
