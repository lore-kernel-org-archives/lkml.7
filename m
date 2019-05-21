Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BB4C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90C021743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBxldnqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfEUPTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:19:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43098 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfEUPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:19:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id i26so20875779qtr.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sWMC8cFNF9NAAGYCE/e0IaWpCRmXZGuoE47LOE7jw0c=;
        b=rBxldnqW042v/nsNwK4R1exHq9mUpoBxBpbew1lhjFnHl8WveODpC+urx9ymeaHloN
         fMyUKN0Y/FM6Nup9T1Hgl0sxOnXLT3icEOmceE/GbiRF4u3eGXwjGYGeXaS2btv21cOd
         3/FUBrDxi10o7P2Upk8QowxIQOjWaTnOk04m0lZsRc+0Qo+iqQ6oHPzJuZOjUWVre2tH
         4ZzIgK1cXFBiaGx7T7WKlYlMDkZvywjAQU7OYAvlQmCywCKgt2HhCEKUv/MjqfhL4h1F
         ViwVPe9h+gNvtfJ7z5PKEo9do1ijVb2LnMIzDg8VK3nxZX2bLV9eqIzTh7XlspvCnvrF
         nhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sWMC8cFNF9NAAGYCE/e0IaWpCRmXZGuoE47LOE7jw0c=;
        b=uPFYTZM45WREDISt+iCkKe/Ho0Qcrq6jQOJmFcmTFG1jvq63AjtrP9j2MV1tgBA0ng
         a9O/pnECv+SgOIPOZFuHGLuyR5B77+haaEqg4qH0pe4Jr3tb4I1E7qmoXwHGXUsFDzVS
         67tw+JCUgze1aOD/HA+uVnd4OV+CsnHpuL4i3RghqgDFM4Mz94QzgshlbJw64sJZYpxT
         Ho8lVJGeojhctSr3CbEMjZer7J6xfXs0aMIiQ/Q1p1LsP4HDSJbmxmd/sWeZoXKMLZcP
         ECCg2p6eutmYVLx/lV9PvrFg+2AFOYGgpxTA7PRGLsgFjCgOaVZMjfENE5vhlkPlROUA
         ZuFA==
X-Gm-Message-State: APjAAAVCkU+FqAdlZJEknFr1AKgbzAhDvdRbkTldJTG3Y6w6ora78AbR
        c24f+Zl18BtJe4icpJu4s0k=
X-Google-Smtp-Source: APXvYqwoycOORnzL9Bo74lb4jnqC8dfq3cdzCS6MLEXQ5iWANYs36MomhOjO/NAy3FAzm0A68b+AkQ==
X-Received: by 2002:a0c:ad46:: with SMTP id v6mr45747851qvc.82.1558451961776;
        Tue, 21 May 2019 08:19:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id e20sm9699565qkm.42.2019.05.21.08.19.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 08:19:20 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 93F2B404A1; Tue, 21 May 2019 12:19:18 -0300 (-03)
Date:   Tue, 21 May 2019 12:19:18 -0300
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl when system kernel headers
 are ahead of the kernel
Message-ID: <20190521151918.GD26253@kernel.org>
References: <20190521030203.1447-1-vt@altlinux.org>
 <20190521132838.GB26253@kernel.org>
 <alpine.LRH.2.20.1905211632300.4243@Diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1905211632300.4243@Diego>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 21, 2019 at 04:34:47PM +0200, Michael Petlan escreveu:
> On Tue, 21 May 2019, Arnaldo Carvalho de Melo wrote:
> > Em Tue, May 21, 2019 at 06:02:03AM +0300, Vitaly Chikunov escreveu:
> > > When a host system has kernel headers that are newer than a compiling
> > > kernel, mksyscalltbl fails with errors such as:
> > > 
> > >   <stdin>: In function 'main':
> > >   <stdin>:271:44: error: '__NR_kexec_file_load' undeclared (first use in this function)
> > >   <stdin>:271:44: note: each undeclared identifier is reported only once for each function it appears in
> > >   <stdin>:272:46: error: '__NR_pidfd_send_signal' undeclared (first use in this function)
> > >   <stdin>:273:43: error: '__NR_io_uring_setup' undeclared (first use in this function)
> > >   <stdin>:274:43: error: '__NR_io_uring_enter' undeclared (first use in this function)
> > >   <stdin>:275:46: error: '__NR_io_uring_register' undeclared (first use in this function)
> > >   tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: line 48: /tmp/create-table-xvUQdD: Permission denied
> > > 
> > > mksyscalltbl is compiled with default host includes, but run with
> > 
> > It shouldn't :-\ So with this you're making it use the ones shipped in
> > tools/include? Good, I'll test it, thanks!
> > 
> > - Arnaldo
> > 
> 
> I've hit the issue too, this patch fixes it for me.
> Tested.

Thanks, I'll add your Tested-by, appreciated.

- Arnaldo
