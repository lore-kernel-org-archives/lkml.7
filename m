Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D67CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A86D21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571411594;
	bh=pzDE1n0YiuxtPgLDCC29Lmj45rwffh951llpqts7Ox4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T/eNZKF1EndS8ucCQbddsHeE+/fFhYfETGNA84LsQXFh0CyBwi4aaKaKLYuY9z9o9
	 0gF67Uokkx3g0F+pzEYYnzPvAK3+AXNfR5f9ghHU3QKGSOMlBoemUbIXGsA17ivXOH
	 gK+Co11j9BWzk32DZlQD5IylbtebYVbfzoiOrEU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408643AbfJRPNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:13:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38557 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393855AbfJRPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:13:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so6597718ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4AT2pHM5eKiwWql/S0na26YGuwD55vsY36Ry4jT4KQ=;
        b=byTTQL4kWuo+knbXr4HK+U5vcM49k7bpeNN86fwXjOdo13eqT9Ke6Hpk84xg6WDxKw
         XyAvkGflJXdhc9Lh6KLDZOjWDQ5ALYLzBy6stXZOF522j1XmCkMxRDtV4hWYQfwoThGf
         aIi2dL5srZ6vvcRbEOZVVdhs6oY/EniH0RegQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4AT2pHM5eKiwWql/S0na26YGuwD55vsY36Ry4jT4KQ=;
        b=RnjglKKvdCJZOnRNwq1L9u5pNuVcd+479XWpgeMObU795JnM5/PuoDkVZb4rp6RWUm
         ruThdgxQjLEPnu2YBZtNbF3ii83rQSCW0dBDr1dR466fQSieFU8qFuwQyhaQX5xuQUMN
         q7MGyDOLshtfmIZUCLOmbpRlA8Gq0x3PyLqW3HL+nngXGHXxImHBqhFyB7myySfayPYf
         ln9yxBQ+tfdfHoLovM9pommKOZBtywKIy0aLqNiGiQ1Koc45JKL1HgPKSdmtj6GZi8ns
         y6ng68NtMGCz19L47IS4QT3A97NeuwqWhEu8KnHqgIgNv6XYVRFgqYVT+xjT8OmsRMfG
         evLA==
X-Gm-Message-State: APjAAAWiYPexsrHE6JGt0ga+Q7NIhr3yVGfzvtCeOrjjaRwQUWLNb4+/
        p788EcmnGFPuIjoOGIveDJQiuEGtwP0=
X-Google-Smtp-Source: APXvYqwEgCxdagRHUxbuj5Czy3noyP+OaxeDVj3jVzghLMiLOBEb7RRqweIMWZ9vLKqPbZN6hLDygg==
X-Received: by 2002:a2e:1b52:: with SMTP id b79mr6536093ljb.225.1571411588491;
        Fri, 18 Oct 2019 08:13:08 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y3sm2288375lji.53.2019.10.18.08.13.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 08:13:07 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id v8so4415843lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:13:06 -0700 (PDT)
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr6556317lfl.61.1571411586269;
 Fri, 18 Oct 2019 08:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <1571166922.15362.19.camel@HansenPartnership.com>
 <20191018103540.GC3885@osiris> <yq1pniui429.fsf@oracle.com>
In-Reply-To: <yq1pniui429.fsf@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Oct 2019 08:12:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1UwQdaO_SBscZHJA8CnrCx8rXT+s6Xgf5zAri=BkRTw@mail.gmail.com>
Message-ID: <CAHk-=wi1UwQdaO_SBscZHJA8CnrCx8rXT+s6Xgf5zAri=BkRTw@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 5.4-rc3
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steffen Maier <maier@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 6:21 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Linus, these two commits were in a separate postmerge branch due to a
> dependency on changes merged for 5.4 in the block tree. The patches fix
> two issues in the intersection of the request cleanup changes from block
> (b7e9e1fb7a92) and the request batching changes (8930a6c20791) that were
> made to SCSI during the 5.4 cycle.

Pulled. I don't know if you'll get the pr-tracker-bot reply when the
pull request was in the middle of a thread like this, but it probably
doesn't matter. We'll see.

The "in the middle of a thread" probably matters more to me - just as
a FYI, when there's some discussion thread where the developers are
already actively involved, I tend to just scan the emails
superficially, and could easily have missed that there was a pull
request hidden in the conversation..

              Linus
