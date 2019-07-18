Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E345C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E53208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NXczdsOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390982AbfGRUop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 16:44:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46898 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfGRUoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 16:44:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so28646956qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JbZfrz7b54+i+JSr5xxQ779qu98ZPa/qkwZsG16rsL8=;
        b=NXczdsOp7YEL8kFfKmRxpWmLxzf26mPS+Z6tFjMAFsdNH6QJyhpkTvxDsMUFgrM6YJ
         pViGxebPKzzNOYWdBZZAM7Q4ImZXFCNsWwIDN2NkGB78tBY9AAxVu2LnGbuzJiB7TIPg
         k2PQEN85KbgIaQL3HlrCiVuKcuwAttir2XVyd51WVXFVS5MzfV7DRk2W8auZjeyEeQpI
         zhR2de+w3Xm/TLBrpuYNPbIXDj/I63EG8ca61fQozV0JFWRby8h96L9BOzF2P01EdsGD
         qTFj9JuPs2u/E7ouIKh0arYQKTL0uDdhrZ0Y0mTDz9k9W7PkEGRnt+G5lACHmoU6QPzR
         eNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JbZfrz7b54+i+JSr5xxQ779qu98ZPa/qkwZsG16rsL8=;
        b=hlCXg1DddTax4OzJhRC0880zwQm4uxRcuUMLeqVE76IoGWHQ741ggKJ0U2A2j8XSMa
         0dAUvXW+BDZpzFD4RnGtIRuchNBZTS/huG8e6BU13ZXG5Idx7rjc8tcJAVKgbOb0b+nF
         6vQGw48l723FXk6/oIbMcmcI28M0812ZomXUklkfXDHbyRpxubvsdMr00fCYJN5O7A9k
         MOFGqY14bNnLB5CS3Fdlmq7xUIgGzFMel4YHcIW4rtb19r1I/WhBeZVC/ufb1a6FQ/W7
         iXGq4hBY4s5aizgFkOKVSUBbLf/Nihqnzq3hJmLedwzTWE/x+BYJyr6IxLqxUUqmGnAG
         nFDA==
X-Gm-Message-State: APjAAAWrSIsG4B3ZakhdenlBil/jIGPr5hjbKxtKMe0eWY//QnaRGKKl
        66rQGI5+rBvUNTPYEn2wif+VoA==
X-Google-Smtp-Source: APXvYqwIXfU2ZtUn2HWKKCaT3ZSkTCh3J81GzXQDIlvEvLi5bTLVxXDl+C8wVG2Rz3Yr7mLdYEM9pw==
X-Received: by 2002:ac8:26d9:: with SMTP id 25mr34554299qtp.377.1563482683991;
        Thu, 18 Jul 2019 13:44:43 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r14sm14040245qke.47.2019.07.18.13.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 13:44:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] sched/core: silence a warning in sched_init()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190625155745.GF3419@hirez.programming.kicks-ass.net>
Date:   Thu, 18 Jul 2019 16:44:42 -0400
Cc:     mingo@redhat.com, Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <045C79AE-8A15-4287-8788-BF84AC6BA382@lca.pw>
References: <1561466662-22314-1-git-send-email-cai@lca.pw>
 <20190625135238.GA3419@hirez.programming.kicks-ass.net>
 <1561471459.5154.70.camel@lca.pw>
 <20190625142508.GE3419@hirez.programming.kicks-ass.net>
 <1561475229.5154.74.camel@lca.pw>
 <20190625155745.GF3419@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 25, 2019, at 11:57 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Tue, Jun 25, 2019 at 11:07:09AM -0400, Qian Cai wrote:
>> On Tue, 2019-06-25 at 16:25 +0200, Peter Zijlstra wrote:
>>> On Tue, Jun 25, 2019 at 10:04:19AM -0400, Qian Cai wrote:
>>>> On Tue, 2019-06-25 at 15:52 +0200, Peter Zijlstra wrote:
>>>> Yes, -Wmissing-prototype makes no sense, but =
"-Wunused-but-set-variable" is
>>>> pretty valid to catch certain developer errors. For example,
>>>>=20
>>>> =
https://lists.linuxfoundation.org/pipermail/iommu/2019-May/035680.html
>>>>=20
>>>>>=20
>>>>> As to this one, ideally the compiler would not be stupid, and =
understand
>>>>> the below, but alas.
>>>>=20
>>>> Pretty sure that won't work, as the compiler will complain =
something like,
>>>>=20
>>>> ISO C90 forbids mixed declarations and code
>>>=20
>>> No, it builds just fine, it's a new block and C allows new variables =
at
>>> every block start -- with the scope of that block.
>>=20
>> I remember I tried that before but recalled the error code wrong. =
Here it is,
>>=20
>> kernel/sched/core.c:5940:17: warning: unused variable 'ptr' =
[-Wunused-variable]
>>                 unsigned long ptr =3D (unsigned =
long)kzalloc(alloc_size,
>> GFP_NOWAIT);
>=20
> Yes, I know, I tried. And GCC is a moron because of it.

Actually, not only GCC but clang also don=E2=80=99t understand your =
patch.

# make CC=3Dclang W=3D1 kernel/sched/core.o

kernel/sched/core.c:6384:17: warning: unused variable 'ptr' =
[-Wunused-variable]
                unsigned long ptr =3D (unsigned long)kzalloc(alloc_size, =
GFP_NOWAIT);

Maybe adding a =E2=80=9C__maybe_unused=E2=80=9D until the day that =
compilers are getting smarter.=20=
