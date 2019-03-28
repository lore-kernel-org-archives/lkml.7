Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF59DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858C520823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="MO2/LL5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfC1NnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:43:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39180 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfC1NnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:43:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so22956017wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pw401xXTqlnDbYpTAlJF13Zvd2fv8A+z1dJpMwS4aaU=;
        b=MO2/LL5+hYaosiXzrxzv3elcZNspPX459b5JRre0mnaEKoo/ehHBFo1AvuBJqVK0G0
         qLeTuRPYM0EeNf97Zjh18WrSyYsiei48krEF+QUyQGP6oPpPGq/mENLNuVlKvxzUJfal
         0ES6uREEMR8NJYAsMjq6jELk+R12G6U0IQNALkKjPPg84ZbDCHKkPIhyndT3ga0zEkKW
         6YnAvcNY5AB8nP2w83FITKroBSskuEt/+GC8NIPU8hVplM7DgiR7vq3AbbjTtFuQqin9
         n6rG87xFphXIuM5grHS2g7RXrapHk1HF69jEGlV18ywZ+v9OjwWNGiCHfc4DlLQNZrfP
         1m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pw401xXTqlnDbYpTAlJF13Zvd2fv8A+z1dJpMwS4aaU=;
        b=IELOBT8+93NNj4POsjGfyZElcuHQIwT62H78hkGBGHtwIbz4opl+QcqNpKGNehxM1W
         LiHXsGBDz4pXFKU5EV/yCiiUs4tIENdMUFxNIJ2OGxvV9qYZrSBUSl1sG+eCRKdsVkKt
         4RO//TDvxUEyie0KOak0B9QL3K4ywOfHoklt+nuGPM7KFpOdicJJEdh9t2UjPrvQ4faX
         EdgHTmoorf0BsaHjN+/uLDqF0laca0xFoXFR7fhy910gVBptI615Uppdy2jv8xv6RbQf
         Fz2z1CzAx294Kif2rb52+8zu0NolS7gyINMn8wec/v5275i7VJYA8Jf3PnTu//CWNqa7
         tMBA==
X-Gm-Message-State: APjAAAWrzXsWZUD1gwe8OG2RyVnFFq1j6LM/wm9nqycR8NX3Ok4rUBVC
        aYN5pGL2xoEdQ5NIGEXhUGGIQQ==
X-Google-Smtp-Source: APXvYqxncczm+Gmzc7gLsvH/iZuAQyZOi8F1qkxFuX93u88zxTd9nI1pSp5BzqprmUh+vpaUXYxRMA==
X-Received: by 2002:adf:c7c8:: with SMTP id y8mr29688653wrg.149.1553780601047;
        Thu, 28 Mar 2019 06:43:21 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id h17sm21063678wrq.93.2019.03.28.06.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:43:13 -0700 (PDT)
Date:   Thu, 28 Mar 2019 14:43:13 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/22] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190328134313.GO14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
 <2c29310b-a2a0-3867-a09f-51f2dc47ecd3@gmail.com>
 <20190328071853.GY26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328071853.GY26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Mar 28, 2019 at 08:18:53AM CET, mkubecek@suse.cz wrote:
>On Wed, Mar 27, 2019 at 07:25:47PM -0700, Florian Fainelli wrote:
>> > +GET_STRSET
>> > +----------
>> > +
>> > +Requests contents of a string set as provided by ioctl commands
>> > +ETHTOOL_GSSET_INFO and ETHTOOL_GSTRINGS. String sets are not user writeable so
>> > +that the corresponding SET_STRSET message is only used in kernel replies.
>> > +There are two types of string sets: global (independent of a device, e.g.
>> > +device feature names) and device specific (e.g. device private flags).
>> > +
>> > +Request contents:
>> > +
>> > +    ETHA_STRSET_DEV		(nested)	device identification
>> > +    ETHA_STRSET_COUNTS		(flag)		request only string counts
>> 
>> Should not that be part of the nested attribute under
>> ETHA_STRSET_STRINGSET. We should probably think about adding another
>> flag which indicates that we want to get the stringset associated data,
>> see below why.
>> 
>> > +    ETHA_STRSET_STRINGSET	(nested)	string set to request
>> > +        ETHA_STRINGSET_ID		(u32)		set id
>> > +
>> > +Kernel response contents:
>> > +
>> > +    ETHA_STRSET_DEV		(nested)	device identification
>> > +    ETHA_STRSET_STRINGSET	(nested)	string set to request
>> 
>> string set requested?
>> 
>> > +        ETHA_STRINGSET_ID		(u32)		set id
>> > +        ETHA_STRINGSET_COUNT		(u32)		number of strings
>> > +        ETHA_STRINGSET_STRINGS		(nested)	array of strings
>> > +            ETHA_STRING_INDEX			(u32)		string index
>> > +            ETHA_STRING_VALUE			(string)	string value
>> 
>> This is one of the areas where the legacy ethtool ioctl() is painful
>> because we need to request a string set to know how many of those exist
>> to allocate space for those in both kernel and user space.
>> 
>> If we could find a way to have a single command that allows us to dump
>> stringset (count, values) and associated data, then we save ourselves a
>> context switch and having to pre-allocate memory accordingly.
>
>The way the proposed interface is designed, we can get both without an
>extra roundtrip but it's done the other way around, i.e. passing the
>strings with the request for data. The API allows two modes of
>operation:
>
>1. One shot requests, e.g. typical ethtool use. We use "verbose" mode
>(no ETHA_*_COMPACT flag in the request) and data is provided together
>with the names. E.g. "ethtool eth2" request would look like
>
>  ETHA_SETTINGS_DEV
>      ETHA_DEV_NAME = "eth2"
>  ETHA_SETTINGS_INFO_MASK = ... | ETH_SETTINGS_IM_LINKMODES | ...
>
>and the reply would be
>
>  ETHA_SETTINGS_DEV = {
>      ETHA_DEV_INDEX = 4
>      ETHA_DEV_NAME = "eth2"
>  }
>  ETHA_SETTINGS_LINK_INFO = {
>      ...
>  }
>  ETHA_SETTRINGS_LINK_MODES = {
>      ETHA_LINKMODES_AUTONEG = 1 (AUTONEG_ENABLE)
>      ETHA_LINKMODES_OURS = {
>          ETHA_BITSET_SIZE = 67
>          ETHA_BITSET_BITS = {
>              ETHA_BITS_BIT = {
>                  ETHA_BIT_INDEX = 0 (ETHTOOL_LINK_MODE_10baseT_Half_BIT)
>                  ETHA_BIT_NAME = "10baseT/Half"
>              }
>              ETHA_BITS_BIT = {
>                  ETHA_BIT_INDEX = 1 (ETHTOOL_LINK_MODE_10baseT_Full_BIT)
>                  ETHA_BIT_NAME = "10baseT/Full"
>              }
>              ETHA_BITS_BIT = {
>                  ETHA_BIT_INDEX = 2 (ETHTOOL_LINK_MODE_100baseT_Half_BIT)
>                  ETHA_BIT_NAME = "100baseT/Half"
>                  ETHA_BIT_VALUE
>              }
>              ETHA_BITS_BIT = {
>                  ETHA_BIT_INDEX = 3 (ETHTOOL_LINK_MODE_100baseT_Full_BIT)
>                  ETHA_BIT_NAME = "100baseT/Full"
>                  ETHA_BIT_VALUE
>              }
>              ETHA_BITS_BIT = {
>                  ETHA_BIT_INDEX = 5 (ETHTOOL_LINK_MODE_1000baseT_Full_BIT)
>                  ETHA_BIT_NAME = "1000baseT/Full"
>                  ETHA_BIT_VALUE

I don't like this. This should not be bitfield/set. This should be
simply nested array of enum values:

enum ethtool_link_mode {
	ETHTOOL_LINK_MODE_10baseT_Half,
	ETHTOOL_LINK_MODE_10baseT_Full,
	ETHTOOL_LINK_MODE_100baseT_Half,
	ETHTOOL_LINK_MODE_100baseT_Full,
	ETHTOOL_LINK_MODE_1000baseT_Full,
};

and then there should be 2 attrs:
ETHTOOL_A_LINK_MODE_LIST_OUR	/* nest */
ETHTOOL_A_LINK_MODE_LIST_PEER	/* nest */
ETHTOOL_A_LINK_MODE		/* u32 */

and then the message should look like:

   ETHTOOL_A_LINK_MODE_LIST_OUR start nest
     ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_10baseT_Half
     ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_10baseT_Full
     ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_100baseT_Half
     ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_100baseT_Full
     ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_1000baseT_Full
   ETHTOOL_A_LINK_MODE_LIST_OUR end nest
   ETHTOOL_A_LINK_MODE_LIST_PEER start nest
     ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_10baseT_Half
     ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_10baseT_Full
     ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_100baseT_Half
     ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_100baseT_Full
     ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_1000baseT_Full
   ETHTOOL_A_LINK_MODE_LIST_PEER end nest

Nice and simple. No bits, no strings.



>              }
>          }
>      }
>      ETHA_LINKMODES_PEER = {
>          ...
>      }
>      ETHA_LINKMODES_SPEED = 1000 (SPEED_1000)
>      ETHA_LINKMODES_DUPLEX = 1 (DUPLEX_FULL)
>  }
>  ...
>
>2. Long time running applications, e.g. "ethtool --monitor", wicked,
>systemd-networkd, ... For these, it would make sense to cache the
>strings and either retrieve them in advance (on start and when new
>device appears) or when they are needed for the first time. The request
>would then include the ETHA_SETTINGS_COMPACT flag and reply would be
>
>  ...
>  ETHA_LINKMODES_OURS = {
>      ETHA_BITSET_SIZE = 67
>      ETHA_BITSET_VALUE = 0x0000002c 0x00000000 0x00000000
>      ETHA_BITSET_MASK = 0x0000002f 0x00000000 0x00000000
>  }
>
>For "set" type requests, it's up to the application if it uses verbose
>or compact form. The verbose form is most useful when we want e.g. to
>set the values of one or two bits which may be identified by their names
>(on command line or in config file).
>
>Michal
