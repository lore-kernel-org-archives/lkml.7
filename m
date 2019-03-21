Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B4DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FC721902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553188016;
	bh=Z0TElPGWZSWlaikZLt8SCY2ee3JnG2HgbznQh5bPGA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yr1FkZ3brhxs3TrpNrcYm5qu93rQbHdfcwvcK2EZTUt/HV/I1ITvDxPnnjA1Ubczr
	 93lN4u9BNLZaeOKYaq4fBVOfjRWSWPoYrHd21vuCz21AP/xNyp+wgj3sxtEWRBv5Yg
	 MSVUPL/aGCXguQacbXFXXkQWbS533IflDtLhgG/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfCURGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbfCURGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:06:53 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A81921902
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553188012;
        bh=Z0TElPGWZSWlaikZLt8SCY2ee3JnG2HgbznQh5bPGA4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LOOWJuByXdD8b1+jaFaSyr2zkkWalCl3ge3GcdiEL7xQhxqFstxkD3iPS5oivvNwv
         fXk7botuCK+0WuBs1LpokFKGPVRJyzjSCtkieDm7ekaZBH6QL5NcHPnwJvbrZPlg5y
         cf8jq5Ru86+dYbkwriWjrXA3+kdpKbhGC5HnJoSE=
Received: by mail-wm1-f53.google.com with SMTP id z6so2487275wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:06:52 -0700 (PDT)
X-Gm-Message-State: APjAAAWtLtuUum5KfL9ACsplMVryV1Qxw7y8+nXH31DQZ2ezyjXFH9Xc
        mYORueWPCkY5stwCGBViEiBaJruCkchTA2kNmVWZEQ==
X-Google-Smtp-Source: APXvYqw9fxSzavVM3tXaXRt/rhdinjzhhKhJU7acerv1J9dDxMrkI0ygy6nBjAJL0JUkzYY0tWp8lyptxfBQBLfhJXs=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr217890wmh.74.1553188009218;
 Thu, 21 Mar 2019 10:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190320143717.2523-1-cyphar@cyphar.com>
In-Reply-To: <20190320143717.2523-1-cyphar@cyphar.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Mar 2019 10:06:38 -0700
X-Gmail-Original-Message-ID: <CALCETrV-Q4qZXGeavBPQbF6-VVz7hqvjRkbhFeYmbGiQgu5Omg@mail.gmail.com>
Message-ID: <CALCETrV-Q4qZXGeavBPQbF6-VVz7hqvjRkbhFeYmbGiQgu5Omg@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 0/5] namei: vfs flags to restrict path resolution
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 7:38 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> Now that the holiday break is over, it's time to re-send this patch
> series (with a few additions, due to new information we got from
> CVE-2019-5736 -- which this patchset mostly protected against but had
> some holes with regards to #!-style scripts).

I generally like this, but, as Linus pointed out, it will be
unfortunate if application authors see this as just another
non-portable weird Linux API and don't use it.  Would it be worthwhile
to put some thought into making it an API that other OSes might be
willing to implement?  As it stands, the openat(2) flags are getting
rather crazy in this patch set.

Aleksa had a resolveat(2) proposal that really didn't seem too bad.
