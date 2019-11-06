Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F401C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114142178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="blk99mJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbfKFQBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:01:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35350 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfKFQBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:01:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id q22so9819637pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 08:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qJxDuXPZ8UpIcZ8oIYsXCJePMzRQNpnyqe+e0E6zGHM=;
        b=blk99mJsoZk20GxoK2V46+jO/Oqw9jYi6crtDZrI+ZxeXiTlD3tuMCd0Z8VVzDJMpw
         nN+cheIlNECTN7dPlDZKdLFbekuYTE3psnY+5OGStsOBNTAuRkxADLRkSG6N2XtXoD6C
         dfTMLNtwC5oS0f8FgbO9o4ZSWaiwVbX47Tcn23ZfPuDPjE2loe5UqjZgC50t0nDGDPrg
         DfpDcS8uCMwV7C+XhJ3nIQF751Pj0UeKhO23vnokeUcnttBJ+Lr9olwv69waKyH7cwTX
         I8WT6bhvdusExIB3qdO1lGNvxRiiwQO37BGdSabglpCATEJ79yuu9D2Ky6pRxz1BqKkD
         eaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qJxDuXPZ8UpIcZ8oIYsXCJePMzRQNpnyqe+e0E6zGHM=;
        b=HJFCCWK6MkCgQ0O89VOBe7FrrzBRyj5fcuaSscPqOjFN+c6zGhgfhtvonqSlO/3FZ7
         48nSBPyUXaBF7Kv8JqyikCfj2le678mJswY8HQXK/eSx77q8f85idCj5hsvFGuIc/a5W
         FD0MDnExyt8FSh6/xvdLj1phrGIQ/P4r/lgCl0Z+y6s/vWeZy+uA63jlB+K2d4wFJVDU
         6u7o24Y4fqK97ql4HgUHyzcOSxvaXp+d5kMIzhVcKYL2G9YbtHvJGXNOXONKkluuUfss
         IHfGjqQsNnIWLfA6yXhKhdNt/YZbPk0y/MrYHzG/7G50dG0/2vK+GVyRip5D93TyPIs6
         P7lQ==
X-Gm-Message-State: APjAAAWOc31mXCTFgmLZDK1aKTlYMZgzGspSenBIuOIcLor9+vM0BvnX
        p8QXjbTYH3VxJMlxEbPHiENVfA==
X-Google-Smtp-Source: APXvYqzjpa0BHhN80FIOsJE2uFKOZ6uxAYrLjZJ/pohyDNSVgNBiFgRZuXwWekeFORCsVtX74ohm8Q==
X-Received: by 2002:a17:90a:c56:: with SMTP id u22mr4702905pje.24.1573056081542;
        Wed, 06 Nov 2019 08:01:21 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m13sm21928545pga.70.2019.11.06.08.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 08:01:20 -0800 (PST)
Subject: Re: [PATCH 26/50] powerpc: Add show_stack_loglvl()
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20191106030542.868541-1-dima@arista.com>
 <20191106030542.868541-27-dima@arista.com>
 <8736f172mj.fsf@mpe.ellerman.id.au>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <85528fea-48e3-627b-d497-dc58ed408f87@arista.com>
Date:   Wed, 6 Nov 2019 16:01:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8736f172mj.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 9:52 AM, Michael Ellerman wrote:
> Dmitry Safonov <dima@arista.com> writes:
>> Currently, the log-level of show_stack() depends on a platform
>> realization. It creates situations where the headers are printed with
>> lower log level or higher than the stacktrace (depending on
>> a platform or user).
> 
> Yes, I've had bug reports where the stacktrace is missing, which is
> annoying. Thanks for trying to fix the problem.
> 
>> Furthermore, it forces the logic decision from user to an architecture
>> side. In result, some users as sysrq/kdb/etc are doing tricks with
>> temporary rising console_loglevel while printing their messages.
>> And in result it not only may print unwanted messages from other CPUs,
>> but also omit printing at all in the unlucky case where the printk()
>> was deferred.
>>
>> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
>> an easier approach than introducing more printk buffers.
>> Also, it will consolidate printings with headers.
>>
>> Introduce show_stack_loglvl(), that eventually will substitute
>> show_stack().
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  arch/powerpc/kernel/process.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> This looks good to me.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks for the review and time!

-- 
          Dmitry
