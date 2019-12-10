Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF786C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEB02071E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cUcjvQrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfLJAKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:10:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32877 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLJAKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:10:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id y206so8094318pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 16:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w90N60kf2vkfXZNvEFDEc4sn4v4O0mdh7Peic2U0RJU=;
        b=cUcjvQrLB1c6A1YQUjmrEnuFAWry67dpxeGakaW1Vb9TToQ2P7pfElXXpgd0MJ3BWb
         txLl/L/xD3YcoSVqq5OguXzcyVSjxCNdmlat8DusUQ+d3Ll0pHLUdPxLHueRr79knhW3
         KAbL57XlOgHjt4OeJsg8m8p5HG7ZqETgi4fRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w90N60kf2vkfXZNvEFDEc4sn4v4O0mdh7Peic2U0RJU=;
        b=uXU5cIIPHF3vBdUGudSjw1Y32hBj9OMmXCZBLgveVcBarla94WhMsaevrHEb1QuER6
         AKvaxdJWATWTwOEuQFI1hTesCb6I4hD4j36ivJYHlOqXR7ibcDKxiRY1cBOOEkWbF3d8
         irTN4TFHd6aL3OegfYFkZhVGWMkKaSkAwFpuuhLKupbbEjuG6kMkse7mAAU0caE/ncWh
         n2lvCo35eKQfRab4jSzWJWnfwdmqZN34aIs7SNnUCE0nXCyQrFOFRRiXOBb3iuQcVa/l
         wIPx2F/1OxassP5U7M98CpfzU3tjTvEbX6K/v4zaiLiji3XswsCmz1eaWCMcnVpQlJZD
         BAQA==
X-Gm-Message-State: APjAAAWhkSUTuhmJJCAYy4Zjk9NesdXcGZBc8i2fNaQuh7vviMimc1e3
        cKOMH/bvns+58lJF/r2ZAv+kwg==
X-Google-Smtp-Source: APXvYqyl+o2nEiFfnTVCnxDru2CZs4MZSIEyWUVZGB2xVf09IR2+sLWUb8qQIrzHre089xyxLt4uJQ==
X-Received: by 2002:a63:5219:: with SMTP id g25mr21171426pgb.321.1575936615493;
        Mon, 09 Dec 2019 16:10:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y38sm654427pgk.33.2019.12.09.16.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 16:10:14 -0800 (PST)
Date:   Mon, 9 Dec 2019 16:10:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     syzbot <syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com>
Cc:     acme@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        bp@alien8.de, bp@suse.de, christian@brauner.io, cyphar@cyphar.com,
        dhowells@redhat.com, dvyukov@google.com, ebiederm@xmission.com,
        frederic@kernel.org, gustavo@embeddedor.com, hpa@zytor.com,
        jannh@google.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mark.rutland@arm.com, mhiramat@kernel.org,
        mingo@kernel.org, mingo@redhat.com, mtk.manpages@gmail.com,
        namhyung@kernel.org, oleg@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        x86@kernel.org
Subject: Re: WARNING in arch_install_hw_breakpoint
Message-ID: <201912091608.1DA5B7865F@keescook>
References: <000000000000639f6a0584d11b82@google.com>
 <0000000000007f8bf6059932fe10@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007f8bf6059932fe10@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2019 at 07:33:00AM -0800, syzbot wrote:
> syzbot suspects this bug was fixed by commit:
> 
> commit b3e5838252665ee4cfa76b82bdf1198dca81e5be
> Author: Christian Brauner <christian@brauner.io>
> Date:   Wed Mar 27 12:04:15 2019 +0000
> 
>     clone: add CLONE_PIDFD

That seems ... unlikely? I suspect this WARN should just be pr_err or
something:

        if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
                return -EBUSY;

If it's reachable through normal code, it shouldn't be possible to trip
a WARN.

-Kees

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1268377ae00000
> start commit:   fd1f297b Merge tag 'drm-fixes-2019-03-22' of git://anongit..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
> dashboard link: https://syzkaller.appspot.com/bug?extid=370a6b0f11867bf13515
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d8bd93200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15439f27200000
> 
> If the result looks correct, please mark the bug fixed by replying with:
> 
> #syz fix: clone: add CLONE_PIDFD
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

-- 
Kees Cook
