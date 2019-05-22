Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D0FC072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36F22173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PVPFHzry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfEVCXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 22:23:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35252 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEVCXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 22:23:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id h11so595589ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 19:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FoATy8oZsskl8ARNANZmhlDNjVNkchw4y2fRYzB5sLg=;
        b=PVPFHzryLgdl317MtVFNF4zHtZ9oKN1Vd1ljsQiqgKDbN6uztGOCkcuaO1VMftuRnl
         VutoyZXPws6YtnCNpjj9ORtgriTRvWLuXp/nIUG2YEUsBp4CfNtxNUOv5zggwq0JxNyz
         JBXDPdq3cVwXGcV6Ubb3Blx2+t1YYDNbK9njZwcTI90V69psWIQ4514/glNSAUPL5X21
         gtxk6nQ3MxfjVWV7isrI/fSN7QLV9ZkhGslrh+IVoTnIFM9OlaDbJdKz+b8iQLJrbn4w
         fhjDX/9ncQqEvq8vus8mrlUzoUtFL0s/hPPOIfe8IYhh8vKKzsSAevcW55XIjoEBbiZO
         hMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FoATy8oZsskl8ARNANZmhlDNjVNkchw4y2fRYzB5sLg=;
        b=g5UVpKDs9mSociL6Hvavv8O9yePRf5O1CaH9uPQueuyqhpVGkCdhjx5i7qxiJcyNl1
         truYA2oi6FyQzoCjKTh9n/JSwGE3ufwhtUzbZCVTgifTudigzfmuOMQi5IsoAbCXtYff
         jDsITNEUFiUHyXbwEYmmBQz+drnVWxLXRgdNOIU0U9Na9GCA730BRZ3CzJh3hDmX+b7D
         KC6jEDr2O0cB4k80VUff0FoFoztnw/AJwQDFUk+WDlecaqMCBy9reAg5rmfAemxbimbf
         JTAv0YVOoWcE2XCdgotoLAN9xkHCsbfL2VI5JbX/ZgBFS0XfBieRdZPN440ZJhA3kUr1
         /D3A==
X-Gm-Message-State: APjAAAXUdiWq3GhRRBxD6K9oMJaTHUzlYL46vQgqqd/u55P+OSq961V3
        6ruWB+9D7MpwwXVxTgPoihQQw60gZHmg3lUtzzoa
X-Google-Smtp-Source: APXvYqy8jWokTyif6KzOybi3pSR8WmhOtchqhgdhvt7RrSGFTqkGrmdUyolCs+vmB7F+uW4cl7gy9HWttXA8XM5+5fI=
X-Received: by 2002:a2e:1412:: with SMTP id u18mr8759792ljd.197.1558491817982;
 Tue, 21 May 2019 19:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <67828806f9d2bf0f1e98e24afa58af55c8c8678f.1557358701.git.rgb@redhat.com>
In-Reply-To: <67828806f9d2bf0f1e98e24afa58af55c8c8678f.1557358701.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 May 2019 22:23:27 -0400
Message-ID: <CAHC9VhQ2X_iVO658JP5GgUy8rsr_LnqeJNeQTiWKnQxaCUUFKw@mail.gmail.com>
Subject: Re: [PATCH ghak111 V2] audit: deliver signal_info regarless of syscall
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

On Fri, May 10, 2019 at 12:22 PM Richard Guy Briggs <rgb@redhat.com> wrote:
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
> Changelog:
> v2:
> - change patch title to avoid siginfo_t confusion
> - change return value to "0" from AUDIT_OFF
> - use dummy functions instead of macros in header files
>
> Compile/boot/test auditsyscall enable/disable, audit disable,
> auditsyscall enable/selinux disable.
>
>  include/linux/audit.h |  9 +++++++++
>  kernel/audit.c        | 27 +++++++++++++++++++++++++++
>  kernel/audit.h        |  8 ++++++--
>  kernel/auditsc.c      | 19 +++----------------
>  kernel/signal.c       |  2 +-
>  5 files changed, 46 insertions(+), 19 deletions(-)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
