Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E4520657
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfC1HS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:18:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbfC1HS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:18:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A4CCAF25;
        Thu, 28 Mar 2019 07:18:56 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 2EFDBE1404; Thu, 28 Mar 2019 08:18:53 +0100 (CET)
Date:   Thu, 28 Mar 2019 08:18:53 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/22] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190328071853.GY26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
 <2c29310b-a2a0-3867-a09f-51f2dc47ecd3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c29310b-a2a0-3867-a09f-51f2dc47ecd3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 07:25:47PM -0700, Florian Fainelli wrote:
> > +GET_STRSET
> > +----------
> > +
> > +Requests contents of a string set as provided by ioctl commands
> > +ETHTOOL_GSSET_INFO and ETHTOOL_GSTRINGS. String sets are not user writeable so
> > +that the corresponding SET_STRSET message is only used in kernel replies.
> > +There are two types of string sets: global (independent of a device, e.g.
> > +device feature names) and device specific (e.g. device private flags).
> > +
> > +Request contents:
> > +
> > +    ETHA_STRSET_DEV		(nested)	device identification
> > +    ETHA_STRSET_COUNTS		(flag)		request only string counts
> 
> Should not that be part of the nested attribute under
> ETHA_STRSET_STRINGSET. We should probably think about adding another
> flag which indicates that we want to get the stringset associated data,
> see below why.
> 
> > +    ETHA_STRSET_STRINGSET	(nested)	string set to request
> > +        ETHA_STRINGSET_ID		(u32)		set id
> > +
> > +Kernel response contents:
> > +
> > +    ETHA_STRSET_DEV		(nested)	device identification
> > +    ETHA_STRSET_STRINGSET	(nested)	string set to request
> 
> string set requested?
> 
> > +        ETHA_STRINGSET_ID		(u32)		set id
> > +        ETHA_STRINGSET_COUNT		(u32)		number of strings
> > +        ETHA_STRINGSET_STRINGS		(nested)	array of strings
> > +            ETHA_STRING_INDEX			(u32)		string index
> > +            ETHA_STRING_VALUE			(string)	string value
> 
> This is one of the areas where the legacy ethtool ioctl() is painful
> because we need to request a string set to know how many of those exist
> to allocate space for those in both kernel and user space.
> 
> If we could find a way to have a single command that allows us to dump
> stringset (count, values) and associated data, then we save ourselves a
> context switch and having to pre-allocate memory accordingly.

The way the proposed interface is designed, we can get both without an
extra roundtrip but it's done the other way around, i.e. passing the
strings with the request for data. The API allows two modes of
operation:

1. One shot requests, e.g. typical ethtool use. We use "verbose" mode
(no ETHA_*_COMPACT flag in the request) and data is provided together
with the names. E.g. "ethtool eth2" request would look like

  ETHA_SETTINGS_DEV
      ETHA_DEV_NAME = "eth2"
  ETHA_SETTINGS_INFO_MASK = ... | ETH_SETTINGS_IM_LINKMODES | ...

and the reply would be

  ETHA_SETTINGS_DEV = {
      ETHA_DEV_INDEX = 4
      ETHA_DEV_NAME = "eth2"
  }
  ETHA_SETTINGS_LINK_INFO = {
      ...
  }
  ETHA_SETTRINGS_LINK_MODES = {
      ETHA_LINKMODES_AUTONEG = 1 (AUTONEG_ENABLE)
      ETHA_LINKMODES_OURS = {
          ETHA_BITSET_SIZE = 67
          ETHA_BITSET_BITS = {
              ETHA_BITS_BIT = {
                  ETHA_BIT_INDEX = 0 (ETHTOOL_LINK_MODE_10baseT_Half_BIT)
                  ETHA_BIT_NAME = "10baseT/Half"
              }
              ETHA_BITS_BIT = {
                  ETHA_BIT_INDEX = 1 (ETHTOOL_LINK_MODE_10baseT_Full_BIT)
                  ETHA_BIT_NAME = "10baseT/Full"
              }
              ETHA_BITS_BIT = {
                  ETHA_BIT_INDEX = 2 (ETHTOOL_LINK_MODE_100baseT_Half_BIT)
                  ETHA_BIT_NAME = "100baseT/Half"
                  ETHA_BIT_VALUE
              }
              ETHA_BITS_BIT = {
                  ETHA_BIT_INDEX = 3 (ETHTOOL_LINK_MODE_100baseT_Full_BIT)
                  ETHA_BIT_NAME = "100baseT/Full"
                  ETHA_BIT_VALUE
              }
              ETHA_BITS_BIT = {
                  ETHA_BIT_INDEX = 5 (ETHTOOL_LINK_MODE_1000baseT_Full_BIT)
                  ETHA_BIT_NAME = "1000baseT/Full"
                  ETHA_BIT_VALUE
              }
          }
      }
      ETHA_LINKMODES_PEER = {
          ...
      }
      ETHA_LINKMODES_SPEED = 1000 (SPEED_1000)
      ETHA_LINKMODES_DUPLEX = 1 (DUPLEX_FULL)
  }
  ...

2. Long time running applications, e.g. "ethtool --monitor", wicked,
systemd-networkd, ... For these, it would make sense to cache the
strings and either retrieve them in advance (on start and when new
device appears) or when they are needed for the first time. The request
would then include the ETHA_SETTINGS_COMPACT flag and reply would be

  ...
  ETHA_LINKMODES_OURS = {
      ETHA_BITSET_SIZE = 67
      ETHA_BITSET_VALUE = 0x0000002c 0x00000000 0x00000000
      ETHA_BITSET_MASK = 0x0000002f 0x00000000 0x00000000
  }

For "set" type requests, it's up to the application if it uses verbose
or compact form. The verbose form is most useful when we want e.g. to
set the values of one or two bits which may be identified by their names
(on command line or in config file).

Michal
