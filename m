Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D36C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C6720675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwDZjIv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfCEGhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 01:37:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41665 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfCEGha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 01:37:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id z25so6559430ljk.8;
        Mon, 04 Mar 2019 22:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4yrRR7J7zqt10xqHI8cyZI+wDW4RxTttxjdnNGZntk=;
        b=JwDZjIv02Du31UY5W404iavqNbGEVrgqpjtPLlYGBaIAcfH7on9LD7VgvqqbV4fTJe
         bOZCzCCIV/EC2PgaPksFnpGhM0aaEXku2gxEqu99MCYCY/Fhz3LT9O0VH0xSSrzT7WBm
         6Ygj29wQdLphOPhmfOu2Gg/Sou/BmbE8w4qVu660Ds413duso5BLixGrjKjiHcldzFqh
         YDZ7C1OtS0m1OVmq1vzf1ctla2gXxDnpepS+zNOrZ2rpQLoof/l73sw02Xzn88f4Um54
         bJCFUfgdHKBL4lrPoHPo0x9WHLDWZv34EAV/NDJozg8Q/So2k7Ywz31YfgWAVdw1TsuH
         6Z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4yrRR7J7zqt10xqHI8cyZI+wDW4RxTttxjdnNGZntk=;
        b=GLEvafIWaPOEV8DbGFv2uTVLd2817UScX2VKIOmVFOj2FTc7peJL3UKnbb7eyBrIue
         j2mUFDjmwZB2YBBRx6uovXQldXLqxMwM2MimMT59ILl/P887BqEOmjWksDz+A15IKedd
         HDRfjzAKJLRd8bqqW5soVPErIsmKzyYEoKy9T4IzGh3Ns2kmmDarZwlKkJJqQ5eX6yDB
         00FzCsdGKu3E923P7Wary1SPyTykdg0WHdzlD2HLSSuDaelpusVAnGUGxYBjky0v1zg7
         YveIwhmlwxhK4srFQu3J7yr7fqpARm0/mjUfPmYsTsehh5kELOi0bVocDhNyPuae2h5G
         KtMg==
X-Gm-Message-State: APjAAAVNurtcgymdK1O7o68RX/0fVMcEPMOeE2i4HJnQaY6tblzkREn9
        zUoM0YlOyRrHPl5c0cK1Y5toqovJ41g4vUfdmr0=
X-Google-Smtp-Source: APXvYqz6TmoZO2MrPOA+ubm4pGfBMrGRQIRqABIa3+0zeVZT0pexc30CogV83erPPOTdi/16UsioMIC59Ix9opkW76w=
X-Received: by 2002:a2e:240a:: with SMTP id k10mr12710232ljk.31.1551767848562;
 Mon, 04 Mar 2019 22:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20190304183827.GA6809@jordon-HP-15-Notebook-PC>
 <20190304184958.GR32494@hirez.programming.kicks-ass.net> <CAFqt6zarwg3NnkbNYKEO-jrdHUw8GwMqUrLDTqgQV3D1dux-qQ@mail.gmail.com>
 <712691085.1137.1551729467392.JavaMail.zimbra@efficios.com>
In-Reply-To: <712691085.1137.1551729467392.JavaMail.zimbra@efficios.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 5 Mar 2019 12:07:16 +0530
Message-ID: <CAFqt6zaNsiMdq_XxYrEdFxJigW3v8unSbFys+B3d-vBGWEj4+Q@mail.gmail.com>
Subject: Re: [PATCH] selftest/rseq: Remove duplicate header
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>, shuah <shuah@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 1:27 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Mar 4, 2019, at 1:53 PM, Souptick Joarder jrdr.linux@gmail.com wrote:
>
> > On Tue, Mar 5, 2019 at 12:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Tue, Mar 05, 2019 at 12:08:27AM +0530, Souptick Joarder wrote:
> >> > Remove duplicate header which is included twice
> >> >
> >> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> >> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>
> >> That SoB chain is invalid.
> >
> > I didn't get why it is invalid ?
>
> I think it's about having the author of the patch (From) as first
> Signed-off-by, and then apply following Signed-off-by by maintainers
> who pick up the patch. (That's what I am used to see)
>
> What is the intent behind the second Signed-off-by by Sabyasachi Gupta ?

Sabyasachi is the author and I am posting his patches as his email client
has some issue. I think I need to add Sabyasachi's From: @ the
beginning of change log.
Andrew suggested the same in another thread.
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
