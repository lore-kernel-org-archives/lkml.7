Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F97C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CAD20842
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ristioja.ee header.i=@ristioja.ee header.b="qfeWJJPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfJCGp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:45:58 -0400
Received: from heh.ee ([213.35.143.160]:36254 "EHLO mx1.heh.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfJCGp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:45:58 -0400
Received: from [0.0.0.0] (unknown [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.heh.ee (Postfix) with ESMTPSA id 9479116D285;
        Thu,  3 Oct 2019 09:45:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ristioja.ee; s=mail;
        t=1570085155; bh=lo1ytOcDtHw2l+3dcU7fGcAyQaVo6i3tIMNGf9S8fnI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qfeWJJPzVyxQRpM7KEnuTiB4TNHfik16gyUY91NXyH3hViTA7orx+Y5FlNXFJumt2
         zBZmHcQl0BCENiK6lfOMLcVVezU2WLONRdW1DECWkq3csOga2Bk4Dw5n9PftXQv7px
         a7U8jB4VSsxY5Qy264mMZReKwLsD8HdGwLip91j4=
Subject: Re: [Spice-devel] Xorg indefinitely hangs in kernelspace
To:     Frediano Ziglio <fziglio@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Daniel Vetter <daniel@ffwll.ch>,
        spice-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
References: <92785039-0941-4626-610b-f4e3d9613069@ristioja.ee>
 <20190905071407.47iywqcqomizs3yr@sirius.home.kraxel.org>
 <e4b7d889-15f3-0c90-3b9f-d395344499c0@ristioja.ee>
 <ccafdbaf-7f8e-8616-5543-2a178bd63828@ristioja.ee>
 <1174991123.3693721.1569850187145.JavaMail.zimbra@redhat.com>
From:   Jaak Ristioja <jaak@ristioja.ee>
Openpgp: preference=signencrypt
Autocrypt: addr=jaak@ristioja.ee; prefer-encrypt=mutual; keydata=
 mDMEWyjlXBYJKwYBBAHaRw8BAQdABEPNmQfWmwZZXSl5vKnpI1UVtS4l2N9kv7KqyFYtfLe0
 IEphYWsgUmlzdGlvamEgPGphYWtAcmlzdGlvamEuZWU+iJYEExYIAD4WIQTjaPCMFhRItZ2p
 iV/uxscoTrbt3AUCWyjlXAIbIwUJA8OZNAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRDu
 xscoTrbt3OYPAP9l6ZjLh4qK2r/H1b+7a7qZIAjwf0o4AX6qvtX1WERxywEAhhtOHg+G8idL
 FR08XPW7nlobl2qEHMnqBTqteSsz1gG4OARbKOVcEgorBgEEAZdVAQUBAQdAU6y3a2gcxTI+
 bZgPkJjPXxr0tvuLpCqkIb/envF5ajADAQgHiH4EGBYIACYWIQTjaPCMFhRItZ2piV/uxsco
 Trbt3AUCWyjlXAIbDAUJA8OZNAAKCRDuxscoTrbt3OG5AP0cd6gLbKVSBvSEgRNQ+BNk/1a5
 lSQtocXAcwUx0X9h0gEAqIZ9u7pCWBlRTL+rij97VWWkB/jb1deZ2gExNhd6RAU=
Message-ID: <b902ffbf-9d25-89bc-2d46-d0a4f67dbee4@ristioja.ee>
Date:   Thu, 3 Oct 2019 09:45:55 +0300
User-Agent: undefined
MIME-Version: 1.0
In-Reply-To: <1174991123.3693721.1569850187145.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.09.19 16:29, Frediano Ziglio wrote:
>   Why didn't you update bug at https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1813620?
> I know it can seem tedious but would help tracking it.

I suppose the lack on centralized tracking and handling of Linux kernel
bugs is a delicate topic, so I don't want to rant much more on that.
Updating that bug would tedious and time-consuming indeed, which is why
I haven't done that. To be honest, I don't have enough time and motivation.

I would have posted a link to the upstream (kernel) bug tracker for
this, but being confined I only posted a link to my original e-mail on
the virtualization list Pipermail archive. Can you please provide a
better URL to a reasonably browsable index of this whole e-mail thread
in some web-based mailing list archive? Perhaps posting that to
Launchpad would suffice.


> It seems you are having this issue since quite some time and with
> multiple kernel versions.
> Are you still using Kubuntu? Maybe it happens more with KDE.
> From the Kernel log looks like a dead lock.

Yes, I'm using Kubuntu 19.04.


Best regards,
Jaak Ristioja
