Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595FAC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1F6208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Z1ujcUSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfFGQfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:35:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38393 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbfFGQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:35:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id f97so1033809plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0wvMqjnLfHeibHfnd5Vo60J3T+kOUBskArwKAN9PGMQ=;
        b=Z1ujcUSObY84r0pQw1gBEgavn3UDkEJ73l7OoeuHJ7dTxxtAWA5cFzGd2tv+bDLXFZ
         ZUSH8lkopmuRZXxnqwLbFKFylazXfmK1Yd06ZaFH3sphoqD6YxdLCXKJjTeZ/46olgLw
         cLkrGYT/rNrgSGRUpMNUrvuX5u7UwSAvEWwn4hAgbhrWtbQEXPMkYf5cSf3rXHCCI2yO
         oxKvbLtHVB4ymsJqzauKbObHwXVJGq0nRHyzLloNX1EQW9P9evaYW8zYcNjTEP4aI/WM
         V69MI12MFr6S0MbwLenZ5QYptjGPavTIFQ1xi2XagjAAyleNVcloUFwKXdfWiK7WVJUO
         LbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0wvMqjnLfHeibHfnd5Vo60J3T+kOUBskArwKAN9PGMQ=;
        b=Hxics4HlzniUbc9IFqAEguu/2ciYRR9SlA3YeOdwg7hXz/jfIoy5rNSCu7Fe1VTmzm
         lDlEztPqwxAIDKPHLD0tqTo5LyPyYBoTV1nLgBMjm3g4SSTW1qh7rHFcDVYBpm8ZdNmd
         P8oJB54PGS8PlLaMYcePXN1+Ygyv4bM9AQnEeSl/zmSygZRhSRtQW3oOy8COabJ3ib0e
         c3ptRtWmCVKrE9+CCpqDOOvowc5JRcJ044jiLuZfpkpU7muEb2x1j0lMlLoF0xNL3t/n
         SzU17jaSu/eZWAan8bcECehe+MulKycpKm0rt+ZRCzGlbqBwu7VOOxegpcbkyLSuDZWP
         iWNQ==
X-Gm-Message-State: APjAAAU/cwBW0RE8PCzy8dgniFQpDr56s9QaaIoS9beV/dcWf7HA27TL
        DxZaA/tjeIG4W5McikzNn9/MVw==
X-Google-Smtp-Source: APXvYqxYfU9YVziUJO0vNHvuNseZrHbxK2V0LHuxNzSafUXNPN+YeoYV3SImF7zgnh5F5HqBc8Gomg==
X-Received: by 2002:a17:902:7e0f:: with SMTP id b15mr48583188plm.237.1559925330160;
        Fri, 07 Jun 2019 09:35:30 -0700 (PDT)
Received: from ?IPv6:2600:1012:b044:6f30:60ea:7662:8055:2cca? ([2600:1012:b044:6f30:60ea:7662:8055:2cca])
        by smtp.gmail.com with ESMTPSA id f2sm2240019pgs.83.2019.06.07.09.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 09:35:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup function
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
Date:   Fri, 7 Jun 2019 09:35:27 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <76B7B1AE-3AEA-4162-B539-990EF3CCE2C2@amacapital.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-4-yu-cheng.yu@intel.com> <20190607080832.GT3419@hirez.programming.kicks-ass.net> <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 7, 2019, at 9:23 AM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>=20
>> On Fri, 2019-06-07 at 10:08 +0200, Peter Zijlstra wrote:
>>> On Thu, Jun 06, 2019 at 01:09:15PM -0700, Yu-cheng Yu wrote:
>>> Indirect Branch Tracking (IBT) provides an optional legacy code bitmap
>>> that allows execution of legacy, non-IBT compatible library by an
>>> IBT-enabled application.  When set, each bit in the bitmap indicates
>>> one page of legacy code.
>>>=20
>>> The bitmap is allocated and setup from the application.
>>> +int cet_setup_ibt_bitmap(unsigned long bitmap, unsigned long size)
>>> +{
>>> +    u64 r;
>>> +
>>> +    if (!current->thread.cet.ibt_enabled)
>>> +        return -EINVAL;
>>> +
>>> +    if (!PAGE_ALIGNED(bitmap) || (size > TASK_SIZE_MAX))
>>> +        return -EINVAL;
>>> +
>>> +    current->thread.cet.ibt_bitmap_addr =3D bitmap;
>>> +    current->thread.cet.ibt_bitmap_size =3D size;
>>> +
>>> +    /*
>>> +     * Turn on IBT legacy bitmap.
>>> +     */
>>> +    modify_fpu_regs_begin();
>>> +    rdmsrl(MSR_IA32_U_CET, r);
>>> +    r |=3D (MSR_IA32_CET_LEG_IW_EN | bitmap);
>>> +    wrmsrl(MSR_IA32_U_CET, r);
>>> +    modify_fpu_regs_end();
>>> +
>>> +    return 0;
>>> +}
>>=20
>> So you just program a random user supplied address into the hardware.
>> What happens if there's not actually anything at that address or the
>> user munmap()s the data after doing this?
>=20
> This function checks the bitmap's alignment and size, and anything else is=
 the
> app's responsibility.  What else do you think the kernel should check?
>=20

One might reasonably wonder why this state is privileged in the first place a=
nd, given that, why we=E2=80=99re allowing it to be written like this.

Arguably we should have another prctl to lock these values (until exec) as a=
 gardening measure.=
