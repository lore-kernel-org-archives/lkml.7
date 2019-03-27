Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3ACC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281C82070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="iuZvIrac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbfC0KEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:04:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35252 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbfC0KEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:04:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so17822608wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Ngg8dVEnWPMGor+nIV4V2v+8f2pclCfsBtCpdi6Jbc=;
        b=iuZvIracgjguJPsJ/z/h1PhxSafhOzr1WHs3aKRwhCRoLl2sDOQGjpLyTERZnccfNk
         9gYlhx4cSUWxB0oV2exkNi32kY13LNIY3lUjYkHRC0cQJffVX7pBuyxrZSBkw93NkL3M
         FDPPEZ12IVQzjCrPK3be+CYtg9GphN70HXIUJlBh3X1ixIGupscJuPorJ9xDLfoE0DbX
         IGaxIoJ/xqqPJGMF5HQ4cB5PwAwY565yU9l6EyG3+pkLXAxZ89OTCiz5xbIabW+WwmOw
         +K3Vyfv9HlLMEgWfiSUjkcF9/79BKOQ7MQYt9z+R14e2/JZEApfT1cUntfCRfws5/zrp
         uozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Ngg8dVEnWPMGor+nIV4V2v+8f2pclCfsBtCpdi6Jbc=;
        b=bsANO/dc2sd3tKbVyrK/mnlrIFsrOELfn7Aoztn9Z+j6/MiFWX+/Z23LK1WTdCtwP8
         2IQSRx7fq4lIGOjMqFiU1bT2mO0rz8CWsm6Y8PM7ggovRUaFupgfUiNmhkLKMGKJ6XmR
         yOzzarum+YxG3tgJdXSH5W1v9e81lTzQ1dFUOKyJhJvaFHd9OcLxDVPzANsLzrl6jdOJ
         blouRo3pTl2oFfaXhUdg2cPFBoFKIIfFNLXNfRmlgrqn/6ae36iq+Yv7Tzk9bOlL3XbB
         n7ZPWs2CNjuKhmL2JHu6rcaGvgcKB+o57kq6wjWWUZTQDqJJV+qdxiay/gpxXXbfT7XY
         6a3w==
X-Gm-Message-State: APjAAAXVDexlF4SUAe/KSGP2d9mcjNYs2JpUCD+UPJ6y2nTcHwa0Cpm1
        MVVqr6w2nZEICwR5/M29n1yU4g==
X-Google-Smtp-Source: APXvYqx9D1nJfDYegGAhJhC46JPrAznTHepYjXS7SfsmmNQQ3b9G4ZxdAeFyv+Vzz9MVzuc9sdCDCw==
X-Received: by 2002:a05:6000:124a:: with SMTP id j10mr23653836wrx.24.1553681082668;
        Wed, 27 Mar 2019 03:04:42 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id h131sm5657809wmh.1.2019.03.27.03.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 03:04:42 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:04:41 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/22] ethtool: support for netlink
 notifications
Message-ID: <20190327100441.GE6979@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <3578e5f334acf11b84e75d0ee41c072340a7b085.1553532199.git.mkubecek@suse.cz>
 <20190326163400.GC4958@nanopsycho.orion>
 <20190326181720.GO26076@unicorn.suse.cz>
 <20190327093843.GB6979@nanopsycho>
 <20190327095148.GE15396@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327095148.GE15396@lunn.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 27, 2019 at 10:51:48AM CET, andrew@lunn.ch wrote:
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
>Hi Jiri
>
>All other gen netlink kill the machine dead if they cannot register

Wait, what do you mean be "kill the machine dead"?

>the socket.

Example:
static int __init devlink_init(void)
{
        return genl_register_family(&devlink_nl_family);
}

