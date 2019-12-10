Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076B2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7FB20836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="L2E5nPko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfLJO1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:27:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45946 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfLJO1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:27:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so20292422wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 06:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W5IUf7nsGsbe8tjOIPGAbRfLSF1koHZCPW1tiAPp8KQ=;
        b=L2E5nPkojADtCwJoOc2zngiVfEFaOKerMJDA+dP8i3AACTrFfXIMrkbZ9lYGWVu9sV
         D2erbLhpXuzHVInZHHR8xNKZ/SM9Kp8u0zdDN8Dlt+Sj0C4Sa7S0/keaBfvgNCDUEXo8
         h5kebBQIiPHTu3yDYxD7ieCguFvT34pbVQXmbMVMuWJpPfTAM5RiAru/6vv47X8TyUXd
         Vs3IusyQUM204x2b1Y58btUqzfGzL2KEgImhUKTVNeggWhnICXA0Aq69dkdgr6qLJ31M
         MLm1/iZMet/4Jam1bbyZ2eZOWDvTuC4v3/jP+cvta2HH5p+QG20t2PqOlYBlqb8ASitt
         cqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W5IUf7nsGsbe8tjOIPGAbRfLSF1koHZCPW1tiAPp8KQ=;
        b=b6oN/uxWzDdwk/WRPnDdxXxbL/ccktGtRf+9fWuIcCpDR7Fl33qTFMzBGx6QTDPq9v
         wMyah/1v9Fb/X5skNxfXOhVVKpMOjlEDZ9Mb4qyUaQ4pa1nOOXkw/6R15XK3YsgJDxvQ
         uWgOM1A9TW5lCnWiA1VBvafcvlLowbU368Y9xhCzzvDnV3/lqJEbhNe9Aw+86hyVg0hk
         Jb+dIhQjXhXvuFdD59/vNFhm3UYx+X8XJCbjyc/lxvHxXR5VVX2ltwXNSvAWEIeAweo+
         u5Yt31L3Eg8p/uC2GaA7GHVmGeBBNN0JXZMpIBm9Ta/eT0vlh7wZV7Y+Kzq58iRzKZt6
         gtow==
X-Gm-Message-State: APjAAAVFS9HR7+D/HjerNvuu5hagCqdEeZCMtVgk7aZRjrPSHPwlMbGZ
        TMII8ztYD1NduMkMZUSnnp8kJQ==
X-Google-Smtp-Source: APXvYqyUBijfm2TzBx1LeB2u6bQBew7o/j0N0PGJZC176s95+fAfBOddZN/O46L6Umk0VstiaF22Fg==
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr3564701wrs.200.1575988070777;
        Tue, 10 Dec 2019 06:27:50 -0800 (PST)
Received: from localhost (ip-94-113-220-172.net.upcbroadband.cz. [94.113.220.172])
        by smtp.gmail.com with ESMTPSA id m10sm3468304wrx.19.2019.12.10.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:27:50 -0800 (PST)
Date:   Tue, 10 Dec 2019 15:27:49 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] ethtool: provide link mode names as a
 string set
Message-ID: <20191210142749.GA7075@nanopsycho>
References: <cover.1575982069.git.mkubecek@suse.cz>
 <fe689865e1e8cda85dd0ca259c820c473bd9576c.1575982069.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe689865e1e8cda85dd0ca259c820c473bd9576c.1575982069.git.mkubecek@suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Dec 10, 2019 at 02:08:13PM CET, mkubecek@suse.cz wrote:
>Unlike e.g. netdev features, the ethtool ioctl interface requires link mode
>table to be in sync between kernel and userspace for userspace to be able
>to display and set all link modes supported by kernel. The way arbitrary
>length bitsets are implemented in netlink interface, this will be no longer
>needed.
>
>To allow userspace to access all link modes running kernel supports, add
>table of ethernet link mode names and make it available as a string set to
>userspace GET_STRSET requests. Add build time check to make sure names
>are defined for all modes declared in enum ethtool_link_mode_bit_indices.
>
>Once the string set is available, make it also accessible via ioctl.
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Jiri Pirko <jiri@mellanox.com>
