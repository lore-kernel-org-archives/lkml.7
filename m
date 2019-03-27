Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F008BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F572075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="sdjVbn5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbfC0Ju1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:50:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46169 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfC0Ju0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:50:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so1069621wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wipIzrvoeOTIBslny18TNK+ATOtqYKZYGtldVHX21gc=;
        b=sdjVbn5sGLQnVaZiTLhbnNv8ihmcyHuPyf6BcoupZkh7bQVFUb4NK8VmTQtcoNfLEH
         srtbvtqj72yZtqklCm/HZwhmiqZRlERYmQS8vz0pJ1a3zSChcal2+ljVFXuc46mdbfsU
         e+LPuZ8kMOGhzgfyAWLT3nmLfZM9fYuQxlLH5WqegJdiPEfuNCjMtcOyVbZriDixut/L
         /UUhLF1V17hWUQcS3j7iMjCE4ZE+6DGuDplM8rceo0w0tYqxpFHXxjKzRjP9PDfC+15G
         P8cJHmD+6SqDAV+MIij6C955mtc2zrzrrNUN0O7OH5mspWFQlzNUnwhlMdaTWFNmK91B
         PfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wipIzrvoeOTIBslny18TNK+ATOtqYKZYGtldVHX21gc=;
        b=IjpKk5XG1jgghYDiJthr0uXDBk9L7XU9KtCI4xIXtc7D9TuZCdzk0foxytr+SyIhng
         mZDJ+QUsC5JEzgiytTOdW3KMAN7Pkmo3JnSIvoye7N+PuckOj7BHhsdNied9C+1rso46
         iTPs7zbF/mKqcMu875ivCVF0le5o6+SlNLix7avYzIa/oajsuJchCKna8HErYuegkogD
         MhSt4WSFchjf9ElQwwh1na551UdMKD/1m/n184mv3JUAlZS+3N7aDxlVAAYF7+ULTXWD
         IozCOK90pclJqy4Cgo94j5kPUs1k7YOXPX15XS7YmhOUI8lvsA/RJPqrmaQOj9umeGMl
         pMIQ==
X-Gm-Message-State: APjAAAWIwB7rJ+WY/g74w95f4CjoUl53mc9hOPp1/d1FlpVZDbHTCrYH
        Tz0iMgW0Qj2CnsymNjjIR5h/bUwXP4E=
X-Google-Smtp-Source: APXvYqzmv9nsyBInX8Thc/BXxG7Fi7McNGfiWOV9AdTY8p+zG2gOjnPaU7VgZ3g4SSdYi1feb8OKZw==
X-Received: by 2002:a5d:458f:: with SMTP id p15mr23853676wrq.188.1553680224473;
        Wed, 27 Mar 2019 02:50:24 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id x11sm18887564wmh.2.2019.03.27.02.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 02:50:23 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:50:23 +0100
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
Message-ID: <20190327095023.GC6979@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
 <20190326120909.GF2230@nanopsycho>
 <20190326132427.GK26076@unicorn.suse.cz>
 <20190326134251.GA5181@nanopsycho.orion>
 <20190327092604.GP26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327092604.GP26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 27, 2019 at 10:26:04AM CET, mkubecek@suse.cz wrote:
>On Tue, Mar 26, 2019 at 02:42:51PM +0100, Jiri Pirko wrote:
>> Tue, Mar 26, 2019 at 02:24:27PM CET, mkubecek@suse.cz wrote:
>> >On Tue, Mar 26, 2019 at 01:09:09PM +0100, Jiri Pirko wrote:
>> >> Mon, Mar 25, 2019 at 06:08:09PM CET, mkubecek@suse.cz wrote:
>> >> >+Device identification
>> >> >+---------------------
>> >> >+
>> >> >+When appropriate, network device is identified by a nested attribute named
>> >> >+ETHA_*_DEV. This attribute can contain
>> >> 
>> >> Isn't it ETHA_DEV_*? I must admit I'm a bit confused.
>> >
>> >ETHA_*_DEV is the nesting attribute (e.g. ETHA_SETTINGS_DEV), ETHA_DEV_*
>> >(ETHA_DEV_INDEX and ETHA_DEV_NAME) are in the nest.
>> 
>> Yeah. I wonder why you need to duplicate this. Can this be in top-lever
>> attr enum that is shared among all commands? It is there anyway and
>> looks a bit silly to have "DEV" attr separate for every command.
>> Something like this:
>> 
>> ATTR_IFINDEX
>> ATTR_IFNAME
>> ATTR_SOMEOTHER (flags perhaps)
>> ATTR_CMD_SPECIFIC_NEST_START
>>   ATTR_CMDX_SOMETHING
>>   ATTR_CMDX_SOMETHING2
>>   ATTR_CMDX_SOMETHING3
>> ATTR_CMD_SPECIFIC_NEST_END
>
>I would rather prefer the opposite:
>
>ATTR_HEADER
>    ATTR_IFINDEX
>    ATTR_IFNAME
>    ATTR_INFO_MASK
>    ATTR_PER_QUEUE
>ATTR_CMDX_SOMETHING
>ATTR_CMDX_SOMETHING2
>ATTR_CMDX_SOMETHING3
>...
>
>This way the "header" with universal attributes (not specfic to
>a particular message type) would be kept together at the beginning even
>after we need to add some more later and command specific attributes
>would still have fixed numbers (starting from 2). I'll think about it
>some more and check what would be pros and cons of the two variants
>when parsing and generating the messages.

Okay, so what you suggest is per-cmd top level attr enum. That leads to
duplications of common attributes:
You would have to have HEADER attr defined in every cmd enum:

enum cmdx {
ATTR_CMDX_HEADER
ATTR_CMDX_SOMETHING
ATTR_CMDX_SOMETHING2
ATTR_CMDX_SOMETHING3
};

enum cmdy {
ATTR_CMDY_HEADER
ATTR_CMDY_SOMETHING
ATTR_CMDY_SOMETHING2
ATTR_CMDY_SOMETHING3
};

That is odd. TC has it and I hate it there :)

I think that the rtnetlink example is better. The generic things are in
generic top level enum. Then you have IFLA_LINKINFO with per-type enums.

>
>> >> >+Messages of type "get" are used by userspace to request information and
>> >> >+usually do not contain any attributes (that may be added later for dump
>> >> >+filtering). Kernel response is in the form of corresponding "set" message;
>> >> 
>> >> Okay. Do we want reply to "*_cmd_something_get" command to be
>> >> "*_cmd_something_set". That sounds odd. Why reply has to be "cmd"? Why
>> >> not something like "reply" or "response"?
>> >> This should work for both "doit/dumpit" and notifications.
>> >
>> >As stated right below, the aim is to use the same format for replies to
>> >GET requests as userspace uses for related SET requests. We could use
>> >different id (genlmsghdr::cmd) but that seemed like a waste for no actual
>> >gain.
>> 
>> I understand. I just wonder if the replies/notifications could use the
>> same name, not having "set" in it. I know we have it like this in many
>> netlink ifaces, it is however confusing to users. So once we are doing
>> this from scratch, we can do it differently.
>
>How about
>
>  ETHTOOL_MSG_GET_FOO  for get requests
>  ETHTOOL_MSG_FOO      for get replies, notifications and set requests
>  ETHTOOL_MSG_ACT_FOO  for actions (renegotiation, reset, blinking, ...)
>
>?

Why don't you have ETHTOOL_MSG_SET_FOO for set? I think that for
kerne->userspace the ETHTOOL_MSG_FOO if fine. I would change the
ordering of words thought, but it is cosmetics:
ETHTOOL_MSG_FOO /* kernel->userspace messages - replies, notifications */
ETHTOOL_MSG_FOO_GET
ETHTOOL_MSG_FOO_SET
ETHTOOL_MSG_FOO_ACT

What do you think?

>
>Michal
