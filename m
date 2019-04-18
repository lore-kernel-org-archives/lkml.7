Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5B7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97F7208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OEKJisEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389069AbfDRO7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:59:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34917 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388277AbfDRO7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:59:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id j20so1880275lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LE07HDZj9OewdeoMnjTBSXjV2SgwNpRGLcBWvK5Jtf8=;
        b=OEKJisEG742TvIxAggby08MJCS2WeLG4nv/IJylSsXx7OCS1acyKQGZfxsStAkLn6f
         Wyqno3zbYrzfZjcN7GWbjP1pBrwMxNy5soSeIzb4BaidIjCAeyJ6oiNOMG5NfSc0j2gK
         otrUI3cp3CUQ8sSq1bs6v8dw/Ev3F0lvV5Hq+iX9EMSQvb7NM/ml1cClvMyN3Zyfq6C0
         7VI+NwAAfXFEACB2+DYH0PdeVyn22Yz+277n5B8Dws7W76a8DNu9Dp5SgaEDsvYnZQw3
         wgMQkextPEuZlBQl0uyE6YA3h6uSSwfRCz6LXJxPxn/co34Hd3ixsFc2iTR+xc4MIMxb
         0CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LE07HDZj9OewdeoMnjTBSXjV2SgwNpRGLcBWvK5Jtf8=;
        b=hvWdiD9ZEkROXx9jyAxsmIALRr8BdpREhQcNwBzxk1nVMP/JThQXsc2EV/tnSiXSZC
         0kZrZ6h0cx7N2SehiGcwUSN2E4wNgwQb/Xzzp0mIjjoV4FI2Ic1n5/clrIaD1hLtCRRE
         9euhXVakIcBeGNseDbbdYXU4TfjYz7NCPhtQZbowTDVXpqaRhXHi+WBorKdB7xxj8f2w
         6bajqwVIFG5xJdCr9i3UNs3x5ozFG0dnJ7YjlneVtdOzu4BrI+M7HhcEMpJdm0k6PpW9
         Z35cyWE8xdQId+Iz6Q3SFNkO1t6OAOGfEAn1VgJ7WlEwUMLk11A+ghkZv3cuvPjZcFTC
         jgfA==
X-Gm-Message-State: APjAAAW/Bg4I6Mh2R1svKoOZNe82a1JbU5RPBUOLkfHw1pGbm8jScOoO
        LkFtCErt4ITlpUR6YmcEPgsRLyfC8k3F+5rJfTu6
X-Google-Smtp-Source: APXvYqxjuXQGj9EcHlN83/q7WOWq69LsC6fQvMSt1vTkUDkL6x36a2+2Haz9aUJYrpFM4QDYifz0FYS8Dl1I6rJaHtw=
X-Received: by 2002:a19:7702:: with SMTP id s2mr32257157lfc.102.1555599590822;
 Thu, 18 Apr 2019 07:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <c7b092894ac6d611f8c5083e712da41e6685f94a.1554781852.git.rgb@redhat.com>
In-Reply-To: <c7b092894ac6d611f8c5083e712da41e6685f94a.1554781852.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Apr 2019 10:59:39 -0400
Message-ID: <CAHC9VhSCRrbFYy3KnSAt4GhADCfTXW-_uSm8focUk-i7_FPjrA@mail.gmail.com>
Subject: Re: [PATCH ghak111 V1] audit: deliver siginfo regarless of syscall
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        sgrubb@redhat.com, omosnace@redhat.com,
        Eric Paris <eparis@parisplace.org>, ebiederm@xmission.com,
        oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 11:53 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> When a process signals the audit daemon (shutdown, rotate, resume,
> reconfig) but syscall auditing is not enabled, we still want to know the
> identity of the process sending the signal to the audit daemon.
>
> Move audit_signal_info() out of syscall auditing to general auditing but
> create a new function audit_signal_info_syscall() to take care of the
> syscall dependent parts for when syscall auditing is enabled.
>
> Please see the github kernel audit issue
> https://github.com/linux-audit/audit-kernel/issues/111
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h |  6 ++++++
>  kernel/audit.c        | 27 +++++++++++++++++++++++++++
>  kernel/audit.h        |  4 ++--
>  kernel/auditsc.c      | 19 +++----------------
>  kernel/signal.c       |  2 +-
>  5 files changed, 39 insertions(+), 19 deletions(-)

...

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 1e69d9fe16da..4a22fc3f824f 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -226,6 +229,9 @@ static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
>  }
>
>  #define audit_enabled AUDIT_OFF
> +
> +#define audit_signal_info(s, t) AUDIT_OFF
> +

Should this be AUDIT_DISABLED to preserve the current value/behavior?
Technically they should both have a value of zero right now, but since
the AUDIT_DISABLED value isn't explicit it seems safer to go with
AUDIT_DISABLED.

> diff --git a/kernel/audit.h b/kernel/audit.h
> index 958d5b8fc1b3..18a8ae812e9f 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -299,7 +299,7 @@ extern bool audit_tree_match(struct audit_chunk *chunk,
>  extern void audit_put_tree(struct audit_tree *tree);
>  extern void audit_kill_trees(struct audit_context *context);
>
> -extern int audit_signal_info(int sig, struct task_struct *t);
> +extern int audit_signal_info_syscall(struct task_struct *t);
>  extern void audit_filter_inodes(struct task_struct *tsk,
>                                 struct audit_context *ctx);
>  extern struct list_head *audit_killed_trees(void);
> @@ -330,7 +330,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
>  #define audit_tree_path(rule) ""       /* never called */
>  #define audit_kill_trees(context) BUG()
>
> -#define audit_signal_info(s, t) AUDIT_DISABLED
> +#define audit_signal_info_syscall(t) AUDIT_OFF

Similar as above.

-- 
paul moore
www.paul-moore.com
