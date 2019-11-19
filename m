Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0800C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9969219F6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="XbtyWj71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfKSLey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:34:54 -0500
Received: from canardo.mork.no ([148.122.252.1]:48253 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbfKSLex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:34:53 -0500
Received: from miraculix.mork.no ([IPv6:2a02:2121:282:91e0:68e2:39ff:fe1c:1a78])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id xAJBYXhW005061
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 19 Nov 2019 12:34:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1574163275; bh=3c0RkDqtClK7mnfJEI2VW+D7m35xk5cvEa+CdQvxvlU=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=XbtyWj71ebSSkaSbHE9p0BYzxA0Bywzz+D5S1xQB7GAJ4yvnk7o1aA4nqCbtyjyNf
         /1CKdVbUS2uZ7Y+89h38zHb0G4odf9+ZUzM/3ynNujqk2Nk2/LQt0bmpXPrefl8gnI
         D2IM6E0b39i+uwWNLNCsIKwDPaJdQ+/CRBn8dcMY=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1iX1m8-0007Jf-K6; Tue, 19 Nov 2019 12:34:28 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Oliver Neukum <oneukum@suse.de>
Cc:     syzbot <syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com>,
        andreyknvl@google.com, baijiaju1990@gmail.com,
        bigeasy@linutronix.de, colin.king@canonical.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuehaibing@huawei.com
Subject: Re: INFO: task hung in wdm_flush
Organization: m
References: <0000000000003313f0058fea8435@google.com>
        <8736ek9qir.fsf@miraculix.mork.no> <1574159504.28617.5.camel@suse.de>
Date:   Tue, 19 Nov 2019 12:34:28 +0100
In-Reply-To: <1574159504.28617.5.camel@suse.de> (Oliver Neukum's message of
        "Tue, 19 Nov 2019 11:31:44 +0100")
Message-ID: <87pnho85h7.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.101.4 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum <oneukum@suse.de> writes:
> Am Dienstag, den 19.11.2019, 10:14 +0100 schrieb Bj=C3=B8rn Mork:
>
>> Anyway, I believe this is not a bug.
>>=20
>> wdm_flush will wait forever for the IN_USE flag to be cleared or the
>
> Damn. Too obvious. So you think we simply have pending output that does
> just not complete?

I do miss a lot of stuff so I might be wrong, but I can't see any other
way this can happen.  The out_callback will unconditionally clear the
IN_USE flag and wake up the wait_queue.

>> DISCONNECTING flag to be set. The only way you can avoid this is by
>> creating a device that works normally up to a point and then completely
>> ignores all messages,
>
> Devices may crash. I don't think we can ignore that case.

Sure, but I've never seen that happen without the device falling off the
bus.  Which is a disconnect.

But I am all for handling this *if* someone reproduces it with a real
device.  I just don't think it's worth the effort if it's only a
theoretical problem.

>>  but without resetting or disconnecting. It is
>> obviously possible to create such a device. But I think the current
>> error handling is more than sufficient, unless you show me some way to
>> abuse this or reproduce the issue with a real device.
>
> Malicious devices are real. Potentially at least.
> But you are right, we need not bend over to handle them well, but we
> ought to be able to handle them.

Sure, we need to handle malicious devices.  But only if they can be used
for real harm.

This warning requires physical acceess and is only slightly annoying.
Like a USB device making loud farting sounds.  You'd just disconnect the
device.  No need for Linux to detect the sound and handle it
automatically, I think.


Bj=C3=B8rn
