Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148D6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35A921900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYggKp+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbfDXP7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:59:17 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:42539 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbfDXP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:59:16 -0400
Received: by mail-pl1-f175.google.com with SMTP id x15so5143418pln.9;
        Wed, 24 Apr 2019 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=F0crqVS1oQC1PHQ4v5nc+AZXy84JZ83AYdQBJxSNry8=;
        b=nYggKp+xyUFCdNbyIPRx8gntoJ1SsSkN/Qmsq/d3QD/7DzP21eODa71jQJJVPFdTMS
         cE4SzS2xJ0LQGYw7RvOKoPX+NF0p2Db7Y0sSQWmN34UG2ycJr9Yx6r4s8YaiQqXFfhOF
         hFi0aIOK8f8qHodrrvyGT10jRkY1KnQ5HjZg2S1ESQkY4A2BH9o/DNUDjn/7lzwmxvPD
         c+tD8TCtfkjyTDfvPuKWXjrgj10TxMrp2BiQtwMYWl1bVC1n8YuPzm6rp86zcbnuO4Ok
         WleERDPnByxVgBU82sI+dgN+r94SXHbfqXcI2lmUhHlc1ZrRzrUxgFTWEuKzB4d7mXvg
         eNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F0crqVS1oQC1PHQ4v5nc+AZXy84JZ83AYdQBJxSNry8=;
        b=SvexHWil56NhJC97F41blKA1uhRxivYX6B97FsO7l/YsUoaEKVRPdyaV7dEQPoxf47
         6QcbeYuaHTGpwGzSjB24owTiTjRgjonG1Uqb228KAhI2Zg5KBwT6yWL4+YnHkRPHxJEC
         n2l/zed0wTgOKM/QYXZiE06FrfEzj8/RiQ8dum6PzS0mDB+iUq8DhvB0Z73DN3O61Rcx
         i+KY+rJq92hcl8USro6FZQITwyZlYPRatP2ji16W72hbL27qBBndI7EVX4rR6dLb2U7x
         VRJdPa2cO8T3lTdZ4MwVgjlGCh1Ak6EKsNvmLKodft3jA21ZPAlGFPS3SlyU9gAz51wG
         oe9g==
X-Gm-Message-State: APjAAAUGtNfI6SjG2KB2Lkm4lSn0FAaNinVuOWaz6xLaYB5CLS/uafgm
        IRK6PByjr2ckYnHxMyDnP9q0MPL2
X-Google-Smtp-Source: APXvYqzzBU0Eyep5cINcQ4HfwCHe26Ygf2QlYv+5YCfCf7GZZXAGp0DqASD61kAPhB3Ct1nVyAWfMQ==
X-Received: by 2002:a17:902:9687:: with SMTP id n7mr33645655plp.105.1556121555435;
        Wed, 24 Apr 2019 08:59:15 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id v12sm25842822pfe.148.2019.04.24.08.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:59:14 -0700 (PDT)
Subject: Re: RFC: zero copy recv()
To:     Maxim Uvarov <maxim.uvarov@linaro.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAD8XO3atijveUR0irCM2z3hsr8Rm9piwTbBp0NTwvzJt9+MHdw@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <d0c9c052-6153-6336-f296-15ad5611f21b@gmail.com>
Date:   Wed, 24 Apr 2019 08:59:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD8XO3atijveUR0irCM2z3hsr8Rm9piwTbBp0NTwvzJt9+MHdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/23/2019 11:23 PM, Maxim Uvarov wrote:
> Hello,
> 
> On different conferences I see that people are trying to accelerate
> network with putting packet processing with protocol level completely
> to user space. It might be DPDK, ODP or AF_XDP  plus some network
> stack on top of it. Then people are trying to test this solution with
> some existence applications. And in better way do not modify
> application binaries and just LD_PRELOAD sockets syscalls (recv(),
> sendto() and etc). Current recv() expects that application allocates
> memory and call will "copy" packet to that memory. Copy per packet is
> slow.  Can we consider about implementing zero copy API calls
> friendly? Can this change be accepted to kernel?

Generic zero copy is hard.

As soon as you have multiple consumers in different domains for the data,
you need some kind of multiplexing, typically using hardware capabilities.

For TCP, we implemented zero copy last year, which works quite well
on x86 if your network uses MTU of 4096+headers.

tools/testing/selftests/net/tcp_mmap.c  reaches line rate (100Gbit) on
a single TCP flow, if using a NIC able to perform header split.

But the model is not to run a legacy application with some LD_PRELOAD
hack/magic, sorry.

