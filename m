Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7DFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538FA218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="GNlxODKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfCTXsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:48:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33294 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfCTXsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:48:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so3850063ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 16:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJAjnNyQyoI4jcj7/tfz9qZtFR2QTmyN6OQ6+gk8aHo=;
        b=GNlxODKY2cXGyDHBJEhylwuxzug2kEMQAVHe9ybfvYikmW4u8u7H0YWR6hjaL8nhM6
         0QWC+dqjBlwh8WvBs2n8RLbXrazQTIclC/ckW49RJ/QYVszS58s6151LARHFVaN53bRi
         LQVMi2joNkMRgIs9XGXQ+auxkKVuf0mdnmdN7sECNRgKm/BrIszzV4Qlzs42xhlQbID9
         1X5aVYh/0S4eOZnj9wwIXpQChYorQeGj0EEcAXyjmbs5aJFCqZJxQTX2WqHKhuvBQ3jN
         GdafozoBuv/MCXJx0CJzaaYbxVcFNVYVR2VVoA2ysURCJpiicDDlCIcfgtser2cwltFZ
         SFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJAjnNyQyoI4jcj7/tfz9qZtFR2QTmyN6OQ6+gk8aHo=;
        b=YvhTWH0H1CODzvs5cCM7dZRxHclHDWyXKvhpBpCjw8y+czHYshm6eKkGQfN93STXI7
         faKVdsryVIXKzB/yEKpDYL5twuvRiVgEvsh7BkRpWLz6uM9DXygrSpmLd6GhLkTvkGYx
         185PamIHsYC9VzFG7Oy6mbkuYG3D5WVOqiWMfMKP4Rfa+gzjaW1PgbXlhUrxk/IkkFGa
         pIEzEWxF9zcbg23fB6CO9064jU4SjGWq+h0+JAVpNkNKHyQs7A+N3q3h6Xk0zB+NF213
         H8zhZgwncCWfp1or3QSb7J1590GiOr3dqbK9X5hGq2sWOHgKBs8FdwMl8KGhzK7wvztV
         wpmw==
X-Gm-Message-State: APjAAAUqwtwh8WaahechV5ccEd5BaIy7PM7SrX01GLLu1n/gBvrEVt1A
        2876Sm/1gemq4A47TnYla9iumchKZitWCG5r89iP
X-Google-Smtp-Source: APXvYqyTy/0Jx0A5zxhGXII9imQPLaDDUiMBztEy9QyBkli0QjSD2HhZ7X6GxqIdMe4bebjgTMzPGSR+c8tXwI+QEGM=
X-Received: by 2002:a2e:500d:: with SMTP id e13mr345820ljb.169.1553125700851;
 Wed, 20 Mar 2019 16:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <81d0122d14c4fbb3a2ad33d25fdf2dd001c7dcc7.1552737854.git.rgb@redhat.com>
In-Reply-To: <81d0122d14c4fbb3a2ad33d25fdf2dd001c7dcc7.1552737854.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 19:48:09 -0400
Message-ID: <CAHC9VhS61LTQMXiALRre+5_+wvwe6Wa9RN-WYNTjvz5LVsA5rw@mail.gmail.com>
Subject: Re: [PATCH ghak109 V1] audit: link integrity evm_write_xattrs record
 to syscall event
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, zohar@linux.ibm.com,
        mjg59@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 8:10 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> In commit fa516b66a1bf ("EVM: Allow runtime modification of the set of
> verified xattrs"), the call to audit_log_start() is missing a context to
> link it to an audit event. Since this event is in user context, add
> the process' syscall context to the record.
>
> In addition, the orphaned keyword "locked" appears in the record.
> Normalize this by changing it to "xattr=(locked)".
>
> Please see the github issue
> https://github.com/linux-audit/audit-kernel/issues/109
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/integrity/evm/evm_secfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index 015aea8fdf1e..4171d174e9da 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -192,7 +192,8 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
>         if (count > XATTR_NAME_MAX)
>                 return -E2BIG;
>
> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_EVM_XATTR);
> +       ab = audit_log_start(audit_context(), GFP_KERNEL,
> +                            AUDIT_INTEGRITY_EVM_XATTR);

This part is fine.

>         if (!ab)
>                 return -ENOMEM;
>
> @@ -222,7 +223,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
>                 inode_lock(inode);
>                 err = simple_setattr(evm_xattrs, &newattrs);
>                 inode_unlock(inode);
> -               audit_log_format(ab, "locked");
> +               audit_log_format(ab, "xattr=(locked)");

Two things come to mind:

* While we can clearly trust the string above, should we be logging
the xattr field value as an untrusted string so it is consistent with
how we record other xattr names?
* I'm not sure you can ever have parens in a xattr (I would hope not),
but if we are going to use the xattr field, perhaps we should simply
stick with the name as provided (".") so we don't ever run afoul of
xattr names?  I'm curious to hear what the IMA/EVM folks think of
this.

-- 
paul moore
www.paul-moore.com
