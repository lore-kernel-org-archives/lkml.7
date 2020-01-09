Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928D4C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600E22072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdgOUrwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgAIIUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:20:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35584 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgAIIUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:20:12 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so5238855qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 00:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nntsi3ZIZ4YTnCqpslNwLZBauzhg9rC3/Kr5lCbJGLM=;
        b=KdgOUrwoRKlKyIE48pG0Q85YWMdko0UhJ3v9AUQZA+pZbJDrWSoKhtRH/VQ9ciedjL
         ILNhwIl8z1+CRUhbtdsD6Do8LlF3d2HyXjIR0IF8tWIuUDas3ywLzAtctwmz+vrh78Z2
         FPzdEctv1OfekncziNGDIdVn5fe2oFpxWSMrtOqccbbFaAYCZ6XLAYGuLRXZN8aW4cpk
         XMzQbpcGJKn6i2oA+l8xMxM50n9QE6GfR0AOnhfT956t/iBKJuXwuGDqhdo7ON9BU1Xp
         holnkaReSd5if7w+vcnpx9ouY8BKQ3dkX1V2wj9babO1CPJxkDRNdu/5bcnPe7IObTpp
         npxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nntsi3ZIZ4YTnCqpslNwLZBauzhg9rC3/Kr5lCbJGLM=;
        b=EiSJMwP9J8cpd/1gBrEhkv3zmOkns3oBecVkR6kzk0lKNaZKpab7oK4NDF+EjCPlS4
         AsKdJ7qZ4oEL4r9L6ZqHyxLtTVDsLK+mF1QvXwljGWhxVAyT9JhLiypKYJYE7tDy3tv0
         K6aMtALR48QFpg3tGLSRh1PjQGyHSKaSOTLTJwhG1nXuN0hUEkdcc+D/S90WsZwugMih
         dje9Nn0WaSm+jj2xkCUJv4K7u08gUmiYGVHFi1MAOV/v8+cC5AtsMyJhBnnXCiu+mtYa
         C3RVdKfeBBQflsiTZaOzS1RM60+kgjpuqWwV4XLzJatowNZPvgiMauuDARVI+/3E+Q9E
         u38Q==
X-Gm-Message-State: APjAAAX0Q62xFYmEK4VsuukEiXY2fYSkwgchk5E30z7WCmd68F0e0izB
        3oNrY+FJrYYLbu84wsuKYOlRUlz+O6LOH8+2BANrsA==
X-Google-Smtp-Source: APXvYqzoYusFp/63zWLhSXi9P7Xfz0t1A3k1UMy8zAE33t/cJkEETydSd7vAVohcF5cxg22g94He62lLgUDDNqy+mfI=
X-Received: by 2002:a37:e312:: with SMTP id y18mr8541800qki.250.1578558008734;
 Thu, 09 Jan 2020 00:20:08 -0800 (PST)
MIME-Version: 1.0
References: <00000000000036decf0598c8762e@google.com> <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com>
 <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com>
 <f7758e0a-a157-56a2-287e-3d4452d72e00@schaufler-ca.com> <87a787ekd0.fsf@dja-thinkpad.axtens.net>
 <87h81zax74.fsf@dja-thinkpad.axtens.net> <CACT4Y+b+Vx1FeCmhMAYq-g3ObHdMPOsWxouyXXUr7S5OjNiVGQ@mail.gmail.com>
 <0b60c93e-a967-ecac-07e7-67aea1a0208e@I-love.SAKURA.ne.jp> <6d009462-74d9-96e9-ab3f-396842a58011@schaufler-ca.com>
In-Reply-To: <6d009462-74d9-96e9-ab3f-396842a58011@schaufler-ca.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jan 2020 09:19:57 +0100
Message-ID: <CACT4Y+bURugCpLm5TG37-7voFEeEoXo_Gb=3sy75_RELZotXHw@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_kill
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 6:19 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 1/8/2020 2:25 AM, Tetsuo Handa wrote:
> > On 2020/01/08 15:20, Dmitry Vyukov wrote:
> >> I temporarily re-enabled smack instance and it produced another 50
> >> stalls all over the kernel, and now keeps spewing a dozen every hour.
>
> Do I have to be using clang to test this? I'm setting up to work on this,
> and don't want to waste time using my current tool chain if the problem
> is clang specific.

Humm, interesting. Initially I was going to say that most likely it's
not clang-related. Bug smack instance is actually the only one that
uses clang as well (except for KMSAN of course). So maybe it's indeed
clang-related rather than smack-related. Let me try to build a kernel
with clang.

> > Since we can get stall reports rather easily, can we try modifying
> > kernel command line (e.g. lsm=smack) and/or kernel config (e.g. no kasan) ?
> >
> >> I've mailed 3 new samples, you can see them here:
> >> https://syzkaller.appspot.com/bug?extid=de8d933e7d153aa0c1bb
> >>
> >> The config is provided, command line args are here:
> >> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-smack.cmdline
> >> Some non-default sysctls that syzbot sets are here:
> >> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream.sysctl
> >> Image can be downloaded from here:
> >> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce
> >> syzbot uses GCE VMs with 2 CPUs and 7.5GB memory, but this does not
> >> look to be virtualization-related (?) so probably should reproduce in
> >> qemu too.
> > Is it possible to add instance for linux-next.git that uses these configs?
> > If yes, we could try adding some debug printk() under CONFIG_DEBUG_AID_FOR_SYZBOT=y .
