Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D96C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0312087F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AMPNdNyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfDRVwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:52:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34874 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDRVwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:52:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id j20so2711193lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 14:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UnclNOyKgaVdgRUC7bKMlUdq3Z/8THTWqN3fdo44i+I=;
        b=AMPNdNyzg0dcm4+VZaGNqKgWO1HB1nyOCsfpDKD81IUY9sxJJuoGUUYryM1PvH7pHc
         oDJrRv9pimFZR2H9RxXV4+gdKmNwao1L4GvKpATL9Paa6Ocap+a5zndCKsBoc64yvmSp
         DEBDDQKri44DqHqKV1iLj3IxBCbnN8x37UtZf3T6jx+CljBUjUjIBsxPY0TFyngKipL6
         eWQ0OhiF2C98QAt/YSzRK5oggGrqIVRJXBLcEDshaWeh+yZXJm7IBBtzvLJG/B7ovjeY
         oCfS6LLdzPWRBpyVXZtDOqL7Z/OmOWEh97kzR0JWcPrwlK007QI6+dVIAzNNt++aSdhU
         GZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UnclNOyKgaVdgRUC7bKMlUdq3Z/8THTWqN3fdo44i+I=;
        b=hZlfUeyq+1DYrhNYeDseZZ3mCUUpRk9BqS8OKVYyXQInOsFvd/Iw6nAIjvwHPp00vS
         u457VAVwr52yi+T2msdyeDUrAHyhjhGVTyZzauSgRu0SWSOxw5ePyr5gjmnv4YGn9xmz
         xYJtSxsa1d2E5svUMsIsNSqiopgZOxpiaeQhV99X1winY/8TEwTM68bDWyuOhXtCJBS9
         JyExmpeqTmyyEAGUkfEDBQTmNTjmPpdJ84ZUjoyn79UAkgCW4Xi01DX3C3XmdQaPMeKN
         G3fu9GWlP4B++xku3q7FyLp0ctB5/HbGNfsXvOn7gUBLj/sWdPTtaMQu5NvIWI5ZBDYb
         W3pw==
X-Gm-Message-State: APjAAAUESuzOEGDTzrmIxtM2oMBUWKPNkW/JOfNdtjo33mCC1RIQgmEk
        ABsZUmAUL0xk640KSekVcwFK15sVZF/tIBkOprxC
X-Google-Smtp-Source: APXvYqwv9Z637CTwkv6+3n7+VeJigEj0HVWhPsplZAl/38v1CEEQVL3j9dNZENGJZPDBRSFxiNbTU5tUvVVdvSqYs0Q=
X-Received: by 2002:a19:760f:: with SMTP id c15mr205457lff.105.1555624337550;
 Thu, 18 Apr 2019 14:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <1555609155-11934-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1555609155-11934-1-git-send-email-wang6495@umn.edu>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Apr 2019 17:52:06 -0400
Message-ID: <CAHC9VhT-9JDNVVQfh-uYcck=eRX3aRRG4CaMkidgLQ3Z1MHrRg@mail.gmail.com>
Subject: Re: [PATCH] audit: fix a memory leak bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Eric Paris <eparis@redhat.com>,
        "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 1:39 PM Wenwen Wang <wang6495@umn.edu> wrote:
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
> To fix this issue, free the allocated tree in the default case.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  kernel/auditfilter.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 63f8b3f..70a34db 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1128,6 +1128,8 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
>                 audit_log_rule_change("remove_rule", &entry->rule, !err);
>                 break;
>         default:
> +               if (entry->rule.tree)
> +                       audit_put_tree(entry->rule.tree);
>                 err = -EINVAL;
>                 WARN_ON(1);
>         }

Since there are only two "types" (_ADD_RULE and _DEL_RULE) and the
allocation is only three lines (audit_data_to_entry() + two lines for
error handling), maybe it makes more sense to duplicate the
audit_data_to_entry() call into the individual case statements so we
are only doing the allocations when we have a valid "type"?

-- 
paul moore
www.paul-moore.com
