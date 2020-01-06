Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95380C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD95222D9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqiq0v9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgAFUSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:18:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34824 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgAFUSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:18:23 -0500
Received: by mail-io1-f65.google.com with SMTP id h8so2908671iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Rcg5ibwjG8y5aZAcf4B6F5Z9gExCdMlFDQO0Lciu24=;
        b=lqiq0v9HxFYQSzvoTItL5VboCgvXcPwJrDfjRt4tRzrNP91NfyDXsOiJ0/fojLIeK3
         cZDHOPcKfYWr1Imrjm4ukSv9jgmuqIUFul4cWpToTfFisGt9agV5pyTQYUhw/d56TCA1
         TED+wvKRPwaaajR6wEOAcNtQqO4eOcvinx1dX2jdTd2Kemd8PzCsuPJGravprw31HYd/
         /Q4rQfBCmTNo24mSI3jiIJdTm1ysoZI5RejQGz1yQd0FjM+dJ3zBPY7kWWX0BAepujEy
         B0rIjdFhlP24gElV5/X3YMNSxkww59fgjkVGTad5O92J+/njh17oPYTfbM5B7a3NrsxH
         MpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Rcg5ibwjG8y5aZAcf4B6F5Z9gExCdMlFDQO0Lciu24=;
        b=aPw+rrlILj0HqI+msV6bistyInhqEz5DAiFqAesjjUdr4zEFna/kszUR9N7OSlKoYN
         pKlC93m1p+xfMsyhBnQnk6z4OJGzQ9JnO164ITe6mGr0/Z2Gnf4GFHyzagT14dgQ3gis
         xQEaJARqwA3sMyTPRzL5z2+884WTr40XK+Zal+/QfR/n09i7CWpvECcjYBowyvKU2kc9
         n11URoGECkFuQt7KqruPwTFRQq4eL2pHOltxWXgW9JSHD4sBUhXR0YC3Bn0Pj44wx4A0
         H+wAX15MkUqBQKGLHBI1HtJ1Rj8Rfte+D8kazqs+fRoE7BYH++iwy11n1ZV2lEEp3fZE
         u+jg==
X-Gm-Message-State: APjAAAXq9gqlynAtSIq0Fj6pv8ke2Gx08gs+4gFF8/dxSvyqqyyjR8+I
        OCRrFY3z8VfuZwZxXo0J7HdkoJHq2c9Iwq4gvO2y/A==
X-Google-Smtp-Source: APXvYqxjZclUu0eB6nMi8sSpfdOj8OZ6c2MrV6ct440WVHQXTLBSRRbC9HlKNRn8NRGFiuthiYpgPudrQf4lSXaDVdI=
X-Received: by 2002:a02:c906:: with SMTP id t6mr73461739jao.75.1578341902473;
 Mon, 06 Jan 2020 12:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-8-pomonis@google.com>
In-Reply-To: <20191211204753.242298-8-pomonis@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 6 Jan 2020 12:18:11 -0800
Message-ID: <CALMp9eSvJYzuYmn6sUo5zNGLAmA=d_Pu4DcmCQTMAFCP_dBHsg@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] KVM: x86: Protect MSR-based index computations
 in fixed_msr_to_seg_unit() from Spectre-v1/L1TF attacks
To:     Marios Pomonis <pomonis@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:48 PM Marios Pomonis <pomonis@google.com> wrote:
>
> This fixes a Spectre-v1/L1TF vulnerability in fixed_msr_to_seg_unit().
> This function contains index computations based on the
> (attacker-controlled) MSR number.
>
> Fixes: commit de9aef5e1ad6 ("KVM: MTRR: introduce fixed_mtrr_segment table")
>
> Signed-off-by: Nick Finco <nifi@google.com>
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Reviewed-by: Andrew Honig <ahonig@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Jim Mattson <jmattson@google.com>
