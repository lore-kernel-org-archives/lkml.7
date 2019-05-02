Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CE2C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2182080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEBUSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:18:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38913 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBUSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:18:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id a9so5108028wrp.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 13:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8dtYIKBa6buctD0tTGFWvmlTjX9/9amPjYT4Z55BFOE=;
        b=kejR7TZjaJMEhSzvxkWh/JT2EP2A7Y/qBLFZKVUexzEGaZFs5vcS9joLnU8tQl//A3
         Qg5Zh3/ecST/gvzTqqRGq+u236Emd900GhVo376mC2P8V27o1E7TIx/Qv8HP+ILuXJ14
         +UI3hvxEAkhq1PLmdMFfk7ySAdfjbdyQaYDzb9ToHVHHfpjo6Vjd4IbCWWF2e94BjKlp
         QMvPYA6Qc+xLdYLGBBjB6wmFUJFIqyMAPnf0jtRppn+dzWq4o2LjzVtfSbPDVLeM5mbV
         WAAQUZIern2tY/TYkCAQz+Z1MKZtVirBQCJ9Xol40W/4EiLs6EugEVH6IS8co9r3wwcl
         QrtA==
X-Gm-Message-State: APjAAAVUCrdYEyHxhuNnw9VTGsEq2dAQIjP8fqfjJ0n+dU1e0fc3P7w5
        9ha9ZAAtKJpvFLZnQbiN7JM9/A==
X-Google-Smtp-Source: APXvYqwUnyrsk81frd4IAC7jzT80lIDmo9jbihk5/ZMFhG9C3C1GIvCEeRzmzk1VDJAJTwrkIwlhyg==
X-Received: by 2002:a5d:624f:: with SMTP id m15mr3973819wrv.102.1556828295258;
        Thu, 02 May 2019 13:18:15 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host49-62-dynamic.23-79-r.retail.telecomitalia.it. [79.23.62.49])
        by smtp.gmail.com with ESMTPSA id y7sm325204wrg.45.2019.05.02.13.18.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 13:18:14 -0700 (PDT)
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
Message-ID: <8f853e27-995a-9ec8-89b7-1a57c3623f13@redhat.com>
Date:   Thu, 2 May 2019 22:18:12 +0200
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
> 
> Then we have static storage, no allocation, no fail paths.
> 
> Also note that I removed that whole in_progress thing, as that is
> completely redudant vs !!nr_entries.

Hi Peter,

I am finishing the next version, but now I am in a dilemma.

If I use:

static struct bp_patching_desc {
	int nr_entries;
	struct text_patch_loc vec[PAGE_SIZE / sizeof(struct text_patch_loc)];
} bp_patching;

The in_progress is still needed because nr_entries will increase while
queuing... and so we would enter in the int3 before we actually need.

It will also need a new function on alternative.c to queue each entry into the
vector and change the text_poke_bp_batch() to a text_poke_bp_apply() without
arguments, +- replicating the arch_jump_label_transform_queue() and
arch_jump_label_transform_apply().

[ and probably also take the text_mutex while queuing... and release in the apply ]

OR

I can declare a vector and a counter in arch/x86/jump_label.c, like this:

#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_patch_loc))
static struct text_patch_loc tp_vec[TP_VEC_MAX];
int tp_nr_entries = 0;

and use the arch_jump_label_transform_batch() as it is now, i.e:

void text_poke_bp_batch(struct text_patch_loc *tp, unsigned int nr_entries)

In this case, we do not need the in_progress because the
bp_patching_desc.nr_entries is filled only when in progress.

so, which path should I take?

Thanks
-- Daniel
