Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406F6C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4683E2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRWUNUxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbfDYUpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:45:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33337 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387769AbfDYUpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:45:54 -0400
Received: by mail-io1-f68.google.com with SMTP id u12so1210180iop.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTCIXrMkQw8DWjirY0wbyKHBu3z39INvewV6V58xb34=;
        b=MRWUNUxAgMtfjEUKh5EiicK3Gw8p3WkCwK0DaRezcQPhpuLx8df5emcz4NTK4E5D1o
         gAu0JkwLC+9tUT8zbS9e51olKa2jyblmviizLkXanyqOnYG93fxu/gElGFUGcmWOp/OB
         IfKtowKQ+80dsUp4qfifBulhtVIsPHSkOGGHLmB3TAgUTCkCcfBTt3ncKeByczcklw+c
         5YOVm2E0mHEqz+FQwKO+YAzhUkzxvF2dlEBEo0uyQ/CjOPgK7+JpfaFUw8R76QnHKmaX
         8u7U2ZhFNXvy/CCqKWdoRxpJjYhvxFtD4Ta/5Ij26a4vTAxBONBuPgh04ErsTEKhI/JX
         uHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTCIXrMkQw8DWjirY0wbyKHBu3z39INvewV6V58xb34=;
        b=PxDWUPrl5d4YyzIxWruXp1qotYvkedgMEvrHMsUS5/JKdMB/MfJP3aV41d/Wx6lgsC
         7jiY5K235EOOMwB0yeV7TgHHhCeN8rgP9oeQS+1g3Byys+SyO2K3+/+GXjoCLUIvRIL7
         c49wx4aWlZRCaHKs21GEjdWEPOIuBb1rOcABVwVP9jPYAqNwludk81qoFCEc6B/W94od
         wdl/mnPacITrhx4lT7t05vpLHz2JbZt7go1hOJsxk8mWuFjDYJqZXIjaCcYjYtuAgUJq
         w0oTQ46rS90Pm7J7WnaKC9Z/Sh7/mJhP0WJBJ7ScokdKF4EyF6KaD7ZcgPMKZf5RLIEq
         HwuQ==
X-Gm-Message-State: APjAAAWXYaqfaTqAFGlN79+owMQ2e1ITJww8RRynBdAGW5t2NRFhRqCr
        EUDWQ0+gkDssM2viKUmfHR1VVhhkduFhtP3j0/MSK3Pw278=
X-Google-Smtp-Source: APXvYqxXUTfVNIfA/fuKFQepO3/TNOnkhuDEVEZ0HByFbGB34orvrJ/gIzU17shHf9oBJnXNEcjKm3AfDav4RWXi5X0=
X-Received: by 2002:a6b:e20e:: with SMTP id z14mr24868217ioc.169.1556225153517;
 Thu, 25 Apr 2019 13:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190424211038.204001-1-matthewgarrett@google.com> <20190425121410.GC1144@dhcp22.suse.cz>
 <1df0ef0c-4219-c259-18a2-9abfb2782c08@suse.cz>
In-Reply-To: <1df0ef0c-4219-c259-18a2-9abfb2782c08@suse.cz>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 25 Apr 2019 13:45:42 -0700
Message-ID: <CACdnJuvU4jZJwtpcZq4_t+qujV3X_YLwo=FoDKoNmP74=z7Hng@mail.gmail.com>
Subject: Re: [PATCH V2] mm: Allow userland to request that the kernel clear
 memory on release
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 5:44 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 4/25/19 2:14 PM, Michal Hocko wrote:
> > Please cc linux-api for user visible API proposals (now done). Keep the
> > rest of the email intact for reference.
> >
> > On Wed 24-04-19 14:10:39, Matthew Garrett wrote:
> >> From: Matthew Garrett <mjg59@google.com>
> >>
> >> Applications that hold secrets and wish to avoid them leaking can use
> >> mlock() to prevent the page from being pushed out to swap and
> >> MADV_DONTDUMP to prevent it from being included in core dumps. Applications
>
> So, do we really need a new madvise() flag and VMA flag, or can we just
> infer this page clearing from mlock+MADV_DONTDUMP being both applied?

I think the combination would probably imply that this is the
behaviour you want, but I'm a little concerned about changing the
semantics given the corner cases described earlier in the thread. If
we can figure those out in a way that won't break any existing code, I
could buy this.
