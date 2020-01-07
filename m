Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C0CC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B2220715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="CSduDkeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgAGCJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 21:09:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37926 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgAGCJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 21:09:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so31046120ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 18:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPbFRTSbrgv2vsPRCZzi5SM8FM6S6F8h8auzWw8AmS4=;
        b=CSduDkeGo0MiKWIBdBklgooJvwEsoyXlt60f1DCmYC3Qb4Vv/d8r7FGeOZTEdGBQZT
         ValZtuzYU65N1edWR6mP6aFA/CdxoNSlJMhrxVbPx9NOXgP6t9CIlIABDHZepmj9+9PI
         ckUqIfwABr86VYd8c8/qwsmaOkprP8EWlhg3/gchADjrujjxJ9MIjPeHOag6DxNUmpfg
         Apr/uwlwkEIkvQTwib83+RhWRrEJwRnjcCbjP6HZD/rHtmW77XAsmnrEl6ulTxQpklrB
         xRnSkUZnkdgxJZ32kC4eH1hfnp2PWIvr8qIhc07Hbk9RXxrIBp+siL9ZtpF2fzSSRj1D
         1Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPbFRTSbrgv2vsPRCZzi5SM8FM6S6F8h8auzWw8AmS4=;
        b=VAlpTA/fnH07VNke6CxBspcM7BM2iAi5MReqj7Q3TbQ3+F+hTBMPwSNAfltYGri9mC
         lrpZgFdcum7ugNGgavP5KC3vO+2MDsjF5z3o7cuvtGrL3IGKU6lnaVUwnwjtov+f07X/
         Le1NNrTRO7GmFpznl4aAqPIKy48qOfwC+wp3+qESBH+wImYL6f951dcEiLEnHb49Y45W
         3Ie5cuDM++c02b2ln8fnfhpTTFPNxkk9qeF5Sm9Yf5Zifq27m7gdgb//hjgWHZbuIabs
         6hIFOKmiIiYd1aHdmgxHEZur05Cj6r3fkdqugTJrkPiVyA29qRjvYIwiHDmKOpWPjadl
         2ASA==
X-Gm-Message-State: APjAAAWz+gpGvjzjiPNkfFlGxmuxKAbUdrFwJ5XhE42XkEPhThpcoidq
        zqUacrln/5yaDtI/ZqmT5cBB8MzmW+N5GZ9OKlng
X-Google-Smtp-Source: APXvYqyQjm3v8GTrdfXnWQTa2FVkbB17+WRRz+N5LoFT1P6TzsL8gkJ/g8HhbZEgdwPXkzh1zz0rC7j903Ofs+o568E=
X-Received: by 2002:a2e:7e11:: with SMTP id z17mr62223294ljc.117.1578362985508;
 Mon, 06 Jan 2020 18:09:45 -0800 (PST)
MIME-Version: 1.0
References: <1578361158-27940-1-git-send-email-liuyang34@xiaomi.com>
In-Reply-To: <1578361158-27940-1-git-send-email-liuyang34@xiaomi.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 6 Jan 2020 21:09:33 -0500
Message-ID: <CAHC9VhSy_vWSaRy9xJ+Uis1h1YvqM3nhmMZYB6O0ww=tVi3nxw@mail.gmail.com>
Subject: Re: [PATCH v2] selinuxfs: use scnprinft to get real length for inode
To:     liuyang34 <yangliuxm34@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuyang34 <liuyang34@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 8:39 PM liuyang34 <yangliuxm34@gmail.com> wrote:
>
> as the return value of snprintf maybe over the size of TMPBUFLEN, use scnprintf
> to instead of it in sel_read_class and sel_read_perm
>
> Signed-off-by: liuyang34 <liuyang34@xiaomi.com>
> ---
>  security/selinux/selinuxfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I corrected the typo in the subject line, and cleaned up the
description a little and merged it into selinux/next - thanks!

-- 
paul moore
www.paul-moore.com
