Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3281CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8DC21906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECo9AIei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504093AbfJXSfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:35:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36491 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504082AbfJXSfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:35:37 -0400
Received: by mail-io1-f67.google.com with SMTP id c16so10877622ioc.3;
        Thu, 24 Oct 2019 11:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxI2DuhK3zOVoysZfJnxdcvpsN8qp9TCcsVnGEAYJmg=;
        b=ECo9AIei6Q87z3VdpFYKEmxBFPmAD5SoxsjHkkfSB4a6UrDlagS+q6oL8plddaVYdg
         A9gfYOa+6r5pFo/Bti8QjyZOhV3m7FklUMHsG9KL9LHD8duCpjD4P5fD/kOae5wy3G0p
         Kfm7DDmr1iw9fM2e8PZwKOE3pPaEVyG+oGz6raCBxPWEQ3JLCEwP5PhxwD+MfakEXyQh
         maYDoATesnnX4IWlLs3y0Q1nlPnuNYJqdM9rPf20wbWQeyOh8sh3oChaA0Crn0ignJin
         j9jL4R7QjFqX2OYw/eOejvoB+rYK5ZL8Q4YrDil7Jq7eSRsbD0tndKQiHhB/UzJiKF1o
         lcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxI2DuhK3zOVoysZfJnxdcvpsN8qp9TCcsVnGEAYJmg=;
        b=AZCLYRbSyVbJE+XhHpx0K67NjhiUBXCODsXMKHCFrxVMOMyF8CrXJmJgPOOizrXdo/
         CxLzhyxG1aq9ZVMW4sZASd8VMA76sZ8kcZAwUhaU0Lp2JXqP1FAnoP8UdpSX9LtKduH2
         oR56DdBh2R4juUzpGD1Na87gyYkIgPCdLc+Vo04vUTMrIEkJuNS+ubxLOEg0N/6AZDr3
         YkVyEHCzZZ85qiqv9/sAeGxwsGkXVtNbTkrtkuzfuUS3P0ghya4D0KSpUEiWvo8/IJRE
         oVR0g7+J2rBsQ//8Uz+uxeUSd/YJImYwFpRYImEWZxfT3WROJrn1Xxnn7+BS14hbKezQ
         6GAA==
X-Gm-Message-State: APjAAAU9atR5aai7BUStHaPeBHv1qr+tj5/AZ1MHahUL/8jYkhEPQFVe
        ambUtzylNSPD+Byn7+bzP81tG5GWDDWIg95H5JE=
X-Google-Smtp-Source: APXvYqyV3j6Nj0JO8s/edvZRPXjfgtVRy4383ka1fR/X8RRAqT7EZ2eepZ/RhR+0nbA8U2xrMeF4oMWueyzrjyFn7G4=
X-Received: by 2002:a5e:9e0a:: with SMTP id i10mr10755511ioq.172.1571942135778;
 Thu, 24 Oct 2019 11:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1910241326470.9562@hadrien>
In-Reply-To: <alpine.DEB.2.21.1910241326470.9562@hadrien>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Thu, 24 Oct 2019 13:35:24 -0500
Message-ID: <CAEkB2ER5TOviwk4teTVLJO=jFEbi_NWVqjMEg2jYzL7x4027gg@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix odd_ptr_err.cocci warnings (fwd)
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     John Johansen <john.johansen@canonical.com>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tyler Hicks <tyhicks@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I added Tyler to this conversation.
I believe v3 of the patch addresses this issue:
https://lore.kernel.org/patchwork/patch/1142523/


On Thu, Oct 24, 2019 at 6:28 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> Hello,
>
> The change suggested by Coccinelle is not correct, but the original code
> is not correct either because the argument to PTR_ERR should be a pointer,
> not an integer.
>
> julia
>
> ---------- Forwarded message ----------
> Date: Thu, 24 Oct 2019 18:21:57 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@lists.01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: [PATCH] apparmor: fix odd_ptr_err.cocci warnings
>
> CC: kbuild-all@lists.01.org
> In-Reply-To: <20191021152348.3906-1-navid.emamdoost@gmail.com>
> References: <20191021152348.3906-1-navid.emamdoost@gmail.com>
> TO: Navid Emamdoost <navid.emamdoost@gmail.com>
>
> From: kbuild test robot <lkp@intel.com>
>
> security/apparmor/audit.c:199:5-11: inconsistent IS_ERR and PTR_ERR on line 202.
>
>  PTR_ERR should access the value just tested by IS_ERR
>
> Semantic patch information:
>  There can be false positives in the patch case, where it is the call to
>  IS_ERR that is wrong.
>
> Generated by: scripts/coccinelle/tests/odd_ptr_err.cocci
>
> Fixes: 6f939f24599c ("apparmor: Fix use-after-free in aa_audit_rule_init")
> CC: Navid Emamdoost <navid.emamdoost@gmail.com>
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>
> url:    https://github.com/0day-ci/linux/commits/Navid-Emamdoost/apparmor-Fix-use-after-free-in-aa_audit_rule_init/20191024-123239
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-testing
> :::::: branch date: 6 hours ago
> :::::: commit date: 6 hours ago
>
> Please take the patch only if it's a positive warning. Thanks!
>
>  audit.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/security/apparmor/audit.c
> +++ b/security/apparmor/audit.c
> @@ -199,7 +199,7 @@ int aa_audit_rule_init(u32 field, u32 op
>         if (IS_ERR(rule->label)) {
>                 int err = rule->label;
>                 aa_audit_rule_free(rule);
> -               return PTR_ERR(err);
> +               return PTR_ERR(rule->label);
>         }
>
>         *vrule = rule;



--
Navid.
