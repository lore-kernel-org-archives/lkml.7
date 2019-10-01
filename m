Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C60CC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 05:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157512168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 05:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="No55bwmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfJAFiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 01:38:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36616 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfJAFiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 01:38:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so8852611lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 22:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a+1iZ6wS7UmVYZ5VqPhsnf3EVMkX+PkLBru96WlvsJc=;
        b=No55bwmG/L3BtmQiCDl24RyHnFVFpkgAKrDjLGbvq1NfTtAOkrykGkj6Imi9ZnHyXa
         EiNq6uW0Nm9WNHePE1W7du6eNPRxhtGDghLypTe3iULUwZftnmW35zxZ3XkmHDBkqvvW
         /RPPUPeB9Nu0Ogi9PrtPxQrUIEVvELc5RLq4MjS2+p7R+/FDEeZpnXdoU1qJuaE52Hze
         NTtHO2EJUMeM+iXZT6U7/+eGoKEu8JB4wsVRqiB+hndY+CxidLc4V/hDDuDrYChX/PGM
         YYK9C4p77VymqVtn5l/ER6MXhoCVNF4DzJ8MDYjBiew2cHUWBVmiEkgGCeasXo2YIzvi
         DzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a+1iZ6wS7UmVYZ5VqPhsnf3EVMkX+PkLBru96WlvsJc=;
        b=ChZVtxXp5ugmTdlKPijAZKv/iehJkzuFIMYSFwPPwtUSth74mvgvHya8L/TBc3w/gl
         lxJBKVdUqnniyU6xfeP/sWdpGmZJVC1ZXENWLnhwH6I58GF+tQ5UBQhfxA32cDXw8hq8
         VWxweFdriiWP+8lNHmqmb5sfC96Y2KFT83EjSjchfPiv0JzCL53vmDsmJS94iQjE9L8v
         aaMgnUIvySz4ZdMEU2Onv9m0UFUPFnWx4lkU3Jm02HHV4nSSbps+n1X2xy6MfJhvMQhc
         YKEIbD4uTPxorowiuVSrjxR+xOIdwFTWKQBxpx7tmEHh54teEdAaaj8ALq6+52daE82e
         0OYg==
X-Gm-Message-State: APjAAAWtoD1kWGQhcb1dF+Dp3LVwegZ8Ly7yV9+HXp9snK23X446ScXl
        XVMfXObPcVQg4j5UJgW1ENkOL2/kcqJ7yOK7kODb
X-Google-Smtp-Source: APXvYqy/yAx/jAVUndYWQYKxPBhFnrOpQXpPdMFCCav/qlkLpgYJVFIVF2+aoOudD+nt/Qyd7Dj4SpqfugOAcxDaE04=
X-Received: by 2002:a19:6517:: with SMTP id z23mr7656913lfb.31.1569908291445;
 Mon, 30 Sep 2019 22:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <201909251348.A1542A52@keescook>
In-Reply-To: <201909251348.A1542A52@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Oct 2019 01:37:59 -0400
Message-ID: <CAHC9VhQGAVejYvkvDQ_-egvMYn7VvY9WtdCZvANhmkDswBL8YA@mail.gmail.com>
Subject: Re: [PATCH] audit: Report suspicious O_CREAT usage
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= 
        <jeremie.galarneau@efficios.com>, s.mesoraca16@gmail.com,
        viro@zeniv.linux.org.uk, dan.carpenter@oracle.com,
        akpm@linux-foundation.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel-hardening@lists.openwall.com, linux-audit@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 5:02 PM Kees Cook <keescook@chromium.org> wrote:
>
> This renames the very specific audit_log_link_denied() to
> audit_log_path_denied() and adds the AUDIT_* type as an argument. This
> allows for the creation of the new AUDIT_ANOM_CREAT that can be used to
> report the fifo/regular file creation restrictions that were introduced
> in commit 30aba6656f61 ("namei: allow restricted O_CREAT of FIFOs and
> regular files"). Without this change, discovering that the restriction
> is enabled can be very challenging:
> https://lore.kernel.org/lkml/CA+jJMxvkqjXHy3DnV5MVhFTL2RUhg0WQ-XVFW3ngDQO=
dkFq0PA@mail.gmail.com
>
> Reported-by: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is not a complete fix because reporting was broken in commit
> 15564ff0a16e ("audit: make ANOM_LINK obey audit_enabled and
> audit_dummy_context")
> which specifically goes against the intention of these records: they
> should _always_ be reported. If auditing isn't enabled, they should be
> ratelimited.
>
> Instead of using audit, should this just go back to using
> pr_ratelimited()?
> ---
>  fs/namei.c                 |  7 +++++--
>  include/linux/audit.h      |  5 +++--
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 11 ++++++-----
>  4 files changed, 15 insertions(+), 9 deletions(-)

...

> diff --git a/fs/namei.c b/fs/namei.c
> index 671c3c1a3425..0e60f81e1d5a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1031,6 +1031,9 @@ static int may_create_in_sticky(struct dentry * con=
st dir,
>             (dir->d_inode->i_mode & 0020 &&
>              ((sysctl_protected_fifos >=3D 2 && S_ISFIFO(inode->i_mode)) =
||
>               (sysctl_protected_regular >=3D 2 && S_ISREG(inode->i_mode))=
))) {
> +               audit_log_path_denied(AUDIT_ANOM_CREAT,
> +                                     S_ISFIFO(inode->i_mode) ? "fifo"
> +                                                             : "regular"=
);
>                 return -EACCES;

Other callers typically pass an operation value more closely tied to
the syscall/function name, and that somewhat makes sense since the
syscall/function name is often verb-ish.  The code above, while
helpful in the sense that it distinguishes between types of inodes, it
doesn't give much indication about the "operation" which failed.  I'm
open to suggestions, but something like "sticky_create_fifo" seems
more consistent which current usage.  Thoughts?

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index aee3dc9eb378..b3715e2ee1c5 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -217,7 +218,7 @@ static inline void audit_log_d_path(struct audit_buff=
er *ab,
>  { }
>  static inline void audit_log_key(struct audit_buffer *ab, char *key)
>  { }
> -static inline void audit_log_link_denied(const char *string)
> +static inline void audit_log_path_denied(int type, const char *string);
>  { }

I probably wouldn't make you respin just for this, but since you may
need to respin this anyway, you might as well fix the above.

--=20
paul moore
www.paul-moore.com
