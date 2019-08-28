Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E7BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1905208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YPeGmbRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfH1J23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:28:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41043 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfH1J22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:28:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so1141370pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 02:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZx5QFMA3ykkKGmHMbJA9Au62IZ9SSb+Y6psbhqhgAw=;
        b=YPeGmbRVPwD/7g2CmOmiMzsT4L5WWOv2r2bNBnmdYXYUdM7lfCheB+6UIEIkeIvhEE
         nWz906pKGcRMJtzH7+G1GdPbcCIER8yDS+oiQMyDRgunWHj5gQbyKVBqevudyuYkLrVB
         MVCDZfupL8I2v3rMh/EGJlRTAlOJ4Dze4TAnERGZCR8hbRuoba/hp+nPLK1N1v8vbDq5
         wwFgokuSoEMJMX0Uvn4cMIcj993z0hs7OxnZA//OflzG+fzN2UNZtkUZDyiPiqNkmVb7
         MhybdIIXRC+qvwcxNC7+jWWg7KyDMxRYSC3XFT9QUdqEhFZM/5qKag3vjguBt5cNVd7R
         aH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZx5QFMA3ykkKGmHMbJA9Au62IZ9SSb+Y6psbhqhgAw=;
        b=F1kzfpEdPhwE5TQwrVvtCgt5LjZzIOZ8H/URun1cQhflIZ9TS2BZa4AiL+OaH8qTjW
         VutGw5frk1HF1iYlf99DBu5fy/VxX6kWjPGNqkhLVof8TkNju28YpVXCs011Lc7o38RP
         GWeCQAiZt/g41m4gCOGkNpMZyBulorBACCU+qcBT5j7TZ4+zPcIda+wBJO4v9dnk+H3/
         g9GF0MDyxfg3VfYASZU5iT73qQlEChBMyEfkAkYijE6yhVEEkqpVJpOugklYVGOG68YV
         2LRmzGQOUCL2bDsOkc4zEauH3CrLiQaV48TVN3m5V4+SeGfv93ESXFVXLZ04NFSFbtwC
         CR5w==
X-Gm-Message-State: APjAAAUJhdYknNJA9e3JdU2oI29XMvf15DlfvgTNwv6RILSr7H9i+1vt
        6RIt13bUkeYPPfTs97epQcH5AwNrWlOiF8kP7LOs2w==
X-Google-Smtp-Source: APXvYqz0WqpF7fj08ZtVZkh5HfCpm8kVU1XmTLvg2tS/TEiLZHZzWWuukt700aOKth9QMBIx7YzEEiet/r/7g7OMqgc=
X-Received: by 2002:a63:b919:: with SMTP id z25mr2563361pge.201.1566984507452;
 Wed, 28 Aug 2019 02:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190827234835.234473-1-brendanhiggins@google.com>
 <20190828030231.GA24069@jagdpanzerIV> <20190828044529.GA30152@google.com> <20190828052405.GA526@jagdpanzerIV>
In-Reply-To: <20190828052405.GA526@jagdpanzerIV>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 28 Aug 2019 02:28:16 -0700
Message-ID: <CAFd5g44U_DcCKtNOBKXiqsNuQbhKSTyr=jLRjNnKUxj8S0ZDrw@mail.gmail.com>
Subject: Re: [PATCH v1] printk: add dummy vprintk_emit for when CONFIG_PRINTK=n
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     shuah <shuah@kernel.org>, Petr Mladek <pmladek@suse.com>,
        sergey.senozhatsky@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:24 PM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (08/27/19 21:45), Brendan Higgins wrote:
> [..]
> > I actually use it in a very similar way as dev_printk() does. I am using
> > it to define an equivalent kunit_printk(), which takes a log level, and
> > adds its own test information to the log.
> >
> > What I have now is:
> >
> > static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> > {
> >       return vprintk_emit(0, level, NULL, 0, fmt, args);
> > }
> >
> > static int kunit_printk_emit(int level, const char *fmt, ...)
> > {
> >       va_list args;
> >       int ret;
> >
> >       va_start(args, fmt);
> >       ret = kunit_vprintk_emit(level, fmt, args);
> >       va_end(args);
> >
> >       return ret;
> > }
> >
> > static void kunit_vprintk(const struct kunit *test,
> >                         const char *level,
> >                         struct va_format *vaf)
> > {
> >       kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> > }
>
> Basically, for prefixes we have pr_fmt().
>
> #define pr_fmt(fmt) "module name: " fmt
>
> but pr_fmt() is mostly for static prefixes. If that doesn't work for
> you, then maybe you can tweak kunit_foo() macros?

That doesn't work. The prefix is dynamic.

> E.g. something like this
>
> #define kunit_info(test, fmt, ...)                                   \
>         printk(KERN_INFO "\t# %s: " pr_fmt(fmt), (test)->name, ##__VA_ARGS__)
>
> #define kunit_err(test, fmt, ...)                                    \
>         printk(KERN_ERR "\t# %s: " pr_fmt(fmt), (test)->name, ##__VA_ARGS__)
>
> #define kunit_debug(test, fmt, ...)                                  \
>         printk(KERN_DEBUG "\t# %s: " pr_fmt(fmt), (test)->name, ##__VA_ARGS__)
>
> Would that do the trick? Am I missing something?

This appears to work. I will send out a patch that incorporates this.

Thanks!
