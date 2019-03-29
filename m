Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCCFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3356F2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="vSbvr/z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfC2Inq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:43:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35254 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfC2Inq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:43:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so1801077wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 01:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EP1zrm670XkMo8KCPbZsfPrz4SZTLQl6uR5GdiRGDVw=;
        b=vSbvr/z4Ea6ahtF4IXK8dlUzhQVKtb5yVtl22uqikWMSoi2Xq6LEijIMvvPPhflQNk
         PwLzZUNC+uISPlESPgiQTQ4TWuJgYupAqlvU/EUZKcciHM4+YEkG9+5No6fHSto/Tat3
         vwnnRSVe2ls80/Xv8M6dO1sEP24NMdFtPcW1AhGERF3q7KVsHfnY7xZuTN0i2g5qA0Bn
         dKuuX8GIB+rzudDBTZDi0HpEJ1eN3CRX//LNQnJNv3/oQB7mG0qdS4F329JBQyRlDmKG
         8AKlvXKtOjvrgTi/hn2YFt3idxhwifKiMKRFbNae3RDpWAgF4oTSyaIe+zx1rV8GeE6i
         j7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EP1zrm670XkMo8KCPbZsfPrz4SZTLQl6uR5GdiRGDVw=;
        b=N9uPxuFgyJIAuuca+Jx0MPXFHQsf/gI2pPUe7j8e7rWbPqKQkXlvb3pmXWbee4b9Q6
         4zd3B4or2IjCceYwy0r+AOWd3/N67YZwoiSgv67ozOeMb0m2tFUgk4bgcTeiE3/p0PpF
         wBsHANsIDCaaxGiQSCl4A3tV1ExWzGSJVumkUU3yBk4ap+3RMxs0Obe6yS6mJSny/Irc
         11ithoz0pfN+0J4Vp6ysJRCBEQQ+8ra7PX5AtOvswfhM/ufIalpn6VR2oHFuyBkEdUkW
         dG/36Cr7JqrkwTkyStf+V36iG3B9Ujua/5Iz04HVstNu6Yex13iKua099QglMwd5s6nO
         c1Pg==
X-Gm-Message-State: APjAAAW+63f2AcUhLbSYwOjSEv9TkSmb1pbKBkJpSBdG7QwxI7GAquTp
        RpxBGObe3Luf3+90dc+nn1nwHA==
X-Google-Smtp-Source: APXvYqyQamRoadehH0UFwBCADQSMj1NNBWPIl+z4fxMdyQ9YkH7DFPwgun7umVsfER9nEK/8UaPDSA==
X-Received: by 2002:a05:600c:24f:: with SMTP id 15mr2629966wmj.48.1553849024707;
        Fri, 29 Mar 2019 01:43:44 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id a10sm1418923wrs.19.2019.03.29.01.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 01:43:44 -0700 (PDT)
Date:   Fri, 29 Mar 2019 09:43:43 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/22] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190329084343.GU14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
 <20190327201237.GG14297@nanopsycho>
 <20190327225607.GW26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327225607.GW26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 27, 2019 at 11:56:08PM CET, mkubecek@suse.cz wrote:
>On Wed, Mar 27, 2019 at 09:12:37PM +0100, Jiri Pirko wrote:
>> Mon, Mar 25, 2019 at 06:08:30PM CET, mkubecek@suse.cz wrote:
>> >Requests a contents of one or more string sets, i.e. indexed arrays of
>> >strings; this information is provided by ETHTOOL_GSSET_INFO and
>> >ETHTOOL_GSTRINGS commands of ioctl interface. There are three types of
>> >requests:
>> >
>> >  - no NLM_F_DUMP, no device: get "global" stringsets
>> >  - no NLM_F_DUMP, with device: get string sets related to the device
>> >  - NLM_F_DUMP, no device: get device related string sets for all devices
>> >
>> >It's possible to request all string sets of given type or only specific
>> >sets. With ETHA_STRSET_COUNTS flag, only set sizes (number of strings) are
>> >returned.
>> >
>> >Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>> >---
>> > Documentation/networking/ethtool-netlink.txt |  46 +-
>> > include/uapi/linux/ethtool.h                 |   2 +
>> > include/uapi/linux/ethtool_netlink.h         |  43 ++
>> > net/ethtool/Makefile                         |   2 +-
>> > net/ethtool/netlink.c                        |   8 +
>> > net/ethtool/netlink.h                        |   4 +
>> > net/ethtool/strset.c                         | 447 +++++++++++++++++++
>> > 7 files changed, 549 insertions(+), 3 deletions(-)
>> > create mode 100644 net/ethtool/strset.c
>> 
>> First of all, the code is hard to follow. For reasons I mentioned in
>> other replies (lack of prefixes, wrappers, etc).
>> 
>> More importantly, why do we need this? This concept of having strings in
>> kernel for various things and features and sending them to userspace is
>> weird. Certainly not common for Netlink interface. I believe these
>> strings should be avoided and all should be communicated to userspace
>> and back in form of well-defined Netlink attributes. We are introducing
>> new Netlink API, lets do it properly and don't bring baggage from past.
>
>For some of the global string sets where the values have fixed meaning
>and new values are only appended to, it would be possible. But even for
>those, keeping the list in sync between kernel and ethtool is often less
>than perfect. And ethtool is only one of the tools using the interface.
>So even in this case, I don't see string identifiers (or tags or names
>or whatever we call them) as a baggage from past, rather as a solution
>to a problem some of the existing interfaces have.
>
>Then e.g. netdev features are not fixed in this sense: the same bit
>index represents different feature in different kernels. I guess we

Should not be exposed in bits in first place. See devlink params for
example.


>could introduce some fixed numeric identifiers for them and map between
>those and actual indices but I don't see an advantage of such approach.
>
>But the really important question is how would you handle what is
>currently described by "per device" string sets, i.e. private flags,
>(ethtool) statistics, tests, ...? For these, the list depends on the
>driver or even device.

Yes, those per-driver things have to be strings. That's what we did for
devlink params.

Tests also could be handled in similar way as devlink params.

For stats, I believe that uint->string per-driver mapping
needs to be exposed.

