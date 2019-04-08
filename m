Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3402EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E1521841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDHN4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:56:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfDHN4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:56:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF72344F9F;
        Mon,  8 Apr 2019 13:56:10 +0000 (UTC)
Received: from [10.43.17.46] (unknown [10.43.17.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6DAF64292;
        Mon,  8 Apr 2019 13:56:09 +0000 (UTC)
Subject: Re: CBL issue #431: lld: x86_64: sysfs: cannot create duplicate
 filename $module/.rodata.cst{16,32}
To:     sedat.dilek@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <CA+icZUVW2X6G=qukJTrZuUevcnrOiuShJGxnxVaqyONNxv+RYg@mail.gmail.com>
From:   Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <e5d3d2fc-874c-a8e3-1320-f9396a3621b5@redhat.com>
Date:   Mon, 8 Apr 2019 15:56:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CA+icZUVW2X6G=qukJTrZuUevcnrOiuShJGxnxVaqyONNxv+RYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 08 Apr 2019 13:56:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 3:36 PM, Sedat Dilek wrote:
> I fell over your commit "crypto: x86 - make constants readonly, allow
> linker to merge them" [1] while digging into ClangBuiltLinux issue 431
> [0].
> 
> I see the following in my dmesg-log:
> 
> $ grep sysfs: dmesg_5.0.4-rc1-1-amd64-cbl-asmgoto.txt
> [Fri Mar 22 10:32:09 2019] sysfs: cannot create duplicate filename
> '/module/usbcore/sections/.rodata.cst16'
> [Fri Mar 22 10:32:18 2019] sysfs: cannot create duplicate filename
> '/module/nfsd/sections/.rodata.cst32'
> [Fri Mar 22 10:32:18 2019] sysfs: cannot create duplicate filename
> '/module/iwlwifi/sections/.rodata.cst16'
> [Fri Mar 22 10:32:18 2019] sysfs: cannot create duplicate filename
> '/module/i915/sections/.rodata.cst32'
> [Fri Mar 22 10:32:18 2019] sysfs: cannot create duplicate filename
> '/module/mac80211/sections/.rodata.cst32'
> [Fri Mar 22 10:32:18 2019] sysfs: cannot create duplicate filename
> '/module/iwlmvm/sections/.rodata.cst16'
> [Fri Mar 22 10:32:20 2019] sysfs: cannot create duplicate filename
> '/module/bluetooth/sections/.rodata.cst16'
> 
> Above modules have dependencies to stuff from arch/x86/crypto (see below P.S.).

Not sure how exactly this causes the error, but the cause seems to be
having more than one section with the same name. This occurs in only three files
(grep for ".rodata.cst16," string):

cast6-avx-x86_64-asm_64.S
camellia-aesni-avx2-asm_64.S
camellia-aesni-avx-asm_64.S

/* NB: section is mergeable, all elements must be aligned 16-byte blocks */
.section        .rodata.cst16, "aM", @progbits, 16

In other places I used .rodata.cst16.OBJECTNAME, but in these three cases
there are more than one object in the section, so I left it w/o OBJECTNAME.

I propose to change section name, append _module_ name and optionally
a comment why this is done:

  /* NB: section is mergeable, all elements must be aligned 16-byte blocks */
+/* There is more than one object in this section, let's use module name
+   as unique suffix */
-.section        .rodata.cst16, "aM", @progbits, 16
+.section        .rodata.cst16.cast6-avx-x86_64-asm_64, "aM", @progbits, 16


> Looks like LLD defaults to -ffunction-sections and -fdata-sections.
> Do you happen to know what the defaults are for BFD linker?

linker does not create section names. Compiler does for .c files,
for .S files they are made by a human.
