Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193582082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="kS8V7sZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfC2GwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:52:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33603 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbfC2GwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:52:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so1208341wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ruXtmWQLgkc46B3JMJbHXo3aXemVQmrTySKmr9DUGjU=;
        b=kS8V7sZOnaaY7B4NLyVTXAeNN64EIl/jjmVg2JDKKfWIOXiQhmePO8yZX+Kh6tRgdg
         xIzjC14ms2PLJ4Ttrgo0ueNPeBQFMo7KIuDq/MfgJsP2vrHEBQC2kBXkfaZEsaw1gYLR
         Ebolr/At4JzNYsLFO55VvSBGoptXRof90TWAJ6rNbXKYglpbhU9w4RSi/L8apBnt09Vh
         r2iT80kGhoGiuaevGX3Gb4TF7U1vxP7gFvhbAr1/9NIRz11u4fXCqiSw9uieAtsxX0+W
         Rp1hqMk7Pk/WHPMxciOOqa355NTufVeq1X+BZGoAVXC/AM2eestqFg03aqfym0Ub1ksh
         U8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ruXtmWQLgkc46B3JMJbHXo3aXemVQmrTySKmr9DUGjU=;
        b=ZfGje5HiET/ucXgHNGGAWbXujWHf3vPOXiRV0Af/xbayoP16nzzFYARCI70IlMs72Q
         oztOP2hfIsD9K+MTZXpwc0v+I35NgehGPcePHZxr4JSzsnCD8ZnRKqRxwp82a/voCu7L
         WzwiKbAwzJv7tEaa30Oy9GPng7OmU3XpQEVktTIr/WmKxut2FuagbxvNofW7Wy6wgBZA
         LCVHk3coW4uVLBDjoFJ+32Vd/yjHk0E/zsCH0EfwHxGW0Mjr/l4HT+9pi9e61WUokR0E
         v2YTImiZZJfvTN8hCIYN5BNfJqPhFBPCc2+3qMEN2F0tALn7wCohALe7vI77HA/jCQC/
         8BiA==
X-Gm-Message-State: APjAAAUhCzsjBz51Me+RyUWrmxsyn4YKvdES3qDbDOwidD/rWLg3tGXP
        pam5jXANFFYxtJoXrS2Rfp/BKw==
X-Google-Smtp-Source: APXvYqyMlq6iM+s6pQdEcPmQPjjb3+3WHfPE3qjTPT6KBXCrcZBK+hMSAOcAdYaAc1BUTbqDtaLQAQ==
X-Received: by 2002:adf:f088:: with SMTP id n8mr32166297wro.112.1553842337716;
        Thu, 28 Mar 2019 23:52:17 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id a82sm1234944wmf.11.2019.03.28.23.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 23:52:16 -0700 (PDT)
Date:   Fri, 29 Mar 2019 07:52:16 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/22] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190329065216.GT14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
 <2c29310b-a2a0-3867-a09f-51f2dc47ecd3@gmail.com>
 <20190328071853.GY26076@unicorn.suse.cz>
 <20190328134313.GO14297@nanopsycho>
 <20190328140428.GG26076@unicorn.suse.cz>
 <20190328173524.GR14297@nanopsycho>
 <20190328115256.2a7cb952@cakuba.netronome.com>
 <20190328204329.GH26076@unicorn.suse.cz>
 <20190328140607.285dbfc6@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328140607.285dbfc6@cakuba.netronome.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Mar 28, 2019 at 10:06:07PM CET, jakub.kicinski@netronome.com wrote:
>On Thu, 28 Mar 2019 21:43:29 +0100, Michal Kubecek wrote:
>> On Thu, Mar 28, 2019 at 11:52:56AM -0700, Jakub Kicinski wrote:
>> > On Thu, 28 Mar 2019 18:35:24 +0100, Jiri Pirko wrote:  
>> > > Thu, Mar 28, 2019 at 03:04:28PM CET, mkubecek@suse.cz wrote:  
>> > > >On Thu, Mar 28, 2019 at 02:43:13PM +0100, Jiri Pirko wrote:    
>> > > >> 
>> > > >> I don't like this. This should not be bitfield/set. This should be
>> > > >> simply nested array of enum values:
>> > > >> 
>> > > >> enum ethtool_link_mode {
>> > > >> 	ETHTOOL_LINK_MODE_10baseT_Half,
>> > > >> 	ETHTOOL_LINK_MODE_10baseT_Full,
>> > > >> 	ETHTOOL_LINK_MODE_100baseT_Half,
>> > > >> 	ETHTOOL_LINK_MODE_100baseT_Full,
>> > > >> 	ETHTOOL_LINK_MODE_1000baseT_Full,
>> > > >> };    
>> > > >
>> > > >We already have such enum. The problem with your "no string" approach is
>> > > >that it requires all userspace applications to (1) keep this enum in    
>> > > 
>> > > That is how it is usually done. UAPI defines ATTRS and values, userspace
>> > > assigns appropriate strings.  
>> > 
>> > +1 FWIW, I'm with Jiri on the string situation.  
>> 
>> And I'm still waiting for any of you to tell me how would you handle
>> private flags, stats, tests etc. without the string sets.
>> 
>> Ditching the verbose form of bit sets would be a nuisance for userspace
>> using the interface but compared to e.g. having to mix three different
>> kernel interfaces, it's just a minor problem. Ditching the static string
>> sets would mean giving up the opportunity to get rid of having to sync
>> all kinds of tables with every userspace consumer whenever a new flag is
>> introduced. Pity... but still doable. But how do you want to do without
>> the string sets which are provided by drivers?
>
>I don't think there is a disagreement about stuff which is private to
>the driver.  The strings have to be exposed there.

Yeah, there is no other way of doing that. However, please check if some
driver-specific setting cannot be moved to devlink with use of devlink
params (we have both devlink driver specific params and per-port
devlink driver specific params).
