Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3C4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C86C21734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="W15h/+ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfCLIsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:48:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36668 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfCLIsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:48:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id e4so1562112edi.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=qLa95DyklTZJohSCfbWMlR6TLcwZlkof2Mrj+c+e5rE=;
        b=W15h/+ei6U+x7egAkhO305eE4JZ01p2N6zccFTrUUIryIUEPebB5DrsWxIyHoxK0RV
         jqObdhSNZirfuxbMPRGU0lXl0XUsVb3C84hskg7zHSl9Bg8D1Al0tUrbyETL9lcwgEM5
         cASPRSBM9iHJTRdYeDVLWK4TAzVyZ+PR+SBaiqBWkfGLCtcv2nm9D91cipYToUZgfL22
         WQFfBbXxeEq3Ie/1WUYeB0NCxUmtc4/O3dWjwy+onjIn9fp15mirOaTY18HpcnuCqiC1
         aNXvZG0Z87iofUhRwgDsVyeNKS1neDQq0fBmDX4quESzm5DKFB1DvSsxqGDW8EuQtJ7b
         DNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=qLa95DyklTZJohSCfbWMlR6TLcwZlkof2Mrj+c+e5rE=;
        b=QKJbSPSliryeP0fGwEUjDq/RnqVT6BZLUErk4NGpmzdRiJU+P0X+etnj/8QO9K52Pv
         P278GDLSOvNp45D8Uow26bKsgmRCIhqNss0klXObo6g6yBOfiHXJn7TRCdZZiYKgJvep
         fEjM6TPm7kqOcG2YLvNVpMjJO4121BMRSYYIZh0RXks/WpVuOr28pN/oiZUceZHdvZkq
         OAXAiZSabRdCwWQRrtK1qjQTiEiK+7EvWWPSOUNsYZ7mVi6N4rOWhZYw5rHxx9M+9W5Y
         3ezD7WKS8hgmQTZyXTpTLDrNsjVwcvID/H9zvgzAxdCPmj2MId7kNVS6nQYfs59Lt6TG
         +s0Q==
X-Gm-Message-State: APjAAAWGOBlBjYYCoQnE2YBj6H0B95//rojtyiS01KwSbCMlyDIp/U6u
        KswY2yJkhxSHRFSRVRynWvILeg==
X-Google-Smtp-Source: APXvYqx7rk/jyN7mrCUWyMyGCv9nkcCym92ozsLV4lpukHahWRiypoehHL5DIkj06wvsXe+uwpdzlw==
X-Received: by 2002:a50:a4ec:: with SMTP id x41mr2437370edb.27.1552380498687;
        Tue, 12 Mar 2019 01:48:18 -0700 (PDT)
Received: from ?IPv6:2a02:8109:b6c0:76e:ad50:a908:c1ce:44c? ([2a02:8109:b6c0:76e:ad50:a908:c1ce:44c])
        by smtp.gmail.com with ESMTPSA id d17sm401398ejl.49.2019.03.12.01.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 01:48:17 -0700 (PDT)
Date:   Tue, 12 Mar 2019 09:48:11 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CAK8P3a0iW-bhfiLY2po4cwaG0f-S+Xdoowrj0A6CwaY4VHgdWA@mail.gmail.com>
References: <20190122141027.70cd9166@canb.auug.org.au> <20190213162212.500a7cd5@canb.auug.org.au> <CAK8P3a1hw03ik+tZSG8PnP7Rd=Pzwbo7n59HLJW04ncndyqzsg@mail.gmail.com> <CAMuHMdUmPBeQ=jcDufVBDEGiO1Yk4bWWBSg488Jm_wwAuySHBQ@mail.gmail.com> <CAK8P3a1zHm-WjYjEA65PomrKe7+5Sd110KbXv13=wiMVpxyuaQ@mail.gmail.com> <20190311214307.domy6azaoi4ggtiu@brauner.io> <CAK8P3a0iW-bhfiLY2po4cwaG0f-S+Xdoowrj0A6CwaY4VHgdWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: New syscalls (was: Re: linux-next: manual merge of the pidfd tree with the y2038 tree (now block and tip trees))
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <0E75950C-D39C-43F9-950B-284BEA768A90@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 12, 2019 9:31:33 AM GMT+01:00, Arnd Bergmann <arnd@arndb=2Ede> wro=
te:
>On Mon, Mar 11, 2019 at 10:43 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>> On Mon, Mar 11, 2019 at 10:38:07PM +0100, Arnd Bergmann wrote:
>> > On Mon, Mar 11, 2019 at 9:36 AM Geert Uytterhoeven
><geert@linux-m68k=2Eorg> wrote:
>> > >
>> > > Shall each architcture maintainer take care of this hxxself, or
>will
>> > > this be done in
>> > > a coordinated way?
>> >
>> > I was planning to send a patch for all architectures this time
>> > (after all three sets are merged, which is now), and ask future
>>
>> Just to clarify, are you referring to your sets? I think Linus hasn't
>> gotten around to reviewing the PR for pidfd_send_signal() yet=2E :)
>
>Ah, I thought he had already merged both, the confusion was on
>my end=2E

I think I'll do a GIT PULL RESEND later today since I sent the original pr=
 last Tuesday=2E

Christian


>
>      Arnd

