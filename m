Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15130ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A2D2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfJIMEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:04:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbfJIMEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:04:11 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEF9461D25
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 12:04:10 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id q9so951163wmj.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 05:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U/pCjY843ByXYTvQbCMMgFSjBYKbMQHf1dSGiJ7+gRI=;
        b=bVyAJaSLeVz6j1gVKHSAeZMFV7EuJnYGKu8yn3b0jAY0F4MXl7stoQUhewq5F7hWLq
         9RHc/zqWwyTzbwPP65Tpz1k5pZqD1JAFCwHTZQ8a4jvcw1QtudULs3FughG4BfIx30Ga
         YaQu/s62071YDXAlKZHEr9GplxmvtqAle06EN8Mrx7CHbM2EL4kUYY0asRb8N4BE7YS1
         bxffecmXtZksRcbvfppTLpDDHxDNv7X19m0D8Gc6i3aKCtes+0x1fdAeIJhM/sg6c6zd
         YqgKkIYPiOxUzZ5t8TxJja3JMOuil8an/1DMkSmRU8c9UZo3Klg32wFJG/2SGXM1reou
         sZYg==
X-Gm-Message-State: APjAAAUHkzJuD00gVPNXyqT3SlsxifftmAD4xmDDC6eFvWJfwmYj3+dv
        r2JEs2+OookM+pAn3orisWgPOJisfLG3hYwXJe0WGnRXn+9dITvEb8q2aiV0ZRmNC2q1Vtkbr1V
        Or41j1R9eE2TLi+oENOrFk0JI
X-Received: by 2002:a05:600c:387:: with SMTP id w7mr2427498wmd.138.1570622649063;
        Wed, 09 Oct 2019 05:04:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZ+oZcCKQibBoBmJfmef2PUZbTKxZ5aKJY8TZz1Ktec1n4cqQHSxUZzWOFx7d7yqIH3K/v8A==
X-Received: by 2002:a05:600c:387:: with SMTP id w7mr2427475wmd.138.1570622648821;
        Wed, 09 Oct 2019 05:04:08 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id e15sm1798781wrs.49.2019.10.09.05.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 05:04:08 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] x86/alternatives,jump_label: Provide better
 text_poke() batching interface
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
References: <20191007081716.07616230.8@infradead.org>
 <20191007081944.99652529.7@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <17803d78-3153-cc66-5807-ca27161bccef@redhat.com>
Date:   Wed, 9 Oct 2019 14:04:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191007081944.99652529.7@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2019 10:17, Peter Zijlstra wrote:
> Adding another text_poke_bp_batch() user made me realize the interface
> is all sorts of wrong. The text poke vector should be internal to the
> implementation.
> 
> This then results in a trivial interface:
> 
>   text_poke_queue()  - which has the 'normal' text_poke_bp() interface
>   text_poke_finish() - which takes no arguments and flushes any
>                        pending text_poke()s.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel
