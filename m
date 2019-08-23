Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8252DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EEA204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlCSJVwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbfHWJts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:49:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34712 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbfHWJtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:49:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so5511425pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4pKJfLts+ii68aI+WC2XZXU7J3w8Upzj8e1MnFrdmK8=;
        b=VlCSJVwxNCkO9SjHAgCO85lM05XJjw9MAyN2ZHwcdAFbq29drolRzfkqvR5K9YOs7v
         djh8km3I9oCvdlwwSc210g0KpzYa+ZAp+mm9Bv9bQNzzO2w8NiKf1glGFBP7QDf1U/h+
         Mi3PXFA+9bsYQ4O3pt4wUuQFj2Xs/iw/dTWb0DzhuLVToDvk1Sa5ekxtbRcj3qEOhA9U
         oWhnS+mz3YhgHmQy8ga+K1P39hi7Yt3GooTZtMbauGNW5nW+Dod0CVLD+0GZPIpo80xJ
         3ZjTVwiag9dDBP3Jcqalso6C2qAeOEjBLb7uMox04HDLise2KQfEkFqeHMa4HEvWpxS1
         upUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4pKJfLts+ii68aI+WC2XZXU7J3w8Upzj8e1MnFrdmK8=;
        b=GmZ3JTqyxXmWaVRQSVLrldv5BrQ065DC88KVMy/R2jqE/T3uAR6QKDirrsc9LrhxQs
         4SKn1TWtE8nt8G+hpMA1KNlPOPFZPZbDgA0Mv1EmqTywnIk+3tcOqZCRVkYujpeobeug
         T7qr7suXTJIRf+HV3iBWSoa6qKK1f5X4VyOy6uRmS53IuIVREGJshaEq3Kv3hyHgLNcH
         sovS4lj/EA5doKrjYefMP+TA4N1Vs8Mqmn+DlfdrGrWTWfaUlzG5pF8YjUNj8y5aAGLP
         urUbUMxf4I0mg+GECe8YX1rFmt0aVO4WXoR8JQ5LD36mav0CQVIMj1NxV36br/luCVt7
         gbdA==
X-Gm-Message-State: APjAAAWx1opPtypTNPEMotfjnNGTYjp2rGF/Se/RjDdCVhWPsPlXk/r3
        xweKvU5HxkTsDxl8d+LavbI=
X-Google-Smtp-Source: APXvYqwmyRgsTR2bIVNhj65qQ9q0WLiJj3ErBAlEDENAyR78vnECqs6yufwWYgqaPVatxGWqgGnYTg==
X-Received: by 2002:a17:90a:fe5:: with SMTP id 92mr4328993pjz.35.1566553786972;
        Fri, 23 Aug 2019 02:49:46 -0700 (PDT)
Received: from localhost ([110.70.58.156])
        by smtp.gmail.com with ESMTPSA id j5sm2088113pfi.104.2019.08.23.02.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:49:46 -0700 (PDT)
Date:   Fri, 23 Aug 2019 18:49:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: comments style: Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190823094943.GA15662@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
 <20190820092731.GA14137@jagdpanzerIV>
 <87a7c3f4uj.fsf@linutronix.de>
 <20190822135052.dp4dvav6fy2ajzkx@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822135052.dp4dvav6fy2ajzkx@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/22/19 15:50), Petr Mladek wrote:
[..]
> I could understand that you spend a lot of time on creating the
> labels and that they are somehow useful for you.
>
> But I am not using them and I hope that I will not have to:
>
>   + Grepping takes a lot of time, especially over several files.

But without labels one still has to grep. A label at least points
to one exact location.

>   + Grepping is actually not enough. It is required to read
>     the following comment or code to realize what the label is for.
>
>   + Several barriers have multiple dependencies. Grepping one
>     label helps to check that one connection makes sense.
>     But it is hard to keep all relations in head to confirm
>     that they are complete and make sense overall.

Hmm. Labels don't add dependencies per se. Those tricky and hard to
follow dependencies will still be there, even if we'd remove
labels from comments. Labels just attempt to document them and
to show the intent.

The most important label, which should be added, is John's cell
phone number. So people can call/text him when something is not
working ;)

>   + There are about 50 labels in the code. "Entry Lifecycle"
>     section in dataring.c talks about 8 step. One would
>     expect that it would require 8 read and 8 write barriers.
> 
>     Even coordination of 16 barriers might be complicated to check.
>     Where 50 is just scary.
> 
>   + It seems to be a newly invented format and it is not documented.
>     I personally do not understand it completely, for example,
>     the meaning of "RELEASE from jA->cD->hA to jB".

I was under impression that this is the lingo used by LMM, but
can't find it in Documentation.

I agree, things can be improved and, may be, standardized.
It feels that tooling is a big part of the problem here.

	-ss
