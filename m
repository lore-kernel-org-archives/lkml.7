Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C8CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430FE20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="jeaL76ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfCZP7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:59:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52523 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCZP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:59:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so13210834wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KvLvYQ8To9vnE8+/chaGT7oUCER7SYfH+KoD75hlshE=;
        b=jeaL76aojADDCFOSBXXt0XmST0oQR1XTZNIyNuFeG/4lsPEmF20iM2oSC9/C1yYwUQ
         ShJC7lUWkVwfaL6BN+A7Nt8zfM+eybDCCfRFpCC7qHX1pbgLhPpQNHjbNDh35NCkLP3Y
         URnXqNPjPP7pUqE3oh1o1Bpx9wzD5saGdjBvyFp7kxZyFTkiEuEeDCYmWxL/lfsRtwLJ
         whkRIycdMXSprftUznuWfMS19x6dA+JPV+btQAWbz0uvL/F7+QbHpkxM0bRVbHGAUuey
         L9QDdd0BPhzI1tEAtEiIedzAmZYMcYK1uoktiUI+mt+7cnPo+1eshAy/xbi29byM2P5F
         r5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KvLvYQ8To9vnE8+/chaGT7oUCER7SYfH+KoD75hlshE=;
        b=pzRJWpnqr7KrsxjBztBsHmRKrxVUPbC19FI7n/m5MvCEV36OGy5OGSkcW+wlbk0C+B
         uzpoXWa6sG0DgoMwruVEVephCYBMBberx7jEVX+K3VZ8xO+0fVHFoSmC9HQjswA5G056
         +z4CWuIMrssYdLZf8FBzre9R7hAwwm1DE04Hq4uwqjLuSVJSRXpEZpiZnQsqJbbTldmO
         gwGKQDrm3HSLQh4S1uUIsUTiqMrurERTYRIxfqJgiQXvPn6j7a5EH6R7ZdEJWckwT9E1
         OR1g2jU4xIakEPz2DJwEyO1KgeliojMaqIDB6LweeElwDH2J02YFa6wUETfsjDY3Hmrl
         R6eQ==
X-Gm-Message-State: APjAAAUcPlTnME3nLvfb2o5gje1JjqwMKkXRv3JKxEH+HK/UTnSN8K4O
        p4LV8t8V/q/SODkBde6UihdBKg==
X-Google-Smtp-Source: APXvYqx0VLE2SqTpxDnTTedfDiOi3xMbbu8jujt0Nf7moivF12Z7LAL/tS5ByQ7Mn5HVjGWy4cPINA==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr13965175wmg.14.1553615952187;
        Tue, 26 Mar 2019 08:59:12 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id x5sm21572993wrt.72.2019.03.26.08.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 08:59:11 -0700 (PDT)
Date:   Tue, 26 Mar 2019 16:59:11 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 07/22] ethtool: netlink bitset handling
Message-ID: <20190326155911.GA4958@nanopsycho.orion>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <9123f942b484ef4bbb684bb1f4aa2b70d673a259.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9123f942b484ef4bbb684bb1f4aa2b70d673a259.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 25, 2019 at 06:08:15PM CET, mkubecek@suse.cz wrote:
>Declare attribute type constants and add helper functions to generate and
>parse arbitrary length bit sets.

Hmm, this looks like a lot of work. Two things:
1) This is generic. Not really related to ethtool in any way. Could this
   be done in netlink common code?
2) Did you think about leveraging NLA_BITFIELD32? What I mean is this:
NEST_START
   NLA_BITFIELD32 index 0 (bit 0-31)
   NLA_BITFIELD32 index 1 (bit 32-63)
   NLA_BITFIELD32 index 2 (bit 64-95)
   NLA_BITFIELD32 index 3 (bit 96-127)
   ....
NEST_END
It is basically an array of NLA_BITFIELD32.

