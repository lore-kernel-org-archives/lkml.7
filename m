Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ECDC33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C406207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8n4416R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgAFURc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:17:32 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36754 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgAFURc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:17:32 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so43662482iln.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CX2u59yxqQEiQeQX3TdwASVbTfuTtyRiCwtCS2hV9M=;
        b=r8n4416RC0OjW2zQZKUoUGwBPq+fLIjkEFiWRwI2k9OC6xfH8LexxBEoS0JBAKL4ep
         glcWvgtALerSfVE7MX3hVQsEzoDEMEvdBi2XV5OuFjQ/+rHFaGLv0Y6TVIKJeGE2K4xr
         hPGAu2ZsOO47P84w3U2lb5Pq6FkNZ97fG315dOqz+ZHZ92dKtbrauczGHZ4UiFER5Qzw
         tvRcP0oEPyL8O/VjBoyZq1h3n8jcz936VNWZIW7jJO35SZiO6p4mFIjXs27PSe3mz4hr
         vLfja4o0UrgiZvGv7Wem6QD7qJ7tYB3zq9tgK/CX8e77skiBewq9ETOr5AZrOs8zMWm2
         1CWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CX2u59yxqQEiQeQX3TdwASVbTfuTtyRiCwtCS2hV9M=;
        b=fgIavtq3SshKRa7FiwedoitjuA1RxJSFAVUU/xylbNLQUIK+mZ2eb83g9tudRtCT0A
         Jpkgk5cAzAes0l2lt5UVrNSc/meoGU5h95r18f3sASCBDbUbSdpUElRPJKc7bAZrn/bO
         gHzMerLs6tX1ET0QKMMIhV5dd7oesZ/bPH7zJr/HV/QU5fodIN0CERWlGZFM3cmzGe3a
         tjZL4pvzz6IwHfZicSrrMqN/lo4S8qWuPp2sHg0hPW26a0HXKngTcwmiToNweY3EWXnW
         jC4zb3zTQBnOTq/Nm6W/VvspKeckBlVPjOWpzgkR94h2URuS+EAy/kQH/WxlRgkgQ9hi
         gFhg==
X-Gm-Message-State: APjAAAWAPRE0QgBVCSLbBw55LQOGD551tAacq2ReXtAz5NN14YJPD+Ow
        AqIqlILe3abX6OQwe/SvJ3wiLouVN00iSyLDmsnVNQ==
X-Google-Smtp-Source: APXvYqyReQmw36zPln5QfGWBGVhIpVbv13BJN1T5wbGPlk3lk3Azd0+w4PYXRQmNj1E1SHsoTt2laBhaYWd3jSRwsW4=
X-Received: by 2002:a92:8458:: with SMTP id l85mr88666783ild.296.1578341851389;
 Mon, 06 Jan 2020 12:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-5-pomonis@google.com>
In-Reply-To: <20191211204753.242298-5-pomonis@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 6 Jan 2020 12:17:20 -0800
Message-ID: <CALMp9eTCTj-V0ihi0sQAkjOpKA2HzNY85WiX9LxRQODGvGN1aw@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] KVM: x86: Protect ioapic_read_indirect() from
 Spectre-v1/L1TF attacks
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
> This fixes a Spectre-v1/L1TF vulnerability in ioapic_read_indirect().
> This function contains index computations based on the
> (attacker-controlled) IOREGSEL register.
>
> Fixes: commit a2c118bfab8b ("KVM: Fix bounds checking in ioapic indirect register reads (CVE-2013-1798)")
>
> Signed-off-by: Nick Finco <nifi@google.com>
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Reviewed-by: Andrew Honig <ahonig@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Jim Mattson <jmattson@google.com>
