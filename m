Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0401C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1C9207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="b+yEa/Pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfDBJLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:11:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:48991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbfDBJLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554196290;
        bh=JXV05BtGM2b7bgtXYX9LbOjX21P9UoBPCDJsZCcRJFg=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=b+yEa/Pze0ylVg/pFqcNnboNFYRdYi/yJeCoKoXjIAbfDfB5ttaZkUhNuUVUOtV3b
         FwVuZyUhxKcTzfM4xwD6wYNj1vC63lTnatQpakkUISlWSbim3Hd3iSHLOi1A9m9IBW
         QUJzyUa5gTOpMxZvmdyMEeqXVbgU1gW8FwC1kkRI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.21.100] ([84.185.36.11]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIMUZ-1hDixh13Kp-004Cgn for
 <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 11:11:30 +0200
To:     linux-kernel@vger.kernel.org
From:   f h <haro41@gmx.de>
Subject: Re: [PATCH 1/3] drivers: hid: fix G940 axis/button mappings
Message-ID: <62bf40ca-3bf2-6e36-c54f-fab0eb62a1dc@gmx.de>
Date:   Tue, 2 Apr 2019 11:11:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PKpK2fD3OSnU0J4VLLL0kcmGLuMa/h56KlH9Mdzun8GYSnt5ktp
 vtciNd/WS2Zzwf8TQNjBzVWbFJJx7uYX2R5oKxk/+SU0YhxQt5UEO1X7wTmcD7X6mZl8m4i
 zhor29s3kNiQSxNwvDnkkPLOVx2mHmTLQk0fAmjwtb1OZqpwV2dl3xi1o96zMseBORk4LQX
 SOQ9bSjA3uLeRqgmSW2hQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iemgL50FK2Q=:bxnscaVUlt02avxsfXrz/k
 iVRnmrGCwvK4E65lBkrBAsXeu7dVkKyMvRG6eW6iii4KBwg/qXv8r64w7e7FTiIpXG126ZxAR
 wBAndsH1g59uCZ/ACtBB5NJ4y3xwmbdvttyS2XvGBj7jl0TBuEBJjWbcSzRzQ70RVJyoASpzc
 DmzTsq2PYGivYAywvxMGwSma273OypIlY7EhBfEogjGvixlNZDGkHtW0o8XRpLteqmWcc2pCe
 0hDDXI/nS282SGnZivxbcFeR3LBQM0/U0pjcB2KjcKT93PuJjN3g8mF+/xi9qi6k4DZKy0aHJ
 VLhNivHrId1Pdfui4caxunVXhy+69PxY8heNc9Uk8q6tnIN5J80l6XWk2+zkYOGZzJTlpMTAr
 /nrZdJfUtWYF3Nm0GNJNvHtacStP/+qdJfs3LF+oFDK4dXUemGfHjKBg7jd29VPvnGbbgDi6o
 cTdYYk3nnJMxHqw+SqOk8FcM5qw9+HNtxKjUPpzPhrtPCgryO/zMJ3OhuSEjg001DYSvYym8s
 g8/NLANaDNfJwp/F1E7h8YvWl/9lK6KQPrVJZvvaedqASlQOWyUBY1YEz3uxTTAgwwJzIaBJ5
 TLhy5dt+nuLyuAx6czBAJVyCe7PIBlbXsDnCujNL1PIi+raldSXidqNPeCewyNTzQAzJ8y7tm
 vQAHVGvGh69R5U9uevRW85jyOsYV6u2i8QE2ck++8FYaUsmk86q6rz6BDYWUyET8f+8KZFzUX
 9Pi9rvJL/ejlA031TBCM7JcPE6+kOitMHmj2RixaYWfrZQYLOX5qVigfR9zhbs5HqbQ57f4BO
 IcP+5PmW6tYYPREZ5jrJPvLo6ZF3ZZaFL3EQ0nwVKUkAtsl8SojlUChd7EQ9rmNAgzowf0UkO
 4eUTz2Tl/IIk2OyQ1hrU/MetPz06ZdHvu2tWDTfOMElzgp7334IL1IcJc3AIaf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019, Chris Boyle wrote:

 > Provide a complete map of axes and buttons for the Logitech Flight Syst=
em
 > G940, which fixes several issues:
 >
 > Stop conflating the stick X/Y axes with the mini-stick (hat) axes. This
 > stops reported X jumping between stick X and hat X (likewise Y).
 >
 > Stop conflating the other three hat switches (non-mini-stick) with each
 > other. This was caused by commit 190d7f02ce8e ("HID: input: do not
 > increment usages when a duplicate is found")
 >
 > Report TRIM1 and TRIM2, previously ignored as unrecognised usage types.
 >
 > Report the MODE switch and hand sensor, previously ignored as they're i=
n
 > a vendor page.
 >
 > Signed-off-by: Chris Boyle <chris@xxxxxxxxxx>
 > ---


I have to confirm, that the current kernel driver for logitech G940 is
deficient (as desribed by the author of this patches).

I tested this patch series against latest stable kernel (5.0.5, debian
testing) and it fixes all former input related issues.

Regards,
Jens

