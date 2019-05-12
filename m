Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CBCC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 09:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20E820C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 09:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557653554;
	bh=A9FPuPbEFkA63xTwyfqCrbdeQRHVtnh4fb/H96OYbIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m0KPGpwSk2r0LoAzgs26sApbUxRQzfbz12ioOImgVhz2cx0E1oswcmlspwem2Ux39
	 c0LhhzD8b12rmI4rV+l4l8q93Z4nnWe1YRzE8vTD5IBR/GYOEG6t0PcefRqyoe2DpG
	 R0Uq8oHKPccQaC1fAGSrmjse7zrTs3XUiHBZ3A9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfELJcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 05:32:33 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:37093 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELJcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 05:32:33 -0400
Received: by mail-wm1-f47.google.com with SMTP id 7so4965897wmo.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LuTahM2E+qtgqrP6XO+831k4RT4K0I4EjD+Nn51aYmg=;
        b=qkU6VvVwpuHStHvTEWhaeasPPPlpNWms35Ye5X6DV68z/1RRvF4DsmTqFK+4GQZeN4
         c6UOWgB01nbE2ohPJDYyaCyZ3EiksqWmmnEBcjw7FxI/DEcxVJZniaI1HCQkhQWSBDrI
         4qSWUUO4TzJJYVIDYhIN5PAbFsoPllRXcsAfO9M8PbFwGCuildDMXFHMjQUjHrElgGn/
         Bi1kIlXIA6xgqG87Cgh1g2wvr/tAmFCXyHbNOhtGaP1x532pkqPIU5cVkcazKuz5PpX1
         GKRAPSHVOjKVf6yi18UthCrpNa6/7KR5gd4alkLm8R0GrMlJb6ynOjE8X83hGBlXDsNo
         v3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LuTahM2E+qtgqrP6XO+831k4RT4K0I4EjD+Nn51aYmg=;
        b=FlkMbDwXR/r32vKMi4YPGYojyrzocBVfILtcKSB58kkn8nkrpIFuqqi0hSd1B+VQAy
         dhploNfFJDUdOpEPXNxhH02zq3iiIkN41inqQyeC5bIcHDh0QzCggFSazzbvXfz1mY4y
         MpCGI2iDslFTzoqrr1zIMNqEdKWr6jIw3m4NQgX4kL2GQiBeLdjEMKW1y6nhA696po3Y
         lkGYIogZdkEeB2NNPsEvvtVzAFkgTALCEmFRP0B2JCvXAdrpWgePSMfabsczNxM8DCa+
         iIaG/WjOLSUKGGV0bXI7P63Ixvdd8hPOg0UqdMT9YkVoUSYcuxfoh5ygTDeZ4rhxDh9+
         SFpg==
X-Gm-Message-State: APjAAAUGsUPbyB7szxIC+6Ma1og8sN73kGizlWaJ8Zf95trcWzy5M2Ge
        AM8h0uaOu7gpXhx3yPymBX0=
X-Google-Smtp-Source: APXvYqxBDC9kuv/jzV4nX0J8rYav9JtK65J58QIwUt0JxxMYiw2+tSBnU+cSpt14c4BscyhST/E0lQ==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr12029389wmq.96.1557653551968;
        Sun, 12 May 2019 02:32:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f81sm16651wmf.10.2019.05.12.02.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 02:32:30 -0700 (PDT)
Date:   Sun, 12 May 2019 11:32:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: FYI -ffreestanding shrinks kernel by 2% on x86_64
Message-ID: <20190512093228.GA8088@gmail.com>
References: <20190511200223.GA14143@avx2>
 <20190511201344.GA11535@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511201344.GA11535@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Sat, May 11, 2019 at 11:02:24PM +0300, Alexey Dobriyan wrote:
> > I compiled current F29 kernel config on x86_64 (5.0.13-200.fc29.x86_64)
> > with -ffreestanding. The results are interesting :^):
> > 
> > 	add/remove: 30/22 grow/shrink: 1290/46867 up/down: 33658/-1778055 (-1744397)
> > 	Total: Before=83298859, After=81554462, chg -2.09% (!)
> > 
> > That's original config with modules compiled built-in.
> 
> Argh, it's the other way: adding -ffreestanding shrinks kernel by 2%.

This is a very interesting finding, as we've seen numerous code 
generation artifacts from GCC assuming libgcc things.

Has anyone investigated by any chance where the -ffreestanding space 
savings come from mostly - is it mostly in cold paths, or does it make or 
hot codepaths more efficient as well?

If it's the latter then the kernel would be directly faster as well 
(fewer instructions executed), not just indirectly from better cache 
packing, I suppse?

Thanks,

	Ingo
