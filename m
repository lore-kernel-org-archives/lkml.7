Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2069C73C5C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734DD20693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562710047;
	bh=qCo///t9OGeackny4JJkVPRHASlrNUKMRKpU4CMt2IQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KoYMjy9pn7xSOR1iLF2Fwbfv9N6lZsnPtnNs/m/zQVj1ZRraASWynM+iMNS/PFV7f
	 8GMwJWv6oVd70NvxA1FyeUla0zn7b8hRmknTwkBjY7CjcmV+Lantsbj6MyDJtdVG0l
	 gaw5dgKFuuCEq9N5GF14Muc7iMHKuKJ+RcbZm4oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfGIWH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 18:07:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41279 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfGIWHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 18:07:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so115716lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TwNKZrnOf/DNtoznfTJOHcvnivCBkILoiDNMbeTEGBQ=;
        b=JATPJXNDe3eXMuuaSA9OL8x2LTxnMibTuFzwAxuPITicQsTa3ZQyZLu2m5SP7RUqwk
         vhjkfoaH05Iv8q5Sua2MKOT19+T6EfibpXyx4otzHwW//6vdgq+Wb4TjK1cDIYXp+LIq
         zvAZxl28HN13vpadRziHbRobwBDQxt/whrWjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TwNKZrnOf/DNtoznfTJOHcvnivCBkILoiDNMbeTEGBQ=;
        b=swT2tZS9FwerY8R+aH5VYoRhBmk/Y/LoKcYXF5dHiIdVJMqRca5qWR13dBUq8G+AM1
         lalytVJvzmDZM+cKmxYnabiWng1jflmsS0lt+hOV1p8X+KGGf9/L1QYgB6jOX6FPCtk6
         yhiyGL3LqJ3DYioL2UMWdvj8vxcFrstICWloN2ajgWGwtFfWj/WTw4fJIa56XpxKAX+k
         TmbVvyB0kUn+IcGxjBTVqFpXiOCX4/kn9XGdAa6/0qBPXCt8/5KaJx6rtnxY7ZPsHaLw
         rpOQk0oXOBcDoP8dpbH59Q/Gjs8XpBweXwT/XN5J7V5dsmgjJlacLH5/4sGmg0kxg6HW
         +oKw==
X-Gm-Message-State: APjAAAUxtfTj8QsHFqTC2g3ziZxTNOQR2rw2K8+7Ho8VXJYiTrbwsKzV
        Ba2ULhUJJUPaw+jueMb1z3mVRu6bVnw=
X-Google-Smtp-Source: APXvYqxwOBTsoRCtHesz1n4xosIoHGTnav2z715JNpKQbjQ19PbMKTC/PZ+6CWSP8WMcfRIQdt4yEA==
X-Received: by 2002:ac2:5a1c:: with SMTP id q28mr11431522lfn.131.1562710043156;
        Tue, 09 Jul 2019 15:07:23 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e12sm26986lfb.66.2019.07.09.15.07.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 15:07:22 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id p17so21562ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 15:07:21 -0700 (PDT)
X-Received: by 2002:a2e:b003:: with SMTP id y3mr15421380ljk.72.1562710041715;
 Tue, 09 Jul 2019 15:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190708162756.GA69120@gmail.com> <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
 <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
 <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com> <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Jul 2019 15:07:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8sXuH13b+qm0kK+q7KMU-ZDDaziEHeAAHtfn+kw3SSw@mail.gmail.com>
Message-ID: <CAHk-=wj8sXuH13b+qm0kK+q7KMU-ZDDaziEHeAAHtfn+kw3SSw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
To:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 3:00 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I haven't confirmed yet whether reverting just that one commit is
> required, or if I need to revert the cr0 one too.

Oh, I can't revert just the cr4 one, because the cr0 one depends on it.

But reverting both gets my desktop back to life. My laptop (that hung
earlier) seems to be another (possibly additional) issue.

                      Linus
