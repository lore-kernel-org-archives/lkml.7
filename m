Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F6BC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD86A2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SqOVYIgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388481AbfJCS3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:29:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46457 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfJCS33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:29:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id d1so3833184ljl.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cO77cLY9Zi5R0T68SRSCW4d8IffVADLpJPQ8SXEy8c=;
        b=SqOVYIgy87r6YtFTTSo9IZe+fDrUsz6DGqmrCEZAnJwFB7tO2dmG/aN/PlwDaJNECn
         kpXEzPAlsE2a8m2uf1Jff+hFsdVmg5kJUzZe4/Q/9cI9cd2/P2y47+3YWC/gG8X9cuim
         Cla4F1XSGPdDS6kSLMnITzhr0WxlrK5UOkUd5ybXXi5S0ZAv+kLNviYNWAKS2RMqXJJi
         F8N3bi87ArMe5/5QwCfc1mk+QhmpYL3miNsati1Liw2wVhmJdDUkkQLYiYJQbWYGqCBQ
         YTjv6q42JzBtEvqCcZ35Wkg0gm4YV7zv0p9S4+cwtcq7gM35s1E+Zqw6VSVe3mNJnjAX
         4LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cO77cLY9Zi5R0T68SRSCW4d8IffVADLpJPQ8SXEy8c=;
        b=I98ZihgMZQGIVqm4XZ2zdyVRsCFszicIWL/+Jt8slEh+Z7z4SwxMD3TwY6Kc1ZL8+V
         IKRp9QDBnPvv4Adncbc88ldg5aPHQkcspe6fnc8QD0NbZPdwOAvKZQcXTL0Y68uJbSzB
         gSXlBXcvo2QLiMv+gusaCe+c2ZxAwzxux+ECDMZxhqVurQEtky9j2iPxWOskQ7U07q5b
         /9SrQC9RkKcyUGWOLFj+ypPEG5wgeZBOarZsWC83HigJhvhGB+gNKTlmfwpmx50+HnUc
         IvndTGKnbAACblGVFmpzKn239NpXHSm6XQUBzDUDWYC83qAWatY89Nd4Cvdu7jc0jyDb
         GNoA==
X-Gm-Message-State: APjAAAU4Moa6ijiNXPuuu0/ngLGKTdiRQYFd0RSe6qzD8zzI1+KvDOiS
        6vUd1c62nCi+3q0Q65FEay3mGxi9j2Cj79XZSGKJ
X-Google-Smtp-Source: APXvYqziNAxWP+LWtRPmp0JQpUGI/15O8lUpsN9fOIt1PlWaVDDr0iDcTZbKN2QdCZ+ABWX+Rg5xj+YrJvdZNibPWds=
X-Received: by 2002:a2e:b4c5:: with SMTP id r5mr679986ljm.54.1570127367536;
 Thu, 03 Oct 2019 11:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <201910021640.B01FA41@keescook>
In-Reply-To: <201910021640.B01FA41@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Oct 2019 14:29:17 -0400
Message-ID: <CAHC9VhQKyHAvNhuquVEYXP9U7ix2pDwXGnRO6QaxYTUKA08=UQ@mail.gmail.com>
Subject: Re: [PATCH v3] audit: Report suspicious O_CREAT usage
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 7:42 PM Kees Cook <keescook@chromium.org> wrote:
>
> This renames the very specific audit_log_link_denied() to
> audit_log_path_denied() and adds the AUDIT_* type as an argument. This
> allows for the creation of the new AUDIT_ANOM_CREAT that can be used to
> report the fifo/regular file creation restrictions that were introduced
> in commit 30aba6656f61 ("namei: allow restricted O_CREAT of FIFOs and
> regular files").
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3:
>  - retain existing operation names (paul)
> v2:
>  - fix build failure typo in CONFIG_AUDIT=n case
>  - improve operations naming (paul)
> ---
>  fs/namei.c                 |  8 ++++++--
>  include/linux/audit.h      |  5 +++--
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 11 ++++++-----
>  4 files changed, 16 insertions(+), 9 deletions(-)

Merged into audit/next - thanks!

-- 
paul moore
www.paul-moore.com
