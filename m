Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2619CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EAB20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557259955;
	bh=Q/Pa5RQyUw8RrpVmXL6HpFhiR2izecY1Jg40FKXk8oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=woRA3C/CsIVJhkSR1nPCNB0/Vll350LCDw6T6o1G8LTnmhi+DmCJYtpuGFtaZyMfG
	 ZUdMJ4iJ8HFC5mRjjiKeAFJqJPt0DYBuTc9lSHGofbFXChlgWSdxJa50rn+fOKhGpb
	 y7bx4bRF3bGbirTa3TYemcTiA5CttN1aRSABJwSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfEGUMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:12:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46720 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfEGUMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:12:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so23992224wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CBkOv+ce8TiYMk3pib+kXIOea4gkb4ImRsb0MHpqjWs=;
        b=NyvaIl5pORYknWMYoDaA26V+iLvitZIQBJPJrXkOF8Yz7+iDcFjn0i9z0eEkOceRvO
         fJOHGtcvuLdlmPec8Le55k1zopbxeRUwxDQW5FQlzLrK73/0Z/yZQn4c0b06ApOmj0Vv
         n+DUKylm/sA9ryF8xK9QR94qtc0PghxrYyfAlmU0fSaddUWaElnI0kxr+8r8ntshcwOP
         7HWZeRjV4tGRqciYgYbAkVe+OzT8UeURhOrsVdH9ANBcD4T+1fmJGQgB+TegoBxlX0LV
         DYrbCAXWitTBvXFen1DpnC/zilK06JeNfN0Rev/vPpACT1N07MiIKvlNMgJZL7y0ci32
         yFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CBkOv+ce8TiYMk3pib+kXIOea4gkb4ImRsb0MHpqjWs=;
        b=HQeDE/cEc7Uvd/rFj/RU7oestUQ3THdM3gO2SEy/h9XWiItUQCH081k3zUw9vz0/K9
         Qj7mFjM2zmJe8n6rYXA/XVD7cubKsIY430SMBv+91fNtU1TUzTQaN8MuBznVqDvCv453
         wUAG2YEc9WbTRT2WKWJPLLI8zM8tBGhFMXa3qbzvUPE7oNemg19m9OKVmOGgm5rJH/R6
         wHZw9lqVlZPxgTd6JDxJVQVsQO0tHd6+kbUSIgZ4AA6MRuUGQbRI9mpqaF3gzxXIrU/X
         LBcyFFJryBvafk6bQoOdjPDe8VL858SfPOYXWbNMrYzGj8VcTwRx+wUNfFTZYYHiyI2p
         zf4w==
X-Gm-Message-State: APjAAAVu9DdznjcR1GTS1Ze1W+YRAHi6MWbRNanZShHFJeiZpqw58kZH
        Z9H6WWto4B8+lWCNExyXYxU=
X-Google-Smtp-Source: APXvYqxyLsvq3utlweseufzwfd/RdJjGI36f3hrb4KGXGV/FLeXbjWFe5B/66MkBFOxxbHZfEdHZuQ==
X-Received: by 2002:adf:df88:: with SMTP id z8mr23289944wrl.209.1557259950776;
        Tue, 07 May 2019 13:12:30 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g185sm43692wmf.30.2019.05.07.13.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 13:12:30 -0700 (PDT)
Date:   Tue, 7 May 2019 22:12:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>, Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86 FPU changes for 5.2
Message-ID: <20190507201228.GA64489@gmail.com>
References: <20190507132632.GB26655@zn.tnic>
 <CAHk-=wh4Cjb1qDj_VRW9W4d4n9WLksgMKF-roG8eCk_O0ZaEEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh4Cjb1qDj_VRW9W4d4n9WLksgMKF-roG8eCk_O0ZaEEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, May 7, 2019 at 6:26 AM Borislav Petkov <bp@suse.de> wrote:
> >
> > This branch contains work started by Rik van Riel and brought to 
> > fruition by Sebastian Andrzej Siewior with the main goal to optimize 
> > when to load FPU registers: only when returning to userspace and not 
> > on every context switch (while the task remains in the kernel).
> 
> I love this and we should have done it long ago, but I also worry that 
> every time we've messed with the FP state, we've had interesting bugs. 
> Which is obviously why we didn't do this long ago.
> 
> Has this gone through lots of testing, particularly with things like FP 
> signal handling and old machines that don't necessarily have anything 
> but the most basic FP state (ie Pentium class etc)?
> 
> I've pulled it, but I'd still like to feel safer about it 
> after-the-fact ;)

Most of the x86/fpu commits except the final one are several weeks old, 
but I have to admit that our old-systems testing is hit and miss, and FPU 
bugs do tend to have an additional 'bug report latency' multipier of a 
factor of 3 or so ...

I've been running all this (modulo the final commit) on my primary 
desktop and other systems as well, FWIIW.

Thanks,

	Ingo
