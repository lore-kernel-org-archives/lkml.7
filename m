Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B21C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216492070C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568971317;
	bh=zeNFhs74uqgNCXtIjr6uJcv9gZpBeoNkD55K8dFX3TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a9mnrNNrYhNeYO30eDKs0Ex46p611/U+pemZPg+klLXrObzjl5rLRGA1uhFqFciVu
	 c9v20DQUeiUgZ9VwwGVH5Qcms+5hF61NWJTUZK8chQDJIp4CRDtzpqMGj2u1rwoXs5
	 ybQbIm9iF425w4/N2RJRni5u3FbfBwZrcc5Sq+Hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408447AbfITJV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:21:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33165 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405677AbfITJV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:21:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so4566618lfc.0;
        Fri, 20 Sep 2019 02:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4YiRmEpCFThfevDroMDez2PpfJLDCsCFYMmsvg1iwz4=;
        b=CNnRdJN5yu+ruVbNozHWk+nIXDEjTNHI2wCtE9/IqK9Fge8YClEsrxLGT/QKRu+1Ra
         o4UJCBTDN6itcFN8O24Z6Vx1dEYGEYV9pa2KtYUhAC+XKrdPUDMiOSltTFxe0r9LvTf8
         6tPy8gN9eHMF/0eVps3EXUOdeAcujKcKZ1v8Qy93dmiK5McbMNhH3blh1yf3y6ShkTHW
         RgbDZ641QAPggt+oTNr/RC7d64SXM13/jt1gDStt5jl2k+OD2szSg8yfIpgfv2mxUQXF
         s1Enmrt0Tr7Kd1XbhQQPZckNUYrNXQmZJfCAG0VmdUuwbVsVIQsOgjSqb7sqWzIjfbcU
         KGpw==
X-Gm-Message-State: APjAAAVjJOh2Q/NHc00OAEbQHAyhfJtWIVdjuTirfL3N7N7M+e0YWWVE
        ARiIirYxq/VF7ZwS2tcdNS4=
X-Google-Smtp-Source: APXvYqxZOYE3nc+Z4QWAYIdV8061H1KUyCPCbBY9v+YdKqaFBQwAPT4zCP+/eG0BUypD4wg+vY+s1g==
X-Received: by 2002:a19:2d19:: with SMTP id k25mr8709834lfj.76.1568971313437;
        Fri, 20 Sep 2019 02:21:53 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id g27sm302455lja.33.2019.09.20.02.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 02:21:52 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iBF6v-0001YC-1Q; Fri, 20 Sep 2019 11:21:53 +0200
Date:   Fri, 20 Sep 2019 11:21:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Johan Hovold <johan@kernel.org>,
        syzbot <syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        dmg@turingmachine.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in adu_disconnect
Message-ID: <20190920092153.GN30545@localhost>
References: <000000000000d12d24058f5d6b65@google.com>
 <000000000000a12822058fb4f408@google.com>
 <20190920090803.GM30545@localhost>
 <CACT4Y+Yg5wTsMUGRmTwexKUMzi1ZxrH3k3yaMaJvLaEp7qnjSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Yg5wTsMUGRmTwexKUMzi1ZxrH3k3yaMaJvLaEp7qnjSw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 11:13:14AM +0200, Dmitry Vyukov wrote:
> On Fri, Sep 20, 2019 at 11:08 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Fri, Aug 09, 2019 at 01:24:04PM -0700, syzbot wrote:
> > > syzbot has found a reproducer for the following crash on:
> > >
> > > HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13871a4a600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0243cb250a51eeefb8cc
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c4c8e2600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d80d2c600000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
> > >
> > > usb 1-1: USB disconnect, device number 4
> > > ==================================================================
> > > BUG: KASAN: use-after-free in atomic64_read
> > > include/asm-generic/atomic-instrumented.h:836 [inline]
> > > BUG: KASAN: use-after-free in atomic_long_read
> > > include/asm-generic/atomic-long.h:28 [inline]
> > > BUG: KASAN: use-after-free in __mutex_unlock_slowpath+0x96/0x670
> > > kernel/locking/mutex.c:1211
> > > Read of size 8 at addr ffff8881d1d0aa00 by task kworker/0:1/12
> >
> > Let's resend and retest with commit id from latest report to make sure
> > the patch was actually applied during the last run:
> 
> The reply contains:
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1440268d600000
> that's what's being parsed and applied during testing.

Thanks for confirming, but I can't seem to find that link in the report
from syzbot:

	https://lkml.kernel.org/r/000000000000b05ce40592f8521a@google.com

Is it supposed to be there?

Johan
