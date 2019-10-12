Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E550AC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A85206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570920996;
	bh=51dVFGUk6fsmF81ho7yMnCd3IY86zSZtQ556DfabKlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hYxeVbT6D/rnK0sZY2tl/aikQmXlVVUZZeqtJBRi2SNDopvtrnSzHPQgQN2MoVI7E
	 oS5DMUu7di4uUKcvag4dLp96Id/QtdTEXlKwwDJQB8ydr0GMwu9hELuPLkXT+2aGO6
	 Swsbx25OsvNyf3B3BHqdxRrFMFGQJX3zP81LZ5YY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfJLW4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:56:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41015 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfJLW4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:56:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id r2so9352530lfn.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 15:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DS67+YtCVu11SuWVZgu6Ket3y4/O2UgURNPso78w8e8=;
        b=Z8HBphVPrHzEotVK6GhCCdwuVASP2gvXWc76WJqSndGHM9/B/9mi8kNS+A5t2InmtF
         MSVj/sXqsezE6utbTZrIaBDDElGeUbMDMKgEzYvCnBg0wzL77Air9Ng/uDpX3dFDH/M6
         +8ki0dUOVg8W1BriNCEuKJeWIJUE+8QWI0I6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DS67+YtCVu11SuWVZgu6Ket3y4/O2UgURNPso78w8e8=;
        b=L1kwMme0/CBW0+URphMpIv1JUGGqkJibeHVi0Q+vbaGWxuRwU5ONINLAGsOwbKiSAK
         v/0/Dc6YlGO1oqdPd+3Yy1I3bxSQJmx80rOOXR77eQQSIoJgp2djntyYyyXkolmIb3qA
         ylfo6FZImNmnZp20pVyzkLQQ+g4ha1lZxVaBeEG7hf2+7eN0kMoOa/cE1wrhhwvOkmGR
         984oOKmDrAv/8t9c7mPGISTSHUC+ccumIw1YFNByB4noZfB45LJfbRfAnes3e48F0HeH
         mJqRyIN3yKryPIsq3co9INK1RRReWCY8othrRyqeiu2tzAk80qjD7ahB/tY8jK+4rrlC
         1hpA==
X-Gm-Message-State: APjAAAWenW+D+Ckh3NyyWP8Kxe17q4FiK6kpDAdg9lrSsEnB+fxdW0IY
        Mn8CYs11V6MYsnukYSmsPNMW4dfy24w=
X-Google-Smtp-Source: APXvYqyeKiQo69x3BmLLXjMZfolMh0SJ3kfCC8z+uB7iQK+nnv4c8a+kjcoJc81bCBuYaOSdC1jkWQ==
X-Received: by 2002:ac2:4556:: with SMTP id j22mr12443992lfm.87.1570920992748;
        Sat, 12 Oct 2019 15:56:32 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id d25sm2997903lfj.15.2019.10.12.15.56.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2019 15:56:31 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id w6so9382606lfl.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 15:56:31 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr12727917lfc.79.1570920991283;
 Sat, 12 Oct 2019 15:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191012005747.210722465@goodmis.org> <20191012005920.630331484@goodmis.org>
In-Reply-To: <20191012005920.630331484@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Oct 2019 15:56:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whE7GjKz9LtEVNw=zEgWr65N1mU7t2rA4MLiia8Zit6DQ@mail.gmail.com>
Message-ID: <CAHk-=whE7GjKz9LtEVNw=zEgWr65N1mU7t2rA4MLiia8Zit6DQ@mail.gmail.com>
Subject: Re: [PATCH 1/7 v2] tracefs: Revert ccbd54ff54e8 ("tracefs: Restrict
 tracefs when the kernel is locked down")
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 5:59 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> I bisected this down to the addition of the proxy_ops into tracefs for
> lockdown. It appears that the allocation of the proxy_ops and then freeing
> it in the destroy_inode callback, is causing havoc with the memory system.
> Reading the documentation about destroy_inode and talking with Linus about
> this, this is buggy and wrong.

Can you still add the explanation about the inode memory leak to this message?

Right now it just says "it's buggy and wrong". True. But doesn't
explain _why_ it is buggy and wrong.

          Linus
