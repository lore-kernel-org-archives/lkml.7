Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6199C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22F62087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfDOLd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:33:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36912 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:33:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so18631031qtn.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 04:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wyxXG08I749BVZKb6n+KIukzHoQH6bVLQs+c2la1Kt4=;
        b=npGq86pXCsw+bKnt/crpfOLEBkVuseI5B6XoCMqlzvjqWeRXmYHlKMv+QKenE9ENTU
         XVNC4aYpwW5sgAmL2pdsvZwAjcWYq5vAk6n/6IFILT/CQ2rgglhOW9q7rL1aLfZl0DVV
         UvGe1GbBH1GL/wb1JFq/KGhPSjXRLMhuJ7NIpqLu8+uRQLYOeita/hNbWT/rzuH6HpKZ
         ltVADgsgU68ltFC2IaMsjwXugcJn95rTEgXQrEHdIar57GBo9jUaXx7/sLk7tlnQXBwx
         qi6WJZmo0Cth7W5uhoeariuDFpNwJND8M06kp3U/ZNht3i9IwK/ju+KOG/Wm721vehUO
         dIiw==
X-Gm-Message-State: APjAAAW/vpO5okDcpD5heEk9SGHiDKSvuVeDdv7BBQTIaFu/wfocnLsT
        pofbYoJ/fLR0DdqYz2u/EB2i4w==
X-Google-Smtp-Source: APXvYqz0E+G9/vI3Lq1QgK3aHjV5v3wYOKa+dxh6IVd+Ohms+DT0iKZeJuLFD0Sdxoa8qi0lp83kRQ==
X-Received: by 2002:a0c:81a9:: with SMTP id 38mr58546761qvd.208.1555328036171;
        Mon, 15 Apr 2019 04:33:56 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host237-128-dynamic.51-79-r.retail.telecomitalia.it. [79.51.128.237])
        by smtp.gmail.com with ESMTPSA id s64sm27133050qkc.39.2019.04.15.04.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 04:33:55 -0700 (PDT)
Subject: Re: [PATCH V5 4/7] jump_label: Sort entries of the same key by the
 code
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
 <d89001dfd5429567a4c54ff6667986ecaed9900b.1554106794.git.bristot@redhat.com>
 <20190415105529.GJ11158@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <b6e3350b-8d27-bac6-f3b3-2d98638bada1@redhat.com>
Date:   Mon, 15 Apr 2019 13:33:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415105529.GJ11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 12:55 PM, Peter Zijlstra wrote:
> On Mon, Apr 01, 2019 at 10:58:16AM +0200, Daniel Bristot de Oliveira wrote:
>> In the batching mode, entries with the same key should also be sorted by the
>> code, enabling a bsearch() of a code/addr when updating a key.
> 
> Might be good to explain *why*.
> 
> We can see what the code does, explaining why we do things is what we
> have Changelogs for.

Ack! I will explain why,

>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>> Cc: Jiri Kosina <jkosina@suse.cz>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>> Cc: Chris von Recklinghausen <crecklin@redhat.com>
>> Cc: Jason Baron <jbaron@akamai.com>
>> Cc: Scott Wood <swood@redhat.com>
>> Cc: Marcelo Tosatti <mtosatti@redhat.com>
>> Cc: Clark Williams <williams@redhat.com>
>> Cc: x86@kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  kernel/jump_label.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
>> index e666a4d6642a..8b7bfbba4cef 100644
>> --- a/kernel/jump_label.c
>> +++ b/kernel/jump_label.c
>> @@ -36,12 +36,28 @@ static int jump_label_cmp(const void *a, const void *b)
>>  	const struct jump_entry *jea = a;
>>  	const struct jump_entry *jeb = b;
>>  
>> +	/*
>> +	 * Entrires are sorted by key.
>> +	 */

and this the typo above (just noticed),

>>  	if (jump_entry_key(jea) < jump_entry_key(jeb))
>>  		return -1;
>>  
>>  	if (jump_entry_key(jea) > jump_entry_key(jeb))
>>  		return 1;
>>  
>> +#ifdef HAVE_JUMP_LABEL_BATCH
>> +	/*
>> +	 * In the batching mode, entries should also be sorted by the code
>> +	 * inside the already sorted list of entries, enabling a bsearch in
>> +	 * the vector.
>> +	 */
>> +	if (jump_entry_code(jea) < jump_entry_code(jeb))
>> +		return -1;
>> +
>> +	if (jump_entry_code(jea) > jump_entry_code(jeb))
>> +		return 1;
>> +#endif
>> +
>>  	return 0;
>>  }
> 
> The secondary sort order doesn't hurt, so we could leave the #ifdef out,
> not sure.

and remove the #ifdef, unless someone else things we need to keep it.

-- Daniel
