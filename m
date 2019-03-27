Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791D32082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="vTcAG2pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbfC0Jir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:38:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34271 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfC0Jiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:38:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so17716665wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 02:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BASfTB8zxvOB/m2/uM3UEGAV+xZB5ehdYZbQyVWvTb4=;
        b=vTcAG2pwN22eC6Jo/yr383B9zCsiUIT4Xqp/Fee41BlJzJC2ZWaq/bMFlFSgYGwiZ3
         WIWZhpRijxCJyAXqSoiXDZjec0/3D1JxSkhNExe0qMPCZH0KcWld8Rzz4qsf8H1R16qX
         EvEshbng5J0rZcTeY0/qUYejKIenkkkM/fhbhOFB0dCBO349uKrVsiBLcR747vF+jjKp
         AXx6q7ujxsublPpP2IbgjlXruBL1r57zgZ8MSW7FhDIQIoOZXtX6AR2O349Xmxp6Mw62
         mm8cOkz56Bc1RO/99TOODlS6QboXZZWTyR+1JGy+HqLqFTmws1xf79wrH3/42Tk2zgA+
         D2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BASfTB8zxvOB/m2/uM3UEGAV+xZB5ehdYZbQyVWvTb4=;
        b=fzlVnLcL0Oo8gXlsDEov1y+ZkLGQaNuY5B7VyZZnTvkOprkm9oKLAW5SbY7nbJAZQo
         x5cXFx8fymwdE99EYw4gPkW5nsbYdegF1xdB2q0LzAvbQdk5CJ34UAoF7VOHsu42MfO5
         sB+5HTk/1CEXMZiFl8/A7JXaCSWOyewHwFOeSLPZP9s4Dn6LUSVY5Ug5A/ojdFxjyKWG
         MvrGC/6qwDtZlyAX7iM4XvboKQogO6SbmBMU7aaBvwI1m19Vhe7MPF8OYRd4VBZWfXhy
         S5cLETlxpiubgewLm0czo9T2dw1BFfrvEdMLgi9X5bguJWTc7xsAm0fCKFzBI2Sv1VzE
         i46A==
X-Gm-Message-State: APjAAAVefO7ovk4CTDvLX/OBB+hjvJwWSRc/piEiMRr+FujgjYRvo6hT
        D/ardO6uluMi3Di3tQhMjk9iOWK2LP4=
X-Google-Smtp-Source: APXvYqzBGYA8ERpKrGt/L40n13aQ7JaI41/CRGGJ2W+pHUC1vUJSmCH33BSCoFSC/1oufQvuQtCugg==
X-Received: by 2002:adf:e50d:: with SMTP id j13mr22549024wrm.165.1553679524985;
        Wed, 27 Mar 2019 02:38:44 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id a9sm21805628wrt.29.2019.03.27.02.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 02:38:44 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:38:43 +0100
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
Message-ID: <20190327093843.GB6979@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <3578e5f334acf11b84e75d0ee41c072340a7b085.1553532199.git.mkubecek@suse.cz>
 <20190326163400.GC4958@nanopsycho.orion>
 <20190326181720.GO26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326181720.GO26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Mar 26, 2019 at 07:17:20PM CET, mkubecek@suse.cz wrote:
>On Tue, Mar 26, 2019 at 05:34:00PM +0100, Jiri Pirko wrote:
>> Mon, Mar 25, 2019 at 06:08:18PM CET, mkubecek@suse.cz wrote:
>> >+void ethtool_notify(struct net_device *dev, struct netlink_ext_ack *extack,
>> >+		    unsigned int cmd, u32 req_mask, const void *data)
>> >+{
>> >+	if (unlikely(!ethnl_ok))
>> 
>> Why do you need this?
>
>If genetlink family registration fails, ethtool_notify() can be still
>called from other code (e.g. the ethtool ioctl interface). In such case,
>better bail out right away than fail somewhere later (probably after
>preparing the message which can't be sent anyway).

Again, haven't seen this in any other gen netlink implementation. Why do
they not need it?


>
>> >+		return;
>> >+	ASSERT_RTNL();
>> >+
>> >+	if (likely(cmd < ARRAY_SIZE(ethnl_notify_handlers) &&
>> >+		   ethnl_notify_handlers[cmd]))
>> >+		ethnl_notify_handlers[cmd](dev, extack, cmd, req_mask, data);
>> >+	else
>> >+		WARN_ONCE(1, "notification %u not implemented (dev=%s, req_mask=0x%x)\n",
>> >+			  cmd, netdev_name(dev), req_mask);
>> >+}
>> >+EXPORT_SYMBOL(ethtool_notify);
>> 
>> Please be consistent with prefixes. Rest of the code (most of it) has
>> prefix "ethnl".
>
>The reason why I used ethtool_ prefix here was that this function is an
>entry point which can be called from anywhere and other code doesn't
>care if we are using netlink or something else. But as any caller would
>need to include <linux/ethtool_netlink.h> anyway to get the constants
>for cmd and req_mask, there is no point hiding the fact. I'll rename it
>to ethnl_notify().

Okay.


>
>> >diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
>> >index b8a6cd3dc3e3..5f2299548915 100644
>> >--- a/net/ethtool/netlink.h
>> >+++ b/net/ethtool/netlink.h
>> >@@ -11,6 +11,8 @@
>> > #define ETHNL_SET_ERRMSG(info, msg) \
>> > 	do { if (info) GENL_SET_ERR_MSG(info, msg); } while (0)
>> > 
>> >+extern u32 ethnl_bcast_seq;
>> 
>> Why do you need to have this in header? Second, it is not used by
>> anything. Please don't introduce variables that are not used. Introduce
>> them only in patch where you use it.
>
>It's the same as with ethtool_genl_family. I'll make it static as well
>until it's used in some other file.

Not only static. You should remove it as you are not using it in this
patch at all.


>
>Michal
