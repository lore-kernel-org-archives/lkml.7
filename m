Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03A6C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 15:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C937C20838
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 15:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvbEjwwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfGGPts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 11:49:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35311 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfGGPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 11:49:48 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so19910255ioo.2;
        Sun, 07 Jul 2019 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4nSr8C4VJLXjo2WMEW+SSHBlpQfsTI/51+kxtK6GPA=;
        b=YvbEjwwJ0MctJmyVW2533O+SajBFaUp96J65ETZP+TatSMINnLBybugK6AoA58+MfZ
         yd15CnKnxIQnb+432TC0RnoimNjVmfkheHmHbAo/DwijS92RSoszBySc4s83WHsLef+p
         ZXtoF5JncfYaRuocLhwSQN5OoVp+NjBZozVDL1n9KB5gbQrKGBokpNMsMHF7ScczNG9W
         VErLPBTv8kbBqF0FjQSgB5IYmd3oOKSbu8CTCDMwj97kfsW30VCistO+f40EnHTS7A1p
         IDbwYqJzeKXw/J4laVfJb/T57lFaIteuOcrYiq8sMQEpG3HKhJKB2f+Q6gR5Akx+kl5u
         1M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4nSr8C4VJLXjo2WMEW+SSHBlpQfsTI/51+kxtK6GPA=;
        b=GMxOMXCqS3LHnlI5y3C+V08+j4JME1dV+tGpDw7pOycRfYqcti+GGeOESLK4PLidbJ
         P+VRqkFKgwVj8n3IugOflX3WmWRIM7WAy9hZtAktJS8XJuvi+CRanH+9NOIbA3BaN0Vs
         xVaW/Ki4uCsXhBn0rxU/FrbqiguIEyhd3xJR75Yji/abPoFtCX5SZshVoz0+I9ZHC8bZ
         kM5Sd7IvUz+hSWv3J2dRJJRiky3JkCbytXldIYfg4lojlnmUsOHzuzHTMWyIog2UVxYB
         UYIdFMe7R+1yxGEXtMT7/oeCbyNx1NPjlNPUrgY7GQnfJJiQi1tBBXOtgTLaLJ8cBxNI
         iqJQ==
X-Gm-Message-State: APjAAAX8VcdiOUUqqdEBMcE+SiFtX8FIF8for0C2JIM1DGglstulh8Bs
        R0lE1uzjWSbjTt68XgnEkRYvG3WFnJK2qi4qRA4=
X-Google-Smtp-Source: APXvYqw8oS+uiF28Cm5vFb/bwzir+3/EqF2Ea/W20KGlon5E6qPXtr6B7HM849DAD8MJjXYvcZw/7BLf/kSb+cG9qi8=
X-Received: by 2002:a6b:c9d8:: with SMTP id z207mr13631851iof.184.1562514586987;
 Sun, 07 Jul 2019 08:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-7-git-send-email-s.mesoraca16@gmail.com> <20190706192852.GO17978@ZenIV.linux.org.uk>
In-Reply-To: <20190706192852.GO17978@ZenIV.linux.org.uk>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sun, 7 Jul 2019 17:49:35 +0200
Message-ID: <CAJHCu1+JYWN7mEHprmCc+osP=K4qGA9xB3Jxg53_K4kwo4J6dA@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] S.A.R.A.: WX protection
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Jul 06, 2019 at 12:54:47PM +0200, Salvatore Mesoraca wrote:
>
> > +#define sara_warn_or_return(err, msg) do {           \
> > +     if ((sara_wxp_flags & SARA_WXP_VERBOSE))        \
> > +             pr_wxp(msg);                            \
> > +     if (!(sara_wxp_flags & SARA_WXP_COMPLAIN))      \
> > +             return -err;                            \
> > +} while (0)
> > +
> > +#define sara_warn_or_goto(label, msg) do {           \
> > +     if ((sara_wxp_flags & SARA_WXP_VERBOSE))        \
> > +             pr_wxp(msg);                            \
> > +     if (!(sara_wxp_flags & SARA_WXP_COMPLAIN))      \
> > +             goto label;                             \
> > +} while (0)
>
> No.  This kind of "style" has no place in the kernel.
>
> Don't hide control flow.  It's nasty enough to reviewers,
> but it's pure hell on anyone who strays into your code while
> chasing a bug or doing general code audit.  In effect, you
> are creating your oh-so-private C dialect and assuming that
> everyone who ever looks at your code will start with learning
> that *AND* incorporating it into their mental C parser.
> I'm sorry, but you are not that important.
>
> If it looks like a function call, a casual reader will assume
> that this is exactly what it is.  And when one is scanning
> through a function (e.g. to tell if handling of some kind
> of refcounts is correct, with twentieth grep through the
> tree having brought something in your code into the view),
> the last thing one wants is to switch between the area-specific
> C dialects.  Simply because looking at yours is sandwiched
> between digging through some crap in drivers/target/ and that
> weird thing in kernel/tracing/, hopefully staying limited
> to 20 seconds of glancing through several functions in your
> code.
>
> Don't Do That.  Really.

I understand your concerns.
The first version of SARA didn't use these macros,
they were added because I was asked[1] to do so.

I have absolutely no problems in reverting this change.
I just want to make sure that there is agreement on this matter.
Maybe Kees can clarify his stance.

Thank you for your suggestions.

[1] https://lkml.kernel.org/r/CAGXu5jJuQx2qOt_aDqDQDcqGOZ5kmr5rQ9Zjv=MRRCJ65ERfGw@mail.gmail.com
