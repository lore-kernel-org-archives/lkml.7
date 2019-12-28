Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCF9C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 01:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD22820828
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 01:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLKKu4Yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfL1Bj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 20:39:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34650 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfL1Bj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 20:39:27 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so13591710lfc.1;
        Fri, 27 Dec 2019 17:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+o48AMUaNGbgETwlxDhs0abyiUl4r5Mn6wG6J96sBI=;
        b=NLKKu4Yg5k+4uu9l7NgN/kiad8P6h5A8IrX4Lj6KmexKSqHcyrWijNV5+hYyP2mEeH
         NLGi1THYh23HKQ2lybqwRutIRoQV7nsL1W6YyFxI/eYtRDPcjqryRZxWhrR1bvS7jet0
         jG9F7YN/wi2AlkQo7OMBXVF4nU4PCgRV2mVwhughb3G+TtxuYirnPbzIPEf25xqQdwVt
         Mhegx0s2aMURjzNdrVE07r/WN0x7yN2Qtjcx9ptkAdVW3xGFiQTjoo9Wx2JYZdN0zuZF
         AaYfUeiqs3iygRBGcwjM2XLNvdmfh06qXbdbiMu/ykVcLrXWhcOb8qll+2YMh8E2XPBm
         GMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+o48AMUaNGbgETwlxDhs0abyiUl4r5Mn6wG6J96sBI=;
        b=DCUtJFGKdr2BsG35Al/dfVWK+rWKcyNAFN+66DiwvzQDtjFvixFz9chnKZEMNlYj18
         vp36TaY4nRtfMt+zqHypWzOW2oKwJcP4W37FDw1QNXNw/rLt7aTceutbaVEtilqBxiN0
         xE05CrH2r3ffk4v8N45uqcEYDQtExPVlCTwRaflyVAZK2mHn3lCaz2KvAPsttEGgKMU9
         PtK+PJLkW0ZFyBjrhUlBRBXJ+1EPhXGepOPOHS+xzTNFgCOAihETMCcLw4K+QbpyvTIg
         2gnXdFmjzuru3H4156ud3DkaQl0QyL/cy+IS15/e4vj8PhNywbbp9GgHO96OHUT7Zk+7
         e/ow==
X-Gm-Message-State: APjAAAXouHe/bYI+2b5GLcOEW4zTrECF3F0cIMwO29cnUnPLEX2VqSdR
        E2Bbuitz1cBokfKiznp/VHfBimLp2TuVhAxxxOY=
X-Google-Smtp-Source: APXvYqydB1qXyH+zz0ES+nAhC5c2+sOJfPd8juf7TuwsTrkzTGlJZr7z7xUVwVU7Y5Fj11172EFc8OB1hhFxIY0y+Og=
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr31692298lfk.67.1577497165626;
 Fri, 27 Dec 2019 17:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20191216144907.1931511-1-arnd@arndb.de>
In-Reply-To: <20191216144907.1931511-1-arnd@arndb.de>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sat, 28 Dec 2019 12:39:14 +1100
Message-ID: <CAGRGNgV=vcDTAYpufqk-12pNnJiX79=-aHsMyOBGbXG1YtN=Lw@mail.gmail.com>
Subject: Re: [PATCH v2] y2038: sparc: remove use of struct timex
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Dec 17, 2019 at 1:49 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> 'struct timex' is one of the last users of 'struct timeval' and is
> only referenced in one place in the kernel any more, to convert the
> user space timex into the kernel-internal version on sparc64, with a
> different tv_usec member type.
>
> As a preparation for hiding the time_t definition and everything
> using that in the kernel, change the implementation once more
> to only convert the timeval member, and then enclose the
> struct definition in an #ifdef.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

FWIW this is:

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
