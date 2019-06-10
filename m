Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9856DC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B68E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390938AbfFJOn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:43:57 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42211 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389075AbfFJOn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:43:56 -0400
Received: by mail-vs1-f68.google.com with SMTP id 190so1863612vsf.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 07:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rzTYIiPqSMbaB247OwcvP22Dn5ctSBRMkQLSP6g63TE=;
        b=SJtb1wy/Row31R2fyWz4/64ltn+79CBmUH7O6fyuyrazBXix902JVnY0wC2fE5+uhj
         xmhwNoTKbAFrvXxiZaIT6CDwjRa+f6I5l1cMXoAGg98mcrE0cE0WJyo8g2HlFKUumMJX
         IrEVY9XvYTYn9Ad8XxtKQIxs66yDfDufMEcWz3aJ+O/+4FA2jNkTr65pquWjU+MfOui9
         uSgWEr4Z/jG84+vNScbEMZIYOUoY5U0Eo2CZm0hBFKlHYGtggUWfAse68Jv0aXVlb+gS
         r3pewzPhqZsFdxi72A8MTRQHj3RkYlAtcz0L4DymsxFqTyvbLT+IrPageUclHlbOKY6q
         En/A==
X-Gm-Message-State: APjAAAW+9g3R/ZMU7X/a+7IQqXUEHFBldryyM/+/0jxf8MpKn8pMBN8B
        LTyFfIL8uCGyUyk0fgSwZZ7q6w==
X-Google-Smtp-Source: APXvYqzj3JGOnWo66BHBaY1lDSf86H5ulmKxbipFqXHDa+gBq4fz7JnKtO1dzGP3noNi8L0rfXRlQw==
X-Received: by 2002:a67:ed04:: with SMTP id l4mr17840852vsp.179.1560177835906;
        Mon, 10 Jun 2019 07:43:55 -0700 (PDT)
Received: from [192.168.8.101] ([67.69.69.230])
        by smtp.gmail.com with ESMTPSA id a123sm3187094vka.22.2019.06.10.07.43.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 07:43:54 -0700 (PDT)
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and
 thread creation (v10)
To:     Florian Weimer <fweimer@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
 <140718133.18261.1559144710554.JavaMail.zimbra@efficios.com>
 <2022553041.20966.1559249801435.JavaMail.zimbra@efficios.com>
 <875zprm4jo.fsf@oldenburg2.str.redhat.com>
 <732661684.21584.1559314109886.JavaMail.zimbra@efficios.com>
 <87muj2k4ov.fsf@oldenburg2.str.redhat.com>
 <1528929896.22217.1559326257155.JavaMail.zimbra@efficios.com>
 <87o93d4lqb.fsf@oldenburg2.str.redhat.com>
 <117220011.27079.1559663870037.JavaMail.zimbra@efficios.com>
 <87wohzorj0.fsf@oldenburg2.str.redhat.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <c16c9785-7f8c-430b-a4df-a53e47bf1600@redhat.com>
Date:   Mon, 10 Jun 2019 10:43:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87wohzorj0.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/19 7:57 AM, Florian Weimer wrote:
> Let me ask the key question again: Does it matter if code observes the
> rseq area first without kernel support, and then with kernel support?
> If we don't expect any problems immediately, we do not need to worry
> much about the constructor ordering right now.  I expect that over time,
> fixing this properly will become easier.

I just wanted to chime in and say that splitting this into:

* Ownership (__rseq_handled)

* Initialization (__rseq_abi)

Makes sense to me.

I agree we need an answer to this question of ownership but not yet
initialized, to owned and initialized.

I like the idea of having __rseq_handled in ld.so.

-- 
Cheers,
Carlos.
