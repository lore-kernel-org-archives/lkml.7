Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7B420883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qAPVPvYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDAMEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:04:11 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34114 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfDAMEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:04:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190401120409euoutp028fb3d76c95107498ee16313890a26bd7~RWCH4Izag1585215852euoutp02e
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 12:04:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190401120409euoutp028fb3d76c95107498ee16313890a26bd7~RWCH4Izag1585215852euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554120249;
        bh=LxtegCOtH4r5Z5D9tUIWf/cS9tqpuytPJ8jdh2bo+Tk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qAPVPvYemr+ShO8LTWJD+wwh2ty9hjkVeM/GN96unk33/Irj1Duz9leOLqNQyCqSC
         TnjdFioFnglTCPWAB6fq4t2Zq0VgnEVjYNQCqkm2PRs4G1aeogAajC+bbHDYxHGL0f
         GL9s4CzCyx2/WRLiXbKlZVeS1A+U2f28X7e2lfP4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401120408eucas1p2ebcc1e87ff51e23e95b8ec65b931ce8a~RWCHSl2QW1820618206eucas1p2l;
        Mon,  1 Apr 2019 12:04:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 57.31.04298.83EF1AC5; Mon,  1
        Apr 2019 13:04:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190401120407eucas1p1ed00d5715c2db886a8c5724d3c1472c1~RWCGjhIka1978419784eucas1p1c;
        Mon,  1 Apr 2019 12:04:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190401120407eusmtrp2bcfcaebece528a9de0fdc2a5e9b84e38~RWCGViCmp2054720547eusmtrp2g;
        Mon,  1 Apr 2019 12:04:07 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-bb-5ca1fe38fa3b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 50.1A.04146.73EF1AC5; Mon,  1
        Apr 2019 13:04:07 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190401120407eusmtip20d56fc4157d99f8ce14fb4c59f013f5c~RWCF4TPjj2113821138eusmtip2b;
        Mon,  1 Apr 2019 12:04:07 +0000 (GMT)
Subject: Re: [PATCH] video/macfb: Call fb_invert_cmaps()
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <eaaa9e82-8194-17c3-6106-16a34a36a194@samsung.com>
Date:   Mon, 1 Apr 2019 14:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <80cf1394f099ced17bd5075be88cf33c1232086a.1550445927.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7oW/xbGGJxtFLe48vU9m8XE3qUs
        Fif6PrBaXN41h81i+ZO1zA6sHve7jzN5nGz9xuLx7OBDVo/Pm+QCWKK4bFJSczLLUov07RK4
        Mn7Ne8tc8Iap4s3OI0wNjOuZuhg5OSQETCTW79vA2sXIxSEksIJR4mbHAijnC6PE8ek/2SGc
        z4wS7Qv64Vq6n65mgkgsZ5SYdH8dVNVbRonmhjZWkCphAQuJV6fvsoDYIgLaEhPf7GADKWIW
        aGSUWL50EVgRm4CVxMT2VYwgNq+AncT8i6fAGlgEVCT+n7oK1MDBISoQIdF/Rh2iRFDi5Mwn
        YCWcAokSvdv/gl3ELGAgcWTRHFYIW15i+9s5zCC7JAS62SXufFzHCnG2i8Std1vYIGxhiVfH
        t7BD2DIS/3fOZ4JoWMco8bfjBVT3dqBLJ/+D6rCWOHz8ItQkR4n3L+4xg1wnIcAnceOtIMRm
        PolJ26ZDhXklOtqEIKrVJDYs28AGs6tr50pmCNtDYt7rn6wTGBVnIfltFpJ/ZiH5ZwEj8ypG
        8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzApHL63/FPOxi/Xko6xCjAwajEw6vAsDBGiDWx
        rLgy9xCjBAezkgjvmf4FMUK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGanphak
        FsFkmTg4pRoYJV/P75trtbdln3astOuv4NOlk8+r2V7vqjB3yhaZJWXDuTiD74MHe+z/9cXl
        /+JuJU7Oe6C07Oi6wm22WS0xiyXj7i2R35Dm2pAT5Bi9ac/qu6nee51sI5++72EumJm0tPLo
        vntrKl8+rNvUlsYupOKSoLnO7Z/jlCf3zq/RW94s0e3gmCCjxFKckWioxVxUnAgA8nRcIyYD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7rm/xbGGHybJW1x5et7NouJvUtZ
        LE70fWC1uLxrDpvF8idrmR1YPe53H2fyONn6jcXj2cGHrB6fN8kFsETp2RTll5akKmTkF5fY
        KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZfya95a54A1TxZudR5gaGNcz
        dTFyckgImEh0P10NZHNxCAksZZT4M+8ycxcjB1BCRuL4+jKIGmGJP9e62CBqXjNKTPs2lxEk
        ISxgIfHq9F0WEFtEQFti4psdUEVbgAbtXsQM4jALNDJKnGpdD9bBJmAlMbF9FZjNK2AnMf/i
        KbBuFgEVif+nrrKB2KICERK3HnawQNQISpyc+QTM5hRIlOjd/hfsbGYBPYkd13+xQtjyEtvf
        zmGewCg4C0nLLCRls5CULWBkXsUoklpanJueW2yoV5yYW1yal66XnJ+7iREYKduO/dy8g/HS
        xuBDjAIcjEo8vBVMC2OEWBPLiitzDzFKcDArifCe6V8QI8SbklhZlVqUH19UmpNafIjRFOiJ
        icxSosn5wCjOK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTTx8TBKdXAyH+O
        RTn39J7N1q+dPe+u5i0RO7uI+fHvmrWR87SnLrSpn7jb3vmx19HDPBafQ+RED6wTmtMlvU1F
        9Za8a1rNWvu7d5fM2N/HfHF2gWlT+76WVU9eL+ezDLPaFM5aNPG28mrZLdP7018ptPdMr/GR
        terRKrCvsnxU9lKrrdXgwuQFxtMfrVAuUWIpzkg01GIuKk4EADQqBa2qAgAA
X-CMS-MailID: 20190401120407eucas1p1ed00d5715c2db886a8c5724d3c1472c1
X-Msg-Generator: CA
X-RootMTR: 20190217233037epcas5p1f527f485e504ee424a1a26f47dc1ea51
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190217233037epcas5p1f527f485e504ee424a1a26f47dc1ea51
References: <CGME20190217233037epcas5p1f527f485e504ee424a1a26f47dc1ea51@epcas5p1.samsung.com>
        <80cf1394f099ced17bd5075be88cf33c1232086a.1550445927.git.fthain@telegraphics.com.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/18/2019 12:25 AM, Finn Thain wrote:
> The 'inverse' parameter has no effect otherwise. Remove set-but-unused
> variable.
> 
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
