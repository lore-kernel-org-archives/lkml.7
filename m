Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A172C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81A3222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gandi.net header.i=@gandi.net header.b="XavZhSVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfIZKJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:09:06 -0400
Received: from mail12.gandi.net ([217.70.182.73]:54803 "EHLO gandi.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfIZKJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:09:05 -0400
X-Greylist: delayed 612 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2019 06:09:04 EDT
Received: from khany.gandi.net (unknown [IPv6:2001:4b98:beef:a:1c24:7b6c:715d:6eec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gandi.net (Postfix) with ESMTPSA id DC3821603CC;
        Thu, 26 Sep 2019 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gandi.net; s=20190808;
        t=1569491931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dTGHc4DsskK8sSXcRmGy4kEft1Z/kZC4Ol5LmTKdjlM=;
        b=XavZhSVyA2aNFWlLLsW2aWtp3Qi+ZvEIB3edDUw3bsdqdZWigjRgICinTIgwqVTCKUBlVF
        78MI7N6BAiIemMxMr77iHacnqczvPl3aQq7A9EWrAroVHAYWB/qPPCF+1fgQoBlDOSqIVk
        3dESRW7FZZO9EhEequSHY/MUX5gyPztI+ySXGxoanMB1dOqLHtXWCk62QxmUNdcugXhvVq
        BrJh/TgzUDazmcAM3pT0KtdNz3oskWtb1MV4yMvnFhXCn3Yp8zYpADT01HRsdmE1KAq7eH
        CziudHweoD+vCZRRyEM03drsF1I5JhIQ5m8yqd1/Do4Og9QyoFwznX6ttKbhBw==
Received: by khany.gandi.net (Postfix, from userid 1000)
        id 59355DC0480; Thu, 26 Sep 2019 09:58:25 +0000 (GMT)
Date:   Thu, 26 Sep 2019 09:58:25 +0000
From:   Arthur Gautier <baloo@gandi.net>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
Message-ID: <20190926095825.zkdpya55yjusvv4g@khany>
References: <20190215235901.23541-1-baloo@gandi.net>
 <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com>
 <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de>
 <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
 <20190216234702.GP2217@ZenIV.linux.org.uk>
 <20190217034121.bs3q3sgevexmdt3d@khany>
 <20190217042201.GU2217@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de>
 <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
 <20190218215150.xklqbfckwmbtdm3t@khany>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218215150.xklqbfckwmbtdm3t@khany>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 09:51:50PM +0000, Arthur Gautier wrote:
> On Mon, Feb 18, 2019 at 11:15:44AM -0800, Andy Lutomirski wrote:
> > This seems like it's just papering over the underlying problem: with
> > Jann's new checks in place, strncpy_from_user() is simply buggy.  Does
> > the patch below look decent?  It's only compile-tested, but it's
> > conceptually straightforward.  I was hoping I could get rid of the
> > check-maximum-address stuff, but it's needed for architectures where
> > the user range is adjacent to the kernel range (i.e. not x86_64).
> 
> I'm unable to trigger the BUG I had with my initramfs with this patch
> applied. Thanks!
> 

Hello All,

Just a followup on this issue, I'm still able to reproduce the original
issue with:
    truncate -s 8388313 a
    SECONDFILENAME=bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
    truncate -s 10 $SECONDFILENAME
    echo "a\n$SECONDFILENAME" | cpio -o --format=newc | lz4 -l > initrd.img.lz4

I think Andy submitted a patch Feb 25 2019, but I was not copied on it
(I believe it was sent to x86@kernel.org) and I don't know which fate it
had.

Any chance we could have a look again?

Thanks a lot!

-- 
\o/ Arthur
 G  Gandi.net
