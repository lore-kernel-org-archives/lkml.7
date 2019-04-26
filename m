Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB31C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234D3206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNTWjE07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfDZGsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:48:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44239 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfDZGsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:48:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id s10so2928821qtc.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0POyLSgTrR0cPu+lRcZ2Dj16pZj2mLzXP6Wsc0XCaug=;
        b=dNTWjE07dMd4kkvHt8BeIn1upbMveHLGyVFM0eJaRNYx02mC0zMH5QAXKsoixxNvnJ
         Uc7aefhoersCDNe/CwQ7FfvsNc81dI2RTtTtPdwclV4yigCfg0YnOPFpbqFjb74wPoMi
         JJeUPFPb7aCEfoZAI/ZJxXFtyCIDfEjv+M6WNnjwWkrfvebCLgM9E3dO+exxlJwuaxPE
         SAQp9A6oZhx+O49R+rPhQlq5Gn1kQ3DBqWBhYxA9czSjwB+4j/6Ewqo+DtoF+fkC8E7U
         fVgoeSN70m4M7hH1xGlu4pKAv58rvFqABv4Y6CB4Xato/dPQuYzIG1sRTPqOD/+xMY1L
         IfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0POyLSgTrR0cPu+lRcZ2Dj16pZj2mLzXP6Wsc0XCaug=;
        b=Tzv4ACMK2WYtSJ+HZq3BKEKUhklWcDS806QTy05ExmFJyiNmN2tAsy8TleNo4t5YfC
         GxkPqYp3f2TjratCl6PqeZVHzHjyKLdu6jmHzBH4zNKZEfqvvV2D6c97VPRAqarsG3Xh
         2Cse98UmO0xLMPznj0hgRuP+yek+uQ1Ls6MlZtu5iWYvmKFUsY+Js38fOIrt1sVYdcjY
         9KonkLtSthakFyWpAlVaGJQBB41IM/Xg6dz+bRdzHIw8NXtIWF7awKxfgv0gAycJFFzy
         sAcSgA/nZXp3MJs0721Cl8hXTSvyuKB2OzJ7U1vK6Ahjd+nnIMnxVU1LCmaJAgDqY9ao
         1wKQ==
X-Gm-Message-State: APjAAAWq9fFuh6Devl8fP3xkwLpe6G7BTvzHs6gtKB6xxT+STAOARydD
        JcpAJag26lluJrLPuA1hFnQWryYKWwOvLc8R+chTOM6Mc20dzg==
X-Google-Smtp-Source: APXvYqwh4G9XLOqAT4TREBAqZ3V41J1YYWF85s9uaFjB1tB7sVMD0huYw/HSzOsQVaiqaczBMiFcJe+2DhVQFwMKYJc=
X-Received: by 2002:ac8:6c8:: with SMTP id j8mr16047807qth.57.1556261331629;
 Thu, 25 Apr 2019 23:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101934.51535-1-duyuyang@gmail.com> <20190424101934.51535-21-duyuyang@gmail.com>
 <20190425194831.GV12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425194831.GV12232@hirez.programming.kicks-ass.net>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Fri, 26 Apr 2019 14:48:37 +0800
Message-ID: <CAHttsrbC5My5n0nbu-OP31X-118bfEiemEn8neP9zxVwfErkBw@mail.gmail.com>
Subject: Re: [PATCH 20/28] locking/lockdep: Refactorize check_noncircular and check_redundant
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review.

On Fri, 26 Apr 2019 at 03:48, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 24, 2019 at 06:19:26PM +0800, Yuyang Du wrote:
> > These two functions now handle different check results themselves. A new
> > check_path function is added to check whether there is a path in the
> > dependency graph. No functional change.
>
> This looks good, however I completely forgot we still had the redundant
> thing.
>
> It was added for cross-release (which has since been reverted) which
> would generate a lot of redundant links (IIRC) but having it makes the
> reports more convoluted -- basically, if we had an A-B-C relation, then
> A-C will not be added to the graph because it is already covered. This
> then means any report will include B, even though a shorter cycle might
> have been possible.
>
> Maybe we should make the whole redundant check depend on LOCKDEP_SMALL
> for now.

Sure. I can do that.
