Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79B6C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7448220663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="veoLSuol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbfDQSrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:47:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34334 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDQSrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:47:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so28596618qtm.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l5tI8RsmoLxW8rWd5B2LckPZTYtuRr6KdcIYHAMwTEE=;
        b=veoLSuolS+I+oWN/pukb0VdylC2MM2xFUdM9M/4egq2TT71HyvtUrWoHPR0oZ0w2Mt
         NiA+JMZJlhTIBEVF3XR2HURpUOCnQQ+bk4CNX++oO9tzZz1PeJDsG5KlaqhaF+PcHZ2S
         IBIVDniNtjqO3ZVvJVxu+Bt5oD2KeslyrwTWXnM8fgkzwL2mLRU8DSkB5JB3S2piL95Y
         WiCRvj8sOWY8C/Md19mbkcOSzEGJ1y3r7Z7t1XukxWvyjrVim13kI+JTnoB5E4gOP+oV
         nhRwawCt6TdgaFIfQaRRkhXUxWRrDMTEDGSyzilGSfzdbLQUznz+JossTabuQuR8OGKn
         vZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l5tI8RsmoLxW8rWd5B2LckPZTYtuRr6KdcIYHAMwTEE=;
        b=doccU8wzjANOiQqV22WAHjD0Y5GiEXXqr92HOS2eCVr5Dp6SE617Mx6bObV/EB5//v
         EbHIh6xKj6Sp/TbUyOvsMW5kdoUnZNFbbjPwAk6JLbe+S/vmxt9akijkz2ZnpMrdAkuF
         023zOWh8GtS+civSyzch8l6DCbBIVHH7su8aHEn5ADfY6C0owMlv4c8+AEAV7XnecS6W
         hGWnYZDDP7J473BhQvmWx5Us3XKWloEkAI5sqRx0UK65fgcAjfB1La/AYqyES8gMsF1e
         aElQPc1Rr8RK6Y4kQYdN1P2eTVxVXfNT/jn9phA0pzUWS3bSD0+C2wHghuVeEdm2eQg1
         e++g==
X-Gm-Message-State: APjAAAXTkn2SWwVhtUZJN81RTf0vTBjK2GkJQd8XkI+5AlqTnEUpmMjJ
        y9RfLVxSwSFcfQ8yyVLmJ18=
X-Google-Smtp-Source: APXvYqxPEQvqFSiG9u+fWjJASh8LJuw5G5XiRGjGbzSUF8ySjlJLe7aim2MOxccZa/dnYHGqRXq8ug==
X-Received: by 2002:a0c:ae7c:: with SMTP id z57mr1181762qvc.244.1555526830844;
        Wed, 17 Apr 2019 11:47:10 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id b24sm28162223qtr.51.2019.04.17.11.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 11:47:09 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 657BD40521; Wed, 17 Apr 2019 15:47:04 -0300 (-03)
Date:   Wed, 17 Apr 2019 15:47:04 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf record: collect user registers set jointly with
 dwarf stacks
Message-ID: <20190417184704.GE5246@kernel.org>
References: <a83183c0-21f4-02af-1443-1a3fdb5d89c3@linux.intel.com>
 <20190417073952.GF17024@krava>
 <20190417143542.GA5246@kernel.org>
 <20190417144002.GB2705@krava>
 <60FB78F1-BC48-4172-9669-DD3846F1F0E0@kernel.org>
 <d68cd29b-16fe-7117-b2f4-720c72d6c146@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68cd29b-16fe-7117-b2f4-720c72d6c146@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 17, 2019 at 08:45:08PM +0300, Alexey Budankov escreveu:
> Hi Arnaldo,
> 
> On 17.04.2019 18:48, Arnaldo Carvalho de Melo wrote:
> > On April 17, 2019 11:40:02 AM GMT-03:00, Jiri Olsa <jolsa@redhat.com> wrote:
> >> On Wed, Apr 17, 2019 at 11:35:42AM -0300, Arnaldo Carvalho de Melo
> >> wrote:
> >>> Em Wed, Apr 17, 2019 at 09:39:52AM +0200, Jiri Olsa escreveu:
> >>>> On Mon, Apr 15, 2019 at 06:36:13PM +0300, Alexey Budankov wrote:
> >>>>>
> >>>>> When dwarf stacks are collected jointly with user specified
> >> register
> >>>>> set using --user-regs option like below the full register context
> >> is
> >>>>> still captured on a sample:
> >>>>>
> >>>>>   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP
> >> -- matrix.gcc.g.O3
> >>>>>
> >>>>>   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002):
> >> 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
> >>>>>   ... FP chain: nr:0
> >>>>>   ... user regs: mask 0xff0fff ABI 64-bit
> >>>>>   .... AX    0x53b
> >>>>>   .... BX    0x7ffedbdd3cc0
> >>>>>   .... CX    0xffffffff
> >>>>>   .... DX    0x33d3a
> >>>>>   .... SI    0x7f09b74c38d0
> >>>>>   .... DI    0x0
> >>>>>   .... BP    0x401260
> >>>>>   .... SP    0x7ffedbdd3cc0
> >>>>>   .... IP    0x401236
> >>>>>   .... FLAGS 0x20a
> >>>>>   .... CS    0x33
> >>>>>   .... SS    0x2b
> >>>>>   .... R8    0x7f09b74c3800
> >>>>>   .... R9    0x7f09b74c2da0
> >>>>>   .... R10   0xfffffffffffff3ce
> >>>>>   .... R11   0x246
> >>>>>   .... R12   0x401070
> >>>>>   .... R13   0x7ffedbdd5db0
> >>>>>   .... R14   0x0
> >>>>>   .... R15   0x0
> >>>>>   ... ustack: size 1024, offset 0xe0
> >>>>>    . data_src: 0x5080021
> >>>>>    ... thread: stack_test2.g.O:23828
> >>>>>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> >>>>>
> >>>>> After applying the change suggested in the patch the sample data
> >> contain
> >>>>> only user specified register values:
> >>>>>
> >>>>>   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP
> >> -- matrix.gcc.g.03
> >>>>>
> >>>>>   188368474305373 0x5e40 [0x470]: PERF_RECORD_SAMPLE(IP, 0x4002):
> >> 23839/23839: 0x401236 period: 1260507 addr: 0x7ffd3d85e96c
> >>>>>   ... FP chain: nr:0
> >>>>>   ... user regs: mask 0x1c0 ABI 64-bit
> >>>>>   .... BP    0x401260
> >>>>>   .... SP    0x7ffd3d85cc20
> >>>>>   .... IP    0x401236
> >>>>>   ... ustack: size 1024, offset 0x58
> >>>>>    . data_src: 0x5080021
> >>>>>    ... thread: stack_test2.g.O:23839
> >>>>>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> >>>>>
> >>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >>>>
> >>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
> >>>
> >>> So, there are registers that are needed to do the DWARF unwinding,
> >>> right? But at the same time, if the user says only some are needed,
> >> he
> >>> better know what they're doing and ask for at least the registers
> >> needed
> >>> for the unwinding process to be successfull, right?
> >>
> >> yep, that's how understand that
> > 
> > So we need to document that, stating that specifying a set of registers together with requesting DWARF callchains may break things.
> 
> Do you mean break callchains if omitting IP,SP,BP? 
> For example like this: 
> $ perf record -g --call-graph dwarf,1024 --user-regs=AX,BX,CX -- matrix.gcc.g.O3

Right, i.e. if you don't use --user-regs, then a set of registers will
be asked for by --call-graph dwarf, right? If you use both and specify a
subset that doesn't have some of the asked for --call-graph dwarf, what
happens?

- Arnaldo
