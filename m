Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56225C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 16:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F01E20652
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 16:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="HmwqpYTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfFWQDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 12:03:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45698 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfFWQDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 12:03:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id z19so2799047pgl.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tpBlhz/W7OBriHiehBiGQxTDbFBIruMGU1bNQnl1HCI=;
        b=HmwqpYTUwpJ+rTK/BkWsgpF1U4yMSvKGh03BYJenWDVPKghsqSg/cMSi+X7n0c6CFv
         8F+XH8bCrvob6V7DdTbm9B8qAgVAaim21T5fkU39PcslzH/vvik24iFy3nGzm4xXxBeM
         klyzFu1Q0Xwma/fu2QO/bFtwFtkL4cFxwnNfc/Fm05xuu0a+eAawZpZdLaV+F8ykyy2t
         2nzAA+pMCjpTOzCYBhUHowhqoQSWdFw6iTH84c7i2FIn0TX1lyKBhj0XKV67evZWXoYI
         0duAyVrgxH1zYWktM7N/PrnIWg1pMPOkJDXDRoqJql65lCbUWb5yHOlo7DrKEpe3HZun
         bscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tpBlhz/W7OBriHiehBiGQxTDbFBIruMGU1bNQnl1HCI=;
        b=TKh/kwv37cDds0mSi8zjDCUA1d2RsuW8eVcOaGtz+7Tgs9avYDkSRlSG7xuKUqF2xw
         n4aLH1OkN/EElP+CHhEYLrbxEECpN4AhXIgfIpFMBgwbZzCuCRil+aovMHw3vI2CX5Bl
         ZEG8Y6esG/QLXrOQISbletCa/WZP8xlzjQHcxiJHuV/cNJnvK4BPco6Ro0VReqabPDe9
         9VK2ktf4Qi5FV0EPFDvFRwtCt/ss6kagH1vYTvmhTFyjmb1JldcpQ/LIiR7Jlg/vs1aE
         VVssiJyENPdmOYQLrqkPs7S8OIW39cjp5bKT2Hnl+UeM2tr0J3kPc80OpZ4lC7YGQRSG
         vThA==
X-Gm-Message-State: APjAAAUL9Bd4WEW4NnVUwKnBvPYQJckkaYwq2aeNc+Ona7aj/XNmtDai
        RXC9hSKR//AEWNLAgtZ01TrDVg==
X-Google-Smtp-Source: APXvYqzIVy+0nCKZ6Dtw+pDec9pjCgjkBVO5Ivj6BiZvZ9JEsfUqvSX3L6kbzIeHPmhuxtXsrSdUVQ==
X-Received: by 2002:a63:3042:: with SMTP id w63mr21427187pgw.21.1561305819731;
        Sun, 23 Jun 2019 09:03:39 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:5418:e2ea:f0b8:473d? ([2601:646:c200:1ef2:5418:e2ea:f0b8:473d])
        by smtp.gmail.com with ESMTPSA id w4sm8949105pfw.97.2019.06.23.09.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 09:03:38 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/vdso: Give the [ph]vclock_page declarations real types
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <alpine.DEB.2.21.1906231509440.32342@nanos.tec.linutronix.de>
Date:   Sun, 23 Jun 2019 09:03:37 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <49C4F6B3-D419-4035-B49D-1586912C670C@amacapital.net>
References: <6920c5188f8658001af1fc56fd35b815706d300c.1561241273.git.luto@kernel.org> <alpine.DEB.2.21.1906231441500.32342@nanos.tec.linutronix.de> <CAHk-=whywzng7FLV9X67RPmHNnygK+7VJV+zh4njT6BA+h9tCw@mail.gmail.com> <alpine.DEB.2.21.1906231509440.32342@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 23, 2019, at 6:10 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
>> On Sun, 23 Jun 2019, Linus Torvalds wrote:
>> 
>> Andy added comments and changed the patch in other ways too, so I think
>> it's fine to have him as author, and my sign-off is just for the original
>> smaller patch.
> 
> Well, that will earn me a nastigram from the next checkers as it's not
> compliant to our SOB rules ....
> 

Feel free to add:

Originally-by: Linus ...

I had assumed the textual description was enough.
