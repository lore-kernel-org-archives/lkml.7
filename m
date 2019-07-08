Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FC9C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3DE20644
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="eByNjAHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404511AbfGHT2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:28:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38345 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404490AbfGHT2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:28:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so8247253wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XFGp201YgwfhCgMQ2+xi2UZ04gFlh9fjk8QaqKcWWM8=;
        b=eByNjAHQ9o/gf1C8Xi99pAkcPDF/QW95DHO86xCnnci/4ebU20m0iQNYoDPScgteIW
         QTIWidwi5lZCdk/qtAEX7UwylqH8Ef3jlJM6uLwIf7rgpeA+Uui1beBu2gfEAQ+9bRxy
         96oWoHTPEkWCFw7APu4khyboSygoDGcp03PnQrMQspnzx4EjSGjT1wXSO0HAEnLxMMdZ
         c0eKewVfWXHQxSCMa0x96Y2I5rvX9/ZY8aktg12CMAYxyz+WLm1tzpRdXkGC4xwbwk/4
         33Celnr4Q10QzxJHigzIuf+cTOG+d2YtUEsVJh4AoZ4dr9+IRJyr5zNvnFcIgVOIREAD
         My2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XFGp201YgwfhCgMQ2+xi2UZ04gFlh9fjk8QaqKcWWM8=;
        b=Uwm/SeZqTnth6zt2ocexBqIUvc4qSoq7zEqVkODvt3YQHrpXT4m1ig8p5DHbNmd9EP
         tqsgUmaIOC6AVa82ghq31eA3VFhYdtGqVfKVBQ+LwM1wB0p6kVJ+gzAiCzZ0cTaW0w/p
         IlmdfZMIBVhGf+JAb6TKD/A5sjlSVr+DqD3C6o3KBp52UfOAXzLFRcdMLBwLAeH99VTu
         g8J42poqYX7aOIeZ00+yEieK/hjgshRNfGLxer5Mp/6fCU3SxgzxbWnluphGUppVLds0
         2yJFoc1U0SalWk/GovaQwDTd+gFCWPAqe0nb0qZGZQZbScKgXPbLefkOYz4jt3PXk4Kh
         XASA==
X-Gm-Message-State: APjAAAWI/bIzpV0mOvkVAV2/DNNAfBbb3hzh/TBfR8ZXJah6/Hej9o89
        zdTFNbpHcbI0HonK5EkG8KRiHw==
X-Google-Smtp-Source: APXvYqxBMO+UXgaDORhIMlIs6Cw1cGDEbiueatVNMvNVLb6yQS8osjnRVxBBNdP2hGxx6+flzSYSiw==
X-Received: by 2002:a5d:5448:: with SMTP id w8mr20124921wrv.180.1562614117841;
        Mon, 08 Jul 2019 12:28:37 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id g12sm1058320wrv.9.2019.07.08.12.28.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 12:28:37 -0700 (PDT)
Date:   Mon, 8 Jul 2019 21:28:37 +0200
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
Message-ID: <20190708192837.GE2282@nanopsycho.orion>
References: <cover.1562067622.git.mkubecek@suse.cz>
 <e7fa3ad7e9cf4d7a8f9a2085e3166f7260845b0a.1562067622.git.mkubecek@suse.cz>
 <20190702122521.GN2250@nanopsycho>
 <20190702145241.GD20101@unicorn.suse.cz>
 <20190703084151.GR2250@nanopsycho>
 <20190708172729.GC24474@unicorn.suse.cz>
 <20190708192629.GD2282@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708192629.GD2282@nanopsycho.orion>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 08, 2019 at 09:26:29PM CEST, jiri@resnulli.us wrote:
>Mon, Jul 08, 2019 at 07:27:29PM CEST, mkubecek@suse.cz wrote:
>>On Wed, Jul 03, 2019 at 10:41:51AM +0200, Jiri Pirko wrote:
>>> Tue, Jul 02, 2019 at 04:52:41PM CEST, mkubecek@suse.cz wrote:
>>> >On Tue, Jul 02, 2019 at 02:25:21PM +0200, Jiri Pirko wrote:
>>> >> Tue, Jul 02, 2019 at 01:49:59PM CEST, mkubecek@suse.cz wrote:
>>> >> >+
>>> >> >+    ETHTOOL_A_HEADER_DEV_INDEX	(u32)		device ifindex
>>> >> >+    ETHTOOL_A_HEADER_DEV_NAME	(string)	device name
>>> >> >+    ETHTOOL_A_HEADER_INFOMASK	(u32)		info mask
>>> >> >+    ETHTOOL_A_HEADER_GFLAGS	(u32)		flags common for all requests
>>> >> >+    ETHTOOL_A_HEADER_RFLAGS	(u32)		request specific flags
>>> >> >+
>>> >> >+ETHTOOL_A_HEADER_DEV_INDEX and ETHTOOL_A_HEADER_DEV_NAME identify the device
>>> >> >+message relates to. One of them is sufficient in requests, if both are used,
>>> >> >+they must identify the same device. Some requests, e.g. global string sets, do
>>> >> >+not require device identification. Most GET requests also allow dump requests
>>> >> >+without device identification to query the same information for all devices
>>> >> >+providing it (each device in a separate message).
>>> >> >+
>>> >> >+Optional info mask allows to ask only for a part of data provided by GET
>>> >> 
>>> >> How this "infomask" works? What are the bits related to? Is that request
>>> >> specific?
>>> >
>>> >The interpretation is request specific, the information returned for
>>> >a GET request is divided into multiple parts and client can choose to
>>> >request one of them (usually one). In the code so far, infomask bits
>>> >correspond to top level (nest) attributes but I would rather not make it
>>> >a strict rule.
>>> 
>>> Wait, so it is a matter of verbosity? If you have multiple parts and the
>>> user is able to chose one of them, why don't you rather have multiple
>>> get commands, one per bit. This infomask construct seems redundant to me.
>>
>>I thought it was a matter of verbosity because it is a very basic
>>element of the design, it was even advertised in the cover letter among
>>the basic ideas, it has been there since the very beginning and in five
>>previous versions through year and a half, noone did question it. That's
>>why I thought you objected against unclear description, not against the
>>concept as such.
>>
>>There are two reasons for this design. First is to reduce the number of
>>requests needed to get the information. This is not so much a problem of
>>ethtool itself; the only existing commands that would result in multiple
>>request messages would be "ethtool <dev>" and "ethtool -s <dev>". Maybe
>>also "ethtool -x/-X <dev>" but even if the indirection table and hash
>>key have different bits assigned now, they don't have to be split even
>>if we split other commands. It may be bigger problem for daemons wanting
>>to keep track of system configuration which would have to issue many
>>requests whenever a new device appears.
>>
>>Second reason is that with 8-bit genetlink command/message id, the space
>>is not as infinite as it might seem. I counted quickly, right now the
>>full series uses 14 ids for kernel messages, with split you propose it
>>would most likely grow to 44. For full implementation of all ethtool
>>functionality, we could get to ~60 ids. It's still only 1/4 of the
>>available space but it's not clear what the future development will look
>>like. We would certainly need to be careful not to start allocating new
>>commands for single parameters and try to be foreseeing about what can
>>be grouped together. But we will need to do that in any case.
>>
>>On kernel side, splitting existing messages would make some things a bit
>>easier. It would also reduce the number of scenarios where only part of
>>requested information is available or only part of a SET request fails.
>
>Okay, I got your point. So why don't we look at if from the other angle.
>Why don't we have only single get/set command that would be in general
>used to get/set ALL info from/to the kernel. Where we can have these
>bits (perhaps rather varlen bitfield) to for user to indicate which data
>is he interested in? This scales. The other commands would be
>just for action.
>
>Something like RTM_GETLINK/RTM_SETLINK. Makes sense?

+ I think this might safe a lot of complexicity aroung your proposed
inner ops.

>
>
>>
>>Michal
