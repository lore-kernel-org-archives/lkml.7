Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E61CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADD720645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="dSxlCpbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfDST2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:28:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33555 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfDST2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:28:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id j11so4691111lfm.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8awkoFgJo+7sK0/t71k/qt5Gg5gyX9rXy3SAgYCU+U=;
        b=dSxlCpbLirYkjVORpxe+f+H6+6jho/uixN8Rws9Ju2GRfPAgh4P3cSj45wsYrHpGdd
         t3ElM5Z4PShUQJtPAQLTOoFw4OAdKyRdoWQgVUFkA4i2x+EHXAukvaRbs01lT2absiwt
         30YE4MRhtZTOsmrLfW4alm/lIypUsLQdZNo6RqtnVIaOi3aNRXZAYZmN+LKxqnBWpryA
         XNAQJAyCazdJO1XUVj0ZXkMqKf+bm8GNmUC3f3H9+nCoFR42tyDSA0K2csZ6cwTw4t7+
         Yfk09FCamdjkN+Zmr25Jgi90G++8EIKITP9uDuWJl9wuZE4zTFUAjc5iQYA/W4b1uoE4
         Ii2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8awkoFgJo+7sK0/t71k/qt5Gg5gyX9rXy3SAgYCU+U=;
        b=LrYOiO1XDS4ruWhdPRXim4quAHSgL+H/2YwZahUrsqgpKHSaBqNta3WlkJVtg9Mkt9
         7HrWGkAwkanQSf8Tb+7hk4iHOBCd+dZR1LBfi2Z4KxNTGrRxLVdoISoNWfOkXT1VIdCH
         MJjpdHuZKRclAy6nsLyejHamszVndyEZRn9RatFY68wrDnzLtXtShDlUU5BC/BOMTL5m
         9PYDppIGrjBaUFJ6yPqluE9B6tEHKD+u3pB/6DLiNFDYgMh4nYvD+CMstx0GhcFDyiJH
         rdbDHJD00mYc+uhGxWSs8hxhVMG0kcFyqfWUHt2YWzmI1X0fu1+6pi/uP2rQvYmULiuc
         NU2A==
X-Gm-Message-State: APjAAAVywPkO7KRVjQun9PbUUy3GD3BHw99woxymxkgoFGROg7TEq4fy
        5o2Rme9AMhR1k6//rjuGYzxhmdRcFSlvBRIWPMaY
X-Google-Smtp-Source: APXvYqzBJqbVUnf0fY0jaEzpCdPCVacMyfip+5rGxzp4JLaXM+UOIkL3UXFqlLikP6OgQcV4L4M5RVNsMxr37VBeTs8=
X-Received: by 2002:a19:2814:: with SMTP id o20mr3081918lfo.117.1555702130446;
 Fri, 19 Apr 2019 12:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <1555686587-13866-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1555686587-13866-1-git-send-email-wang6495@umn.edu>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Apr 2019 15:28:39 -0400
Message-ID: <CAHC9VhQNGiw_+KhZPC7DhzS83u3gi+Ch1AKCeZitsFg=98gUDA@mail.gmail.com>
Subject: Re: [PATCH v2] audit: fix a memory leak bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Eric Paris <eparis@redhat.com>,
        "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 11:10 AM Wenwen Wang <wang6495@umn.edu> wrote:
>
> In audit_rule_change(), audit_data_to_entry() is firstly invoked to
> translate the payload data to the kernel's rule representation. In
> audit_data_to_entry(), depending on the audit field type, an audit tree may
> be created in audit_make_tree(), which eventually invokes kmalloc() to
> allocate the tree.  Since this tree is a temporary tree, it will be then
> freed in the following execution, e.g., audit_add_rule() if the message
> type is AUDIT_ADD_RULE or audit_del_rule() if the message type is
> AUDIT_DEL_RULE. However, if the message type is neither AUDIT_ADD_RULE nor
> AUDIT_DEL_RULE, i.e., the default case of the switch statement, this
> temporary tree is not freed.
>
> To fix this issue, only allocate the tree when the type is AUDIT_ADD_RULE
> or AUDIT_DEL_RULE.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  kernel/auditfilter.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

This looks good, it just needs some minor vertical whitespace fixes (see below).

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 63f8b3f..923b858 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1114,22 +1114,28 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
>         int err = 0;
>         struct audit_entry *entry;
>
> -       entry = audit_data_to_entry(data, datasz);
> -       if (IS_ERR(entry))
> -               return PTR_ERR(entry);
> -
>         switch (type) {
>         case AUDIT_ADD_RULE:
> +               entry = audit_data_to_entry(data, datasz);
> +               if (IS_ERR(entry))
> +                       return PTR_ERR(entry);
> +

I realize you are taking the blank line from the code above, but we
probably don't need it here.

>                 err = audit_add_rule(entry);
>                 audit_log_rule_change("add_rule", &entry->rule, !err);
>                 break;
> +

Definitely do not add this blank line.

>         case AUDIT_DEL_RULE:
> +               entry = audit_data_to_entry(data, datasz);
> +               if (IS_ERR(entry))
> +                       return PTR_ERR(entry);
> +
>                 err = audit_del_rule(entry);
>                 audit_log_rule_change("remove_rule", &entry->rule, !err);
>                 break;
> +

Same here.

>         default:
> -               err = -EINVAL;
>                 WARN_ON(1);
> +               return -EINVAL;
>         }
>
>         if (err || type == AUDIT_DEL_RULE) {
> --
> 2.7.4

-- 
paul moore
www.paul-moore.com
