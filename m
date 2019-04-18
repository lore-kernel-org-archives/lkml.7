Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B281C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568FB21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PLJ0mV2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389284AbfDROhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:37:34 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38526 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388387AbfDROhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:37:33 -0400
Received: by mail-ua1-f67.google.com with SMTP id t15so829114uao.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Yc0kXPSW43gvjQq3OdjvHcxyway7inOXa8pO7tmmXs=;
        b=PLJ0mV2uS++UfoeiaSqa2nVZFwJnqAoWwk04XqWlMMDTlU4uefsWohZI7VqGls5haV
         K+yHIQQt2SS9TuwgpB4jX7kQexPcMYO5EsNTjkSo56rqwBwKvD8iE78q4+EGRYYsAOCm
         IYYKlCt+US6vl+wK+fcQtT1HCDZEhXB2nKx5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Yc0kXPSW43gvjQq3OdjvHcxyway7inOXa8pO7tmmXs=;
        b=QolFug7gSbA181EEsVRqVKaSot3U3u1SnMjKf3M7powsPUakfvRnfYrv/u8bRTPcJW
         uHRdvNBNTssQ4MZE+Y2Gf+Jg0nAE/B34rjtuUYmOMDOz4Y+fZXiiyNWbIOG7GfA2su8Z
         azEXpLXFJLRAUXpNljLQMLZyWJEjeMwbA5htwyDlAlEPJ3scEj88IQMYS3EDQ3nBK/GD
         roBIg81nTG4rt/qDII2QqZL7MJ1etrfEjJZA4xXs0aH22oNxsUVNWpAr8uJ/gkGcRRCs
         t+N6ucQhbLXYzK0aWW+uIZCwcVw02AjBpAKYjDvgpROtt8bhijSInTNI8nGNT1d3xwf5
         /iXQ==
X-Gm-Message-State: APjAAAUn/GynGJ9gap3teOpotvqeYoYtAMwumHmfZ+6Z3L2A5uT/6Fmj
        D541JIzA8KHCJ/GQcbBwRe3yA7LVR6Y=
X-Google-Smtp-Source: APXvYqyRsm0cesnL7Brm5MRFLbbrfImcVetk2PsEfd8f6uMvW7nn/bPszv7RY/aXKBoOVTXto8/mHw==
X-Received: by 2002:ab0:2303:: with SMTP id a3mr3836031uao.142.1555598252499;
        Thu, 18 Apr 2019 07:37:32 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id q12sm583072vsr.13.2019.04.18.07.37.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 07:37:32 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id l22so824967uao.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:37:32 -0700 (PDT)
X-Received: by 2002:ab0:72c2:: with SMTP id g2mr51109622uap.112.1555597784764;
 Thu, 18 Apr 2019 07:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <1462963502-11636-1-git-send-email-hecmargi@upv.es>
 <CAGXu5jLZ-DgTfokLTqUHOUphO4C1FwHgYDLTA1oB9HBHnH-a1Q@mail.gmail.com>
 <alpine.DEB.2.21.1904181015270.3174@nanos.tec.linutronix.de> <74755222-0B16-4A81-85F6-D2803E4C0334@amacapital.net>
In-Reply-To: <74755222-0B16-4A81-85F6-D2803E4C0334@amacapital.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 09:29:33 -0500
X-Gmail-Original-Message-ID: <CAGXu5jJpyhN7H2K7a+AT_zWn+G55RkeP9umsBVhDy9KO9B_5eg@mail.gmail.com>
Message-ID: <CAGXu5jJpyhN7H2K7a+AT_zWn+G55RkeP9umsBVhDy9KO9B_5eg@mail.gmail.com>
Subject: Re: [PATCH] x86_64: Disabling read-implies-exec when the stack is executable
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Huaitong Han <huaitong.han@intel.com>,
        Ismael Ripoll Ripoll <iripoll@upv.es>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 9:15 AM Andy Lutomirski <luto@amacapital.net> wrote:
> I have the opposite question: who cares if we have NX?  On a CPU without NX, read implies exec, full stop. Why should nasty personality stuff matter at all?  The personality stuff is about supporting old crufty binaries.
>
> So: are there old 64-bit binaries that have their stacks marked RX that expect mmap to automatically return X memory?  If so, then the patch is a problem. If not, then maybe the patch is okay.

That's what I'm wondering too. (Though remember that ia32 PAE has NX,
so it's also 32-bit binaries.) The matrix I have in my head is:

             CPU: |  lacks NX      |  has NX            |
ELF:              |                |                    |
--------------------------------------------------------|
missing GNU_STACK | doesn't matter | needs RIE          |
GNU_STACK == RWX  | doesn't matter | needs only stack X | *
GNU_STACK == RW   | doesn't matter | needs stack NX     |

(hopefully gmail doesn't mangle this whitespace)

The "*" line here is the question. The question is "when does
GNU_STACK == RWX also mean all mmaps must be X?" If it's only on ia32,
okay, fine we can adjust it, but why is it only an issue for ia32
toolchains? If it's a non-issue, then the above logic stands.

> All that being said, the comment in the patch seems to be highly misleading.  If the patch is to be applied, the comment needs serious work.

Yes, absolutely. (I'd include the chart above, for example...)

-- 
Kees Cook
