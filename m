Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C68C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F0120870
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566763185;
	bh=8dab/N+G+Ws2pEvTnFj8a60ZvdFyDvBBE7tGRKz3PG0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bvHjh/k3dLt1atW5TF2M+XoK4X9bgOAj23oOY7KQxbWgbLFBbRcpL/gcc05Gotvfa
	 Bq0O5qXzLwG4W8leJe5oxGT2DMiCZmFjrcSbaNzOzTAdhkKz7mgncvvwK1LaHn7KXa
	 ye0dvFnsEVt4FdTVnMy5efNQAH/yzbnSnnwE6OMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfHYT7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 15:59:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36203 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHYT7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 15:59:44 -0400
Received: by mail-lf1-f67.google.com with SMTP id r5so5190594lfc.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVa8anCZ+4vkRzIouGu0LBPnwGXRh/AHZn823ax1V5Q=;
        b=Y0BTrtMRbnRRY5Pld/ZZQTW8Q67qN5m1j0be9LImGfHgJfaW9aqNlau409QswX02Al
         K/uZjUY0EJKN19kL81vDzukd+1ZmLD0iZxP0KWabgBmwRmQyB577RVQgWH+AWXcvtPxU
         sVsOjHD13Ve2I5h5gIEAfi7a57cjr0n/MGDnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVa8anCZ+4vkRzIouGu0LBPnwGXRh/AHZn823ax1V5Q=;
        b=SP1RZU9jcLxT4ZQcOjriNkX0FNaxH3tHnSw5SiU73fPRlDQoSzaA2R1N4WTiwgGAdY
         C7er/cXMqP79iolDZ4foKGd5G7v+L2MxG5hrjZEdIwRADrl0tDLw97h3WrZRFeTnHj3r
         gEeOKr+f3rHcqJpByIsbcypSWisxmXtTcIAVg6xg11ygZh0Mm+lF0dry0JdR6w/XwkQH
         1Jw6sgzNmtsK3s+bGbeWilSGHWiSAij/di/okg+nU4/lR9z5wMSDbpjdGz8eHADK78Si
         Fut7xSbu73D+qdme0Y3wqV33TNn2Jiahx+ql0YjDiY5EwrFEXWSoGzrWx+s+FJU8frGk
         GIow==
X-Gm-Message-State: APjAAAXUamQJE9w/JA7WHX5t8NO9EkYsvReMce9IFg5WFnFtkB4c0J/c
        WZ7ey1MytVrYMdMOXzXcm2upFUWU6iw=
X-Google-Smtp-Source: APXvYqxL+q4O7vul+jYLivShOoEHlfca7fXTTRy9MJmqZirtU+53ojpEocpn+WMHA4GoDSGgrtRQpA==
X-Received: by 2002:ac2:5ec8:: with SMTP id d8mr7424224lfq.183.1566763181943;
        Sun, 25 Aug 2019 12:59:41 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 69sm1687112ljj.101.2019.08.25.12.59.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2019 12:59:41 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id n19so10662872lfe.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 12:59:41 -0700 (PDT)
X-Received: by 2002:ac2:428d:: with SMTP id m13mr8633607lfh.52.1566763180838;
 Sun, 25 Aug 2019 12:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
 <20190825173000.GB20639@zn.tnic> <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
 <20190825182922.GC20639@zn.tnic> <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
 <20190825193218.GD20639@zn.tnic> <CAHk-=wiBqmHTFYJWOehB=k3mC7srsx0DWMCYZ7fMOC0T7v1KHA@mail.gmail.com>
 <20190825194912.GF20639@zn.tnic>
In-Reply-To: <20190825194912.GF20639@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Aug 2019 12:59:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcUQjK=SqPGdZCDEKntOZEv34n9wKJhBrPzcL6J7nDqQ@mail.gmail.com>
Message-ID: <CAHk-=wjcUQjK=SqPGdZCDEKntOZEv34n9wKJhBrPzcL6J7nDqQ@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
To:     Borislav Petkov <bp@suse.de>
Cc:     Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 12:49 PM Borislav Petkov <bp@suse.de> wrote:
>
> We're really verbose, though. Dunno if we should make this a WARN_ONCE
> or we say that we really should be very loud with a non-functioning
> RDRAND...

I think WARN_ONCE() is good. It's big enough that it will show up in
dmesg if anybody looks, and if nobody looks I think distros still have
logging for things like that, don't they?

Hopefully this never actually triggers in practice, thanks to rdrand
being turned off on known-bad machines now, and Zen 2 being fixed.

               Linus
