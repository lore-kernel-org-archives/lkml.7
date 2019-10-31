Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6750CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473EF2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VcOIpgoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfJaX1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 19:27:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37156 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfJaX1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:27:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id b20so5980168lfp.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 16:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2ffogDpozyAqtkdcsJAMC3COCP/ysptTvprfPko7e4=;
        b=VcOIpgoByA9ZrkUE+JfCCFcCPoeFfl7j6gYdAOzXPfvvgLqvdY6r3Gdmg+g6f68fLI
         xGnULOcRSdKK5gD8eXiMb4Yq8eSi5n8HexvuS8RcSJzh6Px0GUgbUX79jFw1mkI8d/fr
         ZZDJp8M5bQ5J/S/kuRXA/pYDM8FvGZCU9vtcYcDtTdRyl/PAZsudDCpk1nLR9C127s2I
         0rFn2BEKyPUESeT8YC6IFsdsyPE57SigpC5X2n4ySKHBm4VoTwO4BZGGuN3nb/Q9wJD6
         O72IZfG8kRLS+ZH61h0dR+kGmx1DUPvDvAxvH3h+mnpF0CzKdrdmK8uv7IefoDt+/UkZ
         YpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2ffogDpozyAqtkdcsJAMC3COCP/ysptTvprfPko7e4=;
        b=l3/s5TdjtcDgtemlHXE7vdvTndBNKMzP3+tNbfuUKjPtGMXWVTxb37stm1+GswqSEE
         JvLeFJqbixbyXLNhLIQ9HMQU9pziaTktIGRg87MlXyJ3nmTx6JfFqohX8OysPli5wT2B
         8y6NgrjvtfF+SSevoxaMPxc63p1Brk0cI8sqaL7o1jDBRyQ2mbPs1jD3sSIC94I85waf
         lnQV2ZdKe+GfTDWfCUpVW0JV23cVXbQujMB/1Q2CCraEUgXX7LTthZznieKlyoULGq+c
         dgm4470nucvrzg8Jacz+VNoIocq0aIhIY/DiZPA6f9y/yR2kGYtj2l8NT+Bv6wafTdhQ
         3ulw==
X-Gm-Message-State: APjAAAV8cwInZ1Nuq5ZRY2v2WgLtaPD7rRw6XnGVTCodTJOP8cP/ddCt
        0zcclF/WZiUP2fqhsqwacgbGKIdhPG3QnDKvYZw1
X-Google-Smtp-Source: APXvYqwe1J+xrVrIbls/ckNmuEOFARoFrNb3empdiGVKUDofsl/X5rtVrSeg1VsPy+Ie8l364ZaF6NL2PfaR+fnb23Y=
X-Received: by 2002:a19:8092:: with SMTP id b140mr5180757lfd.13.1572564435823;
 Thu, 31 Oct 2019 16:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <20191031163931.1102669-1-clm@fb.com>
In-Reply-To: <20191031163931.1102669-1-clm@fb.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Oct 2019 19:27:04 -0400
Message-ID: <CAHC9VhRwRSGa5JSL0=cXxG-oOg9jUve9OEYyTCqTxzr=aMdGxg@mail.gmail.com>
Subject: Re: [PATCH] audit: set context->dummy even when audit is off
To:     Chris Mason <clm@fb.com>
Cc:     Eric Paris <eparis@redhat.com>,
        Dave Jones <davej@codemonkey.org.uk>, linux-audit@redhat.com,
        Kyle McMartin <jkkm@fb.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 12:40 PM Chris Mason <clm@fb.com> wrote:
> Dave Jones reported that we're finding a considerable amount of dmesg
> traffic from NTP time adjustments being reported through the audit
> subsystem.  His original post is here:
>
> https://lore.kernel.org/lkml/20190923155041.GA14807@codemonkey.org.uk/
>
> The confusing part is that we're seeing this on machines that don't have
> audit on.  The NTP code uses audit_dummy_context() to decide if it
> should log things:
>
>         static inline void audit_ntp_log(const struct audit_ntp_data *ad)
>         {
>                 if (!audit_dummy_context())
>                         __audit_ntp_log(ad);
>         }
>
> I confirmed with perf probes that:
>
>         context->dummy = 0
>         audit_n_rules = 0
>         audit_enabled = 0
>         audit_ever_enabled = 1 // seems to be from journald
>
> The box boots, journald turns audit on, some time later our
> configuration management runs around and turns audit off.  This journald
> feature is discussed here: https://github.com/systemd/systemd/issues/959
>
> From what I can tell, audit_syscall_entry is responsible for setting
> context->dummy, but we never get down to the test for audit_n_rules:
>
> __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
>                            unsigned long a3, unsigned long a4)
> {
>         struct audit_context *context = audit_context();
>         enum audit_state     state;
>
>         if (!audit_enabled || !context)
>                 return;
>                 ^^^^^^^^^^^^^^^^^^  --- we bail here
>
>         [ ... ]
>
>         context->dummy = !audit_n_rules;
>
> This leaves context->dummy at 0, which appears to be the original value
> from kzalloc().
>
> If you've gotten this far, you've read everything I know about the audit
> code.  With that said, my preference is to make a single source of truth for
> decisions about logging.  This commit changes __audit_syscall_entry() to
> set context->dummy when audit is off.
>
> Reported-by: Dave Jones <davej@codemonkey.org.uk>
> Signed-off-by: Chris Mason <clm@fb.com>
> ---
>  kernel/auditsc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Hi Chris,

This is a rather hasty email as I'm at a conference right now, but I
wanted to convey that I'm not opposed to making sure that the NTP
records obey the audit configuration (that was the original intent
after all), I think it is just that we are all a little confused as to
why you are seeing the NTP records *and*only* the NTP records.

It's been a while, but I thought we suggested Dave try running
'auditctl -a never,task' to see if that would solve his problem and I
believe his answer was no, which confused me a bit as the
audit_filter_task() call in audit_alloc() should see that rule and
return a state of AUDIT_DISABLED which not only prevents audit_alloc()
from allocating an audit_context (and remember if the audit_context is
NULL then audit_dummy_context() returns true), but it also clears the
TIF_SYSCALL_AUDIT flag (which I'm guessing you also want).

Can you confirm the results of 'auditctl -a never,task' on your systems?

-- 
paul moore
www.paul-moore.com
