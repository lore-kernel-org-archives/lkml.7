Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4F4C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 21:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1382206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 21:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AHY1kkqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLWVhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 16:37:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43353 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWVhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 16:37:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so19040999ljm.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 13:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMvN3IfikatrxqeZLIO+wKS6AjEL5TBJnJcInwPc4v4=;
        b=AHY1kkqkbL1tyy0EQQ2o/SCXBRNog8yZ62J7u1trb0v/5+rMwfBnjLsRlYVIrsoH2x
         7x1ydt+L97VLLbGvLV9tURyW7dF0P8ZB0exo9F9mH/lSxP3GeX1+9Bk9srnVE0X9mXyl
         I487XNsOYBklM8DDxsGBuBcnAkjeBi036ZQ6fx9P9RINmqqpH6xALb59aZrDGC4LEeIx
         6pn57qESQhukSkHQSaZ5yWrODtPOo5D9Ax/SZ9kfIPfbeTWCDlWiJhkYhcGy3kvmFuPC
         Jh9M97fnE8K+wSPWc0k5+iOIExBXQIXHdikT9YEse63GbYy/sxj9jh0h3So4Nnlo+nQ1
         Mkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMvN3IfikatrxqeZLIO+wKS6AjEL5TBJnJcInwPc4v4=;
        b=oMpJvjOYJlgThHci8H6ToiC7+5+MNIIvB9qhpX62Cyc5cA8lNYousbTbbqNdMCvmRg
         nYTRfDuruvSww9F8L6R1QheoPx10L1Nfqt+rwTt+ryO5nTkRiY26n2We7MaJ5XpskOyE
         7dqJoNRZ9CQzi3bj4BQ/TmxwkDtIfYrxpRw1pJyqr7D/4g1jzarYDODIAeWAO8s+UE0F
         25uIgAgYn9GZ1RxojHSKfhpnkVhWMLRNfIx6Fk80HVftpBuENnlnXbJtNEglYDYLfE6j
         oBtcl83gVgvAw4TfAvhxHpeJ3/nEqHMZAER/oXM+cQF9bKZ4bSg4dDVYDx2XsVaW/Tw3
         5vdQ==
X-Gm-Message-State: APjAAAVN562l3Avx+7Krb9Xo1SK+HIvxEXReuMuxNtDE8K7gR3QqlyB6
        yEn7C/UDNu/pOLiWtKN6rejb/xAA89C9UPCEa1bY
X-Google-Smtp-Source: APXvYqxoPcTQjHi2HpjbnyoXdggoClkjePbiD8iRyX3l8RqNHg5v4Ul7+zS6oq66FdgU5U9Vg18wI1qDl/piB1Yq6rs=
X-Received: by 2002:a2e:800b:: with SMTP id j11mr17392415ljg.126.1577137072223;
 Mon, 23 Dec 2019 13:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20191223091512.GL2760@shao2-debian> <CAHC9VhQfCmWbd7Yt0Jcz-QpSqXidri5PNgb_514+sfah5w3K6g@mail.gmail.com>
In-Reply-To: <CAHC9VhQfCmWbd7Yt0Jcz-QpSqXidri5PNgb_514+sfah5w3K6g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Dec 2019 16:37:40 -0500
Message-ID: <CAHC9VhQTphqNxZ7ndNRCy-iff3ugFjLan+CoWT8v6joF_smNzg@mail.gmail.com>
Subject: Re: [selinux] 66f8e2f03c: RIP:sidtab_hash_stats
To:     Jeff Vander Stoep <jeffv@google.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jovana Knezevic <jovanak@google.com>,
        LKML <linux-kernel@vger.kernel.org>, selinux@vger.kernel.org,
        lkp@lists.01.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 9:37 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Dec 23, 2019 at 4:15 AM kernel test robot <lkp@intel.com> wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: 66f8e2f03c02e812002f8e9e465681cc62edda5b ("selinux: sidtab reverse lookup hash table")
> > https://git.kernel.org/cgit/linux/kernel/git/pcmoore/selinux.git next
> >
> > ...
>
> Jeff, please look into this.  I suspect we may need to check
> state->initialized in security_sidtab_hash_stats(...) (or similar).

I realized that Jeff may very well be on a holiday so I took a closer
look and this does appear to be the/a problem.  If you try to "cat
/sys/fs/selinux/ss/sidtab_hash_stats" on a system where the policy
hasn't been loaded it blows up in a bad way.  I'll write up a fix
right now and post it as soon as I've verified it fixes the problem.

-- 
paul moore
www.paul-moore.com
