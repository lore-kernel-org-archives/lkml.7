Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42F3C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FEA2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561558704;
	bh=XI/R/c8K/SJkru/0JtHXn/ywOfZdK0nOQvsD26zDF3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bTyS3duUVJjam8KHfB7G8nG0PuEQwL87GiopoEfOhC7obTE0AatdYoZ1HsU/aMwqB
	 wWcE4GqaeVIomRXihRBB11VR+Ede5Pzxu3MXwQCEomIPUEh4xhQt78pCcdP+EXAuDO
	 I7ixnEO4p6HZ49uFL/GdwHIdPBcvqowMJ1coUoJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfFZOSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:18:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40329 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZOSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:18:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so2514253qtn.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1ZIAet+e2sWMiynqsUhY1zRa0vzq/e47+UFZozs6xZI=;
        b=vHCm+I9k+qx6J0bVrpAmyQ9GZ3GuO0un71lWtb/sPUf4qywUwlXv/rRmaioSJpcz81
         C1GjcSzLsFu8n3rj3E2bfPnFHEvqXmwBPUYOPTs3YzS09my4+imYoPXqkAZsyOECwQDR
         2deln3J3AopnhP1ukVA3u8ZSldZ4c7gTyl6mv0EFwhlwQbkVJgQhdXmDNFyrdW8rjn1V
         +wwSaWv8IZD9mhbVVUDHDxfvUjezE6CDauckswXG1iLDcjh77qUdfP3IbblVNrV09C0Q
         zBDFts+2hu4wjCttLiadMtH4kRKvwYms3dYzabvcHbi9P93+W+3i5vAOs1b/NyQt72Tq
         hYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ZIAet+e2sWMiynqsUhY1zRa0vzq/e47+UFZozs6xZI=;
        b=Ivi2kv1XeXgfWsk7dpL0jDqzeZfCq8iBUKQjZWeYPUKqA2fb5K04H/3XsTjAyFMt8S
         Rqh2DGG9KDTMhbkBvQY9gETsewXRyMK2cqFJCaxo8jNK9QQbTJiOVYwX9e0DdkD/VFrP
         kNqh7PaHmi9LBHLwIvoquoxURX9j4PfZZFw61Nyrd++8CUqZWx3/glXL4Kl7we8D8YkD
         UXeNZk2BZ8f+cJqnhb5qVvfy4hr3EO7BiofmOHckjVFEO9WIRwnOXd5u7s4G+JMkx+y9
         wJH7v1hglE/bD/7PfAo6gSrvEDW9Xi8r53Y0vv4NY2No9lCYKqShNNXNVwA5qtp8RIyd
         PJfw==
X-Gm-Message-State: APjAAAV8P2Gp3sx4VkHtZYg1VO36J5T5q2jTGXJ2+6oBxGpCXq16kcoo
        Ncvt7TB52AHLtq3eLegxRDxjm9IG
X-Google-Smtp-Source: APXvYqzF25CTsr1vks+GUfoThBCNNvt9v6wJ4tStJYXjYzJ783X2R8NWON7PMq5Tapby8mrNvW+8DQ==
X-Received: by 2002:ac8:3613:: with SMTP id m19mr3886797qtb.193.1561558701894;
        Wed, 26 Jun 2019 07:18:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::953f])
        by smtp.gmail.com with ESMTPSA id f1sm8593509qke.117.2019.06.26.07.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:18:21 -0700 (PDT)
Date:   Wed, 26 Jun 2019 07:18:19 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] workqueue: convert to raw_spinlock_t
Message-ID: <20190626141819.GV657710@devbig004.ftw2.facebook.com>
References: <20190613145027.27753-1-bigeasy@linutronix.de>
 <20190626071719.psyftqdop4ny3zxd@linutronix.de>
 <20190626134957.GT657710@devbig004.ftw2.facebook.com>
 <alpine.DEB.2.21.1906261551190.32342@nanos.tec.linutronix.de>
 <20190626140112.GU657710@devbig004.ftw2.facebook.com>
 <alpine.DEB.2.21.1906261608260.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906261608260.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jun 26, 2019 at 04:12:15PM +0200, Thomas Gleixner wrote:
> We are working hard to get the remaining pieces in and to the best of my
> knowledge there is no hard resistance against merging them.

I wonder whether it'd be useful to build some consensus around the
approach.  It'd be a lot easier for everyone involved than having the
same conversation repeatedly.  What do you think?

> What we are trying at the moment is to reduce the surface of the bulk of RT
> changes and get the 'innocent' ones in. If you feel more comfortable, then
> we can surely redo the series and pick 1,2,6 for now and keep 3-5 for the
> final submission.

Yeah, that sounds good.

Thanks.

-- 
tejun
