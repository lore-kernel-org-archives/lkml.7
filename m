Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3F9C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9A821916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="teUYffsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfCUQbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:31:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51389 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfCUQbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:31:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so2926866wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2sRA47FZKpicovMeDkeJXEQstEcAFgdARs7Q921qnf4=;
        b=teUYffsK5Z1tSPtQr2DXXJtXg+ZM5hmanWEofPQ1nr3qob5up8VPsrLtXAqgoNUdi5
         e9GxcoIE0ENx1VlLCnYnQa03mXTkgRxiQjH4cRO8z27GKQ/XlOPk06pV9hnou1ZdKchD
         8EX20VCxlCotMZWDk0ziBOEIZhczuCiV+CXYZ2sonq8mJvyE23o8rOMDpLGaonjz7YSg
         tHO9vrYC/Z/7HqanF2EaypuD+eX9iQ5liB7q60PnT4BeyyooUxJBNpSGna5UWI4Os4Dc
         IUu6O1zhBElEtCythGbcK9VOoCy6lE0WgvDxl5loVo2g7rF9d0cdWshkcTFOW+mVtz7B
         kLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2sRA47FZKpicovMeDkeJXEQstEcAFgdARs7Q921qnf4=;
        b=Q/ukulwQSLRGuT4jjN/wMdu+qYekPJL6deRIZsoU0lntZyQEOyPsnlVGmheYCI19Ci
         BZd3Zf0nUAUxluhdZHFkaxJUQ9+HrmsMStkd8f7VMddyVoQeKusY3Y4f1o/O9D8bA1PP
         MrXB1ZJx9iYKW1EHqY21XDKNGbHe0dcNpq/T7eW3ST763XdfnA7Ac6n5LgMM38FZ6vfC
         xz8T+0Edps10B/AYOczfVb3uc7mK27XW9/3jwqq8P/Vpspm0qvZp6eG0pGB//yGg0Jy3
         FQ6Fojsl6bmcNaMe3wh+8iu9st6p6W1Z8VtV+XW8OaAHh3/U56+V90Sj4t/q1YyX52dS
         jTwA==
X-Gm-Message-State: APjAAAU+rtwJS59VDrSQuF9zyh5S4GwgTFYx1uMiXPG8DvN84y+DHx8W
        2YGt34V1d5znDJr963prYYCSsg==
X-Google-Smtp-Source: APXvYqzHRAisPl1kR2+oARcXv9foHKeMIn70fmlHiKYNRhqbSzVV2f4rqv/sPBzdWnhxsk0Dp3riAg==
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr110212wml.50.1553185905860;
        Thu, 21 Mar 2019 09:31:45 -0700 (PDT)
Received: from localhost ([195.39.71.253])
        by smtp.gmail.com with ESMTPSA id 3sm7594392wrk.68.2019.03.21.09.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 09:31:45 -0700 (PDT)
Date:   Thu, 21 Mar 2019 17:21:06 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 05/22] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190321162105.GU2087@nanopsycho>
References: <cover.1553170807.git.mkubecek@suse.cz>
 <a5a50f3d60cee03f75b70fdf17e73a6212aaec3d.1553170807.git.mkubecek@suse.cz>
 <20190321135705.GB17655@lunn.ch>
 <20190321141343.GH29968@unicorn.suse.cz>
 <20190321152509.GB23408@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321152509.GB23408@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Mar 21, 2019 at 04:25:09PM CET, andrew@lunn.ch wrote:
>On Thu, Mar 21, 2019 at 03:13:43PM +0100, Michal Kubecek wrote:
>> On Thu, Mar 21, 2019 at 02:57:05PM +0100, Andrew Lunn wrote:
>> > On Thu, Mar 21, 2019 at 02:07:35PM +0100, Michal Kubecek wrote:
>> > > +static int __init ethnl_init(void)
>> > > +{
>> > > +	int ret;
>> > > +
>> > > +	ret = genl_register_family(&ethtool_genl_family);
>> > > +	if (ret < 0)
>> > > +		panic("ethtool: could not register genetlink family\n");
>> > 
>> > Panic seems a bit strong. Do we really want to kill the box because
>> > this fails?
>> 
>> When I switched CONFIG_ETHTOOL_NETLINK from tristate to bool, I checked
>> some other non-modular subsystems to see what they do on failed
>> initialization and each of them did handle it by panic() so I didn't
>> think about it too much and did the same.
>> 
>> Thinking about it now, if the family registration fails, the only entry
>> point to care about should be ethtool_notify() (I'll have to check more
>> carefully to be sure) so that adding a check there should be sufficient
>> to let everything work (except for the netlink interface, of course).
>
>Hi Michal
>
>So maybe do a WARN_ON() and return the error code.

+1

>
>Linus has been quite vocal about killing the box when there is no real
>need...
>
>	Andrew
