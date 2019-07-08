Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3204AC606CC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18D42086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="xIdMY8nT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404208AbfGHT0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:26:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55259 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404190AbfGHT0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:26:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so636241wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0IaVonFJq9FIdCftu/vlsIjqEgT0raBFRPQO0ku8wpY=;
        b=xIdMY8nT32arQWhJTAgozhsQ9BmbEmS6PBq09oQgbBr5CsF7aleDMXSxhqu+TgBi0L
         TmLJGvJnV/saG85WUpySZU+q/Dm+/krvoD3fp3wcOGiPOO0pSCYbS8u8/77KAM5Qzy0Z
         8bSAjqWORtkcEjUrW9ZBfDnFbcmP/OCV1xWG6KVtLyARwp+FwshgxgglpyQXgnMr7Els
         UrsscwAG5HGSTbtvX1J3R53qWhk4meeC5x8dUo7rdmkMyvzK4X+SrM5mDFn84n83E5AB
         C1Aq/l1HBJi4fGWnIdoN8XifP41Hj1LPFuTNBHTuiQjDJD3DI/rMd3I0jik+6qfcCmoK
         AqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0IaVonFJq9FIdCftu/vlsIjqEgT0raBFRPQO0ku8wpY=;
        b=Zg55CTpHbxcVpuhTBWGtnQ6MIOsudkDb259sjedoEQKtTWDnyoMCC4j7bXDKw2dOm4
         tQx8Z3M2sxQ0b1FQ1db8uq46cnFQ2+0yJ6xGOVJhbuzl3ri82cUnN1uRk34LXFFu+7nG
         1b24q2ttnP98afaoAjgCHV00VirApngsNaiOOcc/Hjq4gRW1yQVwfY/s2E2Etd0emMP7
         8ISH/CqUlVz13uIik93ZEFXnt0ccckcD86Dqfi6yQvE0K/V97EtFF9exGqztaXv8b9Xf
         6j2NkQmAeMQeYvawx9Rnk7nHq1EkyooeRbR/J8sdgvyFpcW/t9QHxWAUQj+1PBVFI0jv
         K5Ww==
X-Gm-Message-State: APjAAAVAtgAGRo5hx099yA8q7jJzzcCB6LJXKfBZpXeDZv86wpseUDng
        pj8oE3rExwfsxgwPArAxKsx5EQ==
X-Google-Smtp-Source: APXvYqytmDy+fI4ccRUZN3I0CSVt2Yceg8mU8BK5uYuRxzR+/tZk5vu2yE7FDfETQigSxaT7JnxFMg==
X-Received: by 2002:a7b:c0c6:: with SMTP id s6mr5402668wmh.115.1562613990453;
        Mon, 08 Jul 2019 12:26:30 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id d7sm15374183wrw.0.2019.07.08.12.26.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 12:26:29 -0700 (PDT)
Date:   Mon, 8 Jul 2019 21:26:29 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 04/15] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190708192629.GD2282@nanopsycho.orion>
References: <cover.1562067622.git.mkubecek@suse.cz>
 <e7fa3ad7e9cf4d7a8f9a2085e3166f7260845b0a.1562067622.git.mkubecek@suse.cz>
 <20190702122521.GN2250@nanopsycho>
 <20190702145241.GD20101@unicorn.suse.cz>
 <20190703084151.GR2250@nanopsycho>
 <20190708172729.GC24474@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708172729.GC24474@unicorn.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 08, 2019 at 07:27:29PM CEST, mkubecek@suse.cz wrote:
>On Wed, Jul 03, 2019 at 10:41:51AM +0200, Jiri Pirko wrote:
>> Tue, Jul 02, 2019 at 04:52:41PM CEST, mkubecek@suse.cz wrote:
>> >On Tue, Jul 02, 2019 at 02:25:21PM +0200, Jiri Pirko wrote:
>> >> Tue, Jul 02, 2019 at 01:49:59PM CEST, mkubecek@suse.cz wrote:
>> >> >+
>> >> >+    ETHTOOL_A_HEADER_DEV_INDEX	(u32)		device ifindex
>> >> >+    ETHTOOL_A_HEADER_DEV_NAME	(string)	device name
>> >> >+    ETHTOOL_A_HEADER_INFOMASK	(u32)		info mask
>> >> >+    ETHTOOL_A_HEADER_GFLAGS	(u32)		flags common for all requests
>> >> >+    ETHTOOL_A_HEADER_RFLAGS	(u32)		request specific flags
>> >> >+
>> >> >+ETHTOOL_A_HEADER_DEV_INDEX and ETHTOOL_A_HEADER_DEV_NAME identify the device
>> >> >+message relates to. One of them is sufficient in requests, if both are used,
>> >> >+they must identify the same device. Some requests, e.g. global string sets, do
>> >> >+not require device identification. Most GET requests also allow dump requests
>> >> >+without device identification to query the same information for all devices
>> >> >+providing it (each device in a separate message).
>> >> >+
>> >> >+Optional info mask allows to ask only for a part of data provided by GET
>> >> 
>> >> How this "infomask" works? What are the bits related to? Is that request
>> >> specific?
>> >
>> >The interpretation is request specific, the information returned for
>> >a GET request is divided into multiple parts and client can choose to
>> >request one of them (usually one). In the code so far, infomask bits
>> >correspond to top level (nest) attributes but I would rather not make it
>> >a strict rule.
>> 
>> Wait, so it is a matter of verbosity? If you have multiple parts and the
>> user is able to chose one of them, why don't you rather have multiple
>> get commands, one per bit. This infomask construct seems redundant to me.
>
>I thought it was a matter of verbosity because it is a very basic
>element of the design, it was even advertised in the cover letter among
>the basic ideas, it has been there since the very beginning and in five
>previous versions through year and a half, noone did question it. That's
>why I thought you objected against unclear description, not against the
>concept as such.
>
>There are two reasons for this design. First is to reduce the number of
>requests needed to get the information. This is not so much a problem of
>ethtool itself; the only existing commands that would result in multiple
>request messages would be "ethtool <dev>" and "ethtool -s <dev>". Maybe
>also "ethtool -x/-X <dev>" but even if the indirection table and hash
>key have different bits assigned now, they don't have to be split even
>if we split other commands. It may be bigger problem for daemons wanting
>to keep track of system configuration which would have to issue many
>requests whenever a new device appears.
>
>Second reason is that with 8-bit genetlink command/message id, the space
>is not as infinite as it might seem. I counted quickly, right now the
>full series uses 14 ids for kernel messages, with split you propose it
>would most likely grow to 44. For full implementation of all ethtool
>functionality, we could get to ~60 ids. It's still only 1/4 of the
>available space but it's not clear what the future development will look
>like. We would certainly need to be careful not to start allocating new
>commands for single parameters and try to be foreseeing about what can
>be grouped together. But we will need to do that in any case.
>
>On kernel side, splitting existing messages would make some things a bit
>easier. It would also reduce the number of scenarios where only part of
>requested information is available or only part of a SET request fails.

Okay, I got your point. So why don't we look at if from the other angle.
Why don't we have only single get/set command that would be in general
used to get/set ALL info from/to the kernel. Where we can have these
bits (perhaps rather varlen bitfield) to for user to indicate which data
is he interested in? This scales. The other commands would be
just for action.

Something like RTM_GETLINK/RTM_SETLINK. Makes sense?


>
>Michal
