Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88750C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B64D2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lmpx8dS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfF1Frk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:47:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43484 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfF1Frj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:47:39 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so9964914ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 22:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JonNVAGavnRlJhh68LVsFtVqprQdtcLj2PTjdYw2e9k=;
        b=lmpx8dS8SmmI+bod4CIGHygIhMfXqrGVR8dl/YJdRJFestIpTr/2lSxlvkarvtECIz
         jx6ZaHJ4aIqG/48rZvDj+pl6lnRoAg9OZ9mxYeLRu+N9SYpUGe3wfh4MU68CNNoASNHc
         CGNxA2syIdCf+HG0oxmfLEi5SFjUdX3hg9TniJxA+g7sQYNxfgMtpYyJie9GQC9bxwvC
         cReJnEEoKLA8nTHOoZ5SvxX9pXWN/Xc6nNnzVxLP0Q0BGFsjFwe1RkKw61gfOyGVyCmv
         qoJTVQu/+2v//+Sk7Cwc3qJ9hw8ZgudhaYDERLiqQNqOdyIAwuu6iSAeKjQ6bW/nLZQu
         bTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JonNVAGavnRlJhh68LVsFtVqprQdtcLj2PTjdYw2e9k=;
        b=YBY9kA8rJSU72AXWq7YRR47CMl1H51LDfIU8c4o5kT7YwSkWEtZkEsQJ19HHwlD6Cy
         G7D9fCAZ8VG77/YhE5+Ah/5RptCEhmSS8uV67rjIxWUl+mLncAINyIUHtXBQP5huNasO
         7JBdQulTgV+rFvUjm+hpOothBOJTn5+LRSGRAH8tDl8XxHb6LI8r7GtssvYWZ1W/akeb
         /gHSTat4+x4kQvQGsYSM8GOyHA5IQ2LN42EGiPMCk+xltoY4kzQgx6OgZHJXO9uN2tRm
         tlRjtgMsWjSF8xfl1gQ/i2gaD3cfL7HRuIKyP1TmnUnnOX/OYkcu7wywnDSVUUV+ERu+
         V81A==
X-Gm-Message-State: APjAAAUgSAkdJrA4zVi72nKvjl8sKS3YNnMsMBQW80lG3lE3aJspf9qV
        XC5RxOA8Jw8EmGZbMfaBFWHHIA==
X-Google-Smtp-Source: APXvYqxSBxEznv5crFBLQNZa0Y7NNPYl7akgvsmNh/b7ftqbAIdgqF6gL+AZSuyVieJq0WKR7ZDQsQ==
X-Received: by 2002:a5d:8195:: with SMTP id u21mr9407119ion.260.1561700858671;
        Thu, 27 Jun 2019 22:47:38 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id t4sm1064999ioj.26.2019.06.27.22.47.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 22:47:38 -0700 (PDT)
Date:   Thu, 27 Jun 2019 22:47:37 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>, Ingo Molnar <mingo@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Changbin Du <changbin.du@intel.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>, Gary Guo <gary@garyguo.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 1/3] x86: Move DEBUG_TLBFLUSH option.
In-Reply-To: <20190429212750.26165-2-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1906272236550.3867@viisi.sifive.com>
References: <20190429212750.26165-1-atish.patra@wdc.com> <20190429212750.26165-2-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019, Atish Patra wrote:

> CONFIG_DEBUG_TLBFLUSH was added in
> 
> 'commit 3df3212f9722 ("x86/tlb: add tlb_flushall_shift knob into debugfs")'
> to support tlb_flushall_shift knob. The knob was removed in
> 
> 'commit e9f4e0a9fe27 ("x86/mm: Rip out complicated, out-of-date, buggy
> TLB flushing")'.
> However, the debug option was never removed from Kconfig. It was reused
> in commit
> 
> '9824cf9753ec ("mm: vmstats: tlb flush counters")'
> but the commit text was never updated accordingly.
> 
> Update the Kconfig option description as per its current usage.
> 
> Take this opportunity to make this kconfig option a common option as it
> touches the common vmstat code. Introduce another arch specific config
> HAVE_ARCH_DEBUG_TLBFLUSH that can be selected to enable this config.

Looks like this one still needs to be merged or acked by one of the x86 
maintainers?


- Paul
