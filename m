Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1FEC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D1D21835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570447573;
	bh=zB9JmGG9Ht8GYQkmLB55BI0N2RbVznxjmcRQ/EqFiJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jkxMM4rwpqIDOk9pfLcyGfKewCRHfnHagx/ilzChqdBl8cay+sVbxoylJ/KEiyFhB
	 RjV8nZpmgi7/X/qUJrHv/w+5PmnB11hflWHrWRKFUiKgK0dLWEW+rqKVgIwS7eMSJB
	 ni13PndfDmm8SI7TNqB6P+cjY5TrXmQeDbLUd6pY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfJGL0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:26:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35681 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfJGL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:26:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so14843655wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H4mBwNwKo3Hw5GQf27SGsDBu1e3aMiLQBDWHw2yh2jA=;
        b=WAyG+kEphCADric44Plx+oHVjOnKviZ5O+s0eQzuS0rdVHtJ9/0b0Qv+2C/b7+CQYF
         CuQiTOv3mpmcagfqjoAtJUup/kmLxImbumWjcGelMFiuSSeiTv7WGEu9W9ZZ7l55cw6f
         kF1ZfKxrDVIHBPBUPMFAX2sWR4O0QEU5Y/ZgSnmgPYT5BynRzEbs8mQ2Rnx9K4zPPert
         Pqd1rogyAmTLd4Hede2AsFAyXO7Qjwf3XBYOxW9Dr2aZI0ZXdd9Sjt5bqIlMI0dtJ5i3
         l2Jem8a03C25ibKPhWbtwN+DNxmwwZ+nntYwznidyMlg/ePX4xC+jyJl47hghsAhja13
         VDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H4mBwNwKo3Hw5GQf27SGsDBu1e3aMiLQBDWHw2yh2jA=;
        b=AyZCpMTe13D78wER0u88ByfxoXumzYpgz7qo7wef4wYCw27b2QNrOEkDKY9gf+9N4P
         iWNqPVu88nFiMiqkf7/D6OGNssYuEUjxYwGzWyvQ0rk7vg9JdLFhGTM3lDRBvcmw0EDK
         FvR1fOFtHkgiM/0wD0prhJUfgV0mHvXhqPQHBg7yy08/A/q5Tw1QPg8TcegPLo7C8fZF
         j93zQfqtfshTiOgzjALLHoBn3U3W+BiOlRSLXLc2fXztoHp3F1QkA0y4Xv4sC6fyWOny
         0gswIX4yYTT9E80+wIILfF2Jwz75sVxbhbBbNIqmY+1o4maCs4nHX0hw4jUHStaOOe/V
         25sQ==
X-Gm-Message-State: APjAAAX39PFXKqciqeB8C4XtR5jAbLBCGshkYco2G+2730Wv+9P7QjNM
        5Mrbz9LwK3ntecMWZJrmJKc=
X-Google-Smtp-Source: APXvYqxAYBBqhUdrgro6AdU92AfqkjpBXjKvaQM+Qh6MuTkPlCOPieeZwhROTxKbHgVFl5k102y4eQ==
X-Received: by 2002:a5d:670c:: with SMTP id o12mr10688264wru.103.1570447569312;
        Mon, 07 Oct 2019 04:26:09 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j26sm22560441wrd.2.2019.10.07.04.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 04:26:08 -0700 (PDT)
Date:   Mon, 7 Oct 2019 13:26:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        hjl.tools@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [RFC][PATCH 0/9] Variable size jump_label support
Message-ID: <20191007112606.GA44864@gmail.com>
References: <20191007090225.441087116@infradead.org>
 <20191007084443.793701281@infradead.org>
 <20191007112229.GA3221@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007112229.GA3221@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Sorry, fixed the Cc:lkml line. ]

* Peter Zijlstra <peterz@infradead.org> wrote:

> These here patches are something I've been poking at for a while, 
> enabling jump_label to use 2 byte jumps/nops.
> 
> It _almost_ works :-/
> 
> That is, you can build some kernels with it (x86_64-defconfig for 
> example works just fine).
> 
> The problem comes when GCC generates a branch into another section, 
> mostly .text.unlikely. At that point GAS just gives up and throws a fit 
> (more details in the last patch).
> 
> Aside from anyone coming up with a really clever GAS trick, I don't see 
> how we can do this other than:

>  - use 'jmp' and get objtool to rewrite the text. Steven has earlier proposed
>    something like that (using recordmcount) and Linus hated that.

As long as GCC+GAS correctly generates a 2-byte or 5-byte JMP depending 
on the target distance, the objtool solution should work fine, shouldn't 
it?

I can see the recordmcount solution sucking, it would depend on early 
kernel patchery. But build time patchery is something we already depend 
on, so assuming some objtool catastrophy it's a more robust solution, 
isn't it?

Thanks,

	Ingo
