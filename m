Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8BBC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517192075B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly7daxZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLIJ2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:28:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37101 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfLIJ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:27:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so266635plz.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 01:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHHQKr0i75mqHj3OhmeZ0+BGxc8hlLVrwIhDe+URYcg=;
        b=ly7daxZy/UDhQUWwKvd7jhbdYl8PZTrdBXVYPA/LGkBGar/kbEow0qUzkwwPARo4Gp
         Pvi91wjoK/CMmeOmdX/bE3oY+FfjVhO9mIHP9k0jd2rXStODOBA3mq+t9xUl+YYlPx+v
         amDe9j28QSKXWUnuP6wZscHm8qwLTAAt3NOSaCzEXgQJP1JTZpKMbFl7/ucc4Vlh+8tT
         N9WIta0wOyWg42uMfurq7gTFg4JTqv5vaIZPlmWCLDK5lGtiYf7VxhCpg4Sebwu8VB/1
         G3qasHMBSSDgwu0KiimykAl6YPD2OfOiyqzH3TT26Ji/wNnzGYPmDxZkIF77oo3N7xRG
         sExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHHQKr0i75mqHj3OhmeZ0+BGxc8hlLVrwIhDe+URYcg=;
        b=PKzoHafCxrkM3UUy1pyp2avJtdZ/9eBCqdiuE6NN/W0bbHqfgZhRNvpacbK32cwuo2
         BEgrxU+dnS7jacJR3eWie0goHf1bBAEC/P4p8W60q0GJ63zGZO+klNyfKDrcdtGrqyel
         T7DOsvZkqzHYeKO7Tek9tyJWt2eMjwEfpM0AkkmMieIqFWQUaECSoAkECPzMo0Toaloe
         vUJHDnbu70Xhkd0LHNWI2Rx+G/yDfZi3P+FDkwBjck5j7D5qycaxwju7iL2B373DCyyl
         0Za1GT8w45k+sTsbZSOa2MhuQzaSulukftjdkJ/OMY7yMKe7+Tb6VeJwcQsC9e+rVRwI
         qZZQ==
X-Gm-Message-State: APjAAAVQrzGGUGXe+XQlpqNIV9keygPCUcVNszvuheCslranoAcEH77G
        v3Mbqfyt9lwkQxDj4WO3BZc=
X-Google-Smtp-Source: APXvYqzCGd3qSvmAfe3R0sLqnFB2USWEhpUozXO8ZhIWbNaRxyD/nWRNvCzlw2bZp99pLhdszeysGQ==
X-Received: by 2002:a17:90a:9f04:: with SMTP id n4mr31320455pjp.76.1575883679106;
        Mon, 09 Dec 2019 01:27:59 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id k13sm16545287pfp.48.2019.12.09.01.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 01:27:58 -0800 (PST)
Date:   Mon, 9 Dec 2019 18:27:56 +0900
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
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
Message-ID: <20191209092756.GH88619@google.com>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128015235.12940-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/11/28 02:58), John Ogness wrote:
> + * Sample reader code::
> + *
> + *	struct printk_info info;
> + *	char text_buf[32];
> + *	char dict_buf[32];
> + *	u64 next_seq = 0;
> + *	struct printk_record r = {
> + *		.info		= &info,
> + *		.text_buf	= &text_buf[0],
> + *		.dict_buf	= &dict_buf[0],
> + *		.text_buf_size	= sizeof(text_buf),
> + *		.dict_buf_size	= sizeof(dict_buf),
> + *	};
> + *
> + *	while (prb_read_valid(&rb, next_seq, &r)) {
> + *		if (info.seq != next_seq)
> + *			pr_warn("lost %llu records\n", info.seq - next_seq);
> + *
> + *		if (info.text_len > r.text_buf_size) {
> + *			pr_warn("record %llu text truncated\n", info.seq);
> + *			text_buf[sizeof(text_buf) - 1] = 0;
> + *		}
> + *
> + *		if (info.dict_len > r.dict_buf_size) {
> + *			pr_warn("record %llu dict truncated\n", info.seq);
> + *			dict_buf[sizeof(dict_buf) - 1] = 0;
> + *		}
> + *
> + *		pr_info("%llu: %llu: %s;%s\n", info.seq, info.ts_nsec,
> + *			&text_buf[0], info.dict_len ? &dict_buf[0] : "");
> + *
> + *		next_seq = info.seq + 1;
> + *	}
> + */

Will this loop ever end? :)

pr_info() adds data to ringbuffer, which prb_read_valid() reads, so pr_info()
can add more data, which prb_read_valid() will read, so pr_info()...

	-ss
