Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954E4C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE3A206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuXUDwrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDZEkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 00:40:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38371 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfDZEks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 00:40:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so903222plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 21:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=HyNPJz1X169VLMtNR26KKjpc2sEs9qFQ9M2v5D+bVv8=;
        b=TuXUDwrVEIx8NtXEzDxtanN52U2D+wK2SVUg2swQN+sNP1mAy1NWpky8Qp5ichbZXZ
         GCdmxf246D//n6ZjuGOKr71xuob2KfVnGBopnrj1lvKU6n4fT2xov6t3CfV/OEpiHrc7
         qE8mKU80EeFyoT0pSSgVB2gf+r81CX/9quQafpsdimBj+5KWMZD3pzSCL3yd8xxdLCkj
         6HdNHuGhW7xMa6LiRX98KGp8FI5v43XY/1PIfpukn5HuyBZwg+lgx2vBCx82gp/QdKu4
         ujwAT+f8aUl11vYYaVPycP9+TDbSqtbOqrIwvZWUCU7bZu0PBw8OfQEIfmmyqYr9ncg8
         xWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=HyNPJz1X169VLMtNR26KKjpc2sEs9qFQ9M2v5D+bVv8=;
        b=pjAM114+7USnZAx7Sm3tYiliQWFqlEiHNUTg6kVZ+XneRhfIW1h/fATE7/r0cyaq2T
         z+YPtolWMG1UZha5COZax0Lt3nPZye1q7t4WY+X6OijNE5PmWkMJdTx7N3bKyHmXgRFh
         8l4aPrdcbCrDYhHmojYTerVID2j3IxK5RciFpeT6u0nIGqmR+zSDNK/4qOZ2D0hBO4ME
         T4DDxqBqSpN0+fLsM0GOTTBjimGgh6bB4dITC942jB5DCJvTRRb1umw0T+Rhv2k7e9DG
         0WS8TmzwbwuZcDHpM5xCrbYSnprnRb1HRWI0CPLHARW9Wf/FWuxOw+Ch6Mwv+cZWwVUM
         yScg==
X-Gm-Message-State: APjAAAVAi8eqvSZfzoDVOjt+N8SrbM9uaDoNr6qqcrd4k5PXqx6hslGR
        KV+WfY9qJO/fMjTiClHC1Wc=
X-Google-Smtp-Source: APXvYqyd4vzJ9MypgChZoEQuJwJaKshCPYVtE2Jmcv9yHyorZNU4m+/ryO0jlMGkVsV1OL3eZ3xygQ==
X-Received: by 2002:a17:902:8483:: with SMTP id c3mr42057501plo.19.1556253648136;
        Thu, 25 Apr 2019 21:40:48 -0700 (PDT)
Received: from localhost ([203.63.161.26])
        by smtp.gmail.com with ESMTPSA id f22sm33926308pgv.45.2019.04.25.21.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 21:40:46 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:40:40 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kernel/sched: run nohz idle load balancer on HK_FLAG_MISC
 CPUs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190412042613.28930-1-npiggin@gmail.com>
        <20190425115620.GQ4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425115620.GQ4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1556253219.geomfr4bo2.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra's on April 25, 2019 9:56 pm:
> On Fri, Apr 12, 2019 at 02:26:13PM +1000, Nicholas Piggin wrote:
>> The nohz idle balancer runs on the lowest idle CPU. This can
>> interfere with isolated CPUs, so confine it to HK_FLAG_MISC
>> housekeeping CPUs.
>>=20
>> HK_FLAG_SCHED is not used for this because it is not set anywhere
>> at the moment. This could be folded into HK_FLAG_SCHED once that
>> option is fixed.
>=20
> Frederic? Anyway, I thnk I'll take this patch as is.

That would be great, thanks. We've been testing it in a staging
environment (this is where they noticed the noise in the first
place), and results have been as expected:

  I've been able to test Nick's idle-loop load balancer (ILB) patch,=20
  with and without the TEO cpuidle governor. With the ILB patch (and=20
  nohz_full) I get a very quiet noise profile with either cpuidle=20
  governor (menu or teo). For my tests, I don't see a meaningful=20
  difference between the two governors.

  [...]

  Bottom line: Nick's patch that constrains the ILB to run on non-nohz=20
  cores has a noticeable noise-reduction effect. For this type of=20
  workload, the choice of cpuidle governor, menu or teo, is immaterial.

This is against a slightly backported RHEL kernel they are using, but
no significant differences from upstream in these areas.

Thanks,
Nick

=
