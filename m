Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF65EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC1E2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576652319;
	bh=TTP4MSYPV9HdMlNGNkq5o649dYotCJRLzBCBA7CTh4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RlmuUiO/EbFNyR5MpTMux71qYRo3RjlFewftRNKuP0aySnCqFyhR0ka4Vv737udwW
	 N3yj8I1of9pj3Q7XDYs21waHaBvFYLbG7rPvZvK/6IUaLdc9vew5iqEmuRtluVswJ5
	 /vRbzwy6d4j9pcdGv6L40V2VF47HaapHWouvj+uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLRG6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 01:58:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36320 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfLRG6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 01:58:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so630382wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 22:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nD6NYo7+E7+s9UJGfhj8VxQoIuDfE8VeJc6SVPDBZ6Y=;
        b=VXP53WLV06g/bblATWXCQWNvKrkUxKacX6ujU3Q1lTUbQkE6ERJqINv8Sx/5jcMr3O
         lz+yeFlKa3AnJK+dVTBkJc+REKkXCt5CjYXyemMyaDPdvFgVObPoh2d0tsjCm+UcNgWh
         p2VDAL1hUMlVrfm4FsVZ/qBxum+kkMLbGaP2zL3TXlvmQuT6CVyaKj1U655xSbs7VP7W
         yFHceYQkcMYoxLEAc6B8ssrh1snUaOFL7xVTCLNRrUrjM9GXfq3Df+Krrm3HYm9+vatR
         xTx0MjCJe92gYJGr6oZcXa3gvADAAENyRZ3r4vpDt2tKO8b3IXSYK3OJk0DSLzkHKyiF
         IQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nD6NYo7+E7+s9UJGfhj8VxQoIuDfE8VeJc6SVPDBZ6Y=;
        b=RcJp/82K+KC21//h3M6+P3RAFGCQiIFtlg/BopZEwC0dd0GAuN9lNPU3Rf5rIvoIVT
         YT3fvMwYHeV1q0BLLyQD4qnCd6ozbR4MhjEh9wPSdBwmQ4FN7ex1fjwRCtiChA9lSCBn
         n43FIf85iR1nuSA7y3pXAo1hxgBtbqxfYUgu4sUg0EQ/q31LghqfSHpKVhv7vBBrjkMd
         5eYtdqxT3Cw+LJ6HSz56FZnw/nLmr3uzg2sH2JqlBnQbQT99iTfGhAUIXcra/dWUPvFW
         zOMQzMtrD0c+a8ErtZRokQEpjIRVy7ngnwxG7rpoVu/gXiXJ0GibW7N/XfK1+A+wdSdJ
         l4Xw==
X-Gm-Message-State: APjAAAV2JFThAHJEKV9yfpcMbCOigjgaJVR/pI6MzmTah8NaI2jj7/Kg
        2RIY8G2ERCuUojPJesekA0c=
X-Google-Smtp-Source: APXvYqwFtsf7ojOXfagMC9OwAZSEivKbIVph0va9XTBjGiMzu5oXQQ6zB+wvC+6+OLJ4umCdIgU6+g==
X-Received: by 2002:a1c:a745:: with SMTP id q66mr1168277wme.167.1576652316510;
        Tue, 17 Dec 2019 22:58:36 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d16sm1574638wrg.27.2019.12.17.22.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 22:58:35 -0800 (PST)
Date:   Wed, 18 Dec 2019 07:58:33 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] perf fixes
Message-ID: <20191218065833.GA35113@gmail.com>
References: <20191217113425.GA78787@gmail.com>
 <CAHk-=wgO0KzB-j8_1GAwkM68nLiWNsK6s1FBXKqKj_62VtDMMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgO0KzB-j8_1GAwkM68nLiWNsK6s1FBXKqKj_62VtDMMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Dec 17, 2019 at 3:34 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Note that the large CPU count related fixes go beyond regression fixes -
> > but the IPI-flood symptoms are severe enough that I think justifies their
> > inclusion. If it's too much we'll redo the branch.
> 
> I'm much less sensitive to the perf _tooling_ changes than I am to 
> actual kernel code changes.
> 
> Of course, if you start having a history of breaking things during the 
> rc kernels, that may change, but at least for now, I tend to look at 
> diffstats and go "oh, this is perf tooling", and not worry too much 
> about it...

Thanks for pulling these in any case!

	Ingo
