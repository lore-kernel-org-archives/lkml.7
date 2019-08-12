Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3AAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551B820578
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLsvuMyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfHLJG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:06:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45833 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfHLJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:06:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id m24so3220409otp.12;
        Mon, 12 Aug 2019 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7w4cBPzdpuAIPtnuVqHY6slc5DSv5Z5fINkYhZ4kFBE=;
        b=eLsvuMytdZ23YbdvsFSsywprInWIcwLJKm5Jf1JAaHsCb5HFDune2mgxPQkw6h2OFh
         iCtDhlGIpN5wZQySaKLLh65EcNf32OhPeKCqvHtJYsOD4vw4wfsjmnncNPw6WMtLwgUX
         vTw/cX9laJEXAP0e13wYCPMAhAvDrvrFAOdP0WgyUwg9LSAKR4T/o2hGrbZozMVb72Mi
         AA0WyQjSshym53yVFWDuY4zr93d7TMFs2MpxoNNAYzonaE6SUlZ56k6x34Yr4W4J9WKc
         fBk1lxKpGX0TVz8xM/d/o81CoYaLSP6Xrhzf8UkvBrZiXEEGE7H0rMUTI8Gs5LNNBi0p
         gDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7w4cBPzdpuAIPtnuVqHY6slc5DSv5Z5fINkYhZ4kFBE=;
        b=eg0uOXfSR8Dsqr1qzARLxUCSfgj2l0ea5+wXCreYsUe/46m+IdplebX3g/GZtK7DWR
         4nNCrwsgQ2maI+hU/kkONdHx717SdWjtFbU2qVj4Vmvnh2L6niUTwzjEC0CAQ81B3kwK
         WgnnmeKIOuI/cimO1aEXn8SoJssRUg1AEjUoR8kdspJY196MIqWPqb1TtG7mZ023wdiT
         iA9lmKGi9yCBuhCjORLkDmNGFrv7yeUTTiANkLvye8GYm65EvPTS7rMXjDmE5lhxdJM1
         jrbV25avfxYZ0qjr2tsV/olrcsqfHiWpwxlj3j6DNQrgY8IQ3wEJNqB8mi7ZbxLjTClo
         RqAg==
X-Gm-Message-State: APjAAAW4QtU59L6dPjALI519PkuHaq4W5EjkEgg1ZOe6aaJaVWA/523e
        W5b0eDv262s42nh9EHMAJceiQA3l2UFPKtFqJcEWHg==
X-Google-Smtp-Source: APXvYqygkorYMLSfFNEA3bxN8+EKejmowoY0qiA0RLVnVfVu1KYAp0SAzGiY0aQVCSgV7h4tF/hD+1olBekb+bCAI+c=
X-Received: by 2002:a05:6808:3:: with SMTP id u3mr12906212oic.141.1565600785312;
 Mon, 12 Aug 2019 02:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <1565329531-12327-1-git-send-email-wanpengli@tencent.com> <fad8ceed-8b98-8fc4-5b6a-63bbca4059a8@redhat.com>
In-Reply-To: <fad8ceed-8b98-8fc4-5b6a-63bbca4059a8@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 12 Aug 2019 17:06:15 +0800
Message-ID: <CANRm+CwMMUEyZXmiUu5Y8GA=BEUYGLw31CRyZTc2uA+ct4Bamg@mail.gmail.com>
Subject: Re: [PATCH] KVM: LAPIC: Periodically revaluate appropriate lapic_timer_advance_ns
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019 at 18:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 09/08/19 07:45, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Even if for realtime CPUs, cache line bounces, frequency scaling, presence
> > of higher-priority RT tasks, etc can cause different response. These
> > interferences should be considered and periodically revaluate whether
> > or not the lapic_timer_advance_ns value is the best, do nothing if it is,
> > otherwise recaluate again.
>
> How much fluctuation do you observe between different runs?

Sometimes can ~1000 cycles after converting to guest tsc freq.

Regards,
Wanpeng Li
