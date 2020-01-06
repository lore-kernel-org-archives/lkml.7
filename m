Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B9EC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3632520656
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="cOVWGtwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgAFImB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:42:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44378 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAFImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:42:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so9749806wrm.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 00:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M8EUuah2JQYFbZVRs4FZbIzhWD8SMtL+msO/T9weTJI=;
        b=cOVWGtwbDXYSvf0c0GX5XlAiVh+TPkIgTWgHF6Tabz3GUbi9aAt+qWys5MuUOzY1OP
         XovJm8QftmdmY7GzMtQhlpOmnoXiNnZuTOkQP6f3ogZi1KeQ0JpiKUYAHJyEA5zvCZvT
         ytT+NqePYbZk0eGryXBzDhB/luNCVNDoitk8W+QNh8DpUWKt8FK306UKWgXV7OL4xT6N
         3zjMC5v1tiFnKzH1qVP8um0np30HxiA+0xMnEfJWabnzitBa/Au5DtyU1tnQpMW4J5ZW
         cAxNdMCoEkbfWH4BH3H4IwMIYLseffge0XbsYwaptB2KwkzEBwMTIZab8l4ukezP/IEq
         5ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M8EUuah2JQYFbZVRs4FZbIzhWD8SMtL+msO/T9weTJI=;
        b=k6LbM/B7D6Bj2R6eD906TF/hOhnKbottdvozisYldm3z1WQ5YoiQKnqIMs01BDNwgk
         f2ARod2m5Mv/qgzLL7iw6+Imq8PPB5f4/JnQrrnCTvfI46n973kr79MinR6kt76ODGSX
         qKMNXBUVQqQYHYsDctHUHey9evFm2aiucPrlJR84tpsw4F1sXsr0s9Twm/QyI2Q71+Mt
         1Ocg84AF1B2Rn+VFfXB+wCKVf3wi6hLojSEjvF37bzXN6R99X41IL7A/93u58JSlwNxC
         ktF+QTryqcDABCT8Xe21e8fKLfQJ2ZiTAV4p2laZP3PVYjRSj0d+7wqZEfXRFMMwUrNP
         0lvQ==
X-Gm-Message-State: APjAAAW+3pfqVF7HGPMF2Qee2tmFAipYLAaxsUnaH2FvWFu9KniWEBRk
        WPRrcEa9pzFldV9qiU9GlpkZBw==
X-Google-Smtp-Source: APXvYqyXJ1E8kAivSw7L5PiTuqmj6FvNr+aT48bF+Uyd9IWHg2Ch1S32YoUtE1yw0rjXlM+ROZu6TA==
X-Received: by 2002:a5d:4749:: with SMTP id o9mr53851412wrs.242.1578300118793;
        Mon, 06 Jan 2020 00:41:58 -0800 (PST)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id a1sm22350876wmj.40.2020.01.06.00.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 00:41:58 -0800 (PST)
Date:   Mon, 6 Jan 2020 09:41:57 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Francois Romieu <romieu@fr.zoreil.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v2 0/3] ethtool: allow nesting of begin() and
 complete() callbacks
Message-ID: <20200106084156.GA10460@netronome.com>
References: <cover.1578292157.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1578292157.git.mkubecek@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 07:39:26AM +0100, Michal Kubecek wrote:
> The ethtool ioctl interface used to guarantee that ethtool_ops callbacks
> were always called in a block between calls to ->begin() and ->complete()
> (if these are defined) and that this whole block was executed with RTNL
> lock held:
> 
> 	rtnl_lock();
> 	ops->begin();
> 	/* other ethtool_ops calls */
> 	ops->complete();
> 	rtnl_unlock();
> 
> This prevented any nesting or crossing of the begin-complete blocks.
> However, this is no longer guaranteed even for ioctl interface as at least
> ethtool_phys_id() releases RTNL lock while waiting for a timer. With the
> introduction of netlink ethtool interface, the begin-complete pairs are
> naturally nested e.g. when a request triggers a netlink notification.
> 
> Fortunately, only minority of networking drivers implements begin() and
> complete() callbacks and most of those that do, fall into three groups:
> 
>   - wrappers for pm_runtime_get_sync() and pm_runtime_put()
>   - wrappers for clk_prepare_enable() and clk_disable_unprepare()
>   - begin() checks netif_running() (fails if false), no complete()
> 
> First two have their own refcounting, third is safe w.r.t. nesting of the
> blocks.
> 
> Only three in-tree networking drivers need an update to deal with nesting
> of begin() and complete() calls: via-velocity and epic100 perform resume
> and suspend on their own and wil6210 completely serializes the calls using
> its own mutex (which would lead to a deadlock if a request request
> triggered a netlink notification). The series addresses these problems.
> 
> changes between v1 and v2:
>   - fix inverted condition in epic100 ethtool_begin() (thanks to Andrew
>     Lunn)

Reviewed-by: Simon Horman <simon.horman@netronome.com>

