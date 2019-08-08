Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE080C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825452089E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctvX7ZiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbfHHFmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 01:42:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39654 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfHHFmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:42:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so107925792otq.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 22:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7F16gWt6CG6Dis1wkwgKShaM3nkA2ktQnhP1yrDL54=;
        b=ctvX7ZiAMG9XRRqxL0NsoHVV4cw9SASk627MtNnvGjYA9cXPWjgkDPupHph7zR2r8K
         z/hL5sZw42rnp8YKuL+1wa+ZNWQD5jI2pki3UmQi9Mr9e9MMCXtyn8k0bcmXnbR2vBUe
         8z0e5cRq3MyO8/kkhkUkr514pRyZ/EXC7R1QBLL7gH0HGRsvytmEIjqMfrWVr5t2z/rJ
         xqQIvvME21BFFrKwsAt2ddaKOBTTg9pMw57gET0Lnf4FNZJ0ksit/Voev0c2pbyIjJDI
         ct1OnLG8JxJNrTS4XAmCV5gj+T2c0Qj3SrOoVhj8SlGtXeRpIbqtg3H10VTxbR814lI9
         1Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7F16gWt6CG6Dis1wkwgKShaM3nkA2ktQnhP1yrDL54=;
        b=cjZSMJPb7GNecUB8t4ENhMlrqBX9Urggd5U/Dhdv+pKThx32VVK2bDHW6KQhC8IOV1
         /C5OKxz55B8pQBJS5mj8fGj9PZHrghUJfuwS9dQJCIhH2kP0fZ07dXUYu7l3PdKoTqUW
         XVI0YyoZ5P20O8z95BxYUAWdLTt7adp+3McU4bVyEnWVMFADhrRXmVXO+55ClsI3BwCV
         hBk0ORmP8jJmtQossmR6GuVLWliuf/CVH1pE2sYAzYMNx812bkE5puImjG8CEe/3xNWs
         T2Vg6g8qTXGXIws8pLLeNEQ/ZZj+jbTQ48HU5qqM47n3DiWgafo2dC31AKVPYO74ER/T
         yIPw==
X-Gm-Message-State: APjAAAVnFK03GGIRMb1htGYLleNKZPqiOoWOuDo6Nb5VuWxQDMqpIaJN
        1rBNYbycbAltxAk3YUG/FHyNvOnS5+KbsZNqiQ==
X-Google-Smtp-Source: APXvYqzfJmybnfFUCmZ62VHpiKZ3A2/FlZApcImHFhPUmGKOMqqvdoNOYq1SLyQrkOLhwBRkLV5sGZMMgKNTp2tmKH0=
X-Received: by 2002:a6b:7d49:: with SMTP id d9mr13259578ioq.50.1565242929081;
 Wed, 07 Aug 2019 22:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <1564995539-29609-1-git-send-email-kernelfans@gmail.com>
 <20190807025843.GA4776@dhcp-128-65.nay.redhat.com> <20190807075226.GA10392@mypc>
 <alpine.DEB.2.21.1908071504310.24014@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908071504310.24014@nanos.tec.linutronix.de>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 8 Aug 2019 13:41:57 +0800
Message-ID: <CAFgQCTs7XN3xBPt64jPNb4wCGAZRmYSjhPM=tgcLriVCEx+uDA@mail.gmail.com>
Subject: Re: [PATCH 0/4] x86/mce: protect nr_cpus from rebooting by broadcast mce
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Young <dyoung@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Drake <drake@endlessm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, Tony Luck <tony.luck@intel.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 9:07 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
[...]
> > > >
> > > > *** Back ground ***
> > > >
> > > > On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
> > > > broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.
>
> Pingfan, please trim your replies and remove the useless gunk after your answer.
OK. I will.

Thanks,
    Pingfan
>
> Thanks,
>
>         tglx
