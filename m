Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE35CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F40F20672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="p41EzjMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfKUVBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:01:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35896 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKUVBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:01:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so2358769pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 13:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=SWPOTYcfPM+SmySXP2izUP7lqeFLHCTV1Gr5PsBRZds=;
        b=p41EzjMBwbH7maExHnalWSvYQ/MmKaQzJXRUb2PtI36n/V3veqyEcpvGJtqE/fuCNh
         ZrSQwEKkOiY4HLEro+A7ic74b4eVxoxOifVcKYxgviB7QfyQz40HNifDXNTliqilhl2f
         mY/dA7JH3P6cOleWZ645B6lf0xxXMzIYn0JK6vlZgAI3ufL9VOqOqfrkBYB6BFV5PMnU
         ArHFZmt2kqPluePU4mkN3yCXUGxgq1Tk5feh1yaCIJtZ9RSYG564rmkcRUvJ3JS93sWg
         rZPGBMKDbJPI3fvZTWBC89fnAJZCFVv4vyAyn3unsCSwDxIdzt7WIR5A4SWZRIAxgzhl
         M7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=SWPOTYcfPM+SmySXP2izUP7lqeFLHCTV1Gr5PsBRZds=;
        b=IolYvpLFTBp4ZefWlljjtu6Tl+6aAg1/5ZVFYk1aR4kiuXjO7cGM1B0/GPmkqA6sQ3
         C/y4H03d4V7x5HrSAWDEuownYScxR8YUEERUIHNe3yX+CZDYrs4Ry2Q8DftSL9NvFhNp
         1fgnNVNwI5GXvRrD4Rk43aSGU4vVYtDpWXZUlw7ctGgEgegcWwkxY2NAlmZu4Bwi9dTM
         ju/zpJIb15tL90SqSaPOvyBQBA5RI6zQHQHztJGirg+IkSEq4q2kg307Rjsru4sdtWnn
         WAdEzhw6YsI1K6cTvBGRJwR2epU52I/dJn0l0PXHDILuNtO6N5h9wvCrCxSXeawFSZn7
         n6lQ==
X-Gm-Message-State: APjAAAXS7VRq5rNtk76686DIuZwZBfVrua1SGWgbR8lTD5JCLSwzdSmD
        YAXGKemmuRa45jUtXCnNitYtew==
X-Google-Smtp-Source: APXvYqxH6iAHaPyaRY1JE4q6SAQD2S4loqyet78ByWa4z+t1eLSlss1XL5GlKB/HQGi/k7VNIVAi6Q==
X-Received: by 2002:a63:f94e:: with SMTP id q14mr11769288pgk.411.1574370070419;
        Thu, 21 Nov 2019 13:01:10 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:8037:4908:32a8:6a21? ([2601:646:c200:1ef2:8037:4908:32a8:6a21])
        by smtp.gmail.com with ESMTPSA id s26sm4397741pfh.66.2019.11.21.13.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 13:01:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by kernel parameter
Date:   Thu, 21 Nov 2019 13:01:08 -0800
Message-Id: <066A48B7-296F-4953-89A6-588509FC0303@amacapital.net>
References: <20191121195634.GV4097@hirez.programming.kicks-ass.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
In-Reply-To: <20191121195634.GV4097@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 21, 2019, at 11:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:=

>=20
> =EF=BB=BFOn Thu, Nov 21, 2019 at 09:51:03AM -0800, Andy Lutomirski wrote:
>=20
>> Can we really not just change the lock asm to use 32-bit accesses for
>> set_bit(), etc?  Sure, it will fail if the bit index is greater than
>> 2^32, but that seems nuts.
>=20
> There are 64bit architectures that do exactly that: Alpha, IA64.
>=20
> And because of the byte 'optimization' from x86 we already could not
> rely on word atomicity (we actually play games with multi-bit atomicity
> for PG_waiters and clear_bit_unlock_is_negative_byte).

I read a couple pages of the paper you linked and I didn=E2=80=99t spot what=
 you=E2=80=99re talking about as it refers to x86.  What are the relevant wo=
rd properties of x86 bitops or the byte optimization?=
