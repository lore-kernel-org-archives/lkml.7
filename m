Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0CAC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C515520823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="ydaAh0bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbfCZNxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:53:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43195 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZNxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:53:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so6506661wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=627/vXGVzva/dFo0wJ6O2man7knSdJogONfiETosPOw=;
        b=ydaAh0bXXTPENny3GS/MBouCfTedFQemaRhhb7NBLGwAQUbdmlyYgWYbCU7/gpaBjk
         bZsLkXbLEtZKo4F7Imjee2VfQiB5rH1bfdXMG/tp7m81AFp7FxUXLk1OcQWEds+4qXdD
         9Wcf5KM3x1ZX01hEk+xmmVkUjZMbUKfuxCy38jm8miVb3k9bLeRZHnrnWxb74u1MT2B1
         KVX1YUsHEvojraLKQrw0f7tY/mF69gPtlQf55DCYIZLcH1cBkwlkv+adBEkUUo76yDsl
         M9ZoMuNfSQIEzKq2F6U1/9vkHmh89ro+RfhvDIfc4sVg9diLI04UtSReweco6XVwjEWh
         0Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=627/vXGVzva/dFo0wJ6O2man7knSdJogONfiETosPOw=;
        b=DZn8XpPv0quPGg5bkrryZT/srADWL0faI2hux5rYnZm09svIAlmHiUPFtpihHLe7SN
         5g4/1V0XkDBGSIX4sbtZxXYBlpJqgDjCxBBfAbIaoTDwJaw+7ZiUjshopOsnMJmRrwqR
         ZXLBIRwG6cozmVQb+OjSEflGAQRcTl8Qy8ht9V9iPnU52Ug2vE+6yLr8dc8ZcC/8YPdJ
         pMIDKxKnF/W9p5tz9fb96OOmQ4gGBMSix4Vt6QOAB7Irn9PujEZeojQ8uXiFhe6p84Ti
         sQCx68sfSjAkmLYM7sf8Qq+puAqcuYHmBs3U8jgmT0wlbWQIio6ctRfmuXirbOAffuVl
         m31w==
X-Gm-Message-State: APjAAAVbbsRd93DLUO+S6aOoGhpnGVEiSioXOcTtGK/xfSMJmRhNEKdO
        usf5wceHnf9sAYc6ebdYKSuYag==
X-Google-Smtp-Source: APXvYqyboa0SLqN7T7s6iGwMZbGGbmSqCk2Wbzr/CjQovIh+84TMAZ7Zz1OZ0flX1H4ZTBJiUafxng==
X-Received: by 2002:adf:b601:: with SMTP id f1mr3058966wre.158.1553608419815;
        Tue, 26 Mar 2019 06:53:39 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id z13sm17060042wrw.36.2019.03.26.06.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 06:53:39 -0700 (PDT)
Date:   Tue, 26 Mar 2019 14:42:51 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/22] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190326134251.GA5181@nanopsycho.orion>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
 <20190326120909.GF2230@nanopsycho>
 <20190326132427.GK26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326132427.GK26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Mar 26, 2019 at 02:24:27PM CET, mkubecek@suse.cz wrote:
>On Tue, Mar 26, 2019 at 01:09:09PM +0100, Jiri Pirko wrote:
>> Mon, Mar 25, 2019 at 06:08:09PM CET, mkubecek@suse.cz wrote:
>> >+All "set" and "action" type requests require admin privileges (CAP_NET_ADMIN
>> >+in the namespace). Most "get" type request are allowed for anyone but there
>> 
>> s/request/requests/
>
>Will fix.
>
>> >+Device identification
>> >+---------------------
>> >+
>> >+When appropriate, network device is identified by a nested attribute named
>> >+ETHA_*_DEV. This attribute can contain
>> 
>> Isn't it ETHA_DEV_*? I must admit I'm a bit confused.
>
>ETHA_*_DEV is the nesting attribute (e.g. ETHA_SETTINGS_DEV), ETHA_DEV_*
>(ETHA_DEV_INDEX and ETHA_DEV_NAME) are in the nest.

Yeah. I wonder why you need to duplicate this. Can this be in top-lever
attr enum that is shared among all commands? It is there anyway and
looks a bit silly to have "DEV" attr separate for every command.
Something like this:

ATTR_IFINDEX
ATTR_IFNAME
ATTR_SOMEOTHER (flags perhaps)
ATTR_CMD_SPECIFIC_NEST_START
  ATTR_CMDX_SOMETHING
  ATTR_CMDX_SOMETHING2
  ATTR_CMDX_SOMETHING3
ATTR_CMD_SPECIFIC_NEST_END

>
>> 
>> 
>> >+
>> >+    ETHA_DEV_INDEX	(u32)		device ifindex
>> >+    ETHA_DEV_NAME	(string)	device name
>> >+
>> >+In device related requests, one of these is sufficient; if both are used, they
>> >+must match (i.e. identify the same device). In device related replies both are
>> 
>> You say this now for the second time. First time this was said in second
>> para.
>
>I'll drop one of them.
>
>> >+List of message types
>> >+---------------------
>> >+
>> >+All constants use ETHNL_CMD_ prefix, usually followed by "GET", "SET" or "ACT"
>> 
>> Why "usually"? Why not "always"?
>
>Right, it's always. And if it changes one day, the sentence will have to
>be rewritten anyway.

Okay.


>
>> >+Messages of type "get" are used by userspace to request information and
>> >+usually do not contain any attributes (that may be added later for dump
>> >+filtering). Kernel response is in the form of corresponding "set" message;
>> 
>> Okay. Do we want reply to "*_cmd_something_get" command to be
>> "*_cmd_something_set". That sounds odd. Why reply has to be "cmd"? Why
>> not something like "reply" or "response"?
>> This should work for both "doit/dumpit" and notifications.
>
>As stated right below, the aim is to use the same format for replies to
>GET requests as userspace uses for related SET requests. We could use
>different id (genlmsghdr::cmd) but that seemed like a waste for no actual
>gain.

I understand. I just wonder if the replies/notifications could use the
same name, not having "set" in it. I know we have it like this in many
netlink ifaces, it is however confusing to users. So once we are doing
this from scratch, we can do it differently.


>
>> >+the same message can be also used to set (some of) the parameters, except for
>> >+messages marked as "response only" in the table above. "Get" messages with
>> >+NLM_F_DUMP flags and no device identification dump the information for all
>> >+devices supporting the request.
>
>> >+
>> >+enum {
>> >+	ETHNL_CMD_NOOP,
>> >+
>> 
>> Usually headers have something like:
>> /* add new commands above here */
>> here.
>
>OK
>
>> >diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
>> >index 3ebfab2bca66..f30e0da88be5 100644
>> >--- a/net/ethtool/Makefile
>> >+++ b/net/ethtool/Makefile
>> >@@ -1,3 +1,7 @@
>> > # SPDX-License-Identifier: GPL-2.0
>> > 
>> >-obj-y		+= ioctl.o
>> >+obj-y				+= ioctl.o
>> >+
>> >+obj-$(CONFIG_ETHTOOL_NETLINK)	+= ethtool_nl.o
>> 
>> Why? I believe this should be always build-in same as ioctl.
>
>I would like to make the ioctl interface optional as well, eventually.
>As someone noted in one of the earlier discussions, there may be some
>special minimalistic setups where ethtool interface may be of no use.

Okay, fair enough.


>
>> >+struct genl_family ethtool_genl_family = {
>> >+	.hdrsize	= 0,
>> 
>> No need to set 0.
>
>OK
>
>> >+
>> >+extern struct genl_family ethtool_genl_family;
>> 
>> Why? You need this just within "netlink.c", don't you?
>
>In the submitted part, yes. But one of the later patches adds specific
>notify handler (different from ethnl_std_notify()) which is not in
>netlink.c and needs to use pointer to ethtool_genl_family for a call to
>genlmsg_put() and genlmsg_multicast().
>
>But I can make it static for now and change to extern when it's needed.

Please do.


>
>Michal
>
