Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C0C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 11:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725EB215EA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 11:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfKILXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 06:23:20 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:53227 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfKILXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 06:23:20 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1My3Mv-1hhn212PAV-00zYO1 for <linux-kernel@vger.kernel.org>; Sat, 09 Nov
 2019 12:23:18 +0100
Received: by mail-qv1-f50.google.com with SMTP id n12so3255269qvt.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 03:23:18 -0800 (PST)
X-Gm-Message-State: APjAAAVOGb3o2h7x5h0TL/zgIjXKoAQNjLL3HiIn2FpT7JL+cDVGXAao
        pO0YpebJHVITSohA+qg2z+RuvfjdRG27llvQttA=
X-Google-Smtp-Source: APXvYqxxAB77c1YarMqQdoEc116g4WeXnOa8DZQ7HV6fruKuOW8GnDi/TVEJOqSzKvF7NaC1YPkjzWf2ZVpdN8LJltQ=
X-Received: by 2002:a0c:d0e1:: with SMTP id b30mr14789374qvh.197.1573298597443;
 Sat, 09 Nov 2019 03:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20191108203435.112759-1-arnd@arndb.de> <20191108203435.112759-5-arnd@arndb.de>
 <20191108221106.GT10313@minyard.net>
In-Reply-To: <20191108221106.GT10313@minyard.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 9 Nov 2019 12:23:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3BybzufBLVr-n5hCuxOt-MK=0qs9F7b3DYhZ58jiv7vw@mail.gmail.com>
Message-ID: <CAK8P3a3BybzufBLVr-n5hCuxOt-MK=0qs9F7b3DYhZ58jiv7vw@mail.gmail.com>
Subject: Re: [PATCH 4/8] ipmi: kill off 'timespec' usage again
To:     cminyard@mvista.com
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Corey Minyard <minyard@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mbARE7PiQ5YLRpHUfPU9Q4fokejltFGp/cxoPZz+MI4VQVX+Xaz
 NZNKimAHOa19xZpghKnYhFI0xzS1V2iUYixjAKPZ5b2boMcWvJY5fHthy2V3zQW1K2GADik
 MBgL1hNFoxxeG2iPrMxIEPNoVPIIrDMVGmz0AWP+obFiq2hFhJf9Vf+La75ZV3Tz8msNkMu
 LgJlwQQPzq9/UAl7z3MpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mN8Q3Q0JnzI=:pkwX/o7sjL38xxnNLQnKkw
 KU24kMJlYiAtPIxNBuMNb/65jNP9TgbpVnN+yP4K612/b58BSQWymEiVgP3zLNkeLLA5PLVbh
 nwWjJDDpcsedijVHPyOl5a5wWAKfQjNYmAGFZvUodL2gy/d6ctFMFIUw05eZfcSoT7xQC+JcA
 bvMFz6aQn3bzj65/C38TFQ4AZuCRWX0Ntb2Dj9WV3A+BFXwE30N4SYhRbbqLuXdeVwpSWeufd
 j4FPM1SVYFPdkIi9CogPTQ9G/Jkh6LKE0T7+6gdXiJAxwr2FRTecRqD4KSADAVJLP32bgmIYj
 pAUosKPA41HVfOEzwOu8y+VnNu2bcnw14LfknEikmxTVIaqoopY7SKvRYqASmRANJf0Y/jAwa
 D6GUpVtEeA3M4v0j/dHYxW+Ek9kmJRIx5wsJkaX08NIarDZFfXmDuMZxfqju8NLESkLyoZs/L
 yXov5xu72HAwJbRV1HfXXRJKgmBQfQrJVnMnDGKIMi6MxUtuDWviXZ4ywEq54LpUWiDGDQdU0
 C05OgwElksPH9GeAHLCUOElot3F5apZclccQyhjEbR1ChAHamKqIEurEC2d3sXwHpyOzGOFct
 ONvqi+4QTegNv+iZJYEukgR2KuRukjEeyL66xVdY7PQ2TIexeURsrlkJQB3PG7aQ6GaMrt/MS
 gRaRGkD91kF4ujzE2LvtZqgGjlQk2lVc5pNuF8xulcZ/zLvXNEIhhl0gDGrWnUNpP8vOqSkxm
 aOz3wOR6Yb1PxI83ca+TzikVTnKygRR7GJ0w0qEjK9yhxkCsBgbFvXqDpjL/bV9uydoVU02Gq
 gZBUAtkXN3GihL2EBp5D3h0xKQzk9Va0eMsKBilLvjlwGAo+zavkoFAovhW/0fYSmbwo+C7Ko
 5BYd5+bB89hro17wDlfQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 11:11 PM Corey Minyard <cminyard@mvista.com> wrote:
>
> On Fri, Nov 08, 2019 at 09:34:27PM +0100, Arnd Bergmann wrote:
> > 'struct timespec' is getting removed from the kernel. The usage in ipmi
> > was fixed before in commit 48862ea2ce86 ("ipmi: Update timespec usage
> > to timespec64"), but unfortunately it crept back in.
> >
> > The busy looping code can better use ktime_t anyway, so use that
> > there to simplify the implementation.
>
> Thanks, this is a big improvement.  I have this queued, but if you
> are going to submit this, I can remove it, and:
>
> Reviewed-by: Corey Minyard <cminyard@mvista.com>

I'd prefer to have this go through your tree, one less thing for me
to worry about (out of the 90 patches).

> Do you think this should go in to 5.4?

Up to you, it probably depends on how well you can test that the change
is correct beyond the review.

       Arnd
