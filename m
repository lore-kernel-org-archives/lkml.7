Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD40C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163AA2190A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQm+y3u5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfCWOco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:32:44 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:43107 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCWOco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:32:44 -0400
Received: by mail-wr1-f47.google.com with SMTP id d17so5304331wre.10;
        Sat, 23 Mar 2019 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YSepjeNEvD+obZ9CWZYM8RsH7hPqMxG/I24yXtQTSQA=;
        b=RQm+y3u5JwBfCTK6EEV2mHBi0ZWTW5NiXZUF91HbJT1bj/5kimCxhJvCvILo8W4Ejl
         dw+rLvYSk+bwN9vyGe1V5huxVrwqcEtuBhPZJx/VCOYgn9YX8lSZB1iydhP2G4E9aTCF
         9ue7yzThvTB2ziGt8+BUwix6GHDh8+y06UbYhD3eFlsxLE1D9HhY8k9zTRdVhIk5opN8
         8zh3mg3JynUTU+dRs3D7FtlO2XgNspL/vfhY3PuoXySe5aDQkDwWVMsntl18xVgYVOy8
         KqQyWSRbKa2ntFuRvMMYapeaHANqyy9l1lclACtMYuu67PMFns0CNNeiTjPgRxN6agHq
         xCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YSepjeNEvD+obZ9CWZYM8RsH7hPqMxG/I24yXtQTSQA=;
        b=HkrI4o5tfILerIqtm8lwkvtUw+ClvYFxIQQ09vsl3SvnFLPVjR+JTxBuCUGHo2x4gf
         oNAWR/zLoFuL9YdD7tSz7lITbY3uq6xmfOFdBayJEgGSt7dfXOE2qV84wik2PWPNGNFl
         Ys3KZL0Or0r85COUOPS98mCdgk/3gKD7GN/rGlGbqoZtJP99S91dssE5QT66Kajg9C38
         Ducjapn6tUZ49LQ4z2AL+oKLH+O0m/Mhnf2mTXywLnduLrAugxKCgQVxa2D8LhLAZW0v
         Xh1QHi4Tf1AXvapSsFp+FCC2V0Sk1NCz+1rhEVqfl3IHs9Rxhpp6Kfd2TStxOzEz3wBO
         g7bA==
X-Gm-Message-State: APjAAAV0qFodX7ViKGykzhMytWWn8NltOC/PQclCea96LLcuffxHk6PC
        X5wUBLKHVAK4yHHjVafI+Eo=
X-Google-Smtp-Source: APXvYqwe8RpCazPRECJUY3tqV6bYBsZG3pMueGt2KvEOlXyWckvtHPn4hd+HI6SYzBdkp5uWhcxpzQ==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr9779196wrl.26.1553351562173;
        Sat, 23 Mar 2019 07:32:42 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bc4:dc00:49b3:4cd3:4cd9:effe? (p200300EA8BC4DC0049B34CD34CD9EFFE.dip0.t-ipconnect.de. [2003:ea:8bc4:dc00:49b3:4cd3:4cd9:effe])
        by smtp.googlemail.com with ESMTPSA id n13sm14440107wrw.67.2019.03.23.07.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 07:32:41 -0700 (PDT)
Subject: Re: New ethtool sub-feature and ethtool-netlink
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     John Linville <linville@tuxdriver.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <4ecd48b3-92d6-38a1-11db-5c7b6a0ae341@gmail.com>
 <20190322073807.GL29968@unicorn.suse.cz>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <da5508a4-d2a0-4e9a-974d-f6808ae8da1e@gmail.com>
Date:   Sat, 23 Mar 2019 15:32:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190322073807.GL29968@unicorn.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.2019 08:38, Michal Kubecek wrote:
> On Thu, Mar 21, 2019 at 10:23:36PM +0100, Heiner Kallweit wrote:
>> I have an ethtool extension in the pipe that adds one more PHY tunable
>> sub-feature (for Fast Link Down support). Are smaller extensions still
>> ok for ethtool,
> 
> Adding a new PHY tunable is IMHO minor change which doesn't need to wait
> for the netlink interface. It's a bit more complicated due to the way
> tunables (and PHY tunables) are implemented in ioctl API (which requires
> both sides to have a list of tunables and their interpretation) but that
> is one of the things I would like to change. :-)
> 
> After all, I don't have support for (PHY) tunables in the netlink API
> yet (not even in the part which hasn't been submitted yet).
> 
Thanks a lot, good to know. I think I can submit the new PHY tunable
next week.

>> or IOW: When do you think is ethtool-netlink going to be stable enough
>> so that other developers can add features?
> 
> I would say that once it reaches mainline and userspace starts to use
> it, it will have to be stable (due to "Linus' first commandment"). When
> that is going to be, that depends on how the review is going, it's hard
> to guess.
> 
> Michal
> 
Heiner
