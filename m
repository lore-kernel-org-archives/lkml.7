Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D46DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F9321773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="z8Anbw9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfC1IKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:10:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39858 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfC1IKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:10:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so21619114wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vihdnHLOI0zKt0tbN4BcO/WirxMvxXyBvEp2oO+WLAU=;
        b=z8Anbw9NIMm74zK0b6SdvrHMuapVRpAMKaFj9UsEoRu+HHPckgNN62QGJ9w+il1nK9
         xf6FLSUjwcaIN7qFby6F3fSUH09OTJclk6A33wRNWcdrXfVKTpHSjSkbZHa17odjO+PR
         s5eH09b6ROpy4ms/kQRbtRIpB1GGbIch3yBGbJIMjxrG+bslMH+2N7cPf06UaO6nt0Uh
         TY+4w1AvCJtBWpJ4iO2Io5LnXMqvK7fPOn1FIoCuJ8I5dJT3jm/MfAeizLH+rg0/72YK
         7VkFvC8LPsvZkBQZzSuyuIPJIMIM1bRlr8ZpoN1CHWQSiSsfL/8vbZg0/OXXEOwAsRSI
         YyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vihdnHLOI0zKt0tbN4BcO/WirxMvxXyBvEp2oO+WLAU=;
        b=iLvJEj6dSRscNgENct/8ylX0CZkmOKXHJi6XxJl81LNhYUf2D1Yypmcbdzxsa8wGj4
         k0m1/1rd5Xap/TqOhKEVGGSzTdXRBg4XSH4fZ7xKpJtTIQEbphjeXVCW98r/B6bGl61x
         wtIwIlKKIoxqbR6Ti9YtTbpgLyVJ4oVjCqcO8t7fCJwwqHzl89AKLgCsrUSMCIQNhmV6
         AW2sDqyAS2OLnDOJetLz8xFH0f/ElDdwl7tyFF2J5Uu9sk7Ab2fnleXbYy/nWOC5ZS/4
         oy+61oHL0NEBKWM6OXAMPv/d7UJOmlGnCuRhNocuerw/AG/5au7ZPg0zh4TP5UkjaijN
         +iYg==
X-Gm-Message-State: APjAAAW1S+YMzmICKd22GOM4KbNUjFWZcf9WGPGWlCkENoWQKbdc20hV
        9WJRTfkyT0zjMyjVdIe4eoc4/w==
X-Google-Smtp-Source: APXvYqyNayXfny+tuVu+10xqfPtahs/uhqNvJwxdlSUpazSNE+mtjk3N1JPPFd8W1I+il74d7SZcIw==
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr9407323wro.40.1553760611741;
        Thu, 28 Mar 2019 01:10:11 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id 13sm2429226wmf.23.2019.03.28.01.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 01:10:11 -0700 (PDT)
Date:   Thu, 28 Mar 2019 09:10:10 +0100
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
Message-ID: <20190328081010.GJ14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
 <20190326120909.GF2230@nanopsycho>
 <20190326132427.GK26076@unicorn.suse.cz>
 <20190326134251.GA5181@nanopsycho.orion>
 <20190327092604.GP26076@unicorn.suse.cz>
 <20190327095023.GC6979@nanopsycho>
 <7e883a7c-7f1a-b1a0-4735-0ad368998c65@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e883a7c-7f1a-b1a0-4735-0ad368998c65@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Mar 28, 2019 at 03:05:14AM CET, f.fainelli@gmail.com wrote:
>
>
>On 3/27/2019 2:50 AM, Jiri Pirko wrote:
>> 
>> Why don't you have ETHTOOL_MSG_SET_FOO for set? I think that for
>> kerne->userspace the ETHTOOL_MSG_FOO if fine. I would change the
>> ordering of words thought, but it is cosmetics:
>> ETHTOOL_MSG_FOO /* kernel->userspace messages - replies, notifications */
>> ETHTOOL_MSG_FOO_GET
>> ETHTOOL_MSG_FOO_SET
>> ETHTOOL_MSG_FOO_ACT
>> 
>> What do you think?
>
>We could even name the notification explicitly with: ETHTOOL_MSG_NOTIF
>or ETHTOOL_MSG_NTF just so we spell out exactly what those messages are.

Sound good. Something like:

ETHTOOL_MSG_FOO_GET
ETHTOOL_MSG_FOO_GET_RPLY /* kernel->userspace replies to get */
ETHTOOL_MSG_FOO_SET
ETHTOOL_MSG_FOO_ACT
ETHTOOL_MSG_FOO_NTF /* kernel->userspace async messages - notifications */
