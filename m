Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B96C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E2B2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="pAZeSA1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfC1JQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:16:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53585 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfC1JQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:16:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so2754023wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 02:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v1grggD9u2yEqsWSLXtCgGTahPBespcKhxcYv5lPQqo=;
        b=pAZeSA1mbvpuQ5ivzQdMhQ8y3ZIM5KCyxyiA2Yogn+FsLKbuay/Khbk22yPRCvroE0
         yyTfK71MfAs3fqiX0G1OvuCOvWLX5xKT29CSropNAUUCriC87AAO1F5j/iiQf+u+HwJT
         QM3bRU0ou2VyVo4X6MgdeX5n+bb0A9fvc9WDkCcRaxcs7giiPnncj57IKc4ZqLQoY76G
         +xDY8+XhY0D2A1lla7kUUZn4gF6JnHUAtLUChKC3LSAkzfON5NXcWTKzER+mTn1WOOEb
         A/9+0P/KgCKXBMxZRixtOZ9VxihQSDQKji6uFaEv+xdJ4s1vH5VimFtea89wQL9FveDF
         SzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v1grggD9u2yEqsWSLXtCgGTahPBespcKhxcYv5lPQqo=;
        b=oOImrTmSM76TsdHbF0hmST2oO639LD3b+mOOkQvFhkQJw/NC1pe4Fhroz7Sn9N0gr4
         CdXc/MepyPed1KkHXHfu7od7drkdHi7H2JQ6raHNDSUDf9vGGmJ55Fs+zTrgQmTIuK62
         q1AvCLviijsLXEdpkjOkCdllcqF7JnzeiqaU95s/yIpffwo+JdPhYb8Xl21lpvOsHxO0
         QpgJAXNVv7Jctn3k8NpKTXMDCTsJiv1s9HKtUyuAZ5ph8RzidyAtK0Se6qwp3KouNE6r
         uTg6yvKXdDYWeFGignnA0DG+kOTM1uU2zqs0EcwvNPCAjwbTl+88a1+RjAi3wRFuXc9+
         Napw==
X-Gm-Message-State: APjAAAW2IyMWothxcTyp872qbvqVg5JZ1fmCzy5Th6Mnh2dPStGz6Gvy
        w7DroPb1zicedA8tQw6xff/kPNCLokQ=
X-Google-Smtp-Source: APXvYqymN9UpxcT5sCs6ChCoXj8bYI9KTwonuIq0Wds2CD+3j1kPshbzrHDTnU4te/gc9THK7sLC/A==
X-Received: by 2002:a1c:40d6:: with SMTP id n205mr15183834wma.140.1553764600402;
        Thu, 28 Mar 2019 02:16:40 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id q19sm1908884wmq.23.2019.03.28.02.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 02:16:39 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:16:39 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/22] ethtool: implement EVENT notifications
Message-ID: <20190328091639.GK14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <971a93b567c81103716902cd1ad00946201f9710.1553532199.git.mkubecek@suse.cz>
 <20190327130428.GB14297@nanopsycho>
 <20190327141443.GS26076@unicorn.suse.cz>
 <a3d94fdf-964a-5a2c-3d96-74a0323af37e@gmail.com>
 <20190328064143.GX26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328064143.GX26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Mar 28, 2019 at 07:41:43AM CET, mkubecek@suse.cz wrote:
>On Wed, Mar 27, 2019 at 07:14:43PM -0700, Florian Fainelli wrote:
>> 
>> 
>> On 3/27/2019 7:14 AM, Michal Kubecek wrote:
>> > On Wed, Mar 27, 2019 at 02:04:28PM +0100, Jiri Pirko wrote:
>> >> Mon, Mar 25, 2019 at 06:08:21PM CET, mkubecek@suse.cz wrote:
>> >>> Three types of netlink notifications are introduced:
>> >>>
>> >>>  - ETHA_EVENT_NEWDEV to notify about newly registered network devices
>> >>>  - ETHA_EVENT_DELDEV to notify about unregistered network devices
>> >>>  - ETHA_EVENT_RENAMEDEV to notify about renamed network device
>> >>>
>> >>> The notifications are triggered by NETDEV_REGISTER, NETDEV_UNREGISTER and
>> >>> NETDEV_CHANGENAME notifiers.
>> >>>
>> >>> These notifications are intended for applications and daemons monitoring
>> >>> ethtool events to allow updating the list of existing devices without
>> >>> having to open another socket for rtnetlink.
>> >>
>> >> Wait. You duplicate events that are already going out through RTNETLINK.
>> >> App should open RTNETLINK in order to get those. Other apps are doing
>> >> that too. I don't think that duplications like this are desirable :/
>> > 
>> > Is there a way to filter or at least recognize these events when using
>> > rtnetlink? I couldn't find any. The only way seems to be getting every
>> > RTM_NEWLINK message (there can be quite a lot of those), always perform
>> > the lookup in my device list and recognize what happened - only to
>> > almost always find that nothing interesting. It is possible, sure, but
>> > I would really like to avoid it.
>> 
>> I am afraid you are right about this, would adding a filtering
>> capability specifically for this in rtnetlink be a better route?
>
>Maybe we could add new IFLA_EVENT_* values and use IFLA_EVENT to mark
>RTM_NEWLINK messages announcing "new device" and "device rename". That
>way, monitoring application would still need to parse all RTM_NEWLINK
>messages but it would be able to recognize which announce a change in
>device list without a lookup in its structures.

Hmm, that sounds good.

>
>Michal
