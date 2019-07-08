Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C829FC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2DB20861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="QsT3qIZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfGHI64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:58:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45595 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfGHI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:58:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so7238565pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 01:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HGL8gFLqqUGw26sgh16OPJKq0qs1x4eHHY+Blnf6EkY=;
        b=QsT3qIZhYbzOwPmMAQa3V8+8LFcV3DntFB73Fq82cmu/Yk22aVgYdNgjDUWhRI8Nyb
         KyaSvzV40pqdAXS7WpJjmPCYXzULabRrE7lV9cXawGHpPGkkhylXEEVR5yi8ymV/7cto
         92ItFqXD+bFbplXRUqd3R42zocSXK1Oige4r/1XqMyvVjLxMK1krSMfB60qTL/JAthw0
         X1VklavW/+okkJlvNDG3wTydrpVxHaOgumzbrBQ1STy3z8dGSh4Mp5JPYGZZjVKmEmfb
         r5tvj11qvuWB4wvoON7DEMenVgiUGcGH17wf20ousfB8hnc4D5fzQFkcRWAptFg/jWWV
         XMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HGL8gFLqqUGw26sgh16OPJKq0qs1x4eHHY+Blnf6EkY=;
        b=lntGncERPxH9dfnAzsuq6OyKEmA54lxtY9mGwJIXOQKZKm6lV+5NYhGW2Kk/p2RxTP
         aZC2ciVReY/5o6ccOhKdz6lDQ0GTI0bB20mZMYYZjCEXjDUchwTXnI272m2qSNW/8rc8
         ZGHMaWugWht7pPoQ7dJcc9KxIhTqx3KcZWNNm6YvLTzn6GuMpdz4DmJEQ8NatYchDd0m
         xYEQck51jGioQOvIngyV4XmbFQGI+ogE4YZ8wvTh3gIzz3Q1/ijkJ8CCwTcoLncJh/Jh
         WzWnHx1I9pW25cL3BAkXkVikCNhU9xC/9qQuzQc1yGv5wUnqphnhYFjeLyKpiRLhTwuX
         dMoA==
X-Gm-Message-State: APjAAAWM7BeKIbsrznPCaYaxEunsHJiLzGKA2gz06PHPqA2PaEoq2jsi
        NY1xtvZFga+j7UL4zurZhtfMVFxsmDs=
X-Google-Smtp-Source: APXvYqwI3ZeDSzPZYZ1iGB+3vJSHCo3wNgDN9uvKi4uaT4l0mRebpTmJLY6bijBGOWhjVYnJOUlUuQ==
X-Received: by 2002:a17:90b:8cd:: with SMTP id ds13mr22511988pjb.141.1562576334613;
        Mon, 08 Jul 2019 01:58:54 -0700 (PDT)
Received: from etsukata.local (fs76eecbcd.tkyc008.ap.nuro.jp. [118.238.203.205])
        by smtp.gmail.com with ESMTPSA id b16sm16679098pfo.54.2019.07.08.01.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 01:58:53 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>
References: <20190704195555.580363209@infradead.org>
 <20190704200050.534802824@infradead.org>
 <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
 <a4a50e28-d972-3cef-b668-1e49d5b5496f@etsukata.com>
 <20190708074823.GV3402@hirez.programming.kicks-ass.net>
From:   Eiichi Tsukata <devel@etsukata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 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
Message-ID: <48e29640-fedc-3e72-535c-27ef07b73938@etsukata.com>
Date:   Mon, 8 Jul 2019 17:58:49 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708074823.GV3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/07/08 16:48, Peter Zijlstra wrote:
...

> 
> Or are we going to put the CR2 save/restore on every single tracepoint?
> But then we also need it on the mcount/fentry stubs and we again have
> multiple places.
> 
> Whereas if we stick it in the entry path, like I proposed, we fix it in
> one location and we're done.
> 

Thanks to your detailed comments and the discussion, I've come to realize
that your solution "save CR2 early in the entry" is the simplest and reasonable.

By the way, is there possibility that the WARNING(#GP in execve(2)) which Steven
previously hit? : https://lore.kernel.org/lkml/20190321095502.47b51356@gandalf.local.home/

Even if there were, it will *Not* be the bug introduced by this patch series,
but the bug revealed by this series.

Thanks,

Eiichi
