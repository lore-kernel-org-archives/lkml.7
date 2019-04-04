Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B93BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D48206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHWYozrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfDDNdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:33:32 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:42853 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDNdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:33:32 -0400
Received: by mail-lj1-f177.google.com with SMTP id v22so2093349lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ElSO3JilSrfvBpkYt7Xj0vpQkyxBUWJQkAMjQGNyec=;
        b=CHWYozrF9IRqOrTqfnTnQYzVZYbl1py9ORPjBudktMS1Y9AaMORPwrF1l5xvHbMah2
         nhN6uwQeoi8/9OmN8pYeL/AaFe8KQYhJiemQgesoJVME6t5JFe5ZTYg+41AzwZvtRoj8
         JcgdyCBAVIMTPLC0Rk7Xfoionlleu1T1KnZZjWL6FA/n4rleoz+nZcIzey4U/ZsIq/k2
         c1QOwunGj4Tg87vzIDIU+5Tj3CoZNpWjtNIgm7xLvFqQdOQ4bDrUA3N7C5P6rljHcN2G
         dzUYNB/u+Ufyv+22O7qOMEZxLG+y2DkMyhDnaQT/9omw1fO/DzIowByScHeTuLoAB89p
         rRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ElSO3JilSrfvBpkYt7Xj0vpQkyxBUWJQkAMjQGNyec=;
        b=pKT16tV7ZpmRaNGASMwkfdaiNUZyTFDPVQCnYjfLUc+48OSpBKmIRQdjkHXmpqghxT
         Ceht96Jy6LvFTYbiOMX/NqnOqhRSHVjf11PlpEwvrZdLrKtJ3vhEqMJ8gWSGqK3TEXOZ
         PddsMZKWdf+U496tG6eI334mqUqqpBhR7U4fKMcECD59BqmQJPdBIcZ4uiAkDUzTxa3R
         w30ZkUxiF4Ww8V5duZkJOpm4ugURaUO26BSSc/ioLuCQMgsEPqwJ0jHV6tLBWta5YY2F
         I80tsfVYLakkGHYhdgOc8+HYEYs51+7xxdftgp3dnXRJVqp5AwCZe7jjGYmtU+oTs+HO
         Edhw==
X-Gm-Message-State: APjAAAV67WB5k22eQjFJ/So9jBLQcwFRjlg4xjC46BtKFy4xXzBt+q61
        DP41WmvK5Afx3G8l5EDBPJD4BiEo
X-Google-Smtp-Source: APXvYqxy6WwFn3GV945cGGEvPdcKZhpcsUO3hoUaliFErAtYuGblWl8luc1eQ+SP1wPjsAm+7JA6TA==
X-Received: by 2002:a2e:9a91:: with SMTP id p17mr3428781lji.127.1554384810285;
        Thu, 04 Apr 2019 06:33:30 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id m1sm3645571lfb.78.2019.04.04.06.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 06:33:29 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 57272460438; Thu,  4 Apr 2019 16:33:27 +0300 (MSK)
Date:   Thu, 4 Apr 2019 16:33:27 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: perf: perf_fuzzer crashes on Pentium 4 systems
Message-ID: <20190404133327.GP1421@uranus.lan>
References: <alpine.DEB.2.21.1904031043170.29188@macbook-air>
 <20190403191944.GH1421@uranus.lan>
 <20190403203144.GI1421@uranus.lan>
 <alpine.DEB.2.21.1904040922350.3758@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904040922350.3758@macbook-air>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 09:25:47AM -0400, Vince Weaver wrote:
> 
> It looks like there are at least two bugs here, one that's a full 
> hardlockup with nothing on serial console.  The other is the NULL 
> dereference.
> 

Seems so. I've spent plenty of time yesterday trying to figure out how
we even reach the case when event = nil but without much luck.

> Just ran with your patch applied and it hit the hard lockup case.
> 
> I'll have to see if things are reproducible and I can try to see if I can 
> get a reproducible value for what even caused the issue.  perf_fuzzer has 
> some infrastructure for determining that but it's hit or miss if you can 
> get anything useful from it.

At least the sequence of events migh give us some ideas, maybe not indeed.
Thanks a huge, Vince!

> I'll keep running things, but I'm a bit busy at work here the next few 
> days so there might be some delay in the results.

Sure, take your time. I think this problem with p4 is not urgent. I'll ping
you if I get some more ideas.
