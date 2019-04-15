Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0B6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1816F20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDOL3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:29:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37384 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDOL3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:29:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id z16so18618310qtn.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 04:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=usFrDqzhJnWBwYWLae/DxekonZqcAJXyrvqPuXgUwu4=;
        b=TxBgWGJxvkd8bv3/RoRfoqUGwS/IsfG1/O/VzR8ftVsFTKUhcaqMe9NII6GQairP6E
         5fnE1nf+UnVvo2yVdPdWx5xE3bXR7+ONTh+iakMAJOvMfTsu0W25e157poCJzqKFG7p+
         1V6Ze4sG7haeQ6/0IawP8DyqyWLqVrBsJxp0LhTw+H4yuZJSzO4XN+ZeP098FNjj50tl
         THUvzT54CHmX6Dgie7JV1MttrYGM0ZFdYLhsci0fd4mqZVtDelKtvMD7gxUaxB2RCVcc
         /nL6LV7WL6ZEz1bwIj2F/WkvztwMOnJDP2PwEqCyn+ql62JJNDZevcJS7mDtk+/c668W
         GTWA==
X-Gm-Message-State: APjAAAUeko75m5yDJTds1FmwobdcA8n0y2TnwmvdvSUl2rJ89ENJifip
        nOGGYeQFoemd8DB20XLUg0FYMw==
X-Google-Smtp-Source: APXvYqwxIPuNeshtT1KQ1ifdHszzgBJXeQtGbZ+o9CCKHX1iEsLxPNbrWxq9RCyuDBn2n5B2QvuEAg==
X-Received: by 2002:ac8:3782:: with SMTP id d2mr58250889qtc.170.1555327780506;
        Mon, 15 Apr 2019 04:29:40 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host237-128-dynamic.51-79-r.retail.telecomitalia.it. [79.51.128.237])
        by smtp.gmail.com with ESMTPSA id w9sm24917340qkf.94.2019.04.15.04.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 04:29:39 -0700 (PDT)
Subject: Re: [PATCH V5 1/7] jump_label: Add for_each_label_entry helper
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
 <708f1d88826965ef5735c372cc9a17bb80613856.1554106794.git.bristot@redhat.com>
 <20190415105159.GI11158@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <c7243145-03cc-d7c6-4d0f-f25ec1fe3834@redhat.com>
Date:   Mon, 15 Apr 2019 13:29:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415105159.GI11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 12:51 PM, Peter Zijlstra wrote:
>> +#define for_each_label_entry(key, entry, stop)				  \
>> +	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++)
>> +
> I don't really like this naming; most (all?) for_each_*() loops start
> iteration and have the iteration variable as first argument.
> 
> This should maybe be called:
> 
> 	for_each_jump_entry_by_key_cont(entry, stop, key)
> 
> and I realize that is a horrible name too.

Borislav did not like this helper too, so I am convinced: we do not need it. I
will remove it in the next version.

-- Daniel
