Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1D9C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061DF20663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbfDQOmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:42:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45148 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:42:04 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so1524771iom.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDYvFmdHCEUniLd5QA51M6EpL/xNYNtgFWJ3bzHoUHg=;
        b=IqsWM4NWS3E0mRO27mSE8n074F6n54yf8a+eLehSX/2KJBi0natoNccE+UgkjF/HU/
         CdUi7K6K44gD7PMm2NtqBKDdSZhPwYSxVIfHr8JBbCJ2Gp53ZE4r+wuch5ty2NtQXwfW
         0Kk1UXQs3yPmwCvkj3vJ3DK/f2A139jqRsGCJ7q+TfRBOxeGFHq5nV2MoleE/HSFRiDc
         IBwIpfWt9LMdQaQ8mEpUCWszQ/1i7Bt+WRAfQcXRwDCvpw3GrFAqcHHF5nlXU8VzH5Gv
         JzczURnuySDLRySthI9C+QFLXCmRvuPlS9ANpIgltD88QEGTjzDiUCG12uWXA0ntdnxP
         Q9QQ==
X-Gm-Message-State: APjAAAW0xUZHI8jHZ/2jTANBFahZbSOTcUqT2Is46gttVFgfxHtrnEN8
        SWQGY11atrNurqwvZOQJ9stDJp+zGCDbK5xIVuua6w==
X-Google-Smtp-Source: APXvYqzl+CFpGFse89HMRWaGDEuy2Q/EHR+Jt7G5TYpuMb03koyX5q0FwAtabQDeda9ubBwhT2jdwk8gh6kz/9oeiCg=
X-Received: by 2002:a5d:8757:: with SMTP id k23mr7328589iol.68.1555512123473;
 Wed, 17 Apr 2019 07:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190408165942.23640-1-kasong@redhat.com> <20190415153622.GG12232@hirez.programming.kicks-ass.net>
 <20190415165859.ul7i2w3lai3umgik@treble> <CACPcB9f8OJmk++54YwW3yhrnohj31+oJcxfesJbNbNSGk9WUQQ@mail.gmail.com>
 <CACPcB9f0D4SdJLAtUs4vYwduBiPYDpa-y8r7jracYy=sAJmo5g@mail.gmail.com> <20190416174528.GT4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190416174528.GT4038@hirez.programming.kicks-ass.net>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 17 Apr 2019 22:41:52 +0800
Message-ID: <CACPcB9eXWcvFvx6RpRLXc-jKTuejYx4ZiYMPj-Da3fESB=tYng@mail.gmail.com>
Subject: Re: [RFC PATCH v2] perf/x86: make perf callchain work without CONFIG_FRAME_POINTER
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 1:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 17, 2019 at 01:39:19AM +0800, Kairui Song wrote:
> > And I also think the "fake"/"real" reg is fragile, could we abuse
> > another eflag (just like PERF_EFLAGS_EXACT) to indicate the regs are
> > partially dumped fake registers?
>
> Sure, the SDM seems to suggest bits 1,3,5,15 are 'available'. We've
> already used 3 and 5, and I think we can use !X86_EFLAGS_FIXED to
> indicate a fake regs set. Any real regs set will always have that set.

Thanks! This is a good idea. Will update accordingly in V3 later.





--
Best Regards,
Kairui Song
