Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0DEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07A12082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="wYsxDLGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfC1Qen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:34:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38516 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1Qem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:34:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so4821977wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qnDY+KKSr1g56H3QWG5hSclqlBLCH0+HQaNyEn6CAKc=;
        b=wYsxDLGlEXZJO89rd4bdugUO9ysox2UiTlWUA5FsVO2T6vs1TkAfzvhiAaAoLWfdty
         2nt1TRTPNoX7CuhOt6uLONKp4leOGWQFp8tDqgPtslxmXThyHhsbNgUSb7Dt85rxwaV5
         FaVWAFyW9vNvnJACYT3uqMFoAMqZW3V8cXPBnHB81EMaAvxgKn3exABfkzhgbtjUlGiT
         uHiPNA3dVJHOkQSPiSDr4RP8Pja80l9vy5OSEYe2Z9rO84EruwF+DEFGUdRMN5V931qk
         avWoB8DXlKVH7LniLv0nVCqHUDyMwM9vVggdYwCmSYpT8nCan5QJ3qIE9lLieugB5sxZ
         i7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qnDY+KKSr1g56H3QWG5hSclqlBLCH0+HQaNyEn6CAKc=;
        b=mo+a68v2sze+8mlyq2cJ4pZuFXKN5yioTSyhjryLfZRoJ+niil9oRZtZU1sdjI4wYI
         l47lePNiz3H3yRS0xSjEBNvG56Yh9fDpAhpmcvWREs67xSz5l3iVJSQopFQpLdS7ZJpo
         +RNC6qffYfHL6t6kPsV18qjQ+h4ZLHPGOLFep/Onl+UHaGqQW9xuPJPxCL4nl/2n/oKT
         GQzfm6fV0Mb/UlCnlmI84SqB79DnMQ5Aq2ZWECoMA6fl6cPuHsr/eKKtvJ+b9/iFZ2bX
         maDLeIE7616Dgko4sY4E+8r7a0NrK9zbymSNtm0T5GkNRd56FWE3P6kcHrmbYg4hPoIf
         xGiA==
X-Gm-Message-State: APjAAAWEmhxlHBtnzq9GZz6eROAQvUrkmxehJVYc9TWZElbMS+UigUQk
        EoaO8fjesZej9cuMdBizC8QyAg==
X-Google-Smtp-Source: APXvYqxVY2x8Zkn/4Rwq2WDEGSVM3X14G76lRkukw9hYSsAAg92uwMYBwin7uC3+cOYyqeaBuIl/SA==
X-Received: by 2002:a1c:f10f:: with SMTP id p15mr579684wmh.27.1553790880972;
        Thu, 28 Mar 2019 09:34:40 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id z10sm2729303wmi.15.2019.03.28.09.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 09:34:40 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:34:39 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 13/22] ethtool: provide driver/device
 information in GET_INFO request
Message-ID: <20190328163439.GP14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <b7aea4b2642b2fe6f12cfb843a03154f584f3bf6.1553532199.git.mkubecek@suse.cz>
 <20190327201411.GH14297@nanopsycho>
 <20190327222554.GV26076@unicorn.suse.cz>
 <20190328092126.GL14297@nanopsycho>
 <20190328095347.GB26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328095347.GB26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Mar 28, 2019 at 10:53:47AM CET, mkubecek@suse.cz wrote:
>On Thu, Mar 28, 2019 at 10:21:26AM +0100, Jiri Pirko wrote:
>> Wed, Mar 27, 2019 at 11:25:54PM CET, mkubecek@suse.cz wrote:
>> >
>> >I'm all for implementing new features which are are related to physical
>> >device (ASIC) rather than network interface only in devlink (at the
>> >level of kernel-userspace interface). But for features already provided
>> >by ethtool (userspace utility) I can't help seeing the state of devlink
>> >support in NIC drivers as a serious blocker.
>> 
>> What I'm thinking about at for some time now would be en explicit
>> default devlink and devlink_port registration for every netdev for
>> drivers that does not support devlink themselves. I need to think about
>> it more, but it seems doable. Then we can hang appropriate things there
>> and make the ethtoolnl/devlink separation clear. I believe we need to do
>> it.
>
>That sounds great, such "generic devlink" implementation would be a way
>around. Kernel could then emulate features which are not implemented by
>an actual devlink handler (i.e. "generic devlink" is used or particular
>handler is missing) by falling back to ethtool_ops handler so that
>userspace could rely on devlink API for things like device information,
>various dumps, flashing etc. without losing anything.

Yep. Plan to do that next week.

>
>Michal
