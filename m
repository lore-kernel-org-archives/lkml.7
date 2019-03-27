Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B99C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE2F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbfC0J0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:26:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfC0J0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:26:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9390FACE8;
        Wed, 27 Mar 2019 09:26:06 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 36BB0E1404; Wed, 27 Mar 2019 10:26:04 +0100 (CET)
Date:   Wed, 27 Mar 2019 10:26:04 +0100
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
Message-ID: <20190327092604.GP26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
 <20190326120909.GF2230@nanopsycho>
 <20190326132427.GK26076@unicorn.suse.cz>
 <20190326134251.GA5181@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326134251.GA5181@nanopsycho.orion>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 02:42:51PM +0100, Jiri Pirko wrote:
> Tue, Mar 26, 2019 at 02:24:27PM CET, mkubecek@suse.cz wrote:
> >On Tue, Mar 26, 2019 at 01:09:09PM +0100, Jiri Pirko wrote:
> >> Mon, Mar 25, 2019 at 06:08:09PM CET, mkubecek@suse.cz wrote:
> >> >+Device identification
> >> >+---------------------
> >> >+
> >> >+When appropriate, network device is identified by a nested attribute named
> >> >+ETHA_*_DEV. This attribute can contain
> >> 
> >> Isn't it ETHA_DEV_*? I must admit I'm a bit confused.
> >
> >ETHA_*_DEV is the nesting attribute (e.g. ETHA_SETTINGS_DEV), ETHA_DEV_*
> >(ETHA_DEV_INDEX and ETHA_DEV_NAME) are in the nest.
> 
> Yeah. I wonder why you need to duplicate this. Can this be in top-lever
> attr enum that is shared among all commands? It is there anyway and
> looks a bit silly to have "DEV" attr separate for every command.
> Something like this:
> 
> ATTR_IFINDEX
> ATTR_IFNAME
> ATTR_SOMEOTHER (flags perhaps)
> ATTR_CMD_SPECIFIC_NEST_START
>   ATTR_CMDX_SOMETHING
>   ATTR_CMDX_SOMETHING2
>   ATTR_CMDX_SOMETHING3
> ATTR_CMD_SPECIFIC_NEST_END

I would rather prefer the opposite:

ATTR_HEADER
    ATTR_IFINDEX
    ATTR_IFNAME
    ATTR_INFO_MASK
    ATTR_PER_QUEUE
ATTR_CMDX_SOMETHING
ATTR_CMDX_SOMETHING2
ATTR_CMDX_SOMETHING3
...

This way the "header" with universal attributes (not specfic to
a particular message type) would be kept together at the beginning even
after we need to add some more later and command specific attributes
would still have fixed numbers (starting from 2). I'll think about it
some more and check what would be pros and cons of the two variants
when parsing and generating the messages.

> >> >+Messages of type "get" are used by userspace to request information and
> >> >+usually do not contain any attributes (that may be added later for dump
> >> >+filtering). Kernel response is in the form of corresponding "set" message;
> >> 
> >> Okay. Do we want reply to "*_cmd_something_get" command to be
> >> "*_cmd_something_set". That sounds odd. Why reply has to be "cmd"? Why
> >> not something like "reply" or "response"?
> >> This should work for both "doit/dumpit" and notifications.
> >
> >As stated right below, the aim is to use the same format for replies to
> >GET requests as userspace uses for related SET requests. We could use
> >different id (genlmsghdr::cmd) but that seemed like a waste for no actual
> >gain.
> 
> I understand. I just wonder if the replies/notifications could use the
> same name, not having "set" in it. I know we have it like this in many
> netlink ifaces, it is however confusing to users. So once we are doing
> this from scratch, we can do it differently.

How about

  ETHTOOL_MSG_GET_FOO  for get requests
  ETHTOOL_MSG_FOO      for get replies, notifications and set requests
  ETHTOOL_MSG_ACT_FOO  for actions (renegotiation, reset, blinking, ...)

?

Michal
