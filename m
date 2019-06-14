Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33CEC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ABA2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFNIFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:05:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46475 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfFNIFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:05:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id z23so1772019ote.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 01:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+cBvUSvUwljJzZGmDUiwDo+HPkbVxvHXHt9BRXDb/A=;
        b=Z70cQw14NwOBVvEAdEWcsUosnAonfvTedqX0t+8FAlXzx2mg5Vror288pKI/q80PPp
         /ufjm5ZPnyhNqX8WkqBNED0BmBvIjMsmrK+wMwr/lEO51benbkkiLEgqGfV8VHLSVJwk
         +RKZuiJpWkprxS7o1U1LvrS/jq+SN2zDdvkzm5GsdCGGb2cnniQ5QAGlSnAD3qdcqAUn
         JFWrL38C1Q1lixT2w5DxbomfF9XNX4k6IrwDlHyIo0noViwS5u7oqCRXSAGn6J2dIn+Y
         xRYhBG7dW2aPcs8PQuWV9NULZUibPFzUAmLBKV8cFP7lJr5sUsx4O63Go6xU45H5hdCk
         enSw==
X-Gm-Message-State: APjAAAUufb8BvS9NDxjMLO1FBCI1Xer2N1f4c/DgReVT3Id36C5lfRvf
        Xw2lMoGd6zjcIe/IZhtQ5G3+MFCQ347Ag+W2QK82mA==
X-Google-Smtp-Source: APXvYqws/BIn0xh694klgJH9Xrz/VJPcXmFAB6yMRzOoeD0HBCOu65JzqDT8ctr6waWftZDpsINN+tTG3pDGakWWlc8=
X-Received: by 2002:a9d:73cd:: with SMTP id m13mr10590092otk.43.1560499505394;
 Fri, 14 Jun 2019 01:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <53af233d05da5e07d75d122878387288a10276df.1560447640.git.rgb@redhat.com>
In-Reply-To: <53af233d05da5e07d75d122878387288a10276df.1560447640.git.rgb@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 14 Jun 2019 10:04:54 +0200
Message-ID: <CAFqZXNvTAj_MhgbUB0kbQwF+gDQTTO5jXPagQfW9qwfHEzc1iQ@mail.gmail.com>
Subject: Re: [PATCH ghak57 V1] selinux: format all invalid context as untrusted
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 8:43 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> All instances of one field type should be encoded in the same way.
> Since some invalid_context fields can contain untrusted strings, encode
> all instances of this field the same way.
>
> Please see github issue
> https://github.com/linux-audit/audit-kernel/issues/57

I would add at least a short explanation ("The userspace tools expects
all fields of the same name to be logged consistently.") directly to
the commit message. Funny that Paul warned about this on the SELinux
ML just yesterday :) [1]

>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Passes audit-testsuite.
>
>  security/selinux/ss/services.c | 48 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 10 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index cc043bc8fd4c..817576802f7d 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1588,6 +1588,8 @@ static int compute_sid_handle_invalid_context(
>         struct policydb *policydb = &state->ss->policydb;
>         char *s = NULL, *t = NULL, *n = NULL;
>         u32 slen, tlen, nlen;
> +       struct audit_buffer *ab;
> +       size_t audit_size;
>
>         if (context_struct_to_string(policydb, scontext, &s, &slen))
>                 goto out;
> @@ -1595,12 +1597,22 @@ static int compute_sid_handle_invalid_context(
>                 goto out;
>         if (context_struct_to_string(policydb, newcontext, &n, &nlen))
>                 goto out;
> -       audit_log(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR,
> -                 "op=security_compute_sid invalid_context=%s"
> -                 " scontext=%s"
> -                 " tcontext=%s"
> -                 " tclass=%s",
> -                 n, s, t, sym_name(policydb, SYM_CLASSES, tclass-1));
> +       /* We strip a nul only if it is at the end, otherwise the
> +        * context contains a nul and we should audit that */
> +       if (n) {
> +               if (n[nlen - 1] == '\0')
> +                       audit_size = nlen - 1;
> +               else
> +                       audit_size = nlen;
> +       } else {
> +               audit_size = 0;
> +       }

If you reasonably assume that (n == NULL) implies (nlen == 0), then
you can simplify this down to:

    audit_size = nlen;
    if (nlen && n[nlen - 1] == '\0')
        audit_size--;

(or similar), see my recent patch to log *rawcon as untrusted [2].
That is IMHO faster to parse. But I see you copied it from
selinux_inode_setxattr(), where it is like this... I'm not sure if it
is worth changing this patch / consolidating the style across all
places that do this / creating a helper function...

> +       ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR);
> +       audit_log_format(ab, "op=security_compute_sid invalid_context=");
> +       audit_log_n_untrustedstring(ab, n, audit_size);
> +       audit_log_format(ab, " scontext=%s tcontext=%s tclass=%s",
> +                        s, t, sym_name(policydb, SYM_CLASSES, tclass-1));
> +       audit_log_end(ab);
>  out:
>         kfree(s);
>         kfree(t);
> @@ -3007,10 +3019,26 @@ int security_sid_mls_copy(struct selinux_state *state,
>                 if (rc) {
>                         if (!context_struct_to_string(policydb, &newcon, &s,
>                                                       &len)) {
> -                               audit_log(audit_context(),
> -                                         GFP_ATOMIC, AUDIT_SELINUX_ERR,
> -                                         "op=security_sid_mls_copy "
> -                                         "invalid_context=%s", s);
> +                               struct audit_buffer *ab;
> +                               size_t audit_size;
> +
> +                               /* We strip a nul only if it is at the
> +                                * end, otherwise the context contains a
> +                                * nul and we should audit that */
> +                               if (s) {
> +                                       if (s[len - 1] == '\0')
> +                                               audit_size = len - 1;
> +                                       else
> +                                               audit_size = len;
> +                               } else {
> +                                       audit_size = 0;
> +                               }

analogically here ^^

[1] https://lore.kernel.org/selinux/CAHC9VhRwKjp9qwqMB3p7intdpxFT1oYVOUKmoEcwZcN1VAC-UA@mail.gmail.com/T/#m1515af36ca98dceddfb6c9f795e1dfa2ac6e8a1b
[2] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?h=stable-5.2&id=aff7ed4851680d0d28ad9f52cd2f99213e1371b2


> +                               ab = audit_log_start(audit_context(),
> +                                                    GFP_ATOMIC,
> +                                                    AUDIT_SELINUX_ERR);
> +                               audit_log_format(ab, "op=security_sid_mls_copy invalid_context=");
> +                               audit_log_n_untrustedstring(ab, s, audit_size);
> +                               audit_log_end(ab);
>                                 kfree(s);
>                         }
>                         goto out_unlock;
> --
> 1.8.3.1
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
