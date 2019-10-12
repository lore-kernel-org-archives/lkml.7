Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AF6C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FE32067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="VBs+QBoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfJLWcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:32:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36166 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfJLWcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:32:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23so7859795pgk.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=EUytYsgismnGdLjrYT1f0D/ivlcB+VQ8GRyrP/oYfX8=;
        b=VBs+QBoVHJCnP5YQqA8mNk1nKouTo1snowQoHzOd1ZorebOzDaje0mcjZNemM9Oy9W
         avsbJPGLxOIZIJq7gtHlkv/c1E9VUV7XXZPQZ/76Nt3ATijiguEpuIERlb2yw4a+6AuE
         C5E9PYji+e67bpXWCgnFAifbEemiShfNMLyv0Hugcp8tRNh2Ih7x4Fa4uChKgaSbReoT
         4E0z17sWgGQPlh6RERptdtr9FHZgEolPD6nNkFJt0xcwc8tym6J0GpQMKR/ZssX7ipKq
         npB9e/vnZ9VxEzoBKpr2P23jKUvXU4ldADZJgJ4Uh7xfH+No7pn/1ED0hCgd4Mom0hVk
         jKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EUytYsgismnGdLjrYT1f0D/ivlcB+VQ8GRyrP/oYfX8=;
        b=eukeYcPWuAtOHKrdsFcMhWYGbAu7AmI7/hRwffvuMlfDQ4M52Yxr8M5uknG2Gh1JD8
         z+eSl0Lyu+vPze9DiELGiPDqPhUqA2G4TOBJQQ/YPdyed+kQxEUDzjgBLfw5KA8eZcyH
         sKKEhXGKjoC1cuPUeNfwn1p8PIVcq4YeholxkRHjWc7hueF8k02/sjfwAz5ipU0FDxrs
         O4U4rpOWgcGH3cwhJ62YeuZ/BlSTRfVOcDBSkgbaIL9UOuI9g/Vv5WEeV8kqPNXtpLGx
         RbAwJSN96G8TZqSs1RReGw+bE9xwVe2hC/GkNqklIhdzq6/ux6QhxdjWotVxj92dTEfn
         yq1g==
X-Gm-Message-State: APjAAAVXVQfbPWRcccoZFnk9hr/eOLUQvvl1U3VCCmpM6jKA+xDTXlzj
        ZJWHyRRZrTiznJqgbHbaDs8HEg==
X-Google-Smtp-Source: APXvYqzwerfAMCLkzfc6iw/hQmNINLGN5bzPoTAZm4z5/mB1dyyOaS8uYz7N4ku1A1iKIynFmulEig==
X-Received: by 2002:a17:90a:1617:: with SMTP id n23mr26521029pja.75.1570919519713;
        Sat, 12 Oct 2019 15:31:59 -0700 (PDT)
Received: from cakuba.netronome.com ([2601:646:8e00:e18::2])
        by smtp.gmail.com with ESMTPSA id v28sm17346964pgn.17.2019.10.12.15.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 15:31:59 -0700 (PDT)
Date:   Sat, 12 Oct 2019 15:31:56 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH] netdevsim: Fix error handling in nsim_fib_init and
 nsim_fib_exit
Message-ID: <20191012153156.01d962f1@cakuba.netronome.com>
In-Reply-To: <20191011094653.18796-1-yuehaibing@huawei.com>
References: <20191011094653.18796-1-yuehaibing@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019 17:46:53 +0800, YueHaibing wrote:
> In nsim_fib_init(), if register_fib_notifier failed, nsim_fib_net_ops
> should be unregistered before return.
> 
> In nsim_fib_exit(), unregister_fib_notifier should be called before
> nsim_fib_net_ops be unregistered, otherwise may cause use-after-free:
> 
> BUG: KASAN: use-after-free in nsim_fib_event_nb+0x342/0x570 [netdevsim]
> Read of size 8 at addr ffff8881daaf4388 by task kworker/0:3/3499
> 

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 59c84b9fcf42 ("netdevsim: Restore per-network namespace accounting for fib entries")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
