Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DBEC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451202071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxx9TJPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfLIHmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:42:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40161 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfLIHmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:42:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so6673158pgt.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 23:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mxNFYCmNhlniWht0zpLB7qcISplkfJ5aENS7UtExcLA=;
        b=lxx9TJPYOhlvXmJQSe9z15P6BYI2yXj6oQ8GNUXfIL3FiCkisygeP+qQvp3HVN8snj
         Isp4uPZqrKvaSv00mOpdJ0qgDgi+DFoaf2iGeQ7FFy74iZVgh2P09uzQ9sZebJsp96Gn
         X9QGvPCjTKbhzB20W7QJiu1ncyClbosAqy6kmSECC08dh4P8UkY+kP0a3X0R+7lu7j4w
         GlfbyId7LCcdxC1iOpua5CWGMunkw+dMjJhYGJ7yNAcfPzI4N2Fwiz8tVHJNG+UF5V4e
         /G3BHijeubxOcBLhLr9ZptqyGeLW+e2mllxNHKGJmJbLD/xTlO9m8yLvfqP12Esh/lOn
         Hx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mxNFYCmNhlniWht0zpLB7qcISplkfJ5aENS7UtExcLA=;
        b=LWehqw5yXDwr/mz6ywCBKsdMJvF/RR1MAW03vT1qbBFVX0eb+Iay/XyN6q2wWsAb7C
         GVcrs2om7IiVGdRAKw+RiysWHakLRhG3ganlcgEWgROCU2hA1gXSG6QugdZqIHrwRvoC
         OmJJiL/5OTr7NH5UtxXB+zZbcSsX26V0mlnnKCaylLobfE37IUddw1HpxHW1YUm+hfes
         ho3d0rewAXHxBJxQbAXl3IxetrGE9UP5P3qDzMob4e4kh52p00zH5Yvm0VJ311DA7y/l
         /pEJfFo4U8Dh3KOfO3f3sOAU1Opvbwo93uOAENzeEJ+O3LI7Oen5OPsOK1R47Yx0GiSC
         I9Vg==
X-Gm-Message-State: APjAAAU0QsziDnACq9IayynBVhLIEoIvRHY6Z5GLk0VoYN7jKsxGhbt4
        FUGjA3HUDpA4ddYoOc05Yio=
X-Google-Smtp-Source: APXvYqxungzOwpELSZL1K0j4LdT0TT09X0cVw9RGT4oi/TvELjGrHEQelo+Nyoq/cdgCa8U9HixjWw==
X-Received: by 2002:a65:41cd:: with SMTP id b13mr17584367pgq.385.1575877372852;
        Sun, 08 Dec 2019 23:42:52 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id m127sm12134958pfm.167.2019.12.08.23.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 23:42:52 -0800 (PST)
Date:   Mon, 9 Dec 2019 16:42:50 +0900
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
Message-ID: <20191209074249.GC88619@google.com>
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
[..]
> +
> +#define _DATA_SIZE(sz_bits)		(1UL << (sz_bits))
> +#define _DESCS_COUNT(ct_bits)		(1U << (ct_bits))
> +#define DESC_SV_BITS			(sizeof(int) * 8)
> +#define DESC_COMMITTED_MASK		(1U << (DESC_SV_BITS - 1))

What does SV state for? State Value?

	-ss
