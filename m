Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D770CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588DA2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Dnqw8eUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbfJVImP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:42:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41636 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388436AbfJVImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:42:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so17020874wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CCoUEx7pgvSwkd52sbHiDWqhbn6D15dx3IidcUSOlCs=;
        b=Dnqw8eUlpREisKkdtKQIU3R7AtWD+I7KGdKQt39MsbLsH6Qoc355nKrI0tHLiqB3NG
         /Y4Dn9+GMLBCqAfugauXi/usjnov8QawMPImXtU3CjjRKa7jMHE2ZeArfrFGVHD/rFE1
         xT/hLokfxu1BCgHKdBRBCGLOgTZF0se9W2/2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=CCoUEx7pgvSwkd52sbHiDWqhbn6D15dx3IidcUSOlCs=;
        b=V5uM5YKLZEPicxCrexD/VYpVv8sOMe2OEKp//0dwAC6Xwy57kNn5cG1OgAHJ6NX2Qf
         J9w2JkANfYkS/vxHYfITgk9AeNfm0eO15rZeiL25j1WG2xNPEysLtqdmD9EDNDzEpXRt
         2ATL9QDkM6Utev1PijEo37hlb9OSCbwEL7gWFqY0fEF+JSPiP/ZKaFOGFjZu6Z7SaWhm
         /ieSyNiaviW5nL62D2GApWEVzzx9QmeDYdol2zjRDPGgp/oX0uIkwVU16SR6lxMjUCzr
         HWtotQF/yimVxdaQaKE1hizRxwMQYUiqBsPEkDDttdfByxUPKvv4LvUQV1NAwWqPd22H
         w5cg==
X-Gm-Message-State: APjAAAWzWQD94apRs0YuvamKtm1YJjlS3BzGWgiTATvsZn4PoCuToWpb
        fcpDVeMSaxxt8f0aF78wOuHcpw==
X-Google-Smtp-Source: APXvYqysKcOFImNh7q+xLEnI5+oG8yvXGOPWq0yok1GRmNS4PwSgal7nZQXzjWKsbnuYzK3jXSOCnw==
X-Received: by 2002:adf:c409:: with SMTP id v9mr2344929wrf.41.1571733732870;
        Tue, 22 Oct 2019 01:42:12 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id d4sm24692928wrc.54.2019.10.22.01.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:42:12 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:42:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Message-ID: <20191022084210.GX11828@phenom.ffwll.local>
Mail-Followup-To: Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        David Airlie <airlied@linux.ie>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Sean Paul <sean@poorly.run>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191009055407.GA3082@jamwan02-TSP300>
 <5390495.Gzyn2rW8Nj@e123338-lin>
 <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191017030752.GA3109@jamwan02-TSP300>
 <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
 <20191017102055.GA8308@jamwan02-TSP300>
 <20191017104812.6qpuzoh5bx5i2y3m@DESKTOP-E1NTVVP.localdomain>
 <20191017114137.GC25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017114137.GC25745@shell.armlinux.org.uk>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:41:37PM +0100, Russell King - ARM Linux admin wrote:
> On Thu, Oct 17, 2019 at 10:48:12AM +0000, Brian Starkey wrote:
> > On Thu, Oct 17, 2019 at 10:21:03AM +0000, james qian wang (Arm Technology China) wrote:
> > > On Thu, Oct 17, 2019 at 08:20:56AM +0000, Brian Starkey wrote:
> > > > On Thu, Oct 17, 2019 at 03:07:59AM +0000, james qian wang (Arm Technology China) wrote:
> > > > > On Wed, Oct 16, 2019 at 04:22:07PM +0000, Brian Starkey wrote:
> > > > > > 
> > > > > > If James is strongly against merging this, maybe we just swap
> > > > > > wholesale to bridge? But for me, the pragmatic approach would be this
> > > > > > stop-gap.
> > > > > >
> > > > > 
> > > > > This is a good idea, and I vote +ULONG_MAX :)
> > > > > 
> > > > > and I also checked tda998x driver, it supports bridge. so swap the
> > > > > wholesale to brige is perfect. :)
> > > > > 
> > > > 
> > > > Well, as Mihail wrote, it's definitely not perfect.
> > > > 
> > > > Today, if you rmmod tda998x with the DPU driver still loaded,
> > > > everything will be unbound gracefully.
> > > > 
> > > > If we swap to bridge, then rmmod'ing tda998x (or any other bridge
> > > > driver the DPU is using) with the DPU driver still loaded will result
> > > > in a crash.
> > > 
> > > I haven't read the bridge code, but seems this is a bug of drm_bridge,
> > > since if the bridge is still in using by others, the rmmod should fail
> > > 
> > 
> > Correct, but there's no fix for that today. You can also take a look
> > at the thread linked from Mihail's cover letter.
> > 
> > > And personally opinion, if the bridge doesn't handle the dependence.
> > > for us:
> > > 
> > > - add such support to bridge
> > 
> > That would certainly be helpful. I don't know if there's consensus on
> > how to do that.
> > 
> > >   or
> > > - just do the insmod/rmmod in correct order.
> > > 
> > > > So, there really are proper benefits to sticking with the component
> > > > code for tda998x, which is why I'd like to understand why you're so
> > > > against this patch?
> > > >
> > > 
> > > This change handles two different connectors in komeda internally, compare
> > > with one interface, it increases the complexity, more risk of bug and more
> > > cost of maintainance.
> > > 
> > 
> > Well, it's only about how to bind the drivers - two different methods
> > of binding, not two different connectors. I would argue that carrying
> > our out-of-tree patches to support both platforms is a larger
> > maintenance burden.
> > 
> > Honestly this looks like a win-win to me. We get the superior approach
> > when its supported, and still get to support bridges which are more
> > common.
> > 
> > As/when improvements are made to the bridge code we can remove the
> > component bits and not lose anything.
> 
> There was an idea a while back about using the device links code to
> solve the bridge issue - but at the time the device links code wasn't
> up to the job.  I think that's been resolved now, but I haven't been
> able to confirm it.  I did propose some patches for bridge at the
> time but they probably need updating.

I think the only patches that existed where for panel, and we only
discussed the bridge case. At least I can only find patches for panel,not
bridge, but might be missing something.

Either way I think device core is fixed now, so would be really great if
someone can give this another stab, and make drm_bridge/panel easier to
use without fireworks on unload.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
