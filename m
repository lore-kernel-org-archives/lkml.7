Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F63DC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 03:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F55B2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 03:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cO/oSUMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437076AbfIXDB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 23:01:29 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:36063 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408922AbfIXDB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 23:01:28 -0400
Received: by mail-lf1-f47.google.com with SMTP id x80so188343lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 20:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ywjzdhy6ZnHy91q5BEB8BAGGE1BicH70UfBVqn5Luns=;
        b=cO/oSUMbqftn/mRjg/yWzqWrdhcGuKurKhpq40Gtw4EM+RBkt8zS55g/bDTxXDhEfa
         QHBwYJK/+pTXDxAAt0oIIuJwCBJY2pjrHmuhNyJWblbhpn5z0osYB/59u05i2hsFsUpD
         BBebw/GRByLd+YQ1m81bHdyFga6JCikoSpAh7Rr8M1wXbaBBS5rz58LiD3REWiidnEdI
         63o59qDCdAzDhvbD8bMSLn9p3rFvaeC1UOe0d150gMPu2zdyQhHb4zhi9yG0rCe5gp2w
         6KHj+w4CmWn6TXRyRQfTeiy7Ydbpf+eDoS0hov2N+31/cdJ7QVRmswf0SVOEODCXCIB4
         vPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ywjzdhy6ZnHy91q5BEB8BAGGE1BicH70UfBVqn5Luns=;
        b=GDio/h4UiX3H4Nz+refw7N1Ba/gzlXcx9r6o6QMiPgvJAUasfmQkfXMjX6YbgRJk9S
         S98tnakiyZWjk6Fp7sF5WZ+M66DmKc96FwnOdTBjPp2vWZU74TrLtthKrDafsGnPTidO
         hDZCAwDWRiu08Kr1ndBI4oibcPqqA54GKo3810YfiVyA1DUIU+rB3dPjKuGWOAVp2Jrv
         A0/yXmaT9TxfH1w5QhfkMn+cFT0XA25dyNh1HD5VByNoGIZPsbjbpPEVXS4ytYo5juaU
         00eaLLWyGwO02BLLn0dcSqr9eG2sHDxJ+aLoRbN3DHV42LvCdE/HSjgDJVSNfmrXbvbT
         6EDw==
X-Gm-Message-State: APjAAAXc1pz/n8Hb0pJVaVLAEhP2dzkNH7/jyn+1JIl1BGJoASDzx3R1
        YgUBmVJptiY1kVhaj+WuEmDKpvrBXVPW5HiYUnLY
X-Google-Smtp-Source: APXvYqygHGRqSiC0MdlpPqCpY5SKO9zK/4Wg8MLQuNG5binVe9bwa3y9dMaA5+5YZBlykt9bLXhE2YJdDVX2tJ22bU8=
X-Received: by 2002:a19:6517:: with SMTP id z23mr291949lfb.31.1569294085123;
 Mon, 23 Sep 2019 20:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190923155041.GA14807@codemonkey.org.uk> <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <20190923210021.5vfc2fo4wopennj5@madcap2.tricolour.ca>
In-Reply-To: <20190923210021.5vfc2fo4wopennj5@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Sep 2019 23:01:14 -0400
Message-ID: <CAHC9VhQPvS7mfmeomRLJ+SyXk=tZprSJQ9Ays3qr=+rqd=L16Q@mail.gmail.com>
Subject: Re: ntp audit spew.
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>, linux-audit@redhat.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 5:00 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-09-23 12:14, Paul Moore wrote:
> > On Mon, Sep 23, 2019 at 11:50 AM Dave Jones <davej@codemonkey.org.uk> wrote:
> > >
> > > I have some hosts that are constantly spewing audit messages like so:
> > >
> > > [46897.591182] audit: type=1333 audit(1569250288.663:220): op=offset old=2543677901372 new=2980866217213
> > > [46897.591184] audit: type=1333 audit(1569250288.663:221): op=freq old=-2443166611284 new=-2436281764244
>
> Odd.  It appears these two above should have the same serial number and
> should be accompanied by a syscall record.  It appears that it has no
> context to update to connect the two records.  Is it possible it is not
> being called in a task context?  If that were the case though, I'd
> expect audit_dummy_context() to return 1...

Yeah, I'm a little confused with these messages too.  As you pointed
out, the different serial numbers imply that the audit_context is NULL
and if the audit_context is NULL I would have expected it to fail the
audit_dummy_context() check in audit_ntp_log().  I'm looking at this
with tired eyes at the moment, so I'm likely missing something, but I
just don't see it right now ...

What is even more confusing is that I don't see this issue on my test systems.

> Checking audit_enabled should not be necessary but might fix the
> problem, but still not explain why we're getting these records.

I'd like to understand why this is happening before we start changing the code.

-- 
paul moore
www.paul-moore.com
