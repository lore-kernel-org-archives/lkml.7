Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADE8C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F91C218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="07A6jNkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfGCOha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:37:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40986 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:37:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so3093283wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+w5Ekzo0SUahclNPS3vsY3fS0WmvuqOMIX4TEp2/zXU=;
        b=07A6jNkE1oZ17E6pSSQcXrtw++E4AfOcl4aVpafT+DrXKVAMRhAsyZP5pr7j5EJK/P
         Qdbx+5zRTouOI/jAymN9T607NfuaU5yV24hb29bPSAUb16qiyuY07oK+fKNMiP8rlf/Z
         IMUAESTHosw5O6M8IHc36GM22RGTj401EyYn26G04VX3sr/bIt952ZCW0LTStV5DYj/2
         WxE/NqDgYe17v6AdSmEl2ZSMgBsmYNOYoCRcQhNNSz/uH6ySyE+vXiLtYQA/H3HlKLlM
         ZGmaPXnp0hd7gXHXldUm+kTQxbJ97UQbdGd25jbTH+iqkG+sK3iYodSer/U6+7q6q2Ol
         2fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+w5Ekzo0SUahclNPS3vsY3fS0WmvuqOMIX4TEp2/zXU=;
        b=em2cIcE5VrnsY51EU633pMEXsQg+J0bdAPX76wCvsvVzFMV8/g3VoLVB1Ydqd4sokC
         YQULaRUIH1NC3PEd0cXdgbffNUQQKgTt0XpTrA5UcuNLjzguZaReYM8KXJ9RquEzEr7k
         TnI/OWPnkZLLMhQsRt+CqPXfhq3Tf/nhbloNJ4XEzwklj2mRIv6sAdTQyJ93Q0aTgZL8
         3Ap+rVHfqvuvbRErRU8k5k+y5cOOoGsQqhXiveDlvyFoAOZajAErv30uOeRoA5EQZNFn
         wUi0TIeyutjlH9g5TBuxZgKmcdgUS8FaY8YpcT05V1cT6KPrhTvtuLownAVE4CwB51CJ
         Wk2A==
X-Gm-Message-State: APjAAAXyF2bXGGG8g3Dji75tuYYmeb/31poiV350bQHzaU9Q8u1265Gu
        MxEXWe+aElJ4nGp0eH5EJ7G9FQ==
X-Google-Smtp-Source: APXvYqy5XFF9pJ0FRYUwSNusa6CVo7/tVR45PaASQaVwJKYJNKmjqG7ZZ6lGYGu9KpEKxcPBDkWaow==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr16038910wrt.253.1562164646037;
        Wed, 03 Jul 2019 07:37:26 -0700 (PDT)
Received: from localhost (ip-213-220-235-213.net.upcbroadband.cz. [213.220.235.213])
        by smtp.gmail.com with ESMTPSA id c15sm1256625wrx.65.2019.07.03.07.37.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 07:37:25 -0700 (PDT)
Date:   Wed, 3 Jul 2019 16:37:24 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 06/15] ethtool: netlink bitset handling
Message-ID: <20190703143724.GD2250@nanopsycho>
References: <cover.1562067622.git.mkubecek@suse.cz>
 <cb614bebee1686293127194e8f7ced72955c7c7f.1562067622.git.mkubecek@suse.cz>
 <20190703114933.GW2250@nanopsycho>
 <b3cd61506080143f571d6286223ae33c8bd02c3a.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3cd61506080143f571d6286223ae33c8bd02c3a.camel@sipsolutions.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jul 03, 2019 at 03:44:57PM CEST, johannes@sipsolutions.net wrote:
>On Wed, 2019-07-03 at 13:49 +0200, Jiri Pirko wrote:
>> 
>> > +Value and mask must have length at least ETHTOOL_A_BITSET_SIZE bits rounded up
>> > +to a multiple of 32 bits. They consist of 32-bit words in host byte order,
>> 
>> Looks like the blocks are similar to NLA_BITFIELD32. Why don't you user
>> nested array of NLA_BITFIELD32 instead?
>
>That would seem kind of awkward to use, IMHO.
>
>Perhaps better to make some kind of generic "arbitrary size bitfield"
>attribute type?

Yep, I believe I was trying to make this point during bitfield32
discussion, failed apparently. So if we have "NLA_BITFIELD" with
arbitrary size, that sounds good to me.


>
>Not really sure we want the complexity with _LIST and _SIZE, since you
>should always be able to express it as _VALUE and _MASK, right?
>
>Trying to think how we should express this best - bitfield32 is just a
>mask/value struct, for arbitrary size I guess we *could* just make it
>kind of a binary with arbitrary length that must be a multiple of 2
>bytes (or 2 u32-bit-words?) and then the first half is the value and the
>second half is the mask? Some more validation would be nicer, but having
>a generic attribute that actually is nested is awkward too.
>
>johannes
>
>
