Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC65C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCABE20716
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575153328;
	bh=9Y4nNTn+56rpnsalChuJPbv5lxsF1TOFjnwAU8g4I4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rLhsccpUnR7JjHduEIfMr+2BtOdSl2kW5TwqD5R5eucX8xooqU0jw2Eh1ecCYV4lQ
	 KyGvxc6D0lJyKGT5/4UpmkMZLIDxkd23Hkdja+SM26hlCXg3DULsgLlxKsdb0mvrfX
	 0Ub8wRZGcL/T6A7ccibBnSmPA7WGex+ZM5M1H/YQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfK3Wf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:35:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36323 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfK3Wf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 17:35:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so1868913ljg.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 14:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HwDNVPZTmEV8LgEuhD+8L70Dw2SKe0RDGV9XU0Auto=;
        b=NIqeYba352diDcQ/nZ2p84c2Y3Th8G+TmbLbdMGiHk3/iV+fDjGuaNMCi/cp63v2Yt
         xUU6wFlfmalk/xTPl1imj9jtCDOo2K5b87cxBUKJIGko/GtNq68bwEM5jGD7OWNJmzBc
         TGW2Z8GIGHbmD/LDqcBgQagMMNVy3vFP/rs8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HwDNVPZTmEV8LgEuhD+8L70Dw2SKe0RDGV9XU0Auto=;
        b=QTXeEBVdtyCDe0btrWZ5wpEIxjbktKi/+DmCpVgvEQt4GkEqDSgPhYAgbMpkBVu1hq
         oGxP72FT6ElYlxTCsKh8H61DDcmnRVefpULwte+gNQRf19Nty6/vcP6EsaHpmY66lANF
         Bp6K/fKESZG4pBmOhtCNbf0wAHTk1G1CvE6WO9hRHnQoPZs80R0F+Mvd+TwiorVbAmas
         7XMhrujbPzKytBYSZetjg0gibem+YNI/0C1c5AfMvfHChiqW0TGwYS2lWGkAsVmumEyR
         6xl6eNYKFLizqT3rcpyw3iQ0bIlPFDCPDIR11RQSuLPVjVShf3lX3hAofi6c22sxESV4
         TCpA==
X-Gm-Message-State: APjAAAU+0fI6qD2tJcXOMWc6sXL62Qv6NgWyR7OtmMIQr/Ti1qzlS05j
        EYGivCsxFlHj8+CoEivwtD04EPP0fPw=
X-Google-Smtp-Source: APXvYqzuenqUGYcHmhMulhSHhpQk3LQo06iqnHpTBGAqdqpQMfa3qSVcluXcl886xtKHReWDVODDCA==
X-Received: by 2002:a2e:9549:: with SMTP id t9mr5111004ljh.148.1575153324379;
        Sat, 30 Nov 2019 14:35:24 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v28sm7661272lfd.93.2019.11.30.14.35.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 14:35:23 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id e10so26462787ljj.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 14:35:22 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr27824654ljj.97.1575153322708;
 Sat, 30 Nov 2019 14:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20191127005312.GD20422@shao2-debian> <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
 <20191130212729.ykxstm5kj2p5ir6q@linux-p48b> <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
In-Reply-To: <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 14:35:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com>
Message-ID: <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com>
Subject: Re: [x86/mm/pat] 8d04a5f97a: phoronix-test-suite.glmark2.0.score
 -23.7% regression
To:     mceier@gmail.com
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 2:09 PM Mariusz Ceier <mceier@gmail.com> wrote:
>
> Contents of /sys/kernel/debug/x86/pat_memtype_list on master
> (32ef9553635ab1236c33951a8bd9b5af1c3b1646) where performance is
> degraded:

Diff between good and bad case:

    @@ -1,8 +1,8 @@
     PAT memtype list:
     write-back @ 0x55ba4000-0x55ba5000
     write-back @ 0x5e88c000-0x5e8b5000
    -write-back @ 0x5e8b4000-0x5e8b8000
     write-back @ 0x5e8b4000-0x5e8b5000
    +write-back @ 0x5e8b4000-0x5e8b8000
     write-back @ 0x5e8b7000-0x5e8bb000
     write-back @ 0x5e8ba000-0x5e8bc000
     write-back @ 0x5e8bb000-0x5e8be000
    @@ -21,15 +21,15 @@
     uncached-minus @ 0xec260000-0xec264000
     uncached-minus @ 0xec300000-0xec320000
     uncached-minus @ 0xec326000-0xec327000
    -uncached-minus @ 0xf0000000-0xf0001000
     uncached-minus @ 0xf0000000-0xf8000000
    +uncached-minus @ 0xf0000000-0xf0001000
     uncached-minus @ 0xfdc43000-0xfdc44000
     uncached-minus @ 0xfe000000-0xfe001000
     uncached-minus @ 0xfed00000-0xfed01000
     uncached-minus @ 0xfed10000-0xfed16000
     uncached-minus @ 0xfed90000-0xfed91000
    -write-combining @ 0x2000000000-0x2100000000
    -write-combining @ 0x2000000000-0x2100000000
    +uncached-minus @ 0x2000000000-0x2100000000
    +uncached-minus @ 0x2000000000-0x2100000000
     uncached-minus @ 0x2100000000-0x2100001000
     uncached-minus @ 0x2100001000-0x2100002000
     uncached-minus @ 0x2ffff10000-0x2ffff20000

the first two differences are just trivial ordering differences for
overlapping ranges (starting at 0x5e8b4000 and 0xf0000000)
respectively.

But the final difference is a real difference where it used to be WC,
and is now UC-:

    -write-combining @ 0x2000000000-0x2100000000
    -write-combining @ 0x2000000000-0x2100000000
    +uncached-minus @ 0x2000000000-0x2100000000
    +uncached-minus @ 0x2000000000-0x2100000000

which certainly could easily explain the huge performance degradation.

                  Linus
