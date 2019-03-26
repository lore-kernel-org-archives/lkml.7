Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA08C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF8320823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f2wela59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbfCZCWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:22:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39869 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbfCZCWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:22:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so7347977pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 19:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=I8HR9DuBJhNaxmVVRl5EY43j4mASUSOtl5OE+nBW5Ds=;
        b=f2wela59lVLTnNvfKSfNFeUBfgRQQWHnhhkbAGaIxmhgl5NQValU4Wcx8YgeTYELii
         0FXxNpAeJPkZ+u7OLIOFCx+Fuuy0dnNyTDZFcS6guQZpSf3W8rm9wXEdNoXOk6/oUk98
         czgED0J56oKIWvGGebkeHHun5vjze+tz3OjqAuZ0kkKOL9l5DsD158mug1+pugVabE8S
         /OI5bwa3moncNfg/eGF8ofTAo/PEKSp/FWv1R10eAnakKq1QdiJxfed76lFAwYJ2YK+/
         Wd61JoizghCuDlPRsZ5FRwqvBAJgwKv1392BkqF1QWhwhoR3M1iNpNSjfCGVoerj5QBZ
         s8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=I8HR9DuBJhNaxmVVRl5EY43j4mASUSOtl5OE+nBW5Ds=;
        b=t+G9Qf9T8okbnaPAjpfr2BFAYAOGHe0bdhcFdpWBxrBwCVbQpZaWp8jaIK1d4+Rxfg
         P5lGk95ESe5sPJhAnMKsj4dWs+vYTYTSmp9yOc09FLx0rzX8OhK+PB28ToFjXbqU7+Lp
         iPyhP2J/l6rQMI8ptIX8MWk1dEFUgYBKfuK6m8h/vpE95Ra6WJ7YGoRdKtnd0u/tHLbf
         QDAaxjzPbeWmCr6yl8a0ZDWUxBFUTsUUyMdmR7YbIahi+M1fGr9QdZFDUusPV8Gbk0Qm
         isxrtQUpwcKYcjdkzPfmAIapnQb+cpEWX/igJz+EyrrEOlJjsiJm9rcl/ziqrQb72KhZ
         MpsA==
X-Gm-Message-State: APjAAAX5L+47FQRGjPEYH7MQ0Z7YQ0AhXUc/dYMbjyrh2kTmULTthNyH
        W6u4t2czxrM0qrFX52OzsHE4Romg6heru0Nq
X-Google-Smtp-Source: APXvYqxMrnzvIodlWKnYIZ52mKHuMsjndPnaMV0Ag7lvje5+8e0ztu4qEOA2Wmx2SSs4JrywXk++vQ==
X-Received: by 2002:a62:4d45:: with SMTP id a66mr1350207pfb.250.1553566951637;
        Mon, 25 Mar 2019 19:22:31 -0700 (PDT)
Received: from localhost (2001-b011-7001-1270-b809-36ef-31ed-7980.dynamic-ip6.hinet.net. [2001:b011:7001:1270:b809:36ef:31ed:7980])
        by smtp.gmail.com with ESMTPSA id d69sm14379354pfg.26.2019.03.25.19.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 19:22:30 -0700 (PDT)
Date:   Mon, 25 Mar 2019 19:22:30 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 19:21:32 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: Always compile mm/init.c with cmodel=medany
In-Reply-To: <CAAhSdy2-CX729tVuuZzArswpFEC_OeRXhwXtCaiNe53AuzqdTw@mail.gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>, alankao@andestech.com,
        Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-8e00a3e3-5a69-4828-b7bb-2bf000199b48@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 00:01:45 PDT (-0700), anup@brainfault.org wrote:
> On Mon, Mar 25, 2019 at 12:18 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Mon, Mar 25, 2019 at 01:25:50PM +0800, Alan Kao wrote:
>> > Hi Anup,
>> >
>> > Sorry for being late to the party.  I think one more thing should
>> > move together with setup_vm():
>>
>> Ah, I wonded about that yesterday but wasn't sure.  Maybe notrace
>> is a little cleaner?  Either way we should probably document both
>> the mcmodel and notrace assumptions in source comments for the next
>> person touching this code.
>
> The setup_vm() should be allowed to call other functions within mm/init.c
> so let's go with file-level notrace (just like how it was done) for
> kernel/setup.c
>
> I certainly add comments for setup_vm() based on all our findings so far.

Sorry for being slow here, but this is the right approach: setup_vm is called
before relocate, which means the page tables won't be set up correctly for
absolute addressing.  We instead build setup_vm with medany, which causes all
addressing to be PC-relative.  This is all a bit of a hack, but it's the only
way we have to do this right now.

You should be able to add a preprocessor #error to check the code model with 
something like this

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b379a75ac6a6..d6fde6af8d75 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -172,6 +172,9 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
        }
 }

+#ifndef __riscv_cmodel_medany
+#error "setup_vm() is called from head.S before relocate and must not make any absolute references."
+#endif
 asmlinkage void __init setup_vm(void)
 {
        extern char _start;

Marking this notrace is the right thing to do, as it can't call into any 
functions that aren't medany (there's probably other issues as well, since this 
is so early).

Sorry I missed this the first time around, I wasn't paying enough attention.

Can someone add instructions for 32-bit boots to the QEMU wiki?  It sounds like 
it's time to add that to the testing list...

Thanks for digging in to this!

>
> Regards,
> Anup
