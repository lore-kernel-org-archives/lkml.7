Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0256AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A242186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4ZzkTeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfCAG4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:56:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39584 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCAG4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:56:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id z84so11146814wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 22:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EnJpbJX/w2+VAaY+0Mw8fEugcfDzQ6872JX5Qhk7Qs4=;
        b=X4ZzkTeuLYXTQ5R2VsG6OaSfWrTUrST63QLVbfpyaZyhVBsZWNl+j6bBemzUaHwIRq
         PRPnVME/mKiFYyjutpnEM5Wlukw8vWBnD81MO8BsRpMIw5g7banx6ixYHpS0BEyF/jl2
         nCDwJtaQ6Y1TuipOxVHJXxdQE3hfobcOuzqxrrW5+d5Uo+0CzcziihIs7sQowHAuNBh/
         cSE2JseOoGHndA+oqKJ59Luk7lenu0gyvNhkVMfFI2Ler2kZK1iPQinJETsWchMoV0/5
         8+RLzW5baBaXxPYU7uxt2mFpfS5reKB1JXI9rPWxcOSpXwQGursQN8h6N1AOAODefaS2
         Ke/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EnJpbJX/w2+VAaY+0Mw8fEugcfDzQ6872JX5Qhk7Qs4=;
        b=RrDCTthYF8gJGHyBnJh0zm/wQ2k/i+67xwfkEqCsb3AEFHivMxdOrjIDDet5fa+zuK
         vssfSIiYYRI1ZAqz62BhgPxLJOMYNFGkUVpBB6cwg8tIn4Heaf7ypcss5K+LplquRO7V
         aKm7gWhPFZ135tkaI8/dEOFl7AjLTy3QTOVB/V67piOx3lwK+n77tXUpPmnXayk9d9Pp
         NwzBFwGXQd7vv/iIAXw+efdv4GPlVbclKLaPlQBq8x0P51sdkONeeRHJRsPTNxs+7hKJ
         UGHcxei7RpKAXnosgIZIycLQnNkAAeo6NQeuxIaiGMkXLKVRX8NW1iGfRFWjkQDaRipy
         +7MA==
X-Gm-Message-State: AHQUAuYeVoHUAu9EJ24PEudfOir0lHLRtMgJ2bhJdZRNRO7x2p7gXaui
        M4kQlVBsEvEPSBtXYQjpHw==
X-Google-Smtp-Source: AHgI3IYjQLp480/EaDIKB/qf+RHAFdcKetVFPvW1zDfPb5TlT/T5RHhZaDPaUsTBU/V4HWQ8w+Hv5Q==
X-Received: by 2002:a1c:4e09:: with SMTP id g9mr1977499wmh.56.1551423413407;
        Thu, 28 Feb 2019 22:56:53 -0800 (PST)
Received: from avx2 ([46.53.240.236])
        by smtp.gmail.com with ESMTPSA id k6sm29850497wrq.82.2019.02.28.22.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 22:56:52 -0800 (PST)
Date:   Fri, 1 Mar 2019 09:56:50 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wang.bo116@zte.com.cn, WangBo <wdjjwb@163.com>
Subject: Re: +
 include-linux-typesh-use-unsigned-int-instead-of-unsigned.patch added to -mm
 tree
Message-ID: <20190301065650.GA10954@avx2>
References: <20190228174109.MrWZN%akpm@linux-foundation.org>
 <20190228211126.GA28901@avx2>
 <CAK7LNAQv4giq5r4AKv4Ff1KP7k7US2Sdt=m1ZAXsDmKWKhZ9vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAQv4giq5r4AKv4Ff1KP7k7US2Sdt=m1ZAXsDmKWKhZ9vQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 09:13:27AM +0900, Masahiro Yamada wrote:
> On Fri, Mar 1, 2019 at 7:08 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > On Thu, Feb 28, 2019 at 09:41:09AM -0800, akpm@linux-foundation.org wrote:
> > > --- a/include/linux/types.h~include-linux-typesh-use-unsigned-int-instead-of-unsigned
> > > +++ a/include/linux/types.h
> > > @@ -155,9 +155,9 @@ typedef u64 dma_addr_t;
> > >  typedef u32 dma_addr_t;
> > >  #endif
> > >
> > > -typedef unsigned __bitwise gfp_t;
> > > -typedef unsigned __bitwise slab_flags_t;
> > > -typedef unsigned __bitwise fmode_t;
> > > +typedef unsigned int __bitwise gfp_t;
> > > +typedef unsigned int __bitwise slab_flags_t;
> > > +typedef unsigned int __bitwise fmode_t;
> >
> > I don't know if this is desireable. Switching to "unsigned" is better:
> > 1 less token and less 80 column pressure.
> 
> 
> 
> See the following commit.

Ah, checkpatch.pl, how could we live without it.
