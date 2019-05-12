Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE291C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA4420C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf+UKWxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfELR4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:56:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36649 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfELR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:56:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so11570546wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gyfaOU+RLkJUHaoaPmeqsA/Kgr0raXRSWBNZ4c2jFPg=;
        b=hf+UKWxMT2pJh0EcyBKFCl9KZ34LK6b4xHvfegpzSXzOweoD067I0hJZpg0FpvrLus
         otQ1fZK9bH85Y/MT52PesKI493W/jI99Y6ehzLn5g0rLH0Cgz4y1/1XTGmqi2REHenG4
         WrQtnbmzmLZGvn3JWXuN4YdvK70WjqQU8kvVTmliLGaTaggVJfuYJuO+fTvxpUM8JSLt
         e2GC4F0rRm6PmDzzgvel4zIqeC2ceIxKwo4BfChVc0BvBCaI8rAiPAjovD5/ofM8GM24
         558RhS2qL44PhPT8uJz3Ph43QyIS32cnFWBtMeqKQqL2kzZJ17zjWhcOo60VWPMVChkv
         EkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gyfaOU+RLkJUHaoaPmeqsA/Kgr0raXRSWBNZ4c2jFPg=;
        b=iAUDjB57P9NmYDF2mAcF8bl1qHMuOT7VXienwzLpwdQE5jnRlKgIYRInELtFTbu1qK
         OLdyRl+qCe0cuuVtT28puBVyyMoHc0xqaHceC6dmjsysj8w1ZzCB5+OZ2KUcoZQV4B1z
         mus4Ete8616vG8Ga8yr71u0L589pGBfeS01d8kVrqjDXIzF9TvFuLCBQH6J3YdXRFrmq
         shfb1vgpbj77PsZNaAo/f/Wr8UPAkBpkFAbXjulghUVBr0FqeTg4vAON5YBLh5sffbSE
         fxwd706EjoQZLqKk7UnJu2S6ijBpB/JnozmjQmn6AVjbuxArBfO6nWngpZGPf8L9tsaz
         ZzIw==
X-Gm-Message-State: APjAAAWvG9uJu2M+lAPL6qK82hpQRdDwGnz8kbTbUXXszUPRy3o8QYpT
        RumDcTTyty2JU2sh4K0Quw==
X-Google-Smtp-Source: APXvYqwUQDzS89IfGmFyMQB4tHQ5yaug5im3059aPpTvt7wIj2bKmtnAt0OL/gXN8cEEoMCbLIHy6w==
X-Received: by 2002:a1c:c1c8:: with SMTP id r191mr11463298wmf.99.1557683757685;
        Sun, 12 May 2019 10:55:57 -0700 (PDT)
Received: from avx2 ([46.53.251.158])
        by smtp.gmail.com with ESMTPSA id v18sm7833610wro.11.2019.05.12.10.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:55:56 -0700 (PDT)
Date:   Sun, 12 May 2019 20:55:54 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: FYI -ffreestanding shrinks kernel by 2% on x86_64
Message-ID: <20190512175554.GA10777@avx2>
References: <20190511200223.GA14143@avx2>
 <20190511201344.GA11535@avx2>
 <20190512093228.GA8088@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190512093228.GA8088@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 11:32:28AM +0200, Ingo Molnar wrote:
> 
> * Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > On Sat, May 11, 2019 at 11:02:24PM +0300, Alexey Dobriyan wrote:
> > > I compiled current F29 kernel config on x86_64 (5.0.13-200.fc29.x86_64)
> > > with -ffreestanding. The results are interesting :^):
> > > 
> > > 	add/remove: 30/22 grow/shrink: 1290/46867 up/down: 33658/-1778055 (-1744397)
> > > 	Total: Before=83298859, After=81554462, chg -2.09% (!)
> > > 
> > > That's original config with modules compiled built-in.
> > 
> > Argh, it's the other way: adding -ffreestanding shrinks kernel by 2%.
> 
> This is a very interesting finding, as we've seen numerous code 
> generation artifacts from GCC assuming libgcc things.
> 
> Has anyone investigated by any chance where the -ffreestanding space 
> savings come from mostly - is it mostly in cold paths, or does it make or 
> hot codepaths more efficient as well?
> 
> If it's the latter then the kernel would be directly faster as well 
> (fewer instructions executed), not just indirectly from better cache 
> packing, I suppse?

Turns out -ffreestanding completely disables stack protector :-\

F29				83298859
-ffreestanding			-1744397	-2.09%
STACKPROTECTOR_STRONG=n		-1369949	-1.64%

Builtin function are in noise, e.g -fno-builtin-sprintf is only -14KB.
