Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B91C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E16A217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfDHPEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:04:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfDHPEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:04:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86BC530BB366;
        Mon,  8 Apr 2019 15:04:39 +0000 (UTC)
Received: from [10.43.17.46] (unknown [10.43.17.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D599C608CA;
        Mon,  8 Apr 2019 15:04:38 +0000 (UTC)
Subject: Re: CBL issue #431: lld: x86_64: sysfs: cannot create duplicate
 filename $module/.rodata.cst{16,32}
To:     sedat.dilek@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <CA+icZUVW2X6G=qukJTrZuUevcnrOiuShJGxnxVaqyONNxv+RYg@mail.gmail.com>
 <e5d3d2fc-874c-a8e3-1320-f9396a3621b5@redhat.com>
 <99dde862-6aee-65a0-8b39-33b8ac10df45@redhat.com>
 <CA+icZUUw3SgyCdk9fyv+mVUGDepDNGj8Bm7t0WWOE3Q0sHJs4Q@mail.gmail.com>
 <863a33cf-0a1a-17af-0ea8-42e288f8a1fd@redhat.com>
 <CA+icZUVvtLkNNor+9wQy1_bt=NfRAfJD9f_daqX2Da=EcdjAaA@mail.gmail.com>
 <5c5c169d-3bad-9e34-8c56-bedca3e5ae08@redhat.com>
 <CA+icZUUk8jhGqsu65A8oHFcqzrqNRon+riPff9aJu2UFLXL7wQ@mail.gmail.com>
 <CA+icZUVy0-F7==ES2ar+0LumE3LTv8jye8LAz=DHAoDZKiyC5A@mail.gmail.com>
From:   Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <ceec77ac-28e5-5d2f-3ea9-ef132a35acc5@redhat.com>
Date:   Mon, 8 Apr 2019 17:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CA+icZUVy0-F7==ES2ar+0LumE3LTv8jye8LAz=DHAoDZKiyC5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 08 Apr 2019 15:04:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 4:57 PM, Sedat Dilek wrote:
> We have arch/x86/crypto/chacha-avx2-x86_64.S and
> arch/x86/crypto/chacha-avx512vl-x86_64.S:
> 
> .rodata.cst32.CTR2BL
> .rodata.cst32.CTR4BL
> .rodata.cst32.CTR2BL
> .rodata.cst32.CTR4BL
> 
> ...and in arch/x86/crypto/sha256-avx2-asm.S and
> arch/x86/crypto/sha512-avx2-asm.S:
> 
> .rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK
> 
> Correct?

You mean, we have duplicate section names.

Well, this brings me to my initial response -
"Not sure how exactly this causes the error".

Duplicate section names are allowed by the linker.
There is nothing wrong with that.

The warnings you see come from some other tooling,
which does not handle correctly object files with more
than one section with the same name.

(Having unique names is still preferable,
it helps humans to more easily find where sections come from,
and for potential future --gc-sections optimization).
