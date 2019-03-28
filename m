Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C57C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3C82173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="L7TZMfi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfC1R2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:28:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52662 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfC1R2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:28:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so4443204wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lP46VF+YGJi1QUXrMBZ3MRpL9mA7umkG2KC872VEL6o=;
        b=L7TZMfi96yYcVJWXzXnhR81CyUjQRQGizCMN12qs7994FovE7udjsU6lQmhHs1v5e9
         Z7Xf5FJUTQwxUwReggRYDfAJBmwXFenjJ9/TnwTONl25KucBW6BYmEC/F4hLHIDra7CC
         K00pbKchqwRbyPP3+NwBJfh5AS/hgVgTmnZYiyedl42/4O+fsmwkCGflzfIGHdRAo8Qe
         aBcMw7oUHIRFX3CnVR0JQ7ysVO+s7jqh9dd3bNhxQf2sOJ6p1L3qKw/9wwUP6aOxpAIk
         GOU03luTlyk8muQdw70Xnw0uiigOpW+c2ZYY3k8vNO/IF2tWupG872ScfSUghiH25jtp
         ZoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lP46VF+YGJi1QUXrMBZ3MRpL9mA7umkG2KC872VEL6o=;
        b=IuN1Bz9L3aZhQ7ktOVIyNmXFT1rI5tlcrYkXBM71vWNUH0/lTC+yhGB8iF6/CwWq02
         shLotLWXGatK74BqRD8kPaSP0rDl0vcabIevTGcQq4AtAAC6J9BC6tQ7L8r7pIxclV99
         Wt5dgT+Zzn/qn8DfacZ/eUQ6uODsGAuoRj5XKkrkAuv0r6giIMtpPeHKKnaoFfMJ2FBg
         fH2Lx2tSm2ai3R1AFeaQYfL1bnbpVTBhhPYAbvaal8DdpriULD36uGfAVfo5layBg+Sf
         tJ8pYjMwol8lIjb+TjvjXKtG/mM/xa1iTSBMhLD3MDZy3J5cOapNdHwwaTCXbJdEaK2l
         QCAQ==
X-Gm-Message-State: APjAAAXJdMTwz/IqIB3ICe04MRiaTipyCHGTCyc1370zs0wFK08f4M4S
        Ysh82YG2x0//5BG5W7voXCI/hw==
X-Google-Smtp-Source: APXvYqzq5+LrSciVn8Ia7uAZ6y2+J6qB5Db00CGMAyGLPPXyEYL7eGIUkcvxYmAYaFo80KfQmVfeDw==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr700046wmg.132.1553794112114;
        Thu, 28 Mar 2019 10:28:32 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id h9sm3042298wmb.5.2019.03.28.10.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:28:31 -0700 (PDT)
Date:   Thu, 28 Mar 2019 18:28:30 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/22] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190328172830.GQ14297@nanopsycho>
References: <20190326120909.GF2230@nanopsycho>
 <20190326132427.GK26076@unicorn.suse.cz>
 <20190326134251.GA5181@nanopsycho.orion>
 <20190327092604.GP26076@unicorn.suse.cz>
 <20190327095023.GC6979@nanopsycho>
 <7e883a7c-7f1a-b1a0-4735-0ad368998c65@gmail.com>
 <20190328081010.GJ14297@nanopsycho>
 <20190328093746.GA26076@unicorn.suse.cz>
 <20190328132316.GM14297@nanopsycho>
 <5edb07f0-427f-8a06-97f5-d904b4a50cc1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5edb07f0-427f-8a06-97f5-d904b4a50cc1@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Mar 28, 2019 at 06:00:20PM CET, f.fainelli@gmail.com wrote:
>On 3/28/19 6:23 AM, Jiri Pirko wrote:
>> Thu, Mar 28, 2019 at 10:37:46AM CET, mkubecek@suse.cz wrote:
>>> On Thu, Mar 28, 2019 at 09:10:10AM +0100, Jiri Pirko wrote:
>>>> Thu, Mar 28, 2019 at 03:05:14AM CET, f.fainelli@gmail.com wrote:
>>>>>
>>>>>
>>>>> On 3/27/2019 2:50 AM, Jiri Pirko wrote:
>>>>>>
>>>>>> Why don't you have ETHTOOL_MSG_SET_FOO for set? I think that for
>>>>>> kerne->userspace the ETHTOOL_MSG_FOO if fine. I would change the
>>>>>> ordering of words thought, but it is cosmetics:
>>>>>> ETHTOOL_MSG_FOO /* kernel->userspace messages - replies, notifications */
>>>>>> ETHTOOL_MSG_FOO_GET
>>>>>> ETHTOOL_MSG_FOO_SET
>>>>>> ETHTOOL_MSG_FOO_ACT
>>>>>>
>>>>>> What do you think?
>>>>>
>>>>> We could even name the notification explicitly with: ETHTOOL_MSG_NOTIF
>>>>> or ETHTOOL_MSG_NTF just so we spell out exactly what those messages are.
>>>>
>>>> Sound good. Something like:
>>>>
>>>> ETHTOOL_MSG_FOO_GET
>>>> ETHTOOL_MSG_FOO_GET_RPLY /* kernel->userspace replies to get */
>>>> ETHTOOL_MSG_FOO_SET
>>>> ETHTOOL_MSG_FOO_ACT
>>>> ETHTOOL_MSG_FOO_NTF /* kernel->userspace async messages - notifications */
>>>
>>> The names sound fine to me and having different message ids would still
>>> allow processing messages by the same handler easily.
>>>
>>> But there is one potential issue I would like to point out: this way we
>>> spend 4 message ids for a get/set pair rather than 2. These message ids
>>> (genlmsghdr::cmd) are u8, i.e. the resource is not as infinite as one
>>> would wish. There are 80 ioctl commands (43 "get" and 29 "set") at the
>>> moment.
>>>
>>> Netlink API should be less greedy in general. I already combined some
>>> ioctl commands into one netlink request type and with an easy way to add
>>> new attributes to existing commands, we won't need to add new commands
>>> as often (certainly not in a way which left us with 9 "get" and 9 "set"
>>> ioctl commands for netdev features). So even with 4 ids per get/set
>>> pair, we might be safe for reasonably long time. But it's still
>>> something to keep in mind.
>> 
>> There are still 16 bits reserve in genl msg header:
>> struct genlmsghdr {
>>         __u8    cmd;
>>         __u8    version;
>>         __u16   reserved;
>> };
>> 
>
>And you know not all message IDs will be making sense depending on the
>direction, so aliasing specific message IDs to an existing value should
>be fine?

You are right, good idea. There can be 2 enums one for in, one for out.
