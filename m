Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4919C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D272217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NlCUU5PO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfDDX3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:29:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40798 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbfDDX3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 19:29:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so1942643plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=nNTAkkSsesyNF1L4wisBciP/ffK/Ou780QIlgqZ7C+I=;
        b=NlCUU5POvdSDVM2ZUfmhXzSe8nwyHxfj3wmUbZuFZrmik1KALP438cig7tYr2imNuj
         fkbo39GuuYQkJFk0maPEgW0F9Xrud2GIKuqRTq+fUn53DN+B1MusFx7iPyGmCFteSvcU
         4+/hyrmaz7hAQbfMRAlLJqrzcDb31K/nbB0qnFMKY+/1F2k4nWNqJJIuLP/Wm3D1NaC0
         8dplYsRrrPkU3uKURX3cbb0ygf2N55l5ZZ4xMhH2ksaIib7IrS26RM3UGVBmvWmcEgB4
         CdUq6dTx93i+yVnoVQrJljIUjEwR63Fk6wmMBrrBqKkIJl2QJDtc1i6P8M3/TBADuV2g
         +aNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=nNTAkkSsesyNF1L4wisBciP/ffK/Ou780QIlgqZ7C+I=;
        b=D5QgsqqxhSkDuP0pZjf0wvQelxHDA7hEhaK2n3sTkiZPWsuFX22VzC4IL/NJRU69dD
         W3pSiDTQZbh+5AFOj16e2O0S9qChNlNwm76VBXrrcrSi9em53o0I53fTfaUoVDpQzca4
         PAAfW8a0tkRazmjRzk/xUQLD501MV6YdhEA9POX/oybKjaxYkNNdtgPC56v46ryazE+h
         VoEwAX0ZoylIBtXSmSIJTu5dh9ynK+RPOo5ZHNPppbg4mU3YzE0oIPaldzLOSHXuvIST
         MZOgHiMwbb+yQbEXbzEFSbmOgX3EKRVYIjhe46qXY+3DctoO8jF5JOWetXSuB1HQl3RL
         bq7w==
X-Gm-Message-State: APjAAAUnzLOUWtM1qxkniN54TW/NaUCI2uNrWU1yzmydd5ie986Svw9t
        X+0fZwXJKSwdLN7Jni5+laTo8A==
X-Google-Smtp-Source: APXvYqyT886hiDdS9f9N1ElR0YHL1O+XWROWt1J/VpvcSZn88aex51BUH6YO4f9IFbNnWC2h08TDZg==
X-Received: by 2002:a17:902:47c2:: with SMTP id d2mr9263608plh.277.1554420583757;
        Thu, 04 Apr 2019 16:29:43 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f6sm16304527pgq.11.2019.04.04.16.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 16:29:42 -0700 (PDT)
Date:   Thu, 04 Apr 2019 16:29:42 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Apr 2019 16:23:28 PDT (-0700)
Subject:     Re: [PATCH 3/6 v3] riscv: Fix syscall_get_arguments() and syscall_set_arguments()
In-Reply-To: <20190404102653.705456df@gandalf.local.home>
CC:     ldv@altlinux.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mingo@kernel.org, akpm@linux-foundation.org, luto@amacapital.net,
        roland@hack.frob.com, oleg@redhat.com, linux-arch@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, gustavo@embeddedor.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux@dominikbrodowski.net, luto@kernel.org, keescook@chromium.org,
        ebiederm@xmission.com, wad@chromium.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     rostedt@goodmis.org
Message-ID: <mhng-a348d416-3a9d-458e-be83-d7a584f590aa@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Apr 2019 07:26:53 PDT (-0700), rostedt@goodmis.org wrote:
> On Thu, 4 Apr 2019 17:02:10 +0300
> "Dmitry V. Levin" <ldv@altlinux.org> wrote:
>
>> On Mon, Apr 01, 2019 at 09:41:07AM -0400, Steven Rostedt wrote:
>> > From: "Dmitry V. Levin" <ldv@altlinux.org>
>> >
>> > RISC-V syscall arguments are located in orig_a0,a1..a5 fields
>> > of struct pt_regs.
>> >
>> > Due to an off-by-one bug and a bug in pointer arithmetic
>> > syscall_get_arguments() was reading s3..s7 fields instead of a1..a5.
>> > Likewise, syscall_set_arguments() was writing s3..s7 fields
>> > instead of a1..a5.
>> >
>> > Link: http://lkml.kernel.org/r/20190329171221.GA32456@altlinux.org
>> >
>> > Fixes: e2c0cdfba7f69 ("RISC-V: User-facing API")
>> > Cc: Ingo Molnar <mingo@redhat.com>
>> > Cc: Kees Cook <keescook@chromium.org>
>> > Cc: Andy Lutomirski <luto@amacapital.net>
>> > Cc: Will Drewry <wad@chromium.org>
>> > Cc: Palmer Dabbelt <palmer@sifive.com>
>> > Cc: Albert Ou <aou@eecs.berkeley.edu>
>> > Cc: linux-riscv@lists.infradead.org
>> > Cc: stable@vger.kernel.org # v4.15+
>> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>
>> According to
>> https://lore.kernel.org/lkml/mhng-8e9b547b-7fe3-43d2-9dea-b217de923605@palmer-si-x1c4/
>> the following tag could be added to this patch:
>>
>> Acked-by: Palmer Dabbelt <palmer@sifive.com>
>
> That link isn't actually an ack. Palmer, you OK if I add it?

Acked-by: Palmer Dabbelt <palmer@sifive.com> (for the RISC-V parts)

Thanks!
