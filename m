Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217E3C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978832184B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ristioja.ee header.i=@ristioja.ee header.b="CZYFfli/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbfIEMeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:34:08 -0400
Received: from heh.ee ([213.35.143.160]:54742 "EHLO mx1.heh.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731438AbfIEMeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:34:08 -0400
Received: from [0.0.0.0] (unknown [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.heh.ee (Postfix) with ESMTPSA id 05B9C16BF1F;
        Thu,  5 Sep 2019 15:34:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ristioja.ee; s=mail;
        t=1567686846; bh=LFJJB8HaRCeJflug32dzVDXPw+towLk1sQP9ogor7+A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CZYFfli/f+r3GSXDHeu3Xk/mw2JOlWDFAjueuJ5OXXzuOkPEPJjx9D1A+z4lMpy8D
         J/U25+xiF3ZhAWaiX3eM96x67vZyCbKsePG8cD3KV73LpOd9u0J+JVrcu5CJHELu+N
         mJZOXBW9G41Y1oS9e/R96a4REJ3a/4zI+PLlQa6E=
Subject: Re: Xorg indefinitely hangs in kernelspace
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <92785039-0941-4626-610b-f4e3d9613069@ristioja.ee>
 <20190905071407.47iywqcqomizs3yr@sirius.home.kraxel.org>
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
Message-ID: <e4b7d889-15f3-0c90-3b9f-d395344499c0@ristioja.ee>
Date:   Thu, 5 Sep 2019 15:34:12 +0300
User-Agent: undefined
MIME-Version: 1.0
In-Reply-To: <20190905071407.47iywqcqomizs3yr@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.19 10:14, Gerd Hoffmann wrote:
> On Tue, Aug 06, 2019 at 09:00:10PM +0300, Jaak Ristioja wrote:
>> Hello!
>>
>> I'm writing to report a crash in the QXL / DRM code in the Linux kernel.
>> I originally filed the issue on LaunchPad and more details can be found
>> there, although I doubt whether these details are useful.
> 
> Any change with kernel 5.3-rc7 ?

Didn't try. Did you change something? I could try, but I've done so
before and every time this bug manifests itself with MAJOR.MINOR-rc# I
get asked to try version MAJOR.(MINOR+1)-rc# so I guess I could as well
give up?

Alright, I'll install 5.3-rc7, but once more it might take some time for
this bug to expose itself.

One thing to note though, is that this occurred much more often with
older kernels (or older versions of the Kubuntu desktop/Firefox in my
VM), sometimes even several times in an hour of use.


Best regards,
J
