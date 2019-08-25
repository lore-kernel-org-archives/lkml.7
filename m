Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261F6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8C120578
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566754690;
	bh=Lns7iJf1ID9QWex2orEqasZX28aZRIIy+GcyCzdnE8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0oPTIet7ya+LzWWyKl1rHR23rsvHnq/KM1JPmDYGTPNdSyND1z59/I7qHCOzO7JJh
	 1XP0vIRhBXQ6n7Ptc54h33GS3lGJxFai+tpG0JrR9Y94jH7oHgGWJ3v96n+a1z6Hxs
	 lizp5ClWYMu/LPrxbGksL+cyPYYOz7NdNrSeuP00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfHYRiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 13:38:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41033 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfHYRiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:38:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so10526770lfa.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6JITCXyksgGXPuuiEKTTWYpxFZ0smMdS2qA/RBn6LM=;
        b=Cn+X/37xbugDcXrRxIZ5lJxNcBOgsbWUT3oQDffw/10clliWPwH7NfEePy+DMUW+S/
         /3AQHcXBW5JCoafWOZqZ6gfThcwMhjF1lSFM7mGVSw/KQsH7CkEnF49qp+NzbxQ2HVla
         zpvzOOa6IP/i12QsAdliEN7n5p+QzwsDzCxi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6JITCXyksgGXPuuiEKTTWYpxFZ0smMdS2qA/RBn6LM=;
        b=uCe1boamzDKpCRZ8Y/t4x7rFPSt4synkXJtI05nDdMmMdzERhqR6vOcmKi6eN3wt1K
         DjvTRy2piqufDtfgvlXPKy9Yd/4V35KXY0oneXvT6sVZZAAIHihJDc9121vHpQCBc08D
         H89GHCmerBCcPkvvwDhW+QO7fXk1TnJs2dEMF//hoxyioAmvCOHWbNoavf8NBbG83/fw
         N3RozDxMLXzgz5rsTpCDTFlB/MoMzDq4kWHDEZKMAS040eLa6dNjVRRJi/ijDJ9g42NC
         iLXSjlh0cC+xli/lJ8+saj/cbJpLw9lGAXEJMwdct1CeD58yzKV1YJgBUcsrebXc1BOm
         a8xA==
X-Gm-Message-State: APjAAAWPkDbwWFME5N5xkOletX9eF6PwX6qmYMnsFEmOyGkh3qaSbnv/
        uO0faXlrivncbDscQI8DCgeH9jJtAa8=
X-Google-Smtp-Source: APXvYqzl6SnUPih8iPiczcFRbvg/A/+hGFN89NG1Pi2nvsvjq9704xINfIc9etslieoNVRHvGxLi4A==
X-Received: by 2002:a19:e04f:: with SMTP id g15mr8821749lfj.46.1566754684863;
        Sun, 25 Aug 2019 10:38:04 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y70sm1647890lje.41.2019.08.25.10.38.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2019 10:38:03 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id w67so2394860lff.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 10:38:03 -0700 (PDT)
X-Received: by 2002:ac2:428d:: with SMTP id m13mr8395283lfh.52.1566754683351;
 Sun, 25 Aug 2019 10:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com> <20190825173000.GB20639@zn.tnic>
In-Reply-To: <20190825173000.GB20639@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Aug 2019 10:37:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
Message-ID: <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
To:     Borislav Petkov <bp@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 10:30 AM Borislav Petkov <bp@suse.de> wrote:
>
> Should we do that somewhere in the early boot code by adding a WARN_ON()
> or so and see who screams?

It might be a good idea, just to see if it ever happens (again).

It doesn't even have to be early boot. It's probably more important to
let the user _know_, than it is to then disable the rdrand
instruction.

Particularly since we might as well just do it in general, and in the
general case we don't even know how to hide it in cpuid. So maybe just
something like "read the rdrand value a few times, make sure it
actually changes" at CPU bring-up (both boot and resume)

It sounds like a stupid test, but considering that AMD has had this
particular bug now several times over at least three different
generations, maybe it's not a stupid test after all.

Who knows what the Chinese CPU's that use the AMD core do? Hygon?
Whatever. Did they get the firmware fixes?

              Linus
