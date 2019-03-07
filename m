Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177D1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22782081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551976430;
	bh=TlOB1L/i8+EDI9ksNjvGf402mI1jf2H43isHRC+JIgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SmJr8DQihjRVS3bl92dVsppF79fJqWOTKWYyibJaT8rgQI6I7sd/vprQSeK9WHCr7
	 XgJd9sSTvdyWKiEO0rS5VLahGlEovpdmjw+TRevaMmassorcMR/D5G1uYB/+8cgFVQ
	 dkIUONQmUAUYe9oJzp8qkvd5lZS8bsWDd/lWAcRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfCGQdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:33:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37781 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGQds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:33:48 -0500
Received: by mail-lf1-f66.google.com with SMTP id u2so5201665lfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 08:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zV1/Q9K8yf9DgcOtn6Jx1ENNgi6PmLWeH+dMT56acKo=;
        b=RjC4D68mhmlXQdzuhrd1XFazStJLTqJ8d36vyv5rS2B2T2A9woK2AVOnZjkja/9FBA
         pNxGEEWUxuz8QNjlO2c7k6LzPK5GxlZ41k5JzwFGA6mpdHBaHojVLRsXfObOAZ5WgUkV
         uganL5gYfKJn/2utjNnFpHSZCIaN8c7R6ZNAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zV1/Q9K8yf9DgcOtn6Jx1ENNgi6PmLWeH+dMT56acKo=;
        b=LUNaqSHg3lJPJzckogmDwLqsBDverD34BracR4+rJUN6mAXiXeP6BiVF2PA2l1hpOH
         cdKIxlZKZ+2EMSz0pHA185HhPt9ftf0E0nCXZkR3WdGTI+1wZ/NHjzAZuVB8s4oHXhbY
         EpugqRMrvAeKcAVDdUj462JizpKV+K8xs0o33AE2iRhaAr2QZZGByxq4sSaoPc+piFgV
         iHfWZzmtHT2kUu3PMvFeV/gdchg+QyVf+vVDTQY/7CnN5m3MPHL9rUlDUAvSdrfg5fRj
         CAbzhhy6XjJuUu5bqegAN65Xko7tU8siCmOGZQVL9I9Xo8xVGclC52uXxmDjkcTABLK+
         dIhg==
X-Gm-Message-State: APjAAAV8rp7llRawrA+svGdkt9XF7LP5zJQlcechrr3oSXF8VXxrktej
        7A8NZsLS13+GxPnILdpbcbCcPFxz5mc=
X-Google-Smtp-Source: APXvYqz9ta/Res7Xu0PJ9LQFNCA+jw7qFuim+UoR6f2O8RjzZyzGrL5iz+VGH/SEBANKUFDcQsHKcg==
X-Received: by 2002:ac2:5387:: with SMTP id g7mr7980278lfh.158.1551976426026;
        Thu, 07 Mar 2019 08:33:46 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j7sm910743ljb.1.2019.03.07.08.33.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 08:33:45 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id r123so12151436lff.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 08:33:44 -0800 (PST)
X-Received: by 2002:ac2:5386:: with SMTP id g6mr7552046lfh.88.1551976424441;
 Thu, 07 Mar 2019 08:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20190307114511.870090179@infradead.org> <20190307115200.697533978@infradead.org>
In-Reply-To: <20190307115200.697533978@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Mar 2019 08:33:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
Message-ID: <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 3:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> XXX: are we sure we want __memset marked AC-safe?

It's certainly one of the safer functions to call with AC set, but it
sounds wrong anyway. It's not like it's likely to leak kernel data
(most memset's are with 0, and even the non-zero ones I can't imagine
are sensitive - more like poison values etc).

What's the call site that made you go "just add __memset() to the list"?

            Linus
