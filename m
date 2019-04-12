Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77780C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ADA2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxG5Lfvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfDLAte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:49:34 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35029 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDLAte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 20:49:34 -0400
Received: by mail-vs1-f66.google.com with SMTP id d8so4603123vsp.2;
        Thu, 11 Apr 2019 17:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWBpR9dyC+xLnfEFgXj9tuZsVDw3WOnEHHAmffrI+OI=;
        b=rxG5LfvmG1C32HozkkLevSvbpCrrv685/jmZpjprMmyNxtE2Q31fL6G9UOlE4AIO3h
         NrV1UtIwHzrDNoSm9wNa54wKqjSKHrlb0DovQGCQ87iw+Al7LUaZidbJHwF8rRpx3oue
         xTdo6CXkjvHkapqQtTAVywV3eZS+iUgyK3IhBCmyRJd9RW6papq6LEn0RyqBlYnp2j8/
         +/3GqT4QR0cF3gWvmGWA5DC9pILZPFqeC2PilE9b+aVAesqUS7aCXbRqokBYBRQc4bKx
         7DQafVtU8z2UkkIDUFuK5khaHkMOxSZzvHYXlROdjoMJIvWj0qfHvj/gEDzLQvfxDu7V
         Fg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWBpR9dyC+xLnfEFgXj9tuZsVDw3WOnEHHAmffrI+OI=;
        b=grxrNE2RxS8hZGMRnuB/BbUSgu1xxnWdRnMzSfSKaMYnuedAY67YTmzmwFR54ohkI/
         MJen2kNeesGWDKg6tx4F4eCD+Mnr+HIrJjetTapsvaLtsMOvc7eN88B1UjMvFqKjFE5c
         FgCLLIojA0HJ1Co6eYQclSy0472kVjzT0+vGYTw9j2CBTDqSXlNwDZFhn0mL63yyL9ZT
         VAYVSxt5+2kGvm8qF+IU94u85wb8B07nsFIdQYbSPqNQzRnWXHsgo7J0zz+s5iNzFwfj
         z4I5NRi5NVuwgl++Kt5m5LfdWq2FmczqnDtco/H7tsH5+4ab+xn0kJIsoDlMck7LQyNx
         574Q==
X-Gm-Message-State: APjAAAUBLlHlWDySjYwjW5q8EMKYkjlDQ3U2smmeolk216dCinat3CmP
        hR3SIdIJXBkvqO0spdCea6CsLC65lSGA7AzFYKp5w8el
X-Google-Smtp-Source: APXvYqyJYVcb+/w0X0buIFBGIPHkKGOSh2HGwtbXkVBvxd/Bn2yJI3+LXBSdxM/cuDO+GUiEgeLRt9DWYAM/7TVnp8A=
X-Received: by 2002:a67:b106:: with SMTP id w6mr30490948vsl.16.1555030172978;
 Thu, 11 Apr 2019 17:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190213091936.GA22829@shao2-debian> <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
 <CAC=cRTM5=e7rJX80m0vL10aQoLawK_VTnQubH8A7_sUO2VUCNA@mail.gmail.com> <cc8af095-50e0-cd3e-e498-8c3350d314b7@redhat.com>
In-Reply-To: <cc8af095-50e0-cd3e-e498-8c3350d314b7@redhat.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Fri, 12 Apr 2019 08:49:21 +0800
Message-ID: <CAC=cRTP38JmFWe8C=y6ew_m1Lswb8DghnqLtdiMc0EW_fyPH7g@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
To:     Waiman Long <longman@redhat.com>
Cc:     Chen Rong <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "IngoMolnar@shao2-debian" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:08 AM Waiman Long <longman@redhat.com> wrote:
>
> On 04/10/2019 04:15 AM, huang ying wrote:
> > Hi, Waiman,
> >
> > What's the status of this patchset?  And its merging plan?
> >
> > Best Regards,
> > Huang, Ying
>
> I have broken the patch into 3 parts (0/1/2) and rewritten some of them.
> Part 0 has been merged into tip. Parts 1 and 2 are still under testing.

Thanks!  Please keep me updated!

Best Regards,
Huang, Ying

> Cheers,
> Longman
>
