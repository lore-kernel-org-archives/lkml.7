Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC567C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FE0218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="lDQiYQGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfGDIGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:06:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50712 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfGDIGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:06:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id n9so4756114wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7U8PUS9qeOEnu5XyHEv9AyKWyWyvdTGDvMPE5z/vTV4=;
        b=lDQiYQGTJywYz1M49aN4htdUio8wJiZoNk0UFRG2Qp89ahNYYFRAIFKNngGvPx30ZJ
         68rb6xm9N2tPRwjlQGo35YR4zNIbwMD3X/hMwxDrenqh/bLUW9CWk58jIYR4GOMyH47l
         UVIoKb5MrhOfcsFtkxkICTuYQI7N1E2Jjz5DNvxWUPNOmY2+aC+C+kdelbY0nK2iA5Xy
         qRYJexEvscpdMjx1QxF0bfQ3PdBp1xAttUY6YDp46b6sYnCsknOwQzMIVOI4LpePH/Ei
         j6x09CrtLH3Oq68T6+FKRItmkfjgS8lnCPrt0EmWUNJ91BtNUcgjwPxexRez2jzEU8ky
         93fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7U8PUS9qeOEnu5XyHEv9AyKWyWyvdTGDvMPE5z/vTV4=;
        b=LVtur39GB5346GFUXLPlsTKdOEN+q0wF24xmSfPBUJxgn58qK0ol8zc4D6vtrGn2es
         5gu79O55k7eefeqTA7avvw6B8F/V8uAX3rdfCDJc948JHWsnBMVxTy1maW+J/KOnPDQe
         Pi1W7ZDSdv0lYPIZ9sHmyGVIFVhU34qXhgMzLCH6NkeryGbyzk4NJX7O29t3X/beXEXO
         ykQj02kyBgMyL8BiNqV/Yo8Fs1f+zt0TidUwUmHPLyoAZRQDgtDynaN+bZPO4jBl/PF5
         irt2kMRk2eGuGqpQ63Q490z9HAtwGpuwBRfU3q2ne26Jwz5D401cdu65eTktc0MCPPOs
         pQWw==
X-Gm-Message-State: APjAAAWn4ceUZUTwtMUHCuHSk57vKN0VulB0Aeiu5kPgXvtHmh2dbxWJ
        0hojqPq1uvhDeq7wudCkoBQYfQ==
X-Google-Smtp-Source: APXvYqxYyYoFFR6L6fhUUqkc+y4k/H17KErTfxui37ASNX5vZmb3mmQo+bdo6f4Frl1E5L4aN9xK1A==
X-Received: by 2002:a05:600c:2218:: with SMTP id z24mr11398628wml.84.1562227560803;
        Thu, 04 Jul 2019 01:06:00 -0700 (PDT)
Received: from localhost (ip-213-220-235-213.net.upcbroadband.cz. [213.220.235.213])
        by smtp.gmail.com with ESMTPSA id w24sm3387938wmc.30.2019.07.04.01.06.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 01:06:00 -0700 (PDT)
Date:   Thu, 4 Jul 2019 10:06:00 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 07/15] ethtool: support for netlink
 notifications
Message-ID: <20190704080600.GG2250@nanopsycho>
References: <cover.1562067622.git.mkubecek@suse.cz>
 <4dcac81783de8686edefa262a1db75f9e961b123.1562067622.git.mkubecek@suse.cz>
 <20190703133352.GY2250@nanopsycho>
 <20190703141614.GL20101@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703141614.GL20101@unicorn.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jul 03, 2019 at 04:16:14PM CEST, mkubecek@suse.cz wrote:
>On Wed, Jul 03, 2019 at 03:33:52PM +0200, Jiri Pirko wrote:
>> >+/* notifications */
>> >+
>> >+typedef void (*ethnl_notify_handler_t)(struct net_device *dev,
>> >+				       struct netlink_ext_ack *extack,
>> >+				       unsigned int cmd, u32 req_mask,
>> >+				       const void *data);
>> >+
>> >+static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
>> >+};
>> >+
>> >+void ethtool_notify(struct net_device *dev, struct netlink_ext_ack *extack,
>> >+		    unsigned int cmd, u32 req_mask, const void *data)
>> 
>> What's "req_mask" ?
>
>It's infomask to interpret the same way as if it came from request
>header (the notification triggered by a SET request or its ioctl
>equivalent uses the same format as corresponding GET_REPLY message and
>is created by the same code). But it could be called infomask, I have no
>strong opinion about that.

The name should be same all along the code so the reader can track it.


>
>> >+{
>> >+	if (unlikely(!ethnl_ok))
>> >+		return;
>> >+	ASSERT_RTNL();
>> >+
>> >+	if (likely(cmd < ARRAY_SIZE(ethnl_notify_handlers) &&
>> >+		   ethnl_notify_handlers[cmd]))
>> 
>> How it could be null?
>
>Notification message types share the enum with other kernel messages:
>
>/* message types - kernel to userspace */
>enum {
>	ETHTOOL_MSG_KERNEL_NONE,
>	ETHTOOL_MSG_STRSET_GET_REPLY,
>	ETHTOOL_MSG_SETTINGS_GET_REPLY,
>	ETHTOOL_MSG_SETTINGS_NTF,
>	ETHTOOL_MSG_SETTINGS_SET_REPLY,
>	ETHTOOL_MSG_INFO_GET_REPLY,
>	ETHTOOL_MSG_PARAMS_GET_REPLY,
>	ETHTOOL_MSG_PARAMS_NTF,
>	ETHTOOL_MSG_NWAYRST_NTF,
>	ETHTOOL_MSG_PHYSID_NTF,
>	ETHTOOL_MSG_RESET_NTF,
>	ETHTOOL_MSG_RESET_ACT_REPLY,
>	ETHTOOL_MSG_RXFLOW_GET_REPLY,
>	ETHTOOL_MSG_RXFLOW_NTF,
>	ETHTOOL_MSG_RXFLOW_SET_REPLY,
>
>	/* add new constants above here */
>	__ETHTOOL_MSG_KERNEL_CNT,
>	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
>};
>
>Only entries for *_NTF types are non-null in ethnl_notify_handlers[]:
>
>static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
>	[ETHTOOL_MSG_SETTINGS_NTF]	= ethnl_std_notify,
>	[ETHTOOL_MSG_PARAMS_NTF]	= ethnl_std_notify,
>	[ETHTOOL_MSG_NWAYRST_NTF]	= ethnl_nwayrst_notify,
>	[ETHTOOL_MSG_PHYSID_NTF]	= ethnl_physid_notify,
>	[ETHTOOL_MSG_RESET_NTF]		= ethnl_reset_notify,
>	[ETHTOOL_MSG_RXFLOW_NTF]	= ethnl_rxflow_notify,
>};
>
>If the check above fails, it means that kernel code tried to send
>a notification with type which does not exist or is not a notification,
>i.e. a bug in kernel; that's why the WARN_ONCE.

Got it, thanks!


>
>Michal
>
>> >+		ethnl_notify_handlers[cmd](dev, extack, cmd, req_mask, data);
>> >+	else
>> >+		WARN_ONCE(1, "notification %u not implemented (dev=%s, req_mask=0x%x)\n",
>> >+			  cmd, netdev_name(dev), req_mask);
>> >+}
>> >+EXPORT_SYMBOL(ethtool_notify);
