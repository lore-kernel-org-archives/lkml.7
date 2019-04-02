Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC43C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F91120857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="S9s0eOdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfDBKBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:01:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33114 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfDBKBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:01:40 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F207E1EC0669;
        Tue,  2 Apr 2019 12:01:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554199299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dGuezb48eKAARpAh+E3nO7bUor10ahBxe0RobKvzrMY=;
        b=S9s0eOdtq4xTgYSdkbhRd4QxArOM+zArmj5V1YitaUHMKbwNp8I/0Ic4U8X8ECpEfXdx39
        mbNZMCxkMlY2MH5yW3TPDdJ5Eknu2LkX96j+/wEnGcVoSZ1smtnmjktS7dd303D3hPkbkg
        lM4M7XOyF1OtQiZink2xHQqROsCzrMM=
Date:   Tue, 2 Apr 2019 12:01:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH v3 2/4] x86/microcode: Fix __user annotations around
 generic_load_microcode()
Message-ID: <20190402100134.GE6826@zn.tnic>
References: <20190329214652.258477-1-jannh@google.com>
 <20190329214652.258477-2-jannh@google.com>
 <20190401173031.GK28264@zn.tnic>
 <CAG48ez04ARfFNXHUsod1kCH08k=-EvTbQkgLoLMfegNfyj-0zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez04ARfFNXHUsod1kCH08k=-EvTbQkgLoLMfegNfyj-0zg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 07:53:46PM +0200, Jann Horn wrote:
> Hm. request_microcode_fw() gets that buffer from
> request_firmware_direct(), which does this:
> 
>         __module_get(THIS_MODULE);
>         ret = _request_firmware(firmware_p, name, device, NULL, 0,
>                                 FW_OPT_UEVENT | FW_OPT_NO_WARN |
>                                 FW_OPT_NOFALLBACK);
>         module_put(THIS_MODULE);
>         return ret;
> 
> What is that module_get()/module_put() supposed to be good for? Are we
> expecting that caller to do something ridiculous like calling
> module_put() on us? This doesn't seem to make any sense.

Yah, the microcode thing used to be a module. Not anymore.

> And then _request_firmware() goes and ends up in places like
> kernel_read_file(), which already use vmalloc().
> 
> Anyway, isn't this kind of thing exactly why we have that iov_iter
> stuff? request_microcode_fw() can build an ITER_KVEC,
> request_microcode_user() can build an ITER_IOVEC. And then
> generic_load_microcode() can use something like copy_from_iter(). Does
> that sound reasonable?

/me doesn't know that interface, goes and looks...

You mean doing something like iov_iter_init() ... and then
copy_from_iter()? I'm looking at vhost_vsock_alloc_pkt() as an example
for a user of that interface.

The only thing I'm unsure about is the use case: that iov thing uses
a bunch of segments with separate lengths AFAICT which it copies
back'n'forth.

The loader does that sequentially in the sense that it parses the header
first, does some checks, then computes the size of the trailing patch
data which then copies again, see those ->get_ucode_data invocations.

Which would mean that the iov_* stuff would be always called with a
single segment of some length. Not that it is an issue, just saying.

That's why I suggested doing the trivial thing of copying the whole
buffer at once but I tend to prefer simple things so... :-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
