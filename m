Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82264C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521E920656
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SZ2pNwsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfGFRka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 13:40:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:53103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfGFRk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 13:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562434828;
        bh=/n43sMCS1UDymFzdSKY66nWDBInrlzv3LBNGZxaKWus=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=SZ2pNwsxmqNwXvS3GmuaOlWNvyMCzx294SKSxicFe4oqQijMGXgMOWr23nppOw2OI
         YuYfIgOi7JyWYyOdkG8SLgz6t4UtkcJZ3XtPqvGKZZ+ojl8QB0gmsn4G6pJh3B9rCJ
         1tbO87RIbQQ8D10WQXkWzYxFiL9PPfap6xZiCxbI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.24] ([95.116.17.218]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1hwxqt36h6-00UrWy for
 <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 19:40:28 +0200
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: unusual high cswch/s spikes
Openpgp: preference=signencrypt
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <74b0c6c1-b8f7-2dfd-3037-409c8e2f5907@gmx.de>
Date:   Sat, 6 Jul 2019 19:40:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+G5ntZoPdx5gNebNXs3V/hC+b4ddAojGYt0IQ0ZpCcQCH777iRt
 zc07hhXk6vBmQfPEaTQPnYWRCt0BLgiW7WWSVJVljWrFIBL+wyFLAUh7IivldvDfLq4CW+r
 kO8yF0HU2QAnkMDav1gi1pZr4yxKoz/yqMNFbBH4wFSzy6dLLsHs87A6Vxuhb1oIxaMmJmK
 PUtKEjmo8IfrdA0NFatiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tqR8jccGURc=:z/8Fd68LYx3mIhRjkdXEaD
 n9eeStjm4aq+sE9lXF1ZD6CObXvOd9ixs32p5pvPFMIUSA5b6W0bT0GxODiGTEKUWVfeRleyo
 N7k1rBc8XAy05rP3mc0sVuiQRgzj+l94mKnoPzXQFgslE7Vh9ukpPoD3ooEHE7ytMJpn4yzjE
 Pwz9971IT3foQrMoEGbjee1VWaWvS6fjrKVOSvDOgGMRo6A7peg4c0+6LkUM7hHZGlxYHSDNc
 fMIWmLB0w2nkp7+x1n7QNBiCRi2v4r73lSOyTzMjAzCPPjPLMZwXVfnUU3bvJOFoXbP0uPLc6
 Apbdyp+TAEOj07pgrmVpHRN7bB/6C2d3Yby0foU/kK0RcFfTYzJbOXf1r9+W2n4PszUsNDz6V
 0nVrKwOkkEKdaNzQ8CTjWFjY4WGjrNpNSXKDi61kx84Pi783Jy0tHLPpJLLIHj0PHHxM9gRYB
 PF18ROCFfMiLpeOx6o8fEQ53+nxZ3zdOf1GDikL7Y3110UyGBFhSE8sZ9QKPzCGfgrEdChaki
 fo7AgcV3il6UA41C0yhPl88fwvagzx74k9hSbFOawaaWP864dqq3Wl1oNqlrbITMn2sshVoiA
 ySparu32efoMXnkfSIWK5xG9SgHdSVQYkaY3/FtlJTvTS82IZ2p6xrn7I/4udW/o3fq9CjMpQ
 Q8aSKzqlPX4x0hxuEGvgLHfLXr4fC0eyuhaDOcmABRkiqLiTa3SjrdgNia1yIWadUl/f5gBOp
 WPLzGdyk4VO49zG2ekTmAruQ4v1ssUQj2MClsFvbcFZoDpoT2/PXvEmLPEBCotqgYdsmJdr7/
 XsW9Dp/Y8HSI+VdJOh6fffmVjLdVBE1GzYe+EhKdA4VHgbjA9D9lu4UfvOt3aPYrzUN/WfU4Z
 0panhaY1nTfuhA4+fz/kqrargEkSag2BBltV1jGgEmC1+V0ZXvapI+lwv737/RqRhPbonwahG
 QgvzJ6inHU3vRD8Hlqd9ELYpcppJt+NoIJf+3dZYUOah0ZC/Z1LFzYZqNQ9zYyvVUAXavhNFn
 lL53R1D6WkG6EVUhpqKQ0+WWw7K/StzsisLbD282vsHKYjiSputFh/n6R5CzlYfF0KlzJs5pj
 hDPRGxDQEIRbHrkGt2J759WPdUWQgvyezk9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At a server (hardened stable Gentoo) I do usually do see values around 15,=
000 for that measure.
But 1 or 2 times per day that value gives a spike of 300,000 (or up to 1,5=
00,000) over a 1 minute or so.
I do wonder how I can drill down the root cause for those spikes?

=2D-
Toralf
PGP C4EACDDE 0076E94E

