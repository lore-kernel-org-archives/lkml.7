Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB428C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58E821D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573110156;
	bh=tsSO2oKH4AjYEiJRusdVI6QSVnr6kuH4qgplOpJ5GCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0UsLTN+Y3Q3sg2j0Iy5gNDcBdlZZpdk+uXOMJE2JJT94DsFw7pRvCjG8+al+QgwGj
	 jZ/C5U8Wrw4R8hTLSefQ5cyF6JWltTZjPls80q9Sb7eDeu0eclyjIOo2bWEhWl50Oq
	 ANbLq0F/kf00ylS0/zTid67SclpjlmIkPVEj35vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfKGHCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:02:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39469 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfKGHCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:02:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id a11so1707184wra.6;
        Wed, 06 Nov 2019 23:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zZXglcpbTpC9QlP3VtjwpWHkMXqkfLtACCkjAh1NRHY=;
        b=t9pBSGRQKigXPt5sxvRAMRQ6ExnjvHMa36xRxQRAsSpYYyhBFnVedw3Ox/IgmX9+Qv
         xGH4azkjAoZqRambEY92VVUepJ3+EzwVtNd+zbFzATad+wtbIZxghv91Rg0aeX8b/RBz
         7QVPiYydbiRR3cGrTt4e5bYCkXhDsZxL6VbIr2RnKxMSWgWI6fRPPdKwcryXK3yF09I9
         WVerep8+6ROk9Zok3h+OviCQq7fJwzMrAdRfbtxY1o/wGn5u2uQr0INe5wEfR3P8wOkj
         p5Cqv5f2+eKGOULbN/DzyV5SweO0DVZbHl998jivCtROOCUGEoPyreIFmngPOUQqSbth
         xZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zZXglcpbTpC9QlP3VtjwpWHkMXqkfLtACCkjAh1NRHY=;
        b=pbHoaMB2UvBj47hmREQftASKQHkV+0l+HVXN+NupVH/OcIZ+/byylMMrF+N8M4wL4T
         8aUDj44CjWREt6bL6Rw1YND/k6m7Kgw2SRRWhCkoJKsi0fHaBATHSY8QT9VBSysBKQuG
         JP0X7h4+qmsjRy8R0lyS2e9t5gKe3tpgbHnratHAlgVLW1pM7P/tSb0+FV6Ljer2vz/u
         1YtHiEKIcDvcyQtkSuELy49kSyoQTd9l5MGAsfOpZXf6mUdK4OF3Hezi9zU9AwNDPfU0
         hu09gy0ryYTVFj+FrhBtELxwfG38TdL0Fs8GZlK1hr6f/mKJDXP1IL8l59Yr7hfyW1ic
         yhug==
X-Gm-Message-State: APjAAAWNbK12y1H/0A2m9nJ1+JV7ipcXabUQ2E9QAcHIoj5ns8jIfNTr
        ybG+J0zr9TcQSA1ytRCO0I8=
X-Google-Smtp-Source: APXvYqyixvNMStPVBkupleG+MMdRDltlLiflRAW22PjPlHgaf6vxHn9xI7ckIUqcYUcrMk7roCT06Q==
X-Received: by 2002:a5d:4946:: with SMTP id r6mr689848wrs.155.1573110152345;
        Wed, 06 Nov 2019 23:02:32 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u4sm1169499wrq.22.2019.11.06.23.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 23:02:31 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:02:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Message-ID: <20191107070229.GA30739@gmail.com>
References: <20191017160301.20888-1-acme@kernel.org>
 <20191021062354.GA22042@gmail.com>
 <20191106191051.GE3636@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191106191051.GE3636@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Oct 21, 2019 at 08:23:54AM +0200, Ingo Molnar escreveu:
> > Secondly, there also appears to be a TUI weirdness when the annotated 
> > kernel functions are small (or weird): the blue cursor is stuck at the 
> > top and I cannot move between the annotated instructions with the down/up 
> > arrow:
> > 
> > Samples: 13M of event 'cycles', 4000 Hz, Event count (approx.): 1272420588851
> > clear_page_rep  /usr/lib/debug/boot/vmlinux-5.4.0-rc3-custom-00557-gb6c81ae120e0 [Percent: local period]
> >   0.01 │     mov  $0x200,%ecx                                                                                                                                                                      ▒
> >        │   xorl %eax,%eax                                                                                                                                                                          ▒
> >   0.01 │     xor  %eax,%eax                                                                                                                                                                        ▒
> >        │   rep stosq                                                                                                                                                                               ▒
> >  99.27 │     rep  stos %rax,%es:(%rdi)                                                                                                                                                             ▒
> >        │   ret                                                                                                                                                                                     ▒
> >   0.71 │   ← retq                         
> > 
> > I can still exit the screen with 'q', and can move around in larger 
> > annotated kernel functions. Not sure whether it's related to function 
> > size, or perhaps to the 'hottest' instruction that the cursor is normally 
> > placed at.
> 
> I couldn't reproduce this one so far, with another small function,
> clear_page_erms, what happens is that the cursor seems to be hidden at the
> bottom, if you press the "magic" 'D' hotkey it will tell (at the bottom of the
> screen) that the idx is at 18, which  for a function with just 8 output lines
> doesn't make sense:
> 
> Samples: 12K of event 'cycles', 4000 Hz, Event count (approx.): 2219443843
> clear_page_erms  /proc/kcore [Percent: local period]
> Percent│                                                                 ◆
>        │                                                                 ▒
>        │                                                                 ▒
>        │    Disassembly of section load0:                                ▒
>        │                                                                 ▒
>        │    ffffffffab9d17c0 <load0>:                                    ▒
>        │      mov  $0x1000,%ecx                                          ▒
>        │      xor  %eax,%eax                                             ▒
> 100.00 │      rep  stos %al,%es:(%rdi)                                   ▒
>        │    ← retq                                                       ▒
>                                                                          ▒
> 1: nr_ent=20, height=35, idx=18, top_idx=1, nr_asm_entries=8
> 
> Doesn't make sense, there aren't 20 entries nor the idx is 18, the
> nr_asm_entries is right, I'll try to follow up on this one...
> 
> But you can in these cases try to go on pressin the up arrow till the cursor
> appears, etc.

Yeah, I can reproduce this too - and don't see the original weirdness 
anymore. :-/

Will re-report if it happens again.

Thanks,

	Ingo
