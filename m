Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB125C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866DA20848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qq4Ew6ML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCYXxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:53:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44137 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCYXxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:53:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id u9so7248368lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2C3/YZIfjxsEf3cvSlX5xrvH6OIQ/5KnYDdX9pq9P+A=;
        b=qq4Ew6MLnLW6H7k0yTZDHnW1OrwRWkLdpvqq104AtAjL9c0ZOKjv4nSxN72oWlTV8t
         R0Yp4reZoRsrSQa1yJ3/WM6+/rj8eCs7sYtKU39UMwXW9+JWeGV16KkUkNaawGJ23iUz
         qVBizpbS4M/vCm5bFA5kSfZC9pknB5v5acC7Hv2ULoNkzIHPZf1MwCsDwDgJ/49Ddke/
         zs3rIqPb6I+JiWKtJqd/sDsujkDf4hpFiInsIHWXMaYeYJ7Ff73KYvuwuqTtQm6iU0Nb
         emcVBZya+xoUvhKKVD6bsri8LAKuSK6CMlsDvxU+d6Rgi2kT7Vwx7xzXuOctgEW/e1Q0
         Wqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2C3/YZIfjxsEf3cvSlX5xrvH6OIQ/5KnYDdX9pq9P+A=;
        b=ksP6722P3N5KV19uGCaXfk4rFKdLZiNqKvbXgjS+xnXDsUI6rmbjSyh1kuKq+PPKgq
         c69qZ0TGJtu5q8Jw0X4zS7rjmspHoX1DBBoDLylz+hPDAvpNikhunW29Z1fjjX533CDI
         88dPI85IdRaCYtt+iIwVCB9wDIfFGblPns58nbrKjIsg9I01byUoX39+kNEXwNt/NiDR
         Z2IHUzxwj9hIbDOmLJ78YTCSZAbLm5Ti0Kze6cjoWXFrjfRGAmBHafI7W6mVDVMXdMcw
         UFcbXzthCfzvSkQ8L8bX4AzJ9jbjyfdGspDgZiephp82ovH2P9HTgh8eVewX2xbkXxrF
         ufHg==
X-Gm-Message-State: APjAAAWjNfQmoSL4zKElFCkB52EnOGCU5CiMIJtKEJwMJ+1r8pd0ajeB
        z9VuMp5hXIqTw3pZCRsbvNgLI8+Na9dhQKp++9GL
X-Google-Smtp-Source: APXvYqynV8Ikurxi0oXyGibRiIrcukoR9Apwtj52nEez1ls3Ks4l8GRQ1gLcWvQ0Py7zhdEsAeiq5if4vmpBkXsdyaM=
X-Received: by 2002:ac2:5921:: with SMTP id v1mr1130268lfi.135.1553557978700;
 Mon, 25 Mar 2019 16:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190325232125.1781-1-casey@schaufler-ca.com>
In-Reply-To: <20190325232125.1781-1-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Mar 2019 19:52:47 -0400
Message-ID: <CAHC9VhRJUxnEyFvJQ3PR+aQTnGt=GZ+EZ-oBQihEE9WgQ9n5EA@mail.gmail.com>
Subject: Re: [PATCH] Bad file pattern in 'SELINUX SECURITY MODULE'
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 7:21 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> The include/linux/selinux.h file has been removed.
> Remove the entry from the MAINTAINERS file.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d263f29..1039c34dff3c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13947,7 +13947,6 @@ W:      https://selinuxproject.org
>  W:     https://github.com/SELinuxProject
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>  S:     Supported
> -F:     include/linux/selinux*

This is fine with me, but if we're updating this file, we should
probably add the following:

F: include/uapi/linux/selinux_netlink.h

>  F:     security/selinux/
>  F:     scripts/selinux/
>  F:     Documentation/admin-guide/LSM/SELinux.rst

-- 
paul moore
www.paul-moore.com
