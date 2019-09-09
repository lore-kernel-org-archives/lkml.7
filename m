Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCD1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3353921920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lvoWhoZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404537AbfIIL47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:56:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60833 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404502AbfIIL47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:56:59 -0400
Received: from [192.168.4.140] (38.85.69.148.rev.vodafone.pt [148.69.85.38] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x89BuRWN2370009
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 9 Sep 2019 04:56:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x89BuRWN2370009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019081901; t=1568030190;
        bh=amVw5RKHgQtC48TDjO25VF7TYKPY9dwQtCHHtmUiWLE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=lvoWhoZgfNLoIKEG5HMqgj2INg4WXNd1HFaah1iCDp0Ax9O9xMwZxJ/tVCfuFPX+t
         SovlpLHk3dL63OePhXjpdYrpwk+zhAKreqHglsT1DKolM9uMw0xDHftZf7qSL4I1dm
         cU7ZrGpYRYdJ2X4B5koCF9HFHOui2BhRpbBaPn/ZZnBBOy3f+nO1AZCVONjlCGdd+J
         R1sDya84Assf38LZxcJN9R9OQyM+Sj4Bw84Sp4RZPx4P8thdY9mXqTbQlvMyex5s4h
         oiSiklz8bhpNWZlFyYKe0WXb8ToI7I4SnOw/otHQAnzM5ukV/GqffGMu5/wJKBrnRn
         CoQCM9nw4hqSg==
Date:   Mon, 09 Sep 2019 12:56:18 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190908072248.GB16220@zn.tnic>
References: <20190905232222.14900-1-bshanks@codeweavers.com> <20190907212610.GA30930@ranerica-svr.sc.intel.com> <20190908072248.GB16220@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/umip: Add emulation for 64-bit processes
To:     Borislav Petkov <bp@alien8.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
CC:     Brendan Shanks <bshanks@codeweavers.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
From:   hpa@zytor.com
Message-ID: <1E11E98F-4A38-4CDE-8549-64A2C28DC63E@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 8, 2019 8:22:48 AM GMT+01:00, Borislav Petkov <bp@alien8=2Ede>=
 wrote:
>On Sat, Sep 07, 2019 at 02:26:10PM -0700, Ricardo Neri wrote:
>> > Wine users have encountered a number of 64-bit Windows games that
>use
>> > these instructions (particularly sgdt), and were crashing when run
>on
>> > UMIP-enabled systems=2E
>>=20
>> Emulation support for 64-bit processes was not initially included
>> because no use cases had been identified=2E
>
>AFAIR, we said at the time that 64-bit doesn't need it because this is
>legacy software only and 64-bit will get fixed properly not to use
>those
>insns=2E I can probably guess how that went =2E=2E=2E

I don't think Windows games was something we considered=2E However, needin=
g to simulate these instructions is not a huge surprise=2E The important th=
ing is that by simulating them, we can plug the leak of some very high valu=
e kernel information =E2=80=93 mainly the GDT, IDT and TSS addresses=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
