Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAADC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66E82085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCgORY8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfFREvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 00:51:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37002 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFREvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:51:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so6903962pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 21:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GcQlY8S/p+kxFAnMkubPgYwK7VdqjVATnBI9h9/SPA8=;
        b=BCgORY8fG3p2oZw4qFVaCKNKF/8FqPeWfMM2TL82ob4r8YP15GX8hY1rRi6tjCHne0
         6/p5Tp4P33PsKTtiG8glwrn63CWlEDeK7z//GlWuLn/bz9n8lpQ89oss+iskkNCc+O1A
         A6ZA0M+jt149ybUbHdSlhJqSk+DlwugQxYeivu7pcDMa9h/ch4aDl9TNhG8OaRpUmWQ+
         h60lxa2M9X4uvJcPIBqAGFnBitHlZTwuLhOhU8wLF0vuf1/DTgjV1/moZwpu0zOw6gts
         YWBO7DzOOr7UnnWe6Injlrgx+BlIhdOAybooB7Y0IYCs4944Uw8OgNxX7Fl+8v6M9+WR
         zKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GcQlY8S/p+kxFAnMkubPgYwK7VdqjVATnBI9h9/SPA8=;
        b=GAPgHwbRrl3GcghCgPtN1pjMW1dUIznto9iW/dOHVmbYdvbJ6fvGjZ14nAVuscQUI/
         W3E7aGqp5jpC8UCDl70a0RTggCZPv6NcMdvh7YEOCV6hlyQqJWxBa1E7WtSfP27yLZJn
         Zb7cGZZMx9agX81rbQQ7MFKpuPE+BzN/gQufN+Ju81p6/+CJc2jRL6YIxFQPglAUdZpk
         4FQ8s/1U5jXGDbrWUYfWy3YcGu7kMxRU1kBBTpcr7QiLIscmkzC3qZlYXtSiQwNTV/OC
         mOvFt64qiALic1YxSQlRqWrUA2G0+XWuOcbv8hPvRidszFjVUlmFIBb1kWgbDo/qjoBw
         1Nuw==
X-Gm-Message-State: APjAAAUISco5jIzPQfYOTCCXkGsEHWEVpy1JMZXqHNhF6zpcTotI5Awy
        jlGqcsUTiCYYXRoj6UUOpnM=
X-Google-Smtp-Source: APXvYqzEDDQ/Tq39/8bkhp/hHoPl7qt/cst7WCob3xQfRP8I7Bffo+94PULeO/aAJi0RBlFSAruRQQ==
X-Received: by 2002:a17:90a:db44:: with SMTP id u4mr2965916pjx.52.1560833481851;
        Mon, 17 Jun 2019 21:51:21 -0700 (PDT)
Received: from localhost ([175.223.20.188])
        by smtp.gmail.com with ESMTPSA id e184sm18115681pfa.169.2019.06.17.21.51.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 21:51:20 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:51:17 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190618045117.GA7419@jagdpanzerIV>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607162349.18199-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello John,

On (06/07/19 18:29), John Ogness wrote:
[..]
> +	struct prb_reserved_entry e;
> +	char *s;
> +
> +	s = prb_reserve(&e, &rb, 32);
> +	if (s) {
> +		sprintf(s, "Hello, world!");
> +		prb_commit(&e);
> +	}

A nit: snprintf().

sprintf() is tricky, it may write "slightly more than was
anticipated" bytes - all those string_nocheck(" disabled"),
error_string("pK-error"), etc.

[..]
> +Sample reader code::
> +
> +	DECLARE_PRINTKRB_ENTRY(entry, 128);
> +	DECLARE_PRINTKRB_ITER(iter, &test_rb, &entry);
> +	u64 last_seq = 0;
> +	int len;
> +	char *s;
> +
> +	prb_for_each_entry(&iter, len) {
> +		if (entry.seq - last_seq != 1) {
> +			printf("LOST %llu ENTRIES\n",
> +				entry.seq - (last_seq + 1));
> +		}
> +		last_seq = entry.seq;
> +
> +		s = (char *)&entry.buffer[0];
> +		if (len >= 128)
> +			s[128 - 1] = 0;
> +		printf("data: %s\n", s);
> +	}

How are we going to handle pr_cont() loops?

print_modules()
 preempt_disable();
 list_for_each_entry_rcu(mod, &modules, list) {
  pr_cont(" %s%s", mod->name, module_flags(mod, buf));
 }
 preempt_enable();

	-ss
