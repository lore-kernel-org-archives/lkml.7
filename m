Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A05BC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531B52082F
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i6D6Mzsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbfHWQFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:05:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39035 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388143AbfHWQFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:05:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so805840pfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5TnNr+OdCIKdBXtg0SdrE33EddMCr1CqhKo91l53s7k=;
        b=i6D6MzsuVeoACvDVMwHW3MuqPegOES+zUYVQqrhaWf6X6M9e1UdPjAa7Rx5ncPFBDC
         nXsXkS9KR98/OHLrjzGzmNKmJp2SLLwz7c3FiucAaLChkqO3t0cFRfmuGhYLqdjAghj7
         2gf1p8ZOVxudFqRRmhrY0a7TFlszacQDPulsVLD7XVeJ0UYb8Ao/MrijaiOVLhvRgZiw
         nCbO7fzAieG7fRPjwapJQyvVReeTTp4x5aFA6EFMWSjg/pGQEv8wsq1sovJcC1SNETE2
         zTePl07c+9ItXy871weD1vUY2Mf5Ttk1mENpR69MX8KT2xQnVOX0Cz+VgArjsekRNJJp
         SLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5TnNr+OdCIKdBXtg0SdrE33EddMCr1CqhKo91l53s7k=;
        b=HvtZNflwhN5KkY2iRqMpIKN3AWyi7ezVj3urIF22xT7XhQFW/Bc/rH3/RSGSBoyDgX
         HYS+Gp4O7g+WC4Tivld08pJ60TnkVyCtK0G5tasTDp9fcFcYLbd/WDSC+0Ibo6wVgxsI
         n9XHxD/Ptkn26x5zjE5R0N8abt0tNl4jqlxYpf7GuFZCwty5hNMgsB59X6+6EDR5I2R7
         aHN0BcNHzVZKvhj2O9Cr0lsy2HDHlNA/a/DRI6jIp5gzEb8+2uWXhbqUZy2WGMcTMYVJ
         Cmygdrp05JVsOAh8L0x3R2m5+8bkPbMBDGVTmsHbgJo374f6dIkd4Xpx4pULBp6+ys+Q
         GbmA==
X-Gm-Message-State: APjAAAVRrkiOO1VI8M/0GRX5wXMP0Yg7trlRjGasn6SWszDAYe62zyu0
        0krRfd7KjhUk5lhvZMz9YXFl2g==
X-Google-Smtp-Source: APXvYqzuYnMl/hMQtDfZdQCtJirc/oPqMuN1+ECkrznVC7BlEDFSwg0YRD5hQTFi7wmoVWJReQ3xiA==
X-Received: by 2002:a63:724b:: with SMTP id c11mr4777486pgn.30.1566576350101;
        Fri, 23 Aug 2019 09:05:50 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:89d4:68d1:fc04:721])
        by smtp.gmail.com with ESMTPSA id e10sm3931971pfj.151.2019.08.23.09.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 09:05:49 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>, gtucker@collabora.com
Subject: Re: [PATCH 4.4 00/78] 4.4.190-stable review
In-Reply-To: <CA+G9fYtUaa7cdpJWLDDywotF0JWDf3XtcFXOweATUXam_99N8Q@mail.gmail.com>
References: <20190822171832.012773482@linuxfoundation.org> <5d5f064c.1c69fb81.e96ef.73f5@mx.google.com> <7himqo259z.fsf@baylibre.com> <CA+G9fYtUaa7cdpJWLDDywotF0JWDf3XtcFXOweATUXam_99N8Q@mail.gmail.com>
Date:   Fri, 23 Aug 2019 09:05:48 -0700
Message-ID: <7hy2zjzx2b.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naresh Kamboju <naresh.kamboju@linaro.org> writes:

> On Fri, 23 Aug 2019 at 04:10, Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> "kernelci.org bot" <bot@kernelci.org> writes:
>>
>> > stable-rc/linux-4.4.y boot: 101 boots: 2 failed, 84 passed with 12 offline, 2 untried/unknown, 1 conflict (v4.4.189-79-gf18b2d12bf91)
>>
>> TL;DR;  All is well.
>>
>> > Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.4.y/kernel/v4.4.189-79-gf18b2d12bf91/
>> > Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y/kernel/v4.4.189-79-gf18b2d12bf91/
>> >
>> > Tree: stable-rc
>> > Branch: linux-4.4.y
>> > Git Describe: v4.4.189-79-gf18b2d12bf91
>> > Git Commit: f18b2d12bf9162bef0b051e6300b389a674f68e1
>> > Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>> > Tested: 47 unique boards, 19 SoC families, 14 builds out of 190
> ...
>> > Boot Failures Detected:
>> >
>> > arm64:
>> >     defconfig:
>> >         gcc-8:
>> >             qcom-qdf2400: 1 failed lab
>>
>> This one looks like the boot firmware is not even starting the kernel.
>> The Linaro/LKFT lab folks will need to have a look.
>
> At LKFT lab arm64 juno-r2 is only the device for 4.4 upstream kernel testing.

That might be your goal, but that's not what is happening.

This boards is clearly being tested with v4.4 in kernelCI:
https://kernelci.org/boot/qcom-qdf2400/

Looks like you may want to blacklist v4.4 for this board in kernelCI.

Kevin
