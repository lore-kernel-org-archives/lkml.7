Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B48C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E62218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Om/tjs+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfDYMUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:20:20 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50251 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYMUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:20:20 -0400
Received: by mail-it1-f195.google.com with SMTP id q14so12038583itk.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Ff5AtzwwT3/+/+DhAf7emgB+G9uyqnQ39QFzfiHlnCY=;
        b=Om/tjs+cIisp8QHDq6CzrUaiOLSXRjROsCaIOMcfRT7mExJkBP94D6lLaZqgBjmK7E
         IhxDMxIDh6ZRbqEyX+oeKocEyjgq0RWG29jCZumjVsCAVAXZmywYbn8qZHxE9DhMM3Q7
         fC1vizrABzM9jaOPzrsHF9sfKzMnciSxuLttMK5ICCOzSw+9+mhdDFphZxs9Kbmvhu6N
         TtmlT4ceZoENTs/l/PFUspaub2hvQijbD14amJ0ZUDUxSKdhU2LZjV78hiJHAhlwPqKP
         oHiUMJIna1eVjx/uNAdb9JzIrhaX9BexQ+YAQR6sEGBjxhOtpiNgU2kAWR9Sat6WPilD
         sfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Ff5AtzwwT3/+/+DhAf7emgB+G9uyqnQ39QFzfiHlnCY=;
        b=Z5qmjRMTaupWjCVfQ9McKUoBOTfIWzObB/F4vJ0sMtBl3BfSCAuFSd2/SzHuxC1Xdo
         tTfkekhZeNPmtb2TOq8+qIo5n7sEG57gxLC/JxZkOsNF9rI0wUJF5jgqBUnIi5ETY2wQ
         Im9h5Dst33f1PWHMTQdYnAkmJUWnPMeAuNkJ/Cbhl1RvxTQTSHzbAfkoMA2jxpiJJPIp
         JRmJMEyIw3edpXYBIXtdYc6vbzmUa0FVJxaIVUns1l8KEsFTLFunYO6D17bXNcncudO/
         ET8Oo7T+h9iFwoKjfBboLPpe//wTg4ORJNwpEV3jif+III4Z2ibjFss+r1zCR2lXCLFa
         k8HQ==
X-Gm-Message-State: APjAAAUaEs+seQKTXUy+ku2BtMdETznQpWNF2IoKCdfcir0Z9JeF2l5B
        Vv2PuXSmb2UVw47FuAKoRhaK61JLpKYYeWwn+dz7NlpgqwE=
X-Google-Smtp-Source: APXvYqzvwgFEFTx/KOu9/KRtMQB8bZPew2d9yQi0ISoduzu75d/y4B7m7oOTvlB/BIjiqYUpckQCHfBQ76huRI/Tbss=
X-Received: by 2002:a24:7350:: with SMTP id y77mr3050214itb.52.1556194819534;
 Thu, 25 Apr 2019 05:20:19 -0700 (PDT)
MIME-Version: 1.0
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 25 Apr 2019 14:20:08 +0200
Message-ID: <CAFULd4ZDbg5jFkLzRnEgnVgRwRJa+OG2EvGYUEFQ0RASux2qqg@mail.gmail.com>
Subject: Re: x86: Use named address spaces in asm/percpu.h
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> * Ingo Molnar <mingo@kernel.org> wrote:
>
>> Not all GCC versions seem to like this series:
>>
>>  In file included from arch/x86/mm/tlb.c:12:0:
>>  arch/x86/mm/tlb.c: In function =E2=80=98switch_mm_irqs_off=E2=80=99:
>>  ./arch/x86/include/asm/mmu_context.h:210:28: internal compiler error: S=
egmentation fault
>>   #define switch_mm_irqs_off switch_mm_irqs_off
>>  arch/x86/mm/tlb.c:183:6: note: in expansion of macro =E2=80=98switch_mm=
_irqs_off=E2=80=99
>>   void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next=
,
>>  Please submit a full bug report,
>>  with preprocessed source if appropriate.
>>  See <file:///usr/share/doc/gcc-7/README.Bugs> for instructions.
>>
>> gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)
>
> That's with a 32-bit kernel, config attached.

I am resurrecting an old thread at [1] that tried to introduce named
address spaces in asm/percpu.h. The thread ended with the above
message [2], but no bugreport was ever filled to GCC's bugzilla. Can
please someone from linux  community file a PR with a failing testcase
to GCC Bugzilla, so we (the GCC community) can analyze the problem and
eventually fix the compiler?

[1] https://lkml.org/lkml/2018/9/12/646
[2] https://lkml.org/lkml/2018/9/12/1052
[3] https://gcc.gnu.org/bugs/

Thanks,
Uros.
