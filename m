Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68471C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1BB20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfD3QMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:12:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33388 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3QMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:12:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id k189so8526092qkc.0;
        Tue, 30 Apr 2019 09:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Dw1Sc4DgzUhOMvuweilLKv0I/kx7THnj4Gu6G9qc/A=;
        b=V9njuefs8h5r7nWTByHu/7skJsBICOSgC+t3zv2Lv5auS+F4kG9z5ftuxNisuUm9KW
         NpI16KFGqbJrGixjVc4QzMhYTJOTLwx4vIv+D/hKq7KDYpAvAd6wvyE4fvo2ovk4pCjI
         A8jpqgG/oQfS/R0shXbk5tDxWslVMeHdmFM/MoVtkqaeTpUKeq9hRWUeC66oQFtsOHHq
         TQVL8zzAIN68XYKGaFGedRhmrWaidq9Gj+7dyIBugHggM2MyklgXmgbeqo3CPrOMMXlZ
         s69n9vuQzuauq0P8muU/Uv+WB8S1ozQjvltUrcQssXxqiMQ/zBUg5rNeLeJws+IdKO4t
         YCwg==
X-Gm-Message-State: APjAAAXlqgx0NWZ6oULx/Gw45MnVyRMkoK5RKdi3w55P4ERODdlD0vOv
        nI5F1MDP0PSXUyJjmu7FTOg/xCej8pSV6ekwFx4=
X-Google-Smtp-Source: APXvYqxZ18tw9VclTG8jiPtQwPA/q6phtCiYjGxgL4Pu5OHC2RhANvcUJKMdOjp8gwPa9BT1lygkiVrzaDoTFNwqSCg=
X-Received: by 2002:a37:b802:: with SMTP id i2mr48165405qkf.343.1556640772741;
 Tue, 30 Apr 2019 09:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org> <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Apr 2019 18:12:35 +0200
Message-ID: <CAK8P3a2JrAApXDws+t=q8AnKFkHJZSox7gsgwW-xEJTfs_mdzw@mail.gmail.com>
Subject: Re: perf tools build broken after v5.1-rc1
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 7:17 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> On 4/22/19 8:31 AM, Arnaldo Carvalho de Melo wrote:
> >> A quick fix for ARC will be to create our own version but I presume all existing
> >> arches using generic syscall abi are affected. Thoughts ? In lack of ideas I'll
> >> send out a patch for ARC.
> >>
> >> P.S. Why do we need the unistd.h duplication in tools directory, given it could
> >> have used the in-tree unistd headers directly ?
> > I have to write down the explanation and have it in a file, but we can't
> > use anything in the kernel from outside tools/ to avoid adding a burden
> > to kernel developers that would then have to make sure that the changes
> > that they make outside tools/ don't break things living there.
>
> That is a sound guiding principle in general but I don't agree here. unistd is
> backbone of kernel user interface it has to work and can't possibly be broken even
> when kernel devs add a new syscall is added or condition-alize existing one. So
> adding a copy - and deferring the propagation of in-kernel unistd to usersapce
> won't necessarily help with anything and it just adds the burden of keeping them
> in sync. Granted we won't necessarily need all the bleeding edge (new syscall
> updates) into that header, its still more work.

I think more importantly, it seems completely broken to sync a file from
asm-generic but not the arch specific file that includes it.

The 1a787fc5ba18ac7 commit copied over the changes for arm64, but
missed all the other architectures changed in c8ce48f06503 and the
related commits.

      Arnd
