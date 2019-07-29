Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D06AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F97A206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="d5BbKW8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfG2QXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:23:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42136 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfG2QW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:22:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so28501981pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TGe/geZ87qC/Bj1IMgqU+ytXYrP/0N7tQMUhQt/p3/s=;
        b=d5BbKW8/plsBM1AKOfuFUhf26MKZlqMYSKZDr8YVVWH1IQPUij8aMiPu4C+K9FSEMO
         r4nAW5vgRlXPfAiJoR2Mo/SVuNnvyA+9FpLZefF+PeC8iy3gma6OYYB3emW4chRNY+Oi
         Up2xrTvtE4xPfvotTloTBiJcshYpwNAdYxWuzPcg8qsDe+cMHsRul3r18mDjwMymD2pr
         EllcF47OUaf0ugNxSYdeljZCTi/tC4FKHS14+RTLb+YtgIJuVTtnlLNx3WIh2aZHvOB5
         xWHx/cfPosBIEtg1/8Sq9RROEL8NTq3owgj/7WE/vEEf0dPBKloa07fUa0FPY98fAIeU
         SgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TGe/geZ87qC/Bj1IMgqU+ytXYrP/0N7tQMUhQt/p3/s=;
        b=E1J0nE7d/7y5+pZBAZeB8Q2mCiHL5rQTZ5PMdIUhLxutuvIV/iHqwlOXe6XP5TKtgy
         HBcCevtb96GJWcQ8e65Rpcs4GevP6e/xtx0RYAEZT6XZ03veZXZUJ2bW38oumE+TKlzx
         JsjOFXMxbjOHxah0AUYCZVGhpPqHEXP/i2ymsRrNDxqMHF3iI4/jgz1EFzgmC3hR3BvC
         1xLdTKF1fkq96HYiXedw0r/+Gw2yuRsJirqtozxj+WFHnxYplDQAkA0yAkpaB+5dSE7b
         XWasmyY6MfPPRohNEbMHHa70+2ssxz2TKIWCY8U/udsLtRN80XCxAeJZQCgzwIm9oZAh
         1tZg==
X-Gm-Message-State: APjAAAXMazfyu1oRGQ3US9R4NyfVPo9AJiXAUy0hd5OdqNpFzfkwc81h
        vxczrgaumD3wCHao4aMKAruo+mnHo8g=
X-Google-Smtp-Source: APXvYqxa3zdBmZyR2hRDHMLO+UBzY5e8eP5A8amqoK/P8m6Ef0NEtSeTPeXrCXXju44jDTKGgVZhvg==
X-Received: by 2002:a65:6256:: with SMTP id q22mr104646436pgv.408.1564417379277;
        Mon, 29 Jul 2019 09:22:59 -0700 (PDT)
Received: from ?IPv6:2600:1010:b041:eebe:98d2:d02:46c3:a133? ([2600:1010:b041:eebe:98d2:d02:46c3:a133])
        by smtp.gmail.com with ESMTPSA id f27sm45266394pgm.60.2019.07.29.09.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 09:22:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of kthreads
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <20190729150338.GF31398@hirez.programming.kicks-ass.net>
Date:   Mon, 29 Jul 2019 09:22:56 -0700
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6DB6BFE-BD85-4329-B313-5D84539CD2FD@amacapital.net>
References: <20190727171047.31610-1-longman@redhat.com> <20190729085235.GT31381@hirez.programming.kicks-ass.net> <4cd17c3a-428c-37a0-b3a2-04e6195a61d5@redhat.com> <20190729150338.GF31398@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 29, 2019, at 8:03 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Mon, Jul 29, 2019 at 10:51:51AM -0400, Waiman Long wrote:
>>> On 7/29/19 4:52 AM, Peter Zijlstra wrote:
>>>> On Sat, Jul 27, 2019 at 01:10:47PM -0400, Waiman Long wrote:
>>>> It was found that a dying mm_struct where the owning task has exited
>>>> can stay on as active_mm of kernel threads as long as no other user
>>>> tasks run on those CPUs that use it as active_mm. This prolongs the
>>>> life time of dying mm holding up memory and other resources like swap
>>>> space that cannot be freed.
>>> Sure, but this has been so 'forever', why is it a problem now?
>>=20
>> I ran into this probem when running a test program that keeps on
>> allocating and touch memory and it eventually fails as the swap space is
>> full. After the failure, I could not rerun the test program again
>> because the swap space remained full. I finally track it down to the
>> fact that the mm stayed on as active_mm of kernel threads. I have to
>> make sure that all the idle cpus get a user task to run to bump the
>> dying mm off the active_mm of those cpus, but this is just a workaround,
>> not a solution to this problem.
>=20
> The 'sad' part is that x86 already switches to init_mm on idle and we
> only keep the active_mm around for 'stupid'.
>=20
> Rik and Andy were working on getting that 'fixed' a while ago, not sure
> where that went.

I thought the current status was that we don=E2=80=99t always switch to init=
_mm on idle and instead we use a fancier and actually correct flushing routi=
ne that only flushed idle CPUs when pagetables are freed.  I still think we s=
hould be able to kill active_mm in favor of explicit refcounting in the arch=
 code.=
