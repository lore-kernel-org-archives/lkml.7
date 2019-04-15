Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D78C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F4A218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfDOMPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:15:18 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33738 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfDOMPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:15:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id k189so9660582qkc.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7unhlftixqJkBJ/xoqxwthgcxUvr22VS2Hsdja3tIGo=;
        b=tcdwMQrprWb2nnso54DuNhvy3PtEccPagi4RE4GsNZR23x+4YWXPSmX/Mbz4Ka7i4o
         N22BNAWKyfYQwobsmg5bN8HPsduEs0b1I49AoWYskR8m8pZbBh1xYKHoYTXuvVwCeZ3t
         GHRjd27gV0Dvub4CxlQZy+nErfctFbRCoaDMn/pc4EvAICum79bDccu6ThvYnv3tua74
         za7OAc4+frQ8EoC+wMTC1kNDZLTRwpntyqXVmDg63U0O8tegF48rDZcFgclcN4Ybu4kB
         HbVXroB2BVjYyVg3HLmaFYjpyRJbTgYTbkHJ3mXdIWHyOEdCJ6avrN13z7akn3CW4SoO
         CXtQ==
X-Gm-Message-State: APjAAAU2dJSBPerD3DDxppYa3zFdi+80elrVAW+0QlLvOpSsl3ZngKt4
        7uX6gLahJ+EQeKRuHdS4ZbuojA==
X-Google-Smtp-Source: APXvYqzAKeHud5K2uh6vYJdS1SKBKtPQdZNPJct8AwIBQlHkNGzTJDKRP1DfepXOzTVYuAG+zqFOhA==
X-Received: by 2002:ae9:c314:: with SMTP id n20mr56272144qkg.191.1555330516030;
        Mon, 15 Apr 2019 05:15:16 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host237-128-dynamic.51-79-r.retail.telecomitalia.it. [79.51.128.237])
        by smtp.gmail.com with ESMTPSA id x5sm24424750qki.26.2019.04.15.05.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 05:15:15 -0700 (PDT)
Subject: Re: [PATCH V5 7/7] x86/jump_label: Batch jump label updates
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <cover.1554106794.git.bristot@redhat.com>
 <725010896650bc040743b0479b103f5f6d28b404.1554106794.git.bristot@redhat.com>
 <20190415115458.GM11158@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <e3ff2665-cf0a-a172-9484-f609adecbf25@redhat.com>
Date:   Mon, 15 Apr 2019 14:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415115458.GM11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 1:54 PM, Peter Zijlstra wrote:
> So how about we do something like:
> 
> +static struct bp_patching_desc {
> +       int nr_entries;
> +       struct text_patch_loc vec[PAGE_SIZE / sizeof(struct text_patch_loc)];
> +} bp_patching;
> 
> and call it a day?

Sure!

Actually, I used something like that in my first poc patches (for my own), but I
thought people would complain...

If nobody else complains, I will use it in the next version.

-- Daniel
