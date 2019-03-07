Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DF6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39B220675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opYSe6cG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCGWpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:45:07 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55518 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCGWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:45:07 -0500
Received: by mail-it1-f196.google.com with SMTP id z131so18006953itf.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 14:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUkXYdmUF5bhjjVVeLEZ9T0FeGUBv2MITzRaC3GTEaA=;
        b=opYSe6cGSKQ4z8YsHOpjV52mfsqJWJK2ydMZUCHqn9UPHf0hj2isAp1cp4LTxqun5/
         jpkMv4YBHV+6H5l8sS5XYACzAHqfS9KUJAX5I/OBM9si0CicOXayPVKk5nsNr1+CQrCQ
         HELGBIofdb6SfAlIfQbf2BtrwlNAHM1ErGY0Q/kJA4UdnkugYuBpA8mSstajXPma2pXn
         AFhqT8C31p5chZwynlmofeKI1kzosOEsjUv44+CBI6FUnKi4SLVeIcgodVBt7UcYNd03
         MdrdCLC/p4zx6yCMn6YqqO+W3L9KgqjPW9ktsHflkg92TnGTX6J74OEuGop8MJ92cWS8
         GbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUkXYdmUF5bhjjVVeLEZ9T0FeGUBv2MITzRaC3GTEaA=;
        b=aC9Nm/gTeAY7WTXjbt5Lzh43H4/V2b0IgmRsywCiZYI80uXjI8zzWgk2aWuEPYI1AK
         OKEdGjeZ+/IWAkFqRico97QRY4YaUFJ9msDCAeEf2SO7Ac8ti1NgBf/lEpCngBCKC0pC
         EIjYML6r7Xn476K9AHb3L7YADyEAc+0zHUPBq6dIp0AILLExoqvt3e+P0oZAfYHIuN5o
         Z4thIRL6GKfA+jK45P/b2H3YgRcvct3QOIiXfAXLr3D7Sa8K6Uc2Iaz3PSrgNa5QQWQ3
         KQR5zzp5WKbn/Zf4UPPQvuxyT2HBkvfK3JujCAH+61FoYtWLC9VQ3bAsyDWt9XgDPC4o
         RLxw==
X-Gm-Message-State: APjAAAUSuoGWm1isPS9PIeHMvvMsOgQ7T3/TuPi8LaVG0PRc/vFikAiB
        3r7qJ7lh6kBKWqwMaXXje10qKGgWETBXHxNVF1BRP771dVs=
X-Google-Smtp-Source: APXvYqw9WjbE2NlS+DsNvDKiWloqHmsLUqlmjXucn//9YuWCIohDoKOIwdzrwvEyMJiZPw9mPhwmv54S351sum0DhJA=
X-Received: by 2002:a24:43d1:: with SMTP id s200mr6679052itb.118.1551998706101;
 Thu, 07 Mar 2019 14:45:06 -0800 (PST)
MIME-Version: 1.0
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
 <1542657371-7019-4-git-send-email-zohar@linux.ibm.com> <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
 <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
In-Reply-To: <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 7 Mar 2019 14:44:55 -0800
Message-ID: <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
To:     Justin Forbes <jforbes@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 2:38 PM Justin Forbes <jforbes@redhat.com> wrote:
> On Thu, Mar 7, 2019 at 4:29 PM Matthew Garrett <mjg59@google.com> wrote:
>>
>> On Mon, Nov 19, 2018 at 11:57 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>> >
>> > The secure boot mode may not be detected on boot for some reason (eg.
>> > buggy firmware).  This patch attempts one more time to detect the
>> > secure boot mode.
>>
>> Do we have cases where this has actually been seen? I'm not sure what
>> the circumstances are that would result in this behaviour.
>
>
> We have never seen it in practice, though we only ever do anything with it with x86, so it is possible that some other platforms maybe?

I'm not sure that it buys us anything to check this in both the boot
stub and the running kernel. If a platform *is* giving us different
results, anything else relying on the information from the boot stub
is also going to be broken, so we should do this centrally rather than
in the IMA code.
