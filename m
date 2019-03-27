Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DEBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D882184D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="IWPetgUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbfC0KnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:43:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35671 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfC0KnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:43:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so17976340wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LsiuI60dfdQ+CJTYPftn2cUhqwHb5lCTFd2DT0+nDAg=;
        b=IWPetgUJ4obAC94+VsLY6w4pQ6j6EO5pOEFzWoGFoq9dX9j5u5fyGX2psA8WZ7iFtn
         7wUaunvzmnRE1yw2lxqQRcht8wYjxaeqY39Z2N8d+Ty6QFP4xBwXkQ/nbZWum5tJFofp
         PO7H5fCG7tA9JCc7LmMrq1I7B+gBrVJjkMwlVM2hMs0cOFhJRo9dea2XRLPvTd0+G8Qa
         AJVqL6igk2TauWZuD6/N1ydUS2ylVP+z+75GjYb9RaSIJ+QeOe2lqqE4UfVGTmVd/dwd
         hB7TiVuadbLwNKr1XMu+XpFvnrgyEC3Vp5YD9icAIuOop7xgZQSPfdKaDw/t18lnqdoP
         Bhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LsiuI60dfdQ+CJTYPftn2cUhqwHb5lCTFd2DT0+nDAg=;
        b=oAXLT0JOPtysmuDddFpzlZsbPbysenuLQgnfBjwUnoBiRszk/dE0yhx0YlFBbf+FCM
         GGY1eF4b9X76ysN/CSv/RykCHW3NvHWurYBLp7Ke7kzfwD9NKhp31uT18WigAIDkVxtY
         FWPPnm+wa040aPk7j6aEhNJE1H9gtZx3nwg3EJuzNGVtp4HUV0zX+TELxB8r4hQzmT/1
         1QAYlNDiWmp0r7YtdCEpK2ensbaOLdutgUuYV//QVHbT0Z3hCRI8DFqR5rxRm6ufde7l
         3xkY5GdlBaS8fmL1VC9/5SYivSNVExRiYUeyjdGEeI2ItwRdJCSHinloW44KYY/f/r7y
         u/Hg==
X-Gm-Message-State: APjAAAVI2bn110Lgl+g2c4PW5/3+LLLVH9lSDNDbK0+px4yroDkwYdUe
        aaOcXR/WCXyiSk4j2wWIVV+5BA==
X-Google-Smtp-Source: APXvYqyav8Zn44WIqvLNV+bomyV/zgnkZGLS8/UK0HaI7qj4kNZy7lVPeqpyG8RvYlwqS0zx0Iruhg==
X-Received: by 2002:adf:e2d1:: with SMTP id d17mr21863853wrj.243.1553683400241;
        Wed, 27 Mar 2019 03:43:20 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id o15sm20167010wrj.59.2019.03.27.03.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 03:43:19 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:43:19 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/22] ethtool: support for netlink
 notifications
Message-ID: <20190327104319.GG6979@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <3578e5f334acf11b84e75d0ee41c072340a7b085.1553532199.git.mkubecek@suse.cz>
 <20190326163400.GC4958@nanopsycho.orion>
 <20190326181720.GO26076@unicorn.suse.cz>
 <20190327093843.GB6979@nanopsycho>
 <20190327095950.GQ26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327095950.GQ26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 27, 2019 at 10:59:50AM CET, mkubecek@suse.cz wrote:
>On Wed, Mar 27, 2019 at 10:38:43AM +0100, Jiri Pirko wrote:
>> Tue, Mar 26, 2019 at 07:17:20PM CET, mkubecek@suse.cz wrote:
>> >On Tue, Mar 26, 2019 at 05:34:00PM +0100, Jiri Pirko wrote:
>> >> Mon, Mar 25, 2019 at 06:08:18PM CET, mkubecek@suse.cz wrote:
>> >> >+void ethtool_notify(struct net_device *dev, struct netlink_ext_ack *extack,
>> >> >+		    unsigned int cmd, u32 req_mask, const void *data)
>> >> >+{
>> >> >+	if (unlikely(!ethnl_ok))
>> >> 
>> >> Why do you need this?
>> >
>> >If genetlink family registration fails, ethtool_notify() can be still
>> >called from other code (e.g. the ethtool ioctl interface). In such case,
>> >better bail out right away than fail somewhere later (probably after
>> >preparing the message which can't be sent anyway).
>> 
>> Again, haven't seen this in any other gen netlink implementation. Why do
>> they not need it?
>
>Do they have notifications triggered from other code by directly calling
>a function (i.e. not through e.g. a netdev notifier)?

Okay, got it.


>
>An alternative to a flag would be using a RCU pointer for this function
>(initialized to null and set once the family is registered) which is
>what e.g. netfilter is doing with its hooks but that would mean that
>each external notification would use an indirect call.

It's slow path, I don't think this kind of overhead is of any issue.
Sounds good.


>
>> >> >diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
>> >> >index b8a6cd3dc3e3..5f2299548915 100644
>> >> >--- a/net/ethtool/netlink.h
>> >> >+++ b/net/ethtool/netlink.h
>> >> >@@ -11,6 +11,8 @@
>> >> > #define ETHNL_SET_ERRMSG(info, msg) \
>> >> > 	do { if (info) GENL_SET_ERR_MSG(info, msg); } while (0)
>> >> > 
>> >> >+extern u32 ethnl_bcast_seq;
>> >> 
>> >> Why do you need to have this in header? Second, it is not used by
>> >> anything. Please don't introduce variables that are not used. Introduce
>> >> them only in patch where you use it.
>> >
>> >It's the same as with ethtool_genl_family. I'll make it static as well
>> >until it's used in some other file.
>> 
>> Not only static. You should remove it as you are not using it in this
>> patch at all.
>
>OK
>
>Michal
