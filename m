Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AC0C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E50C2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LMu9XN7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389921AbfKEPnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:43:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54012 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbfKEPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:43:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id x4so10356551wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ws7Hi7hEPlrtiokvvL54ucIv+PnQC8Xef+cIaeLnl+Y=;
        b=LMu9XN7uvY5qrZDnV8kRjWDJ537EgUXUoDl579SrxOZJaFeLE96BI6nl4KBh2eDSZO
         nhAY+G32tR/D9wPOVWENEBxcPbtmLLiM0v4Lig3OHLZsp5loSG0l1mOIeYgVnzMoTTyA
         9cY32QkuSX7sYyWCH9yhBl3RDeL7YBwlga7ZelJGJqLvI0cg0xc4/GNPkU5kmil8oqym
         9UbQmpACO1EGBkDCphF4+eE+Hrut7ktbSaWtM3ZOJdChZfnJFOfjJiHC/h7nBFB4OvRl
         j5Ns+zeLWcS8Xr5NUCO6WXh5b87zqda3+t0Aau69yevRzynlpd46D5b41KSP9P0P0dOa
         6zOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ws7Hi7hEPlrtiokvvL54ucIv+PnQC8Xef+cIaeLnl+Y=;
        b=D9v7iohdfL2eRVH4z5Cg7V/GGMYTPISRwcKu3R/m+H1VvxOypqMogZgour/mLqXq9c
         P3+F/rRxdsWweNlXb7BQCrHIA/GtWo35vuX8VNsxsJmKw6wFKzuZKtt8qFSVzxlDDrS6
         dmknI/pdq2d9/ZdusvTftb+R7k/1QtujOeM2hWWb7vu3qCe4mpqCabWu3echnNKf/CAm
         klwuzGzXrChhnE8DGSnuGMpWdgzO2RA3qLhGNsrvEuWTGGLGouCnsBJ/I9PbBeTa00UB
         UOqICN9ejBvWpQ4Z7+nvh8/uE9bG/mOu435isHn3q7qa9unHOdLt6KIB7FOeFJITMOJq
         8V2w==
X-Gm-Message-State: APjAAAX3X5qePC75K856Jz9NS21t27+8XCYTECD0BedN76jgFCOCpnH/
        UyP/xgoSXOjPOR66GPEhUaxCUQ==
X-Google-Smtp-Source: APXvYqwPrOKJKAkYFi5aRMX3c4L/ngOPawbJ7a9faj+zYf8ZzV9Ec/nDj5KLBClvVV5TxxkBo4YuuQ==
X-Received: by 2002:a1c:2e8f:: with SMTP id u137mr4888123wmu.105.1572968599564;
        Tue, 05 Nov 2019 07:43:19 -0800 (PST)
Received: from ?IPv6:2a01:e35:8b63:dc30:f096:9925:304a:fd2a? ([2a01:e35:8b63:dc30:f096:9925:304a:fd2a])
        by smtp.gmail.com with ESMTPSA id b3sm13269134wmj.44.2019.11.05.07.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:43:18 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH 3/5] rtnetlink: allow RTM_NEWLINK to act upon interfaces
 in arbitrary namespaces
To:     Jonas Bonn <jonas@norrbonn.se>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net
References: <20191105081112.16656-1-jonas@norrbonn.se>
 <20191105081112.16656-4-jonas@norrbonn.se>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <f479405c-9372-68fb-762e-519f3bfdd333@6wind.com>
Date:   Tue, 5 Nov 2019 16:43:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105081112.16656-4-jonas@norrbonn.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 05/11/2019 à 09:11, Jonas Bonn a écrit :
> RTM_NEWLINK can be used mostly interchangeably with RTM_SETLINK for
> modifying device configuration.  As such, this method requires the same
> logic as RTM_SETLINK for finding the device to act on.
> 
> With this patch, the IFLA_TARGET_NETNSID selects the namespace in which
> to search for the interface to act upon.  This allows, for example, to
> set the namespace of an interface outside the current namespace by
> selecting it with the (IFLA_TARGET_NETNSID,ifi->ifi_index) pair and
> specifying the namespace with one of IFLA_NET_NS_[PID|FD].
> 
> Since rtnl_newlink branches off into do_setlink, we need to provide the
> same backwards compatibility check as we do for RTM_SETLINK:  if the
> device is not found in the namespace given by IFLA_TARGET_NETNSID then
> we search for it in the current namespace.  If found there, it's
> namespace will be changed, as before.
> 
> Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
