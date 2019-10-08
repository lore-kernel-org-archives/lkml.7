Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68D3C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC81F20815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UXq0frZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbfJHNGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:06:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34651 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbfJHNGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:06:32 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so16659763qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RmZkPjyRTggW5Ed7UtvmEQ7eekx/iK5La0taQGH61QU=;
        b=UXq0frZwtNF12l+HJ21FyT/EDz1QzyFB9AP599UMpyYmvKXh/MIGB0eHCqS0oI9Lca
         of7XNOxic31VNfbASC/FbQw8XDN+wAFjtPGWMhrZ/5stI/hBBnPCpSgRm5uBQuyfZBYc
         T3miR0bXURzoMy6hs8ZAv00Dx6OHu5z7TwF+T7mLmyAuI0/4q5QIM3JPm7MiGWBK1eD9
         Gq//OxYyNHTZQt2orOMg4yi/x/WIlwphREWqSSxIwncvN9vjF1ZP9z5i2uO4OlAV0Xss
         TY5uRhysGo5BDcDeZRXY26CxS76glWGpgpf3N9HfNceF1lp0Z1tI6GZOZr7rokISEOdR
         m3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RmZkPjyRTggW5Ed7UtvmEQ7eekx/iK5La0taQGH61QU=;
        b=B49gToY/BLTz+odo2Q6CBL6nlijCZ9v74M+7yJhU6bLCPHkqeKxQflfQRSa3y/ZHgn
         KJH8vTF6vDps0mA5qeTIpjuGXpYRg+0sU7234NT7wNvZcyc0ccCPKrC7/paGgyzjCMtC
         F/sDtD1Xz2CUq10dUU36RMlF+aXVFQOXycCOoreUkXaUIFGotLipBgoFBd9/SqpE/I4h
         7gOc1vBGgWFnsWl1gpweSFtyzXBlgTYz5518Xa3IIttg8KJ+xhM4L3G1aD0Ria9igCCx
         KMp1q6NzxTF6eFl1Pa8rE2Fu4XQ/YzzyUZ9QdOgUUFzV11xnLbNRFBwmT4WhESLwa7YL
         FQfA==
X-Gm-Message-State: APjAAAWyvY35WLOMheV1agh9kdkYLhezTI6KKOtxklw+FIlRwrI8sgKc
        +ksznK/+EkCchOT4fIFUi1UlRw==
X-Google-Smtp-Source: APXvYqyvQWui8vLO/vBQG+w8KxEYe79TwxZD6gvAlulUV05fhZ8DKweP/qu2JYc8z8ETJoEhGOwXmg==
X-Received: by 2002:a37:ac01:: with SMTP id e1mr29109537qkm.140.1570539991566;
        Tue, 08 Oct 2019 06:06:31 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c126sm9268342qkd.13.2019.10.08.06.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 06:06:31 -0700 (PDT)
Message-ID: <1570539989.5576.295.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Oct 2019 09:06:29 -0400
In-Reply-To: <20191008123920.GI6681@dhcp22.suse.cz>
References: <20191008103907.GE6681@dhcp22.suse.cz>
         <3836DE34-9DD2-4815-9E1E-CB87D881B9AD@lca.pw>
         <20191008123920.GI6681@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 14:39 +0200, Michal Hocko wrote:
> On Tue 08-10-19 08:00:43, Qian Cai wrote:
> > 
> > 
> > > On Oct 8, 2019, at 6:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > > 
> > > Have you actually triggered any real deadlock? With a zone->lock in
> > > place it would be pretty clear with hard lockups detected.
> > 
> > Yes, I did trigger here and there, and those lockdep splats are
> > especially useful to figure out why.
> 
> Can you provide a lockdep splat from an actual deadlock please? I am
> sorry but your responses tend to be really cryptic and I never know when
> you are talking about actual deadlocks and lockdep splats. I have asked
> about the former several times never receiving a specific answer.

It is very time-consuming to confirm a lockdep splat is 100% matching a deadlock
giving that it is not able to reproduce on will yet, so when I did encounter a
memory offline deadlock where "echo offline > memory/state" just hang, but there
is no hard lockup probably because the hard lockup detector did not work
properly for some reasons or it keep trying to acquire a spin lock that only
keep the CPU 100%.
