Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E61C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAC22075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9z8imv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE1Ivp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:51:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40759 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE1Ivp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:51:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so11059666pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q4f7YqllLbjYUZXg0ivx58eQQxr0dIl4JKnUfCedx6c=;
        b=e9z8imv0vf+3IdAyEOXs8YRpnrZmU+vJuT26QAe78P+O8YjvYe6y0uS+r4FAaPX5Ip
         f8/bUpLvELfHmZplgavYuhoZcPaT6w8NPR6xGNhp1OhbsnvEgpe1AWZAe6S59jbItkx3
         U7vKSUNCsdEdAJwNNmPoUtivbKBoZPw5Q+4LZRMA9lSRJZiknvuHReM/ELepU/1EmIjg
         r57rWryegImzyhTr/qNmOEk02IU2ycl8h8QJeawhSRJgTPo/IE1uAXkxVs2AgIsyX+6G
         +dj53ar0+5r69QqPreOzAshon9CvTJGaCkaRJIaZZaiR3/ZHhG1BPbTzpNGHEGIb25cB
         ko9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q4f7YqllLbjYUZXg0ivx58eQQxr0dIl4JKnUfCedx6c=;
        b=naBvXx5syXI1OoiBSY1oPabvxXj1p+vsvAa2vsSW6w9BhQvKITmaYSqUQQwibBmP4w
         +GIrVg4Ajey/cHz2gc5D/evY0xKVStAzvMl7eCKGarSo2zaGN0kwJogAQMCWqnsfi7xS
         zpsncOrImKH9uITXKjWEBwF/9780gElkXRF6S+xKAboW/rfCtKMBzWD77c7cvSqiZRpH
         9+WsLrN4CqqS+MPZHN2fPGIH6Hw9NrJQoyA5AI+Ocrip3qiT4Z+tH+9RAKByGBQalbhp
         K441V3I8rgx3Q2N7ZwBy9X6ieUsTa6DBLBDiweAQR6mpJ5oD+LSb6sGrF4gLIuKw1q5S
         Qn0Q==
X-Gm-Message-State: APjAAAUIoOqrSZw8xsgGhZ9vtuuxLKrKzJ/G3aIZiWyhIllcBSXzed6w
        9EpXqL9rTqUqUYwUl15Ib1M=
X-Google-Smtp-Source: APXvYqwsJ8HcMyRgPwBn0ziaXKCtg9PmGAnfN+q0uIFQR+0c7QXPOvDc5qPY4MjkDVaKbL6CXmZVvA==
X-Received: by 2002:a62:fb10:: with SMTP id x16mr77887981pfm.112.1559033504773;
        Tue, 28 May 2019 01:51:44 -0700 (PDT)
Received: from localhost ([175.223.45.124])
        by smtp.gmail.com with ESMTPSA id u14sm7713907pfc.31.2019.05.28.01.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 01:51:43 -0700 (PDT)
Date:   Tue, 28 May 2019 17:51:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190528084825.GA9676@jagdpanzerIV>
References: <20190528002412.1625-1-dima@arista.com>
 <4a9c1b20-777d-079a-33f5-ddf0a39ff788@i-love.sakura.ne.jp>
 <20190528042208.GD26865@jagdpanzerIV>
 <90a22327-922d-6415-538a-6a3fcbe9f3e1@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90a22327-922d-6415-538a-6a3fcbe9f3e1@i-love.sakura.ne.jp>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/28/19 17:02), Tetsuo Handa wrote:
> On 2019/05/28 13:22, Sergey Senozhatsky wrote:
> > On (05/28/19 12:21), Tetsuo Handa wrote:
> > [..]
> Dmitry's patch is changing only the header line (in other words, per printk() call).
> Since op_p->handler(key) is out of KERN_UNSUPPRESSED effect, the body lines might
> not be printed.

Right.

> I think that we need a way to pass KERN_UNSUPPRESSED from printk()
> calls invoked from op_p->handler(key).

Right. That's what the per-CPU context bit address.

> You are trying to omit passing KERN_UNSUPPRESSED by utilizing implicit printk
> context information. But doesn't such attempt resemble find_printk_buffer() ?

Adding KERN_UNSUPPRESSED to all printks down the op_p->handler()
line is hardly possible. At the same time I'd really prefer not
to have buffering for sysrq.

	-ss
