Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D528CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04F921773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="t++1I0OR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfC1NXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:23:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33669 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1NXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:23:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so22902965wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RA3Vc3h6AAZ33dMmUBY7QEkLeyhq0JO2tFHb51/3r08=;
        b=t++1I0ORy4aht2pjt5Nm+Z/QUAOUNG195M+2x5c29X73WIZTNWne5m1X3IU9C+g++N
         o1cgGSupXj7mgy6ptqJcqaSLt32/n5tpvjiz7Hs2Z0epzj3UWKfK6z0LQndbUOSlU+Ff
         b2aOXUkLzUUWM3gxRQVacZpznIoB2VM/N58DmYP3A6vAD4CL5IlNEJE+rH9LzN+y5Q1M
         5TC/T1rrHdut+fDhP6mPtje6/Ays8Ka90fETMImQOjS9LzwmA2CwMkzjCSpCEaF1/iTV
         WEoDP0H0JNsYA17GXTXaIPqKC45WoLC6gxwIH1WFz67xml9TCZym56TO9dN8DmEqejHC
         9MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RA3Vc3h6AAZ33dMmUBY7QEkLeyhq0JO2tFHb51/3r08=;
        b=SCc29w7hi2FS+J3kw0bllmEX99JDKpTsL2bHfZOWM+PwIxwh8bgw2CHuk2T1plAt9q
         0iNqp+Qlneb0QFj9LpLZACwNYS1f12CME8OXRScrvbGnoWIiIMFdH9+CMCuTfFuAymK6
         SrmtvT5+wfO+uQC3rcwGs8rmevWAg3KMEsjgYoHd9BgApsFNkFVxZOJfWVm6vtP+lHBt
         pfMYyFLxnJqtlK5QHRlznKj0iN/yts8BfzkK0yYo9/wQQ5QRuQCVsIEZAjrprr9XnQ9i
         dMMcVm4ydIc+RMkv/Qnil4Ozti03PRnOjQvNgPfVkPAd3ldtnbOWmuGON/XU7tfVt6Yx
         RM3Q==
X-Gm-Message-State: APjAAAWHujqyI73nJlNXPDR7HjeDJiVumxOtHDjp56PsQU74qW1LnT78
        C6vXe4RkdcgYkSToGVKDokVipg==
X-Google-Smtp-Source: APXvYqwQmU67iEmcDDt5hsEVsuB6+EIxp1sOuCCeq6G8K7A3SDyToF6JujRTGFwkajJCNX8DMLbWwg==
X-Received: by 2002:adf:e487:: with SMTP id i7mr27776403wrm.264.1553779398058;
        Thu, 28 Mar 2019 06:23:18 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id s12sm3498806wmj.42.2019.03.28.06.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:23:17 -0700 (PDT)
Date:   Thu, 28 Mar 2019 14:23:16 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/22] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190328132316.GM14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
 <20190326120909.GF2230@nanopsycho>
 <20190326132427.GK26076@unicorn.suse.cz>
 <20190326134251.GA5181@nanopsycho.orion>
 <20190327092604.GP26076@unicorn.suse.cz>
 <20190327095023.GC6979@nanopsycho>
 <7e883a7c-7f1a-b1a0-4735-0ad368998c65@gmail.com>
 <20190328081010.GJ14297@nanopsycho>
 <20190328093746.GA26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328093746.GA26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Mar 28, 2019 at 10:37:46AM CET, mkubecek@suse.cz wrote:
>On Thu, Mar 28, 2019 at 09:10:10AM +0100, Jiri Pirko wrote:
>> Thu, Mar 28, 2019 at 03:05:14AM CET, f.fainelli@gmail.com wrote:
>> >
>> >
>> >On 3/27/2019 2:50 AM, Jiri Pirko wrote:
>> >> 
>> >> Why don't you have ETHTOOL_MSG_SET_FOO for set? I think that for
>> >> kerne->userspace the ETHTOOL_MSG_FOO if fine. I would change the
>> >> ordering of words thought, but it is cosmetics:
>> >> ETHTOOL_MSG_FOO /* kernel->userspace messages - replies, notifications */
>> >> ETHTOOL_MSG_FOO_GET
>> >> ETHTOOL_MSG_FOO_SET
>> >> ETHTOOL_MSG_FOO_ACT
>> >> 
>> >> What do you think?
>> >
>> >We could even name the notification explicitly with: ETHTOOL_MSG_NOTIF
>> >or ETHTOOL_MSG_NTF just so we spell out exactly what those messages are.
>> 
>> Sound good. Something like:
>> 
>> ETHTOOL_MSG_FOO_GET
>> ETHTOOL_MSG_FOO_GET_RPLY /* kernel->userspace replies to get */
>> ETHTOOL_MSG_FOO_SET
>> ETHTOOL_MSG_FOO_ACT
>> ETHTOOL_MSG_FOO_NTF /* kernel->userspace async messages - notifications */
>
>The names sound fine to me and having different message ids would still
>allow processing messages by the same handler easily.
>
>But there is one potential issue I would like to point out: this way we
>spend 4 message ids for a get/set pair rather than 2. These message ids
>(genlmsghdr::cmd) are u8, i.e. the resource is not as infinite as one
>would wish. There are 80 ioctl commands (43 "get" and 29 "set") at the
>moment.
>
>Netlink API should be less greedy in general. I already combined some
>ioctl commands into one netlink request type and with an easy way to add
>new attributes to existing commands, we won't need to add new commands
>as often (certainly not in a way which left us with 9 "get" and 9 "set"
>ioctl commands for netdev features). So even with 4 ids per get/set
>pair, we might be safe for reasonably long time. But it's still
>something to keep in mind.

There are still 16 bits reserve in genl msg header:
struct genlmsghdr {
        __u8    cmd;
        __u8    version;
        __u16   reserved;
};

