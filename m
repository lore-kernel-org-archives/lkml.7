Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7089C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC664217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569609319;
	bh=gCxde8flDYxeiWj3b1CUbAwvbzsbngWbOjjQy9o7eSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oNnpnIQDEAmvldNklwVvq9Hq7rbgUt2clwRpAM8oZh/bBUgqRItHJZWUgjtnTy/3u
	 D2F6oh2f7fOP+boytpHu4ar/6ezL9Pc/bqoeNR5KHW6uABA6K+J8g6CNxwESe4HsmH
	 /MR6L0qj1OK+Eh2+P5ofeN1yxd5wWbpVioBwiIGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfI0SfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:35:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36383 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbfI0SfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:35:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so3465036ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfo/aCWS6InNpF6+CbMoDQhZTwhAvaIIzwPXAG1ON2k=;
        b=PmjiZGWIuux93oBdsbKTUcDUjOwRzdmDhCW+izQNooViyiY5zi7nNI8gmKybNudXez
         mSBXzQfHIJMk7J54/kR1Q0FTZiLQo2TdURWv9EPGoNG5dafe9qzlnG0ZSVDkNphLEhzj
         OpxYIyiGR1+Yl9vS9XQTRr2D9CYcY+0rTw3LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfo/aCWS6InNpF6+CbMoDQhZTwhAvaIIzwPXAG1ON2k=;
        b=srw4PIvCPZ5J1OE7+pwDa2Fwt1Sr7JUPUaaYrV2650Is/QUt4beqJCj7157cio8Bet
         9ZqAGHA7so7xM8yoL6gHxkwmVxpZKhe6vTDJ2X0AMIDh4t3hG6sLK+c7tDL7OEw1E8Wt
         ZlGnQRjs7u466t8SSkS5VNtci6xAmEB7RDvvjlbB6dMEPxH+SoDX2h3JcVmitWbiHbOH
         L8pE3JC1fhSUI8A3oLKrTOts6wtDpEF4eWAJEjBXp7FdQmwwouE+X+oENjTaagjsdQFV
         DWl0t9b3WUHavGhtehPNyuW+ar9MsY260L+bpSh+H/bixVHRL3LaChjCk0sUc4k6N8jk
         ADvg==
X-Gm-Message-State: APjAAAUQ1kSFzrSOW4JEdoXTolIlrhBYPDMFHthvF45HmPsWAD1icbgz
        p9wYyFkXgCmBFakETjdcEavcLlAYIWk=
X-Google-Smtp-Source: APXvYqyiM5ZbiD4/tseULmN9iHPe/wnCE4gD1yjm7evPzxfHtyFYl43cA/74dAMx3DF8QgLNPFcq8w==
X-Received: by 2002:a05:651c:150:: with SMTP id c16mr3857777ljd.224.1569609313937;
        Fri, 27 Sep 2019 11:35:13 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id c18sm721280ljd.27.2019.09.27.11.35.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 11:35:12 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 72so2636248lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:35:12 -0700 (PDT)
X-Received: by 2002:a19:2489:: with SMTP id k131mr3700375lfk.52.1569609312334;
 Fri, 27 Sep 2019 11:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
In-Reply-To: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 11:34:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com>
Message-ID: <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal management updates for v5.4-rc1
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 6:08 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> One thing to mention is that, all the patches have been tested in
> linux-next for weeks, but there is a conflict detected, because
> upstream has took commit eaf7b46083a7e34 ("docs: thermal: add it to the
> driver API") from jc-docs tree while I'm keeping a wrong version of the
> patch, so I just rebased my tree to fix this.

Why do I have to say this EVERY single release?

A conflict is not a reason to rebase. Conflicts happen. They happen a
lot. I deal with them, and it's usually trivial.

If you feel it's not trivial, just describe what the resolution is,
rather than rebasing. Really.

Rebasing for a random conflict (particularly in documentation, for
chrissake!) is like using an atomic bomb to swat a fly.  You have all
those downsides, and there are basically _no_ upsides. It only makes
for more work for me because I have to re-write this email for the
millionth time, and that takes longer and is more aggravating than the
conflict would have taken to just sort out.

                   Linus
