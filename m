Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E3ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B5B21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570456532;
	bh=4cuvAa1Z5X4LNHvZg2iPIROwFWInQSyg6yraKon+aNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zXrVjU6C+pxbYEyuhE9RrAQg3eMIkSBEZkWnj2pw+njZ7X/f5lI0vLlwattTBbuQ4
	 LVurum2espU5C81ja1glb1N3yZFuK/b8sR/6XepPpGAriBiePrLdQMxdWURYzw1Fhk
	 1RIHJGggYw2gcjleB2IL8Vn0TSgTCWgmsP1zRtkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfJGNzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:55:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34353 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfJGNzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:55:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id j11so9648061wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nX2WmJNYQbkql4NfD2u3lVA+v/9Gn5nArZELCqeq/d4=;
        b=YroiitgRO4tNgcR2NQYIOturxR5FQKsj1j3yq0J01z6MeOrxs8xoVpUY/7o5WiIk2I
         iY+wCf4jDxiEeiVocpv8p339BM3mw9sRs4eFc2cKTKAVB1yJdkocg7+a3B9Jm3T2z8Dp
         k5fuq8Zt74O4P+QIDw8mogv2O6vJAtJCsC1jXgq5maw6joj7yk+2wpmCt50LQ1oyHmKo
         +u1jR8PDgu0fVBWcPknuA9DxMlPoGi8TZMw+AR1/wnX/sfovKZiqJumuqNRoBX9GrylZ
         YTwVHPocsQuVhp4dNUTNub7/bx1l2cVCFrpmIAaA/Mj+z9Ys1v5YBDD+ecZL+euSUKwn
         iHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nX2WmJNYQbkql4NfD2u3lVA+v/9Gn5nArZELCqeq/d4=;
        b=ihwA3xERCZ7Yfcl4PxwMqs9DUcRhi24vebm7ng2PaW/BMAyBX86wt/7JgHi3a7TN6F
         Hj4VPBNrnjm+lKAg6ItJ8ZRtHwLx/mpO7i6/Vpns1aMslDvEXc1Y12xFXgE5ivBrziJt
         +wDayk/D2BJnYKsScI/eZZHBYPooWrD0DNQc08JVLcOVtpHPuAiR3nSCvBv7vvA2kACT
         M2kBUkN//pc6OLaY3jbkY/iG03BrPMFw1Bgm9lpBWItr8ohtwZnOaO+odhd6eUM2zeD2
         Dsq0P/3oXcd1VXMO6sD/q/xuo2iJzoKQZqxftDXLxGu5jujANpqS4BZZJAK/CPl46HyT
         FLgw==
X-Gm-Message-State: APjAAAVCiwUDc26cM8GFdPqeZyfoFCZYuaoQWsQMJGXtT9inuWx7grhp
        AOFR+WR86Zxgvv2p0TG5myM=
X-Google-Smtp-Source: APXvYqyWn4+Ok1zOKq2PAzzEpbYQToRt43xloRUHrn/c97AwMviURt5/n2M6yOJkpDzRmmAuN7+1xg==
X-Received: by 2002:adf:ec09:: with SMTP id x9mr23812866wrn.308.1570456529410;
        Mon, 07 Oct 2019 06:55:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g11sm16138156wmh.45.2019.10.07.06.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:55:28 -0700 (PDT)
Date:   Mon, 7 Oct 2019 15:55:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kexec breaks with 5.4 due to memzero_explicit
Message-ID: <20191007135526.GA10253@gmail.com>
References: <20191007030939.GB5270@rani.riverdale.lan>
 <28f3d204-47a2-8b4f-f6a7-11d73c2d87c8@redhat.com>
 <0f083019-61e8-7ed5-dde7-99e1aa363d9c@redhat.com>
 <20191007130942.GA82950@gmail.com>
 <cf44ec0d-33d5-1577-40ad-0d4acbac7e8b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf44ec0d-33d5-1577-40ad-0d4acbac7e8b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 07-10-2019 15:09, Ingo Molnar wrote:
> > 
> > * Hans de Goede <hdegoede@redhat.com> wrote:
> > 
> > > Hi,
> > > 
> > > On 07-10-2019 10:50, Hans de Goede wrote:
> > > > Hi,
> > > > 
> > > > On 07-10-2019 05:09, Arvind Sankar wrote:
> > > > > Hi, arch/x86/purgatory/purgatory.ro has an undefined symbol
> > > > > memzero_explicit. This has come from commit 906a4bb97f5d ("crypto:
> > > > > sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
> > > > > according to git bisect.
> > > > 
> > > > Hmm, it (obviously) does build for me and using kexec still also works
> > > > for me.
> > > > 
> > > > But it seems that you are right and that this should not build, weird.
> > > 
> > > Ok, I understand now, it seems that the kernel will happily build with
> > > undefined symbols in the purgatory and my kexec testing did not hit
> > > the sha256 check path (*) so it did not crash. I can reproduce this before my patch:
> > > 
> > > [hans@shalem linux]$ ld arch/x86/purgatory/purgatory.ro
> > > ld: warning: cannot find entry symbol _start; defaulting to 0000000000401000
> > > ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
> > > sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
> > 
> > I've applied your fix,
> 
> Thank you, unfortunately I was just minutes away from sending a v2
> which adds a missing barrier call (not strictly necessary, more future
> proofing).
> 
> Hopefully you can still pick up v2 instead, let me know if you want
> an incremental patch instead.

Yeah, our mails crossed: I noticed that and didn't push out your fix, so 
all should be good. Take your time.

Thanks,

	Ingo
