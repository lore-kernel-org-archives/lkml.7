Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC60BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AC220679
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="ebFjG3a7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKKQ4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:56:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36488 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfKKQ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:56:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so9821245pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 08:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQ+E6czJ4DNaGOkMLTz7dyfB5cXcK4wWj6bFDEgy1h0=;
        b=ebFjG3a7GurRBYEtFEzgyjSkDQrPT+h3Oeke2Fjt6QWFc1kk89q1scDl25V3vMp0Z3
         9RCiD+1QK1wu6ZSFHVD5gc4qxQ8wRwhW0jtrBlwLzEvFeOuYXX23CfnIPAwdJ6bk3lkO
         FIJS8C3imAMAgF+Q34zvN5SK9ucCPIvVramajPclRHIMIlmgq8l4oBAMcX0GlNsJI7A9
         dUgVkCehUDS/bcO9t6QuxUUIZPngPGWnIqZBbQsEkVS4WvQy6u9BS+q7hKd2chF6QPa/
         K58vsA3r9KTC9VBQHCJmtvUEMsENBGbHJIMdIT8iKdW+oa0gfgo83xuDaaypZnb5HGaX
         l3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQ+E6czJ4DNaGOkMLTz7dyfB5cXcK4wWj6bFDEgy1h0=;
        b=Chv2TUFSz4MhAHgN7G14tL4ZdekpqeO4Wkx2tfzYtWEo8G+iY3hhKhy53JMSVGxTuW
         Kd89Kxps1mP5dCUOfBXqWMN3P5/25Q9YyVJqnmjwQxcOUqnirz8Vq9Dhhwh0vXl51fSu
         9T7XiCuAYKXJAhdgtuS25nqldkR2Gww/6CaciG8FwJpePetoUv9PP9gsZKljrAfIk/Zb
         3ppU1LZ/nu/UktXxiXYJnuuJXBH7UYCniOB5xaHOPYqobkJjDlY/r7DmuLOx+6/o9xq0
         kLoUT+3CnXL8DIept6b30si+Na6sUfg09gqzv26aq9AgVPWBe7tYzMZo8TL4g4C4veHF
         /8aA==
X-Gm-Message-State: APjAAAUJLJZmi/e2nHWIUFImY+SXIlOOxTy99gtPAbAHaje3RRLlEazj
        dw1AtYkMUuR4KjCfnOUubgZbgfmctHngIw==
X-Google-Smtp-Source: APXvYqzUshE6db9IdPvXjjrLX/g9qtWYzSDysJ4A1JV3KsHmRlMG+2hrZcbvDkueZZaRowkldzfB0A==
X-Received: by 2002:a17:90a:22a6:: with SMTP id s35mr34591908pjc.3.1573491401372;
        Mon, 11 Nov 2019 08:56:41 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r5sm15009594pfh.179.2019.11.11.08.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 08:56:41 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:56:32 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Tony Lu <tonylu@linux.alibaba.com>
Cc:     davem@davemloft.net, shemminger@osdl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: remove static inline from dev_put/dev_hold
Message-ID: <20191111085632.24d88706@hermes.lan>
In-Reply-To: <20191111140502.17541-1-tonylu@linux.alibaba.com>
References: <20191111140502.17541-1-tonylu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 22:05:03 +0800
Tony Lu <tonylu@linux.alibaba.com> wrote:

> This patch removes static inline from dev_put/dev_hold in order to help
> trace the pcpu_refcnt leak of net_device.
> 
> We have sufferred this kind of issue for several times during
> manipulating NIC between different net namespaces. It prints this
> log in dmesg:
> 
>   unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> 
> However, it is hard to find out who called and leaked refcnt in time. It
> only left the crime scene but few evidence. Once leaked, it is not
> safe to fix it up on the running host. We can't trace dev_put/dev_hold
> directly, for the functions are inlined and used wildly amoung modules.
> And this issue is common, there are tens of patches fix net_device
> refcnt leak for various causes.
> 
> To trace the refcnt manipulating, this patch removes static inline from
> dev_put/dev_hold. We can use handy tools, such as eBPF with kprobe, to
> find out who holds but forgets to put refcnt. This will not be called
> frequently, so the overhead is limited.
> 
> Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>

In the past dev_hold/dev_put was in the hot path for several
operations. What is the performance implication of doing this?
