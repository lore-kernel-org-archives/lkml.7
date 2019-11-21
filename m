Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718FCC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E2620692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ezo3TE+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKURgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:36:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38797 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKURgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:36:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so2053249pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 09:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m4d6AZEZPRvVJ76CuMbdinqD/PFVnzwGlvHzSNE9aH4=;
        b=ezo3TE+LCwK/fh8gnSUNRPx+lCpxkSs4U3F7FUg8dhWcgXARY2yEbamni63DYQmmDP
         FNFflEH4h1WMFSxsyDQ06IUOY7frbar01+SUyXP+INw+hQuYekMqepSKOFK0FLmZ8vRL
         wF+Dgw+5dKezrBE4PPRuhvotKDUqtt6iXacOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m4d6AZEZPRvVJ76CuMbdinqD/PFVnzwGlvHzSNE9aH4=;
        b=bB6sgcAPp9pX2PBA12BnlIXA3UL1KOoSYH/vAiFVHB34MnLA2fa38iMDGhsttNO+M9
         RHNGA3WxovtAIBxjVS3fwIueXSjQcvcpbM3Gy59XhV05AVZwIhgwObdPl1d+r/os9AC1
         iAEh15EYizzWfEoKv3fKjR2Ak2aBXbEzjmhbq19c/H2bjTNCQOENvp24Q3IQ04+2jeVj
         1P+KF0C7Sbxpzjxyz4J1kU21YYZMHsdHHvVZFYAhYGS20nBSYxG6zgc8/324EOcv3Ie1
         q8IKBNrSFI/dH3O+GvYJHipyhFxNYopNehtHUFUnRzHbIYOC/h6gqmi2OvuasVuz2Au9
         WAQg==
X-Gm-Message-State: APjAAAU9SA6g1dM6PYas45YKg3ebkrMvnhy3dsi3gg3BrspoZbrmj5f7
        PUx5i8NWdK26zv4Zm/U9rEecJA==
X-Google-Smtp-Source: APXvYqx255rjDwfNZwwEwFf8fx73jPuVuKWS6RuwVoBUPqtWjhwcH235pxIMreAIQWYI0vYua1ZWiw==
X-Received: by 2002:a62:a103:: with SMTP id b3mr12251005pff.5.1574357776848;
        Thu, 21 Nov 2019 09:36:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e5sm152682pjv.29.2019.11.21.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 09:36:15 -0800 (PST)
Date:   Thu, 21 Nov 2019 09:36:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     syzbot <syzbot+81e6ff9d4cdb05fd4f5e@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, adobriyan@gmail.com,
        ak@linux.intel.com, bigeasy@linutronix.de, fenghua.yu@intel.com,
        frederic@kernel.org, hpa@zytor.com, kernelfans@gmail.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rafael.j.wysocki@intel.com, riel@surriel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, tonywwang-oc@zhaoxin.com,
        wang.yi59@zte.com.cn, x86@kernel.org
Subject: Re: general protection fault in tss_update_io_bitmap
Message-ID: <201911210931.DB5346C8@keescook>
References: <0000000000004dccce0597d1967b@google.com>
 <20191121110115.GC6540@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121110115.GC6540@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 12:01:15PM +0100, Borislav Petkov wrote:
> On Wed, Nov 20, 2019 at 05:55:09PM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    5d1131b4 Add linux-next specific files for 20191119
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=177979d2e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b60c562d89e5a8df
> > dashboard link: https://syzkaller.appspot.com/bug?extid=81e6ff9d4cdb05fd4f5e
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1549ed8ce00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f91012e00000
> > 
> > The bug was bisected to:
> > 
> > commit 111e7b15cf10f6e973ccf537c70c66a5de539060
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Tue Nov 12 20:40:33 2019 +0000
> > 
> >     x86/ioperm: Extend IOPL config to control ioperm() as well
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10490e86e00000
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=12490e86e00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14490e86e00000
> 
> Try this:
> 
> https://git.kernel.org/tip/e3cb0c7102f04c83bf1a7cb1d052e92749310b46

Rewording so syzbot can see it (https://goo.gl/tpsmEJ#testing-patches) ...

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git e3cb0c7102f04c83bf1a7cb1d052e92749310b46

-- 
Kees Cook
