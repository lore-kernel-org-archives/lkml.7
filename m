Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B015C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E030120843
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH1DM6Qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfENJTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:19:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34882 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfENJTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:19:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id h1so8322411pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZFgtv21p/IVdxF8p1wE7Gb9HyJv5nYQqw2fevd0oG1Y=;
        b=ZH1DM6QhcabMYR/VJM7kfaF0y29TZwaKz83lK5Wy/ejd9cRw8dL1Pay95Lq7rXFogK
         KKSAiT9s/8tI5wfyVo/zdP4Vpt6s9au5PdHXedooYDC8WmOc/54Bck8QBmmcvVyGqUx8
         JqvWtbAuBWP8Kdm5pzLn55lRP1v9x15f0E7zJsj7Q0nLIS12TvC2jUjHCUK8bVzgKnlJ
         qtBYhTryXyOI/P97ltd0IL04Q1kljpZusbDukwlTXyZfMqbB8QnXqTzX5PHFLM0TS8kY
         kL08fc9DpD//69p27LmIl/vrFI0hLkxbbWup436uREbhvJO0Q4GPhLxXIje4hTYjb4vW
         8mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZFgtv21p/IVdxF8p1wE7Gb9HyJv5nYQqw2fevd0oG1Y=;
        b=YI66aACnF6ZpJwEBO9eg7+tOiC5OcaSQ/pPbdyEuaK1hlG7Dzk9dUv12T25uCR6XGt
         NlFoDFiTLGBta1P0LJ2JlpwIiALmTZZ2dJf77WESdL4W29N8Zi+ylM51+wXNnmB+jAOo
         d8kwWsmy545Y6j/WYEa9Mx28QRVmRFhudVH+jYtk5jnYYDxvrIA+5KHpY8gE3LB/KkdU
         SnIFWZiUQINu6eGCQdkOxJTHfvd/ggS6gHAJHwH+8WEg3Cokn4tULhjVe59L5Qgngcc4
         RWhQKZUtRMLf1pQlhz0R4RteaZnGf5JcY/d6CkCX26sLQwxP8IGCmQdUJZhP7ux0WGtP
         F4qw==
X-Gm-Message-State: APjAAAW2SRGLQEvQR0yL8Zq6nh6OHmAFIqIKqacZd8h2Wjnrsrkc/fHV
        tApZhpk3YyUQGd7Jf4lB1gU=
X-Google-Smtp-Source: APXvYqz23Da8pxzOx8ZP9Bk/hUxD3/pEOWcPG4F3mvvj+EhoXrP9tvUWCQgl4nhGqSlhar6GlQH03Q==
X-Received: by 2002:a63:4c54:: with SMTP id m20mr37196609pgl.316.1557825561748;
        Tue, 14 May 2019 02:19:21 -0700 (PDT)
Received: from localhost ([39.7.55.172])
        by smtp.gmail.com with ESMTPSA id i65sm24344884pgc.3.2019.05.14.02.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 02:19:20 -0700 (PDT)
Date:   Tue, 14 May 2019 18:19:17 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] printk: Monitor change of console loglevel.
Message-ID: <20190514091917.GA26804@jagdpanzerIV>
References: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/11/19 00:19), Tetsuo Handa wrote:
> We are seeing syzbot reports [1] where printk() messages prior to panic()
> are missing for unknown reason. To test whether it is due to some testcase
> changing console loglevel, let's panic() as soon as console loglevel has
> changed. This patch is intended for testing on linux-next.git only, and
> will be removed after we found what is wrong.

Clone linux-next, apply the patch, push to a github/gitlab repo,
configure syzbot to pull from github/gitlab? Adding temp patches
to linux-next is hard and apparently not exactly what linux-next
is used for these days.

	-ss
