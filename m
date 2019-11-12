Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551C8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF6F21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573545161;
	bh=u6gLfruMqKLOsUQoS20opa7nxM1dudDE2ea12xHBqFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oyVSaEyqK90dl+j/PUC+7k1FOopjts82OTrqS8rU7fDzqC2ogl1k6D940b8kxAaiq
	 rqfMkx+dIESHIQsI9v0CBFSLdseAFVyp443dlQS8lxPB3o281xin11dIoUJw9Xy/rf
	 09R9iwDL2glntNFDXYbfkrOplPCF4ljfIz9mC9pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKLHwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:52:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36659 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLHwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:52:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so17365757wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2l1fIr2PA713/NXOsGQIe62lfwFG6H7YuOp1UqF8AKg=;
        b=INhESf7eGo+xGfRbtWhEgLtmPIMFpPB1zTmECq85posfWatLYoiSy0/ZEEOah5vldT
         VdIIgevWXBMu7SK9FgBSVSgirNoypofo2kPmxOR+lDSvryo86b1o7Cby5X4TFjBvsnXv
         edshkWchbQbWWCaZa9HO+nUliwdeXVPWvg1R5PxYOptCYIL3P9ycywGFlgSqbXN/oLNf
         0cdNakPDCQEI/t0/V/DORKbmwix6I6QVq+lohPt/2xAzc5gpdtYGcZlfvM2KZDlFqfEJ
         SOgcKVFAteCWwxHj82lfafTH3by2pLAcNlvyoBx0LgB/LLwVr7kXOtGyo6Bg5So1xAJB
         792g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2l1fIr2PA713/NXOsGQIe62lfwFG6H7YuOp1UqF8AKg=;
        b=L0UTOhiFwoycQ7o3ljsHmLsGeW7XKkWGpZEt4qci4L7+LwkcHjqFn6fsSsUcAbpdEr
         7wwKM7F0Dg60FbXqk1vhhmeFdwNx6znp+Tu/olsicT6EDxeJmZhwdGdvdkAdcoMOub2C
         9ZCnmKdbEZ5cJiC1YrHyfT1kDwqmexqK0b4+TSJII6fRL/ToFb2BT64fA9CsQX4KyX0V
         ByxayxfytNfvMXvOvxW7xC3aRtzVhca45uge/0RzqXotKWlH11Slmfdy6g+lY+cFvKai
         DxHYTt3VN76n38wbRbQgIsUIQ9l8FvDVIGBDDqs0BNmdlhNvv2biic+WqHPvm9ZbdPyN
         HlRQ==
X-Gm-Message-State: APjAAAWGuL3LuA4rsCT0EqU7qdXFXM37wtpOvZ1KRE7Zp4OlVfib4MsV
        6s3SMHLKvTTym2QZRwa0ZII=
X-Google-Smtp-Source: APXvYqz1yCchfKKa1C4WjaPu/VDV4iJAKnxFx5DsKEkrdpDtxGz3uMojFv8spHS6N7Zz7X3haw4TjQ==
X-Received: by 2002:adf:d091:: with SMTP id y17mr25466161wrh.182.1573545157751;
        Mon, 11 Nov 2019 23:52:37 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w11sm14339335wra.83.2019.11.11.23.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 23:52:37 -0800 (PST)
Date:   Tue, 12 Nov 2019 08:52:35 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 11/16] x86/ioperm: Share I/O bitmap if identical
Message-ID: <20191112075235.GE100264@gmail.com>
References: <20191111220314.519933535@linutronix.de>
 <20191111223052.603030685@linutronix.de>
 <20191112071406.GC100264@gmail.com>
 <alpine.DEB.2.21.1911120816570.1833@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911120816570.1833@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 12 Nov 2019, Ingo Molnar wrote:
> > * Thomas Gleixner <tglx@linutronix.de> wrote:
> > > +void io_bitmap_share(struct task_struct *tsk)
> > > + {
> > > +	/*
> > > +	 * Take a refcount on current's bitmap. It can be used by
> > > +	 * both tasks as long as none of them changes the bitmap.
> > > +	 */
> > > +	refcount_inc(&current->thread.io_bitmap->refcnt);
> > > +	tsk->thread.io_bitmap = current->thread.io_bitmap;
> > > +	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
> > > +}
> > 
> > Ok, this is really neat. I suspect there might be some pathological cases 
> > on ancient NUMA systems with a really high NUMA factor and bad caching 
> > where this new sharing might regress performance, but I doubt this 
> > matters, as both the hardware and this software functionality is legacy.
> 
> Definitely.
> 
> > > +	/*
> > > +	 * If the bitmap is not shared, then nothing can take a refcount as
> > > +	 * current can obviously not fork at the same time. If it's shared
> > > +	 * duplicate it and drop the refcount on the original one.
> > > +	 */
> > > +	if (refcount_read(&iobm->refcnt) > 1) {
> > > +		iobm = kmemdup(iobm, sizeof(*iobm), GFP_KERNEL);
> > > +		if (!iobm)
> > > +			return -ENOMEM;
> > > +		io_bitmap_exit();
> > >  	}
> > >  
> > > +	/* Set the tasks io_bitmap pointer (might be the same) */
> > 
> > speling nit:
> 
> s/speling/spelling/ :)

Was a lame attempt at a self-depreciating joke ;-)

Thanks,

	Ingo
