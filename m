Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6161C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F9E20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mz1wBwJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfCRNRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:17:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41491 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfCRNRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:17:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so11228657pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMsQCnO3d2N5DODeaXx9kIQiZQAAX2gcah3MrcQIGq4=;
        b=Mz1wBwJj6aCIZctfrRgE6qXPvX+DxKzIewaAWG2rsnRyqxyHSntUGvgMk83TJr4D9R
         vQY040rQcugdz84sOkhKoPh+5b61cRyUPyZHiun1V7TlGA4yTVG73h6PtP07QDgLiuwE
         n+Y726W4fhoevokV4KYe1eN7kRnGOw2ACjkFgmQCINLKKX731h86aGsk7vt7KFXu5VD/
         IvAIbnkhPmKhNvITYDEkPKJcLWmUjR47kAvs4vZgz0S2NXlFkFNzVMsgyzV5Se0Oxdq4
         +rOKDCv24NM7YvtykGdF3O1VGaaySN2ax6qOyIngXLA9yS4tWIS96p9YD5FbV0UfdUAj
         Rnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMsQCnO3d2N5DODeaXx9kIQiZQAAX2gcah3MrcQIGq4=;
        b=e8l47UPv4WscbrVi3WDTc9adkdd7ulboqtT95CDSBBF+J5D5PtW1wxPZuT0p9JtBKE
         OTBwZPgPBQ3QkbxjFib+N6EMBVntmX458BSkEFrAQFW+8TYA9WRGTfkahTZTJaUeBaEi
         WpdsyJSneGgUjDF9E1p7v5wKRqDszYU+KfUrHhXYHqtfe63SODacVqYoTGZ0XYEGxOnF
         RbDjOgaibbJ94KZsZ5rKfEQz1w2DAZ83zL9IghQCwqWfcg5zQymnzqu0fck8lr+e1jwr
         kNskc+vSfBTb2gLrD5RewdHum0EUmxpV+l2/QRil3wejF7Tn+UH0YJXimcTWqpdrZLkC
         5d6A==
X-Gm-Message-State: APjAAAV80/kLYyo+8JkK6yA6jRZrFeL+tO859WsZ1fpn71nmkwu4SZxt
        l7IqZLaftHSbI2PqoAsuZ1QL25YBGBX3G5e7+OMkVw==
X-Google-Smtp-Source: APXvYqznUx/0uvWyFAaioSmzSqQCdEUiA7lTMwL0ocTN2RjTJ+d/Q8++zm5Ul1FUymXrEWoCrhT4qzyR9aFgyliP2CQ=
X-Received: by 2002:a62:6383:: with SMTP id x125mr18765188pfb.239.1552915025400;
 Mon, 18 Mar 2019 06:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com> <56d3373c1c5007d776fcd5de4523f4b9da341fb6.1552679409.git.andreyknvl@google.com>
 <04c5b2de-7fde-7625-9d42-228160879ea0@gmail.com> <CAAeHK+xXLypBpF1EE73KuzQAo0E6Y=apS46wo+swo2AB6cy3YA@mail.gmail.com>
In-Reply-To: <CAAeHK+xXLypBpF1EE73KuzQAo0E6Y=apS46wo+swo2AB6cy3YA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 18 Mar 2019 14:16:54 +0100
Message-ID: <CAAeHK+yxcG=KBjG0A5BicBA7Zwu6LR6t=g5b-9EAPXA8_Dfm2g@mail.gmail.com>
Subject: Re: [PATCH v11 08/14] net, arm64: untag user pointers in tcp_zerocopy_receive
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 2:14 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Fri, Mar 15, 2019 at 9:03 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> >
> >
> > On 03/15/2019 12:51 PM, Andrey Konovalov wrote:
> > > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > > pass tagged user pointers (with the top byte set to something else other
> > > than 0x00) as syscall arguments.
> > >
> > > tcp_zerocopy_receive() uses provided user pointers for vma lookups, which
> > > can only by done with untagged pointers.
> > >
> > > Untag user pointers in this function.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> > >  net/ipv4/tcp.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 6baa6dc1b13b..89db3b4fc753 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -1758,6 +1758,8 @@ static int tcp_zerocopy_receive(struct sock *sk,
> > >       int inq;
> > >       int ret;
> > >
> > > +     address = untagged_addr(address);
> > > +
> > >       if (address & (PAGE_SIZE - 1) || address != zc->address)
> >
> > The second test will fail, if the top bits are changed in address but not in zc->address
>
> Will fix in v12, thanks Eric!

Looking at the code, what's the point of this address != zc->address
check? Should I just remove it?

>
> >
> > >               return -EINVAL;
> > >
> > >
> >
