Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196DBC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6922077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573145628;
	bh=ZXZhc5ZTdS+zJpq6pUX56daYnJk13nRrSkyCdQmzJzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vlRjCMjMSF+9BZPIQbYYcSPeTlSxFrlBLBl4qFcTBdG0pq/V8tRh9Ftm4FZvjIKky
	 RUuA8Ca7CUekZ/W3kqieKNESxVRB4tNwVNEHyWJLJ+0LTrAi6LRpIG2u+pZ7jRyNIB
	 1J5STmx2FyOlP5TOhpthsJ8VIz+CRFtWOTLkIX0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfKGQxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:53:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38504 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfKGQxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:53:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id q28so2140515lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 08:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xmFpAJn0hM4hCADfxgFlNxkJRJWoCVfKXlrufraJ+m8=;
        b=UzYB1aPjPzc7eAqp/cNTEIY689LK/ItFnEl4Q27cI/u5BBjFKhbFMixDDvWFx++y98
         zNaFXfSm5iPweqOkjDXGeR4QXg4Es67aIbQxktg5/1Jwiv4NA+ob0UcqBWDQdCCC44xI
         O8lPeMI595A+1KifyBbibn5DCPW50PRPZ8I90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmFpAJn0hM4hCADfxgFlNxkJRJWoCVfKXlrufraJ+m8=;
        b=ASycn4sprWYd/o+SX0MB7f17nCyx2G/jVX+BNuQJLpJtScNwYtsZOye80eZ9rnMJAf
         8VY89xu/wyvTm5wLi3/Ab2ukIBoemv83ZtMLiSZHD22IMkmhK7GtfPzIEWPsoJ5ucLBK
         pvq0LVlBgwX35WxCpQYJWlEb8wLL7z4X9QyxdJDJpSb0BZ4gv582jxVVgqSGe8JRazSY
         ka2rChN3WaKnV2iLXe0uX7wIL8AcSNVoA9efKAFW10Jjr8wcH+kc8vXFUhBHMu3o2Hj/
         YlXsnW6GSAyTJTh5VfhXBYBJQCkZzRlcpaH4E4hCkiTEAyd+X+hXv83C0l6XllC8doHX
         CZ3w==
X-Gm-Message-State: APjAAAU5i1MS9O7UP5wAmDVPqXocBZY+rxmTaXBWuY9yGWL6zRAPrtQH
        kS6KUcjQ4qOxcUL0RXeqryK10+VHb60=
X-Google-Smtp-Source: APXvYqxIpK/fuOnGmiHB25dCfe4da+dkxiy0oajch2QlacwNgD+sAQVCQCbtbRphW1/U4Fc73sefWw==
X-Received: by 2002:ac2:569c:: with SMTP id 28mr2828211lfr.139.1573145623412;
        Thu, 07 Nov 2019 08:53:43 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id b23sm1415694lfj.49.2019.11.07.08.53.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 08:53:42 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id m9so3048967ljh.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 08:53:42 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr3208604ljh.82.1573145621882;
 Thu, 07 Nov 2019 08:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de>
 <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com>
 <20191107082541.GF30739@gmail.com> <20191107091704.GA15536@1wt.eu>
 <alpine.DEB.2.21.1911071058260.4256@nanos.tec.linutronix.de>
 <71DE81AC-3AD4-47B3-9CBA-A2C7841A3370@zytor.com> <20191107102756.GD15536@1wt.eu>
 <5AAEF116-EC9D-4C58-878F-9D27189E123A@zytor.com> <20191107125638.GB15642@1wt.eu>
 <87h83fd4a2.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h83fd4a2.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Nov 2019 08:53:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjtdCJYfy6nZSE7nKzUb1WLqh0B6MByTJCKe9OLOQ08PQ@mail.gmail.com>
Message-ID: <CAHk-=wjtdCJYfy6nZSE7nKzUb1WLqh0B6MByTJCKe9OLOQ08PQ@mail.gmail.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage further
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Willy Tarreau <w@1wt.eu>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 8:45 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Further a quick look shows that dosemu uses ioperm in a fine grained
> manner.  From memory it would allow a handful of ports to allow directly
> accessing a device and depended on the rest of the port accesses to be
> disallowed so it could trap and emulate them.

Yes. Making ioperm() some all-or-nothing thing would be horribly bad,
and has no real advantages that I can see.

               Linus
