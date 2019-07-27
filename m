Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58647C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6CC2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="YnFCIWK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbfG0Tp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 15:45:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35745 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387890AbfG0Tp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:45:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so50218749wmg.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wJp1gePRH2IkdAIZ2pYiyde6wuoSqldw6tUqDJuiAXg=;
        b=YnFCIWK6ciPrzklA1G/xvsJmQ+lCr1emmQO4TFcWnpXzXIutpzNOnZA/oTc/U71nP2
         h/Po+V7AvfXLLUWPRVldG5tARorD3ifqNhfFgTxwVUX8ZhKDUTbUGDssS0W19ej1wAsZ
         c0Il6AdwSWNNZV8Le5/RwHK1v9Zby/6MgEngEu9yfLAFBK7kXiHuqaBUMyo4Nt+VvrcS
         sqkj8XwJ/w4Tu5Cwa18ceJLzeujpO1Nzt/n3fQ/yZ0lKpHMN5N3ngT8NLflGOziXtSsI
         3M9QoxOiB4VsG3r6thdnbbZNoJ/1sZ+aX5cEo4XK0P4VsZqpwOLYunDJL/v1R3irN9q6
         VlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wJp1gePRH2IkdAIZ2pYiyde6wuoSqldw6tUqDJuiAXg=;
        b=Hgnc4u8AqtBEYQvIoGOcyDaG6/BvRajjT9lkk8mOTLXcKG3p2qpuT0qepn/RN5Zx3e
         2niG3mGvS+xeMXD8rE/2VVXmpqIqF6nGlAtJtsO7clqTe+bxj0mP1RoRwwxpT7qCw+az
         Ad2+7WSpDqbL1YKoA4uh70cGQV3tmvqOWRL1jZdUIb83AEkHoCGFVMagvtSEZX5iytdT
         KHImIwQ8wyzFyN1AtWEhsow0GDQEDHBbQBW+F2BHsi/zyEHjLU3wfEJIc8j3i+K0E5az
         NOH7F93d6a7+H28BqEYEnWHmElLp/ob8gsfJo8H6ixhq+G8Ol1c+R4ieIPznmfqghE5E
         0mTA==
X-Gm-Message-State: APjAAAVIn1GJ6Pp0e5a5j5HhJMJ1+f2hWXj//yYwggGdUdSAW9SgeIWF
        ksSfxGtThkkZKwhUJhmR/yo=
X-Google-Smtp-Source: APXvYqx2FbJMzzbyVWBpedJrw+WlcMzroKQc7T6grzi+Z98W5XymY6EJLNUBS26zvRxL/rST5yaiLA==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr41837462wma.80.1564256754044;
        Sat, 27 Jul 2019 12:45:54 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id j189sm64975762wmb.48.2019.07.27.12.45.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 12:45:53 -0700 (PDT)
Date:   Sat, 27 Jul 2019 21:45:52 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 1/2] pidfd: add P_PIDFD to waitid()
Message-ID: <20190727194552.xpudr7ou4wjowhew@brauner.io>
References: <20190727085201.11743-1-christian@brauner.io>
 <20190727085201.11743-2-christian@brauner.io>
 <CAHk-=whrh5+aHmgqP9YhZ-yzCtUWT8fPi08ZSJdxusx7aHXOQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whrh5+aHmgqP9YhZ-yzCtUWT8fPi08ZSJdxusx7aHXOQQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 09:28:40AM -0700, Linus Torvalds wrote:
> Sorry to keep pestering about the patch series, but with the addition
> of P_PIDFD, I react once again..

That's fine. I don't at all mind being particular about how something
has to be done as long as the result is functional. In this case it
seems we'll end up with something cleaner overall, so sure.

I'll rework the snippets into the actual patch and resend. I'll leave
out the rcu-cleverness you suggested in the other mail though.

Christian
