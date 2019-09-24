Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C4BC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D33207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdVTQLgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407733AbfIXB2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 21:28:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34554 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391730AbfIXB2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:28:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so143806pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 18:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dAEzx7fT/0S8T6OwYYfD593mWT+cjAFFU5hLQ2lomU0=;
        b=XdVTQLgkx65yGyZWW1UNLpT1ol9jqft5ELDACaQFZAMQZpDGySxY59Nwkl4n3vLvtA
         b6xYv3DHnS7ihrCzDsxdpj4xhEmPZds7qJnssR/COxSPfrK2N/gT5jv6ZWHCn7rCJ2mD
         JgaxEPEvIwWVhlUiwL0cWB4gwEGRt2T8cuFtziqUcOtCppi7vC6LXsfnNaDi/pNGFuqS
         CO0x8lsMHzGNsaWM+k3mCShf7OGWgoBf1a2rMRGrDGyc5pj4N9SMovAYICmOUEsdOsiS
         TDyDaXGSSkMIGft2lXhWF0y2ON1YS5AMyLykrx4pyDM+lgrikCGsgeLLu+SVFLHcSB7M
         epNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dAEzx7fT/0S8T6OwYYfD593mWT+cjAFFU5hLQ2lomU0=;
        b=l7tX4pHxLz/MmGwPUaSiSraDj5LqeHKUFf1l7e/Ab2eB7PW3XpebBYd2mmepYYGnsl
         vKQ19v7lLzPBBkqFK0nuUg5IdnRoCsv+KSMz4TuSdi72PSGgDLr9MRbr5ooFdQCLvlhU
         gHvIok9ybxCtPhPUz13ZM2V1k/DgaJTF0J9m7hE724Mr8wRhMMsScmvvhwHnmEnM1fO6
         sSzKBOlgKGwAH38NBZTrUVOCHCFJcji/w1sYFjXv2v3CabD/oz6nFkXHgqmAM54+rOvB
         3S1zF1sO7p2+A/oiBLaCkHM6EHi5SvEJSJwqdhkRi0AvGg3g8j1qXQKul/q+57FymRQs
         M3GQ==
X-Gm-Message-State: APjAAAUKPaLQ/QxS+02l+sHBE3b0KViv3fbOlHF1yxLkLsZmv0zrUxQW
        2uKjBlfFmPG1miz+ApjriZ0=
X-Google-Smtp-Source: APXvYqwhEWYZe65h6MvxMjQ45DCNMriaqT2Rx0Bc9L8bicYBJ0gNLFDXBbmJbGa+Xzo4GOFJ/4mZXw==
X-Received: by 2002:a63:1f23:: with SMTP id f35mr462440pgf.298.1569288518651;
        Mon, 23 Sep 2019 18:28:38 -0700 (PDT)
Received: from localhost ([110.70.15.91])
        by smtp.gmail.com with ESMTPSA id f188sm26664pfa.170.2019.09.23.18.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 18:28:37 -0700 (PDT)
Date:   Tue, 24 Sep 2019 10:28:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Qian Cai <cai@lca.pw>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Will Deacon <will@kernel.org>, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Theodore Ts'o <tytso@mit.edu>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: printk() + memory offline deadlock (WAS Re: page_alloc.shuffle=1
 + CONFIG_PROVE_LOCKING=y = arm64 hang)
Message-ID: <20190924012834.GC3864@jagdpanzerIV>
References: <1567717680.5576.104.camel@lca.pw>
 <1568128954.5576.129.camel@lca.pw>
 <20190911011008.GA4420@jagdpanzerIV>
 <1568289941.5576.140.camel@lca.pw>
 <20190916104239.124fc2e5@gandalf.local.home>
 <1568817579.5576.172.camel@lca.pw>
 <20190918155059.GA158834@tigerII.localdomain>
 <1568823006.5576.178.camel@lca.pw>
 <20190923102100.GA1171@jagdpanzerIV>
 <20190923125851.cykw55jpqwlerjrz@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923125851.cykw55jpqwlerjrz@pathway.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/23/19 14:58), Petr Mladek wrote:
> 
> If I understand it correctly then this is the re-appearing problem.
> The only systematic solution with the current approach is to
> take port->lock in printk_safe/printk_deferred context.

It probably is.
We have a number of reverse paths. TTY invokes MM under port->lock,
UART invokes TTY under port->lock, MM invokes UART under zone->lock,
UART invokes sched under port->lock, shced invokes UART, UART invokes
UART under port->lock (!), and so on.

> But this is a massive change that almost nobody wants. Instead,
> we want the changes that were discussed on Plumbers.
>
> Now, the question is what to do with existing kernels. There were
> several lockdep reports. And I am a bit lost. Did anyone seen
> real deadlocks or just the lockdep reports?

I think so. Qian Cai mentioned "a hang" in one of his reports
(was it unseeded random()?). I'll send a formal patch maybe,
since there were no objections.

> To be clear. I would feel more comfortable when there are no
> deadlocks. But I also do not want to invest too much time
> into old kernels. All these problems were there for ages.
> We could finally see them because lockdep was enabled in printk()
> thanks to printk_safe.

True.
Everyone was so much happier when printk() used to do

       lockdep_off();
       call_console_drivers();
       lockdep_on();

Now we can have lockdep and RCU checks enabled, yet somehow
printk_safe is still "a terrible thing" :)

	-ss
