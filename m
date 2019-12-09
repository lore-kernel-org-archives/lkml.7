Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99776C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0912073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzxUWqrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLIIob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:44:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33248 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfLIIob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:44:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so6768695pgk.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 00:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F/iTXjUirb3qLXL3k7S0xJDWbiKE/py2Dc0msDcOD6Y=;
        b=tzxUWqrby/P+AZfMC57Z7Z3WGfEKwBN4zb4cxo+43y65FaZR07nWWw7tB2ox3/a0oX
         tvTsBm5gpegKACO7vkrWFY85oEFqQkGqjg+rs63vq6WMY2XRRzuJCPWVFaxbjhru+BKM
         UNIrZYzmiLqflF2dWDCwgQnRxj8AsCHdA2TToT36GcgHYjghLiFGV9wchGqmldICR/Lc
         zsvcsBiq/P0/Pj3hfDlXDUMiN0iT1dRgwm2AU8utoQiLU9hCMe3LdiQsni8dA1f0trdX
         hl/0106L1n5mY0mEdEgHJfUWxT+3155gC2FEdjO+8fcfWZey+tiF1HXPAhNZCiIdJTq8
         DMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F/iTXjUirb3qLXL3k7S0xJDWbiKE/py2Dc0msDcOD6Y=;
        b=oStt2pLwoNMF4wUorQ5juGkvTWm4WL+VwulhQYgxSX7xzIKEnPNvtd9w6EeXezzuPZ
         CHiqm47Hm6ehyq3vZ4sXtoJnNlK3Pjsf0ixGB782ESPX/EMhG0kmp9uM/65KujVTlxDX
         25fe3rngtCWkiUnPDenKLQxXW/gS9Fd6W2jUhf8D9opEvls9FnOXiTdzItLV4Oz3ChaP
         QIQOlAKkWTuKv/UNlIrusktbIJMcIf74qaSyOv4bfXYPGZb/c39Nd5oBfeST/+WPAgKg
         9ekP76JNZ7b7la/zoUSACfcvnurzozKFX4J2jeBpwnUr09TeHPP7qsgBxDvh5sXbp7JA
         WE8g==
X-Gm-Message-State: APjAAAWuufCfvGvHcVbIoPyobHB5mYgOjtvD4y59xkMtLHeOoG3zXK1/
        VFSoxGwMNQEQLEWZCnB3OZA=
X-Google-Smtp-Source: APXvYqybX7+sdIIzEOFW9y+rSHNuLGLq4Y2jO1WfkZU+jQSjyqrUnujtXjswtut0UxiAOS7rIR71EQ==
X-Received: by 2002:aa7:989d:: with SMTP id r29mr28989561pfl.142.1575881070580;
        Mon, 09 Dec 2019 00:44:30 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id o17sm3406988pjq.1.2019.12.09.00.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 00:44:29 -0800 (PST)
Date:   Mon, 9 Dec 2019 17:44:27 +0900
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
Subject: Re: [RFC PATCH v5 3/3] printk-rb: add test module
Message-ID: <20191209084427.GE88619@google.com>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128015235.12940-4-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/11/28 02:58), John Ogness wrote:
> + * This is a test module that starts "num_online_cpus()" writer threads
> + * that each write data of varying length. They do this as fast as
> + * they can.

Can we also add some IRQ (hard or soft) writers and (if possible) some NMI
writers?

	-ss
