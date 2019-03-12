Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422DDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111CE2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrD/pzQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCLDZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:25:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37086 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfCLDZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:25:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id q206so721621pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 20:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=97IIXVxr0JRnVLVvGGNhouGmo2ox10byIzwCAWGZzF8=;
        b=xrD/pzQTDVgul0ad5KmZlrdv4O1EWXZpzqTOR7oyrv9pNrkRk/whAhUGHOL5TLxGGP
         9RQDU971YYwahTwRLrhg4REXS70ZuaIssuUfaqEfo0HTSf4fIby3YTRDhM5Ui3KMzgjF
         zW2uQHIR/5nIDlroFi9A6Fn+JS6TGo4sptDtB/2hWaUgqPMy3i06CdiOEeQ4jlNczl+z
         lJzDg7lKtI7+7fT+ARkPubULMfleWT6ej5AggfOphBxc9lkiwaJy6FC25fXdGjMrtnXx
         bu90NmwLrtG3V2SA4teEGS/0H7Fy2N4hVC+r+sdtAXpyPY8j913NHwrJQXZbEyZ/J3Kt
         3zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=97IIXVxr0JRnVLVvGGNhouGmo2ox10byIzwCAWGZzF8=;
        b=F14puTa76L8uBZ1ubFaG+3Lvft87EEO70TpxUhLm8fFd/8PrZhEpaULkbhO0AGtsIz
         dlWIZLsiTDjsOVnieIQdyjJrcmnJtZQrt9td4oknM8mK0AOOTKZZ7HMK3/TgeylrEabj
         eq470tMfLRDvrcDVZeCvzjZcIjRz9UicTjxFSNb5/Z0OCjrtl9Ug9WHO3NbMPJsCkWkn
         wjVzu+1nic1eU5E/QDx7cUnFGes5kZ56zrYHCGdeOndDC8CjMyA7hQRkNotfnflLQP9G
         IT38yxLOg4w92NxuUmY38p2m8eCmiu4kVSlsD3knsqQZACS5t2c/wOWe5/MA8dwVvwXD
         ux7w==
X-Gm-Message-State: APjAAAX8ngD7uFG+KYQ+AuYSGKfFW1F913hUp8LoqgsDyliUAEnCQ2EP
        I8MlUFqyyg6jDTAIRn3i2aCwA5UTv4M=
X-Google-Smtp-Source: APXvYqzNwamPaXIwOAG/0tHKWKu4hFT9rcET3CmQgSoXNTl5taiUxn+Pxb9RY3jWvLm632eczBhE+Q==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61mr37947350plb.158.1552361119475;
        Mon, 11 Mar 2019 20:25:19 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id n6sm9493616pgh.79.2019.03.11.20.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 20:25:18 -0700 (PDT)
Date:   Tue, 12 Mar 2019 08:55:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM / wakeup: Drop wakeup_source_drop()
Message-ID: <20190312032516.dme2wea6zt3v7eiu@vireshk-i7>
References: <2820276.PxaWYKrF8K@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2820276.PxaWYKrF8K@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-19, 12:53, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit d856f39ac1cc ("PM / wakeup: Rework wakeup source timer
> cancellation") wakeup_source_drop() is a trivial wrapper around
> __pm_relax() and it has no users except for wakeup_source_destroy()
> and wakeup_source_trash() which also has no users, so drop it along
> with the latter and make wakeup_source_destroy() call __pm_relax()
> directly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Commit d856f39ac1cc is in the bleeding-edge branch of the linux-pm.git tree.
> 
> ---
>  drivers/base/power/wakeup.c |   18 +-----------------
>  include/linux/pm_wakeup.h   |    9 ---------
>  2 files changed, 1 insertion(+), 26 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
