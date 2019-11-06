Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001A5C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FA620869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH4/tFyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfKFA1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:27:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46468 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfKFA1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:27:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id l4so5304259plt.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z1j1yIp5rIMoQKSGNIhBICR9Hyk56ICQBuP9FBhyVq4=;
        b=KH4/tFyc4WxszKIMrUBOydPWhVKcefPh7MtTFV6OCH3DHwLbFwIh3nKkfJu5nKKEDH
         Heshpi4d6WRXtl6dqRyiLBN/NUH28JZIUjgH8rZcJWrKi3pQg87/o6X81RHIb8vQD5+b
         xr5VnwQDImaBYACqEg1VLTFuvveJMg78mbmc4SHvt9mQRsL5nJbrG6AwfFt+MH+aG8EN
         qvKfx2J83j5/YzG/C7BvG0cgXkw4lddGQTVHpci7qNz1zCL1otqHqGP/aKwf1pgLK+zx
         SrdEY8vvQx0SSyuzjhanzDrfEebhYXZ1U1XEAgLDXmmGCS1sqOG7/+qTRtRyYQO2fjL1
         Ne1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1j1yIp5rIMoQKSGNIhBICR9Hyk56ICQBuP9FBhyVq4=;
        b=WNxL/p7H7/+HdrZhY/bl6ZbLZnJHRVk2H2ZIICOtjpoLApdErss/D8bo8MISpWYiPg
         G48pNXPfxnezoVrUTxLAGfkODpe/RGOzwZM3LG6Rr8GcjyVVCXwkTA74T0wl2XHlTIHd
         z1tlAEcF9Teqsk8w8l9VW5R42+FMPHbehGuojZKxGGw+DAGynR4VwOZLLKVFzOZx179u
         V9mwAnbyBuoroxDtTx0XyYizQHMTexholS+Tos2cgoe6QsFrKFDws6OyNBqDRmgRsMDd
         OxbB7yA33jw2Hm3PApUdI8dU1mvHDrbpjNPzgIKWW6TBrkZldJk87CkJ6CdYQVS9RTgy
         C2GA==
X-Gm-Message-State: APjAAAUPGiqmTIz/YFeZrAFiu4zoUfDX32z1QmLEa+xDo6i/P82CSqq0
        19i90r9JJaU9RYXOo2XvgAs=
X-Google-Smtp-Source: APXvYqziAjo0MsiZfMdR+6SVcTpxmnhunE5fp2hQubz6SwfmsxubnR/owyuKTizz2w1Ib6vllnTUFg==
X-Received: by 2002:a17:902:b58e:: with SMTP id a14mr36560258pls.0.1573000031351;
        Tue, 05 Nov 2019 16:27:11 -0800 (PST)
Received: from u2f459ca2e0dd5b.ant.amazon.com ([61.69.148.113])
        by smtp.googlemail.com with ESMTPSA id c13sm10294111pfi.0.2019.11.05.16.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Nov 2019 16:27:07 -0800 (PST)
Message-ID: <50abba6cb6643a8beaf29b233bea28d7b6eed5e5.camel@gmail.com>
Subject: Re: [PATCH] taskstats: fix data-race
From:   Balbir Singh <bsingharora@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Date:   Wed, 06 Nov 2019 11:27:03 +1100
In-Reply-To: <20191005112806.13960-1-christian.brauner@ubuntu.com>
References: <0000000000009b403005942237bf@google.com>
         <20191005112806.13960-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-10-05 at 13:28 +0200, Christian Brauner wrote:
> When assiging and testing taskstats in taskstats
> taskstats_exit() there's a race around writing and reading sig->stats.
> 
> cpu0:
> task calls exit()
> do_exit()
> 	-> taskstats_exit()
> 		-> taskstats_tgid_alloc()
> The task takes sighand lock and assigns new stats to sig->stats.
> 
> cpu1:
> task catches signal
> do_exit()
> 	-> taskstats_tgid_alloc()
> 		-> taskstats_exit()
> The tasks reads sig->stats __without__ holding sighand lock seeing
> garbage.
> 
> Fix this by taking sighand lock when reading sig->stats.
> 

Hi

Sorry I am just catching up with my inbox, why is sig->stats garbage? I'll
need to go back and look, unsigned long (pointer) reads are atomic and the
expectation is that they would be NULL initially and then non NULL for thread
groups when first allocated. May be I am just being dense in the morning -
what am I missing?

Balbir Singh.



