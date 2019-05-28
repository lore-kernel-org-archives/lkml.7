Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D01C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B999321670
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="iUnnuo7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfE1P62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:58:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36412 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1P62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:58:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so32519852edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pGTbVuTd1G8Iwkz3wKaMpFfX3biKReee0DtS2uJrJoY=;
        b=iUnnuo7Vku1yw/FqE57E9kHru0RxuIjOB0gc7GSVcxKbGsBCNqy4mnsQR8DI0vMnFM
         eqkbhakwU2ix6hKDzN/X3MczVK59vu1WIfZAoZKfaSmGfwrylSHGHQq1b6D/ZkE6usAl
         WJXmQ5o4OObTMoZw8QkJ9Hd0nAVpimTeKKydG+7UAoB/2L/BoLllgflPFi9cS216OLoK
         7hxpSds9XDJYfattxdWJJeBf3nf4ISFgj2icRJLDzYEk4/IaBmp9Pki3s6OJ/L+eSC1k
         2P02JcRDd2AWwsCPG0yLR4n+ayh+i21XHKS8uFzICrCPGS2s0dtOUBiE2q08LTROFVwS
         eFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pGTbVuTd1G8Iwkz3wKaMpFfX3biKReee0DtS2uJrJoY=;
        b=V6znniODxV/UawkL2/h23b2w5zbx23udT7O7zs/hpthsaKM6VOUtwOdTC3yQY6BejF
         4fDCuB88MELsCXQ7KhHdqExLn2U3BOIGU4cYrhz5UN1phhDWwqH0BM0pdW/PLjzYCVT2
         1pp4i/71N24hZzg5q2X4hAaX0f1Akd6oPQCzYhh5unhdCt9TPeAjIzQhJmyVXjfIBDII
         88UZ2Gnghol4OKJD+A2KnnbndCB/HJEYPmyhPPXjY+WUonhkNkWqxapAo77+k1t27z2F
         r1pdaKOm6v83NzO4FGs/IFEpD1u0T+9TWlKHCC4ibKIsCUDtO4h+9mvZm1zvW1wmVyoG
         44Jw==
X-Gm-Message-State: APjAAAVW+B8M4PTr2ApnVSPOIk8mGmtasaVO8vsKu9/pVZZZQztkQ60s
        m9hN/DZ+avWB6WgD8fkMYxGTMQ==
X-Google-Smtp-Source: APXvYqzuNGiUrC8rB7rjc3nsud5YA5qTKm8cPu2HAv8LAYDcvsHHnQBVJZXnoZzD1gSPgBcf52JYew==
X-Received: by 2002:a17:906:4f87:: with SMTP id o7mr3276555eju.281.1559059106205;
        Tue, 28 May 2019 08:58:26 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j27sm2314607eja.91.2019.05.28.08.58.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:58:25 -0700 (PDT)
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20190528002412.1625-1-dima@arista.com>
 <20190528041500.GB26865@jagdpanzerIV> <20190528044619.GA3429@jagdpanzerIV>
 <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
 <e564ee00-6a93-defd-4eab-e306bbfe8b01@i-love.sakura.ne.jp>
 <20190528150345.di2knfzmqfbwro3y@pathway.suse.cz>
 <e0016343-2091-2478-dde3-3136a60b0942@i-love.sakura.ne.jp>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <31b2e5c4-72cf-c9b8-2a0e-2d5800c59aac@arista.com>
Date:   Tue, 28 May 2019 16:58:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e0016343-2091-2478-dde3-3136a60b0942@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I see that the thread is ongoing and you understand printk code much
better than me or probably anybody :)

So, feel free to reuse it. Or I can send v1 with split sysrq/printk
parts if you think it's worth being shaped further.

I think worth to mention three "features" that you might had a chance to
miss from the current code:

1. op_p->handler(key) is not printed under console_loglevel hackery.
   So, under RFC I preserved the behavior. Probably, you don't miss it
   and just looking into ways to change it, but I thought worth
   mentioning.
2. I've found it surprising how pr_info() interacts with pr_cont():
   Basically, pr_cont() without KERN_<LEVEL> prefix will print the
   resulting line with default_message_loglevel AFAIU from cont.level.
   Which might be higher than warning.
   I might miss a part that corrects cont.level to the first
   message's level?
3. CONSOLE_LOGLEVEL_DEFAULT is config-based, so having in mind that it
   can be changed and (2) - it gives me hard time to understand when
   the sysrq message will be printed and when will be suppressed.

Thanks,
          Dmitry
