Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8568CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647DF215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440296AbfFLQdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:33:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43484 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404956AbfFLQdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:33:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so7526313wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CdX+EnBkfilwXkkk167DXZL1DwpMRr9aFTRy+EUa67k=;
        b=Qt6TfYpXK5/MoHdVgDBL0fkuhdEF9H/kzpRTIkaRjaZ0cNAYg5qsmJta05Br3TzuLH
         7B3A3nnESnK+bpbhoHcDz4aJDMyUhck5kdZG6aS1gsgQ3rMRt3SJFBnW2i/4OJFKN415
         r+qMAbjxhX8RU4AW1hklCWJRzakW7OVGoZ4jpkQJY4L3e+YIAscZaNbP/8L+db84Z9ad
         6dU14qo56WNpPwooNTTyxp/CDezMZPDeLUkCPFdwlfBCw7jxXFBLrae95ra8KLzWgDPl
         8E2LQy1XTTD3I4BdWw7DOVFW5IF2QzkJBEqfkrz3X59S9v3ayo8Tm9W7NdOAOFC4ptpv
         CDDQ==
X-Gm-Message-State: APjAAAUc6P+9JrqfiQ3XyTDh7IKXqMA7uL6lkEmKaw/U+R330oh6zK1+
        Ynhzb/K6O3dpW3y93uHMrH0r6g==
X-Google-Smtp-Source: APXvYqyAqzYboAEq45sdUeKRT+Z9fcGGC6MjDwMqFVaZcoBykSuhMJvkh4ceS+p1ni9FtYfZx71J4Q==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr19258006wrv.61.1560357187999;
        Wed, 12 Jun 2019 09:33:07 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host204-55-dynamic.171-212-r.retail.telecomitalia.it. [212.171.55.204])
        by smtp.gmail.com with ESMTPSA id l4sm156804wmh.18.2019.06.12.09.33.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:33:07 -0700 (PDT)
Subject: Re: [PATCH V6 4/6] x86/alternative: Batch of patch operations
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
References: <cover.1560325897.git.bristot@redhat.com>
 <ca506ed52584c80f64de23f6f55ca288e5d079de.1560325897.git.bristot@redhat.com>
 <20190612145213.GK3436@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <ef734312-0b5f-1ceb-9a51-eb49f9e43e3c@redhat.com>
Date:   Wed, 12 Jun 2019 18:33:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612145213.GK3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2019 16:52, Peter Zijlstra wrote:
> On Wed, Jun 12, 2019 at 11:57:29AM +0200, Daniel Bristot de Oliveira wrote:
> 
>> When a static key has more than one entry, these steps are called once for
>> each entry. The number of IPIs then is linear with regard to the number 'n' of
>> entries of a key: O(n*3), which is O(n).
> 
>> Doing the update in this way, the number of IPI becomes O(3) with regard
>> to the number of keys, which is O(1).
> 
> That's not quite true, what you're doing is n/X, which, in the end, is
> still O(n).
> 
> It just so happens your X is 128, and so any n smaller than that ends up
> being 1.
> 

Correct! In the v1, when I was using a (dynamic) linked list of keys, it was
O(1), now it is O(n).

Using an academic hat of easy assumptions, I could argue that:

"Doing the update in this way, the number of IPI becomes O(3) with regard to the
number of keys*, which is O(1).

* Given that the number of elements in the vector is larger than or equals to
the numbers of entries of a given key, O(n) otherwise."

Life is so easy when we can do such assumptions, like infinity memory :-)

So, yeah, with a fixed size vector, it is O(n) in the worst case, but still
"O(1)" in the vast majority of cases.

-- Daniel
