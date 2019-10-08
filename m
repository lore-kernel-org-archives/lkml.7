Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E16C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137CB206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfJHQS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:18:57 -0400
Received: from foss.arm.com ([217.140.110.172]:40578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfJHQS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:18:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61D9B1570;
        Tue,  8 Oct 2019 09:18:56 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E2823F6C4;
        Tue,  8 Oct 2019 09:18:55 -0700 (PDT)
Subject: Re: [PATCH] arm64: lse: fix LSE atomics with LLVM's integrated
 assembler
To:     Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20191007201452.208067-1-samitolvanen@google.com>
 <CAKwvOdmaMaO-Gpv2x0CWG+CRUCNKbNWJij97Jr0LaRaZXjAiTA@mail.gmail.com>
 <CABCJKufxncBPOx6==57asbMF_On=g1sZAv+w6RnqHJFSwOSeTw@mail.gmail.com>
 <CAKwvOd=k5iE8L5xbxwYDF=hSftqUXDdpgKYBDBa35XOkAx3d0w@mail.gmail.com>
 <CABCJKucPcqSS=8dP-6hOwGpKUYxOk8Q_Av83O0A2A85JKznypQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c0f0eb7e-9e46-10cc-1277-b37fcd48d0be@arm.com>
Date:   Tue, 8 Oct 2019 17:18:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABCJKucPcqSS=8dP-6hOwGpKUYxOk8Q_Av83O0A2A85JKznypQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2019 16:22, Sami Tolvanen wrote:
> On Mon, Oct 7, 2019 at 2:46 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
>> I'm worried that one of these might lower to LSE atomics without
>> ALTERNATIVE guards by blanketing all C code with `-march=armv8-a+lse`.
> 
> True, that's a valid concern. I think adding the directive to each
> assembly block is the way forward then, assuming the maintainers are
> fine with that.

It's definitely a valid concern in principle, but in practice note that 
lse.h ends up included in ~99% of C files, so the extension is enabled 
more or less everywhere already.

(based on a quick hack involving '#pragma message' and grepping the 
build logs)

Robin.
