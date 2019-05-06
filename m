Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E3CC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F712205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="txS+4YeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfEFQOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:14:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45910 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfEFQOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:14:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id i21so6675889pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z3pUfqa7gd7ssg4ALokCu3zp8vqsQw6UnB3He64S+ro=;
        b=txS+4YeGY/H0S3mICXO5X0wIehkEzXdpri2XdKbPxIONUrrYDOQ/b5DcvhMMPHEY0r
         KOfyyC3IEmPR2NHWqwych9DXW5MN64WHhTW2lyi1HzI6KRwVPWjbVxDG4Xn06HuG/K/K
         6wa6cnUwNwfMqS98pUQElA4gw+kVzawQYbw5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z3pUfqa7gd7ssg4ALokCu3zp8vqsQw6UnB3He64S+ro=;
        b=udJR2KzNYcZZuiblB8aMTQM40bIHxWZTJgG7Sstn2KHnOAUe8GYTLrp/Ldn60UEZAv
         NUhZ3LrwiPrh+AyPMFPrgBx7gFAK1ILDb+hO4GfLsab0y3a6tmMXGQZAEX9iIotrFnMR
         W9FyqlhV1gY3L+2v3C07RcvvShW+I8ZXfwdwmILFwtE+OXVnABo/ano16xPb3GZwwXiU
         AUBN+19u2/nCBgpAnf7Ds3WEI1EMjzTuqtU8dMdo8BoZrs8wW4wWHfl5OkE5DbBCe8nq
         rV6xUu8KQRXZc51WCAYE5DWHCfQK2O5a/4BsOT1nx5txq06KNVQJy2uWa2JHUtoxcgmB
         R57A==
X-Gm-Message-State: APjAAAWQu/ABl4Kwu0Gc0IH6u0WkNXkWTnJlhB3QElHKMx6s3BlUq9In
        bGGA9wKl4V6g436mk1G+KqzMgA==
X-Google-Smtp-Source: APXvYqzDM4UBpLP79cwiwJXWz9mzogsUcq++jnwygx905NSVdBAvAy2weNCMHUIvOQCc2MgQKU+Bow==
X-Received: by 2002:a63:6b49:: with SMTP id g70mr33374565pgc.340.1557159283609;
        Mon, 06 May 2019 09:14:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h127sm14371516pgc.31.2019.05.06.09.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 09:14:41 -0700 (PDT)
Date:   Mon, 6 May 2019 12:14:29 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michal Gregorczyk <michalgr@live.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Mohammad Husain <russoue@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Srinivas Ramana <sramana@codeaurora.org>,
        duyuchao <yuchao.du@unisoc.com>,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH RFC] bpf: Add support for reading user pointers
Message-ID: <20190506161429.GB234965@google.com>
References: <20190502204958.7868-1-joel@joelfernandes.org>
 <20190506234751.65c92139dccbfa025bdfe300@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506234751.65c92139dccbfa025bdfe300@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 11:47:51PM +0900, Masami Hiramatsu wrote:
> Hi Joel,
> 
> On Thu,  2 May 2019 16:49:58 -0400
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > The eBPF based opensnoop tool fails to read the file path string passed
> > to the do_sys_open function. This is because it is a pointer to
> > userspace address and causes an -EFAULT when read with
> > probe_kernel_read. This is not an issue when running the tool on x86 but
> > is an issue on arm64. This patch adds a new bpf function call based
> > which calls the recently proposed probe_user_read function [1].
> > Using this function call from opensnoop fixes the issue on arm64.
> > 
> > [1] https://lore.kernel.org/patchwork/patch/1051588/
> 
> Anyway, this series is still out-of-tree. We have to push this or similar
> update into kernel at first. I can resend v7 on the latest -tip tree including
> this patch if you update the description.

Sounds good. I also have to split it up and add a deprecation for the old
API. I will get this done today and then you can include them in your series,
thanks! Once I send them, could you CC bpf maintainers on the patches too in
the future? thanks.

 - Joel

