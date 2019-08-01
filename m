Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C34C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80FE2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDskO53+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfHABW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 21:22:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39835 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfHABW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:22:57 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so140676106ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 18:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MnK27LorQx4kBNENrZZMBjXUFWjugtUM3KSU8CcHvaU=;
        b=fDskO53+M3eAyhvlp4uHkoXvYG2j5rGjCWKBixWadEWj02AjgaXDbqhwKioU+3qW2o
         2bn38sMgdHusHjS0wug7Do4N63tn+nhlFhSYlX/POqW3Zf7Y/emH3zX4BlWdbvCWv2UJ
         XrCMcEC9I6InRFlmfr9bpuRzylw6dSr+C5PHB5LmqU2gbuiOxobxqxFb8aYAHmadzSUH
         YFURzsQJARKU/tDUShvS8QrvG/svVNABlmtpQvxtZ7AXSuoaE0QxToVl4THX/1ijG4k9
         aFybKbzfHaIWBUGAtT4JrPkZDeMyDXjlV0kkb8WbHOx5q0CAGb8L84SJ49zhtNRboDIi
         wcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MnK27LorQx4kBNENrZZMBjXUFWjugtUM3KSU8CcHvaU=;
        b=KGY9EEBxYICHxa2+t6mIS7Y4XpkZMCESxCFP1stwECxZ8TIDfHyfrWgQODJmaLC3WL
         ESFERmCNqgmwL8/E5VfcUu0DIrGKNLF8X9L/GycJTEd6TVu3sPCTnCK05IYIHxCA15ly
         K5y2jp21etMOzfgfXQnIXYV4I/GqzGMwXiqnfFeBApLtYJBtlvsaM6pQiOk8uIUxy3ca
         gNS8OQ5HYR7Cw+FEuZswFXnHFdZ6DWfaBZCdlOZ8Cvusziwb9qIQ9BrFpQjFHMbsdi9N
         avZYgEyhtlJcnKACTbP1Q/AntxV+YijHyfBVe1rPwWfgs6uh1u3TU6InhhbQxicLzN5g
         X1+A==
X-Gm-Message-State: APjAAAUQ5pVH0QGDnEAJZNMI/V0P91GZ4Cy23GpWt9o/Ocm3OarYFri7
        271tnQrbzmrg6yjrns2FBuc=
X-Google-Smtp-Source: APXvYqxgA8cfMWHt5m21MTKQZo4cFmaoZ+a6a6qu3BsAS77xfK8WhcwaYGZTBIAt86TmiqOVh9XsUA==
X-Received: by 2002:a6b:2c96:: with SMTP id s144mr114369478ios.57.1564622576567;
        Wed, 31 Jul 2019 18:22:56 -0700 (PDT)
Received: from [192.168.0.8] (97-116-188-146.mpls.qwest.net. [97.116.188.146])
        by smtp.googlemail.com with ESMTPSA id h8sm63351518ioq.61.2019.07.31.18.22.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 18:22:56 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] futex: Implement mechanism to wait on any of
 several futexes
To:     Thomas Gleixner <tglx@linutronix.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Steven Noonan <steven@valvesoftware.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
References: <20190730220602.28781-1-krisman@collabora.com>
 <20190730220602.28781-2-krisman@collabora.com>
 <alpine.DEB.2.21.1908010039470.1788@nanos.tec.linutronix.de>
From:   Zebediah Figura <z.figura12@gmail.com>
Message-ID: <31ad0ada-ecc7-60b3-e204-898460254be3@gmail.com>
Date:   Wed, 31 Jul 2019 20:22:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908010039470.1788@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 7:45 PM, Thomas Gleixner wrote:
> If I assume a maximum of 65 futexes which got mentioned in one of the
> replies then this will allocate 7280 bytes alone for the futex_q array with
> a stock debian config which has no debug options enabled which would bloat
> the struct. Adding the futex_wait_block array into the same allocation
> becomes larger than 8K which already exceeds thelimit of SLUB kmem
> caches and forces the whole thing into the page allocator directly.
> 
> This sucks.
> 
> Also I'm confused about the 64 maximum resulting in 65 futexes comment in
> one of the mails.
> 
> Can you please explain what you are trying to do exatly on the user space
> side?

The extra futex comes from the fact that there are a couple of, as it 
were, out-of-band ways to wake up a thread on Windows. [Specifically, a 
thread can enter an "alertable" wait in which case it will be woken up 
by a request from another thread to execute an "asynchronous procedure 
call".] It's easiest for us to just add another futex to the list in 
that case.

I'd also point out, for whatever it's worth, that while 64 is a hard 
limit, real applications almost never go nearly that high. By far the 
most common number of primitives to select on is one. 
Performance-critical code never tends to wait on more than three. The 
most I've ever seen is twelve.

If you'd like to see the user-side source, most of the relevant code is 
at [1], in particular the functions __fsync_wait_objects() [line 712] 
and do_single_wait [line 655]. Please feel free to ask for further 
clarification.

[1] 
https://github.com/ValveSoftware/wine/blob/proton_4.11/dlls/ntdll/fsync.c



> 
> Thanks,
> 
> 	tglx
> 

