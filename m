Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A85ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E69C214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="QS6pxmtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfJKF4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:56:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44565 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfJKF4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:56:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so10383395wrl.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mddOv/kniAW1h65FFS1ER017AgO05a4Gs6LK6egWamM=;
        b=QS6pxmtWmP720XjrWTu2qiOFWZhrlSSkOb8XhEaBgUhLtEYaOTvlE/fp6e27AB1EdI
         DxQeRjF5QZGWhtC/XZkT3KcSGqy/xtRXAqMZkoFMDODXGf2+v805m3/mOlb+ikO63vMH
         nTdvYSQUApRvx57FjtmfPMe4OcGg2bOmicea/EDH0l/Odlwp2dTlPxcFuNM720SsH/jd
         QnaRGzba3cyYfeT1PoYclhU+CjZYDCmTLsYt845kaxK4I2SC+iTKElnFp6Gcqr6lp2Zc
         +NAQBjWNB5XOU2WRBuOroVci76wqRvtvikXni03vxe2AmTJkTyY9KcpQMxrw7x2lw0Ad
         tfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mddOv/kniAW1h65FFS1ER017AgO05a4Gs6LK6egWamM=;
        b=t26aQo9cIn4az9To/STa23A03NvfIU9AzdOaiVVPg2lhg2dLTfnTWXRGVPYqPI9Gfi
         w6N8Pt0OE3rqR8CHHwC5LNShX0ACJ4xdSIFz9iB3D8pAdpfhP1RCrAf1LyjAhB5e5KIf
         tTvLcobIajDn5zVfHRRaf4icbfNCzMaETn4JdxZ/2u5TKv2OxHC+kqGmrzs0E9HEPsnd
         GX5VqB57cNVz11QA2wJLw00XetKi+NU4YhDVGp/2vKB6U1innndN0xAD3U/N8rLy1KIY
         6d8hS9C2PsYXLT7pRYt7LJOUtgnFQIZ9mvT7J22iIbNKZ1MnmLAngHAYKdapyLY/JKZK
         kpBQ==
X-Gm-Message-State: APjAAAUAv4xOQc4sFP+qTu+5KkjYLTWJQGdNV9AAhofXHIdM0f6iD+4o
        G+MuPRbbPFbljPs+II0YWJ6k8A==
X-Google-Smtp-Source: APXvYqyw8JXPeToMHbhUF/ZzWijmw1b+DbRa9QJcpT00z2ZZ/fTT8SZCawKp6bX+U/8ROQ7THIHGcw==
X-Received: by 2002:a5d:55ca:: with SMTP id i10mr2880932wrw.12.1570773380351;
        Thu, 10 Oct 2019 22:56:20 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id n26sm5815692wmd.42.2019.10.10.22.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 22:56:19 -0700 (PDT)
Date:   Fri, 11 Oct 2019 07:56:19 +0200
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
Subject: Re: [PATCH net-next v7 13/17] ethtool: add standard notification
 handler
Message-ID: <20191011055619.GC2901@nanopsycho>
References: <cover.1570654310.git.mkubecek@suse.cz>
 <ac2fef494116db9d4679f4501f1be6a7898ef724.1570654310.git.mkubecek@suse.cz>
 <20191010152559.GA2994@nanopsycho>
 <20191010181743.GF22163@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010181743.GF22163@unicorn.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Oct 10, 2019 at 08:17:43PM CEST, mkubecek@suse.cz wrote:
>On Thu, Oct 10, 2019 at 05:25:59PM +0200, Jiri Pirko wrote:
>> Wed, Oct 09, 2019 at 10:59:40PM CEST, mkubecek@suse.cz wrote:

[...]


>> >+
>> >+/* generic notification handler */
>> >+static void ethnl_std_notify(struct net_device *dev, unsigned int cmd,
>> 
>> Better "common" comparing to "standard", I believe.
>
>That's similar to ethnl_std_parse(), the idea is that this is the
>standard handler for notifications which are triggered without
>additional data and the message is the same as reply to corresponding
>"GET" request (which is generated by the standard ethnl_get_doit()
>handler). Notifications for actions and notifications for SET commands
>which cannot be generated this standard way will have to use their own
>(nonstandard) handler.

So "default"? The "standard" sounds rather weird to me. It isn't any
"standard" :)
