Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDE9C73C42
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F746214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwfJMv7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfGIMhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:37:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37661 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfGIMhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:37:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so9245145pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 05:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toXyCL0quzFOYmrXy8+MCWdClqdzvUSV1PASvI/KRWE=;
        b=GwfJMv7VfaZfq541svvZnCJToRGP/8W+q7J/2YC/eZqxEDsURJ5Hmqk6qz3aD97lmk
         JNT1ydj7O66POQPHdHTjg3jSZAREZD1j25psAWSvOcsILW8Ub/o3WC+P80nvtiNHnB2h
         gHmdUsjEXJ/jHI/sCNvtBt7hN7kfQP4b7BoZ+WsJp4/6bOpPc5lCJ5mOle8tIb2UsK5d
         aRUxqBcgLvBSAJdQ8nlJ+gvcRA5sJl+mlQiK6YgMz4HdJ5apBSDLLI+E8HPHvkHgFX/7
         a17c22B/w03BUYS9dDBmJMrPfrUAgL2rExPU9WlhJdzGh15MM20NE38Od/muYr9oMFpT
         /YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=toXyCL0quzFOYmrXy8+MCWdClqdzvUSV1PASvI/KRWE=;
        b=qTCe2KTeWMC4nn55pWv4TJaCxVXRXApdPG7gIvHPFAHUnuAG07GKtmwFfAMoK0RbJh
         rSZIfhnyqVaz9qdk7fTkHRpMRPNUijmcN4cwAJeasSuNmRNrMgJDwcbaySshqlzXIyls
         YJGPer2zrHYQBBeNwLuI79o9pexUI3nSU7NVT/LKIcuZqgHbN8HKaAIwLMH01hGp0YTd
         x5zXcfCjknHuz/s6RtXozeBpBVIG1qE9rM2DAqAtGYdMkhTOYL10s2YxtkFF76vo68b4
         YSSWINGnOMvgQthqv6sDWJQLIWr6ESKbF2R+bVJmN8ZoXoGUBchu5TP1EApPUPxyLjzP
         goGQ==
X-Gm-Message-State: APjAAAXIUq2E8AMpk0iCwpogANBbEUKkvfmIC5d672giPVbAQhjvdyBH
        7KPmEcDWbQs1x4CJvFzMQvY=
X-Google-Smtp-Source: APXvYqwnEr4a7gislIXb4YWANEcVg47+zBKfEfCiGCTnhSL0oRHV35kB9bn+pZ1dMusp8+MfbOCCSg==
X-Received: by 2002:a63:211c:: with SMTP id h28mr30226836pgh.438.1562675823411;
        Tue, 09 Jul 2019 05:37:03 -0700 (PDT)
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp. [210.141.244.193])
        by smtp.gmail.com with ESMTPSA id v23sm20816932pff.185.2019.07.09.05.36.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 05:37:02 -0700 (PDT)
Date:   Tue, 9 Jul 2019 21:36:57 +0900
From:   Masami Hiramatsu <masami.hiramatsu@gmail.com>
To:     Anders Roxell <anders.roxell@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     James Morse <james.morse@arm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kprobes sanity test fails on next-20190708
Message-Id: <20190709213657.1447f508bd6b72495ec225d9@gmail.com>
In-Reply-To: <CADYN=9LBQ4NYFe8BPguJmxJFMiAJ405AZNU7W6gHXLSrZOSgTA@mail.gmail.com>
References: <20190708141136.GA3239@localhost.localdomain>
        <a19faa89-d318-fe21-9952-b0f842240ba5@arm.com>
        <CADYN=9LBQ4NYFe8BPguJmxJFMiAJ405AZNU7W6gHXLSrZOSgTA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 12:19:15 +0200
Anders Roxell <anders.roxell@linaro.org> wrote:

> On Mon, 8 Jul 2019 at 17:56, James Morse <james.morse@arm.com> wrote:
> >
> > Hi,
> >
> > On 08/07/2019 15:11, Anders Roxell wrote:
> > > argh... resending, with plaintext... Sorry =/
> > >
> > > I tried to build a next-201908 defconfig + CONFIG_KPROBES=y and
> > > CONFIG_KPROBES_SANITY_TEST=y
> > >
> > > I get the following Call trace, any ideas?
> > > I've tried tags back to next-20190525 and they also failes... I haven't
> > > found a commit that works yet.
> > >
> > > [    0.098694] Kprobe smoke test: started
> > > [    0.102001] audit: type=2000 audit(0.088:1): state=initialized
> > > audit_enabled=0 res=1
> > > [    0.104753] Internal error: aarch64 BRK: f2000004 [#1] PREEMPT SMP
> >
> > This sounds like the issue Mark reported:
> > https://lore.kernel.org/r/20190702165008.GC34718@lakrids.cambridge.arm.com
> >
> > It doesn't look like Steve's patch has percolated into next yet:
> > https://lore.kernel.org/lkml/20190703103715.32579c25@gandalf.local.home/
> >
> > Could you give that a try to see if this is a new issue?
> 
> The patch didn't apply cleanly.
> However, when I resolved the issue it works.
> I'm a bit embarrassed since I now remembered that I reported it a while back.
> https://lore.kernel.org/lkml/20190625191545.245259106@goodmis.org/
> 
> Both patches resolved the issue.
> I've tested both.

In that case, the later one (move postcore to subsys) seems good to me.

Delaying the test is just avoiding the issue that the selftest found,
since right after init_kprobes() are called, the kprobe is ready for use.
This means that the selftest must be run as the first user of the kprobes
and it must be run right after initialize kprobes.

Thank you,

> 
> Cheers,
> Anders


-- 
Masami Hiramatsu
