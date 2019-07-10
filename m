Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634A7C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BCF20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfGJSgp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:36:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36683 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfGJSgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:36:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so1652873plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 11:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A8Qs53e8oL8Rit9Ihe8NcNOpmThh1DKFAspTMJKydW0=;
        b=mYLzaaYbAWrDMQQ3ZnHI7uD5LPxxBroLPEubf2g5M7C1bPK/FjbuJgRoJXVrxU2ipA
         O01mBdDRJ1wN3Y7H0WyQcGt9TDinPPv4d+gs0ezouLdb6wOywtIa7AzqoO8QTzuqWOif
         k+8YWRFVLgZpU2WcaVO+ZC1qRIYl9yNWyEixc9QSx1Y5vdZLX8qESVAlWAQt3/epsDlb
         TrYNDL9Ac7MrTRMtz6kmeAAmcovor741Yrm4QgPrr7IB9q0fdA9xQa6L0xUzVWXMqytN
         LonPqgSRbHVdhucuedvXrRQ94RpWh8sdyQjuzGwROGcooCi2zGX9HrmhdbnxXNWMemQ0
         Godw==
X-Gm-Message-State: APjAAAXuPgpOk5p7S0Argb6d1byuOT4NDCSulY5C7WM/uIY0b1FET1P1
        8YNqZhCIgHN4NKdPftMgTvG4pzQV
X-Google-Smtp-Source: APXvYqw+rVs6cOCxom0649D34DZC/c0A50KHyFAbjBCsjrTXj5njyXdTZWSdMsPCSOFN30O1RgIujQ==
X-Received: by 2002:a17:902:e383:: with SMTP id ch3mr40236752plb.23.1562783803956;
        Wed, 10 Jul 2019 11:36:43 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id q144sm2925710pfc.103.2019.07.10.11.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 11:36:43 -0700 (PDT)
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <00000000000089a718058556e1d8@google.com>
 <f71aaffa-ecf4-1def-fe50-91f37c677537@acm.org>
 <20190710053030.GB2152@sol.localdomain>
 <b378a903-d0fc-a137-e6b9-dec55277cf16@acm.org>
 <20190710170057.GB801@sol.localdomain> <20190710172123.GC801@sol.localdomain>
 <f498d8cc-ba82-d3dc-7557-142a1b35976a@acm.org>
 <20190710180242.GA193819@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a19779d0-0192-8dc0-d51b-e6938a455f31@acm.org>
Date:   Wed, 10 Jul 2019 11:36:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710180242.GA193819@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/19 11:02 AM, Eric Biggers wrote:
> I already mentioned that io_uring triggers it too.
> 
> Those are just 2 cases that syzbot happened to generate reproducers for.  I
> expect there are many others too, since many places in the kernel allocate
> workqueues.  AFAICS most are placed in static or global variables which avoids
> this issue, but there are still many cases where a workqueue is owned by some
> dynamic structure that can have a much shorter lifetime.
> 
> You can also check the other syzbot reports that look similar
> (https://lore.kernel.org/lkml/20190710055838.GC2152@sol.localdomain/).
> Two of them have C reproducers too.

As you may know lockdep cannot use dynamic memory allocation because
doing so would introduce a circular dependency between lockdep and the
memory allocator. Hence the fixed size arrays in the lockdep code.
Additionally, as far as I know lockdep works fine for human kernel
developers and only syzbot runs code that triggers the lockdep limits.
So I think it's up to the syzbot authors to come up with a solution. I
mean another solution than finger pointing at kernel developers.

Bart.


