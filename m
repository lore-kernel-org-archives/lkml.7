Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEC2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82162147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfCMO6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:58:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38123 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfCMO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:58:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id s1so2224609qte.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 07:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQNhrABgTfNbI3LjNPG9bpOQrem4pejdVK1i3DBdroE=;
        b=nfrTJ4aCDCilh0quh/jbAW990kPmNQBTt9bSlYqKDkhbMta+WSv0AtD4XCozaF/l0U
         fBDhVqXYXUQhdBQcT5yf/mcIOYJP/IWf9YWOSMXBSVWa/y+6irw9zo0ib6DIynMzRUzO
         IlxfbXG0fN9jXoRPCPxJWOFmfEOMGpLBRTI1ZPVYTAq9aeaOrYKOyyqs2vfoTTK9o3L4
         gsmkdeeF2toh4t9nqYJxnI5w0kXzWxydJ0TzmcaYchDawI6APApD+L98Fp6RD+DcHM1E
         Jn1S7rAK8L8pYpi/LmyGLAZfJ2Qj0LCwDxDN6Do7qutZp1UKy2QzheCb2zhXxuVqNxRE
         kI7A==
X-Gm-Message-State: APjAAAW5Jdw9aKlcv26ML0d1r6DXy9RSnd/Dr032BwvNyIeHTHgs/tUW
        bnZ0zZXJIO0+4u0UbKA3swdTwGNW85oSsnKonfM=
X-Google-Smtp-Source: APXvYqxAwi30bfPTT3u25hrNOi9+bcXAk5HJ1yq3tsV9ZE74+fJ6CPVYNafDodO0LougzCN+mHiKI0mjqaB91VUJc9g=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr34620996qtb.343.1552489080454;
 Wed, 13 Mar 2019 07:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190310183051.87303-1-cai@lca.pw> <20190311035815.kq7ftc6vphy6vwen@linux-r8p5>
 <20190311122100.GF22862@mellanox.com> <1552312822.7087.11.camel@lca.pw>
 <CAK8P3a0QB7+oPz4sfbW_g2EGZZmC=LMEnkMNLCW_FD=fEZoQPA@mail.gmail.com>
 <20190313091844.GA24390@hirez.programming.kicks-ass.net> <20190313143552.GA39315@lakrids.cambridge.arm.com>
In-Reply-To: <20190313143552.GA39315@lakrids.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Mar 2019 15:57:42 +0100
Message-ID: <CAK8P3a3V+1sQJfTAipYyOeV5b379eYZXasRFjWnf9oKPtCTviQ@mail.gmail.com>
Subject: Re: [PATCH] mm/debug: add a cast to u64 for atomic64_read()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 3:36 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Mar 13, 2019 at 10:18:44AM +0100, Peter Zijlstra wrote:
> > On Mon, Mar 11, 2019 at 03:20:04PM +0100, Arnd Bergmann wrote:
> > > On Mon, Mar 11, 2019 at 3:00 PM Qian Cai <cai@lca.pw> wrote:
>
> I think that using s64 consistently (with any necessary alignment
> annotation) makes the most sense. That's unambigious, and what the
> common headers now use.
>
> Now that the scripted atomics are merged, I'd like to move arches over
> to arch_atomic_*(), so the argument and return types will become s64
> everywhere.

Yes, that sounds like the easiest way, especially if we don't touch the
internal implementation but simply rename all the symbols provided
by the architectures. Is that what you had in mind, or would you go
beyond the minimum changes here?

        Arnd
