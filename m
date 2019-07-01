Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD98AC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92C721850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfGAMCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:02:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36380 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfGAMCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:02:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so15622920wmm.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 05:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7tQhKzs59ZO+mk5DflBxUJRkH1TY98DdollEajrbPNc=;
        b=ZX2rTFZHDm1oy3mxDLD19B01WTYc5qlVqseWgBRc6tCOvtFqMbF5a8yUYGp4HCTfdt
         JffYEsGcx5BPr2CMZShw/4+qCvcv8TxiZ7Zhuou2OcOWknAIAKXGcDuDvwePwhSkQqXd
         R6t6zyQanYoMM76UAfnBmiogtTVmXuTE7WpvQ8cKXj3pAlUeyCaERq5/W6caorUfywh+
         GNLtqt7N+59KBMZTCmC4rjRpQFb3Y5a9agkkpXfBP4a5aMTkfAg3vxyYiV9Qlgzwr0Yr
         TH3kA6LfOMm6bQ0qkLdZydGhPAEwqyTy44Gkw4EYsZ9jVbDeZizliNJ6yEn+t7ymv5Sl
         589w==
X-Gm-Message-State: APjAAAUYR3r9LPV9JB40P+ps3E0H5s13KjBzsiZIQHfDQE+9hbjZbmsx
        cjhRFY6yJ4RhEnlMlBHBiadQmA==
X-Google-Smtp-Source: APXvYqwNj/ZV25WU1NwD38ax6MSpDuhlv1dnFFf7FmXQzltR4cECI04ABeVz55YT2fuFIf9xwhZjVQ==
X-Received: by 2002:a1c:a186:: with SMTP id k128mr7622557wme.74.1561982556801;
        Mon, 01 Jul 2019 05:02:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d4d:4830:bcdf:9bf9? ([2001:b07:6468:f312:5d4d:4830:bcdf:9bf9])
        by smtp.gmail.com with ESMTPSA id v12sm8306849wrr.41.2019.07.01.05.02.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 05:02:36 -0700 (PDT)
Subject: Re: [Kernel BUG?] SMSW operation get success on UMIP KVM guest
To:     Li Wang <liwang@redhat.com>, ricardo.neri-calderon@linux.intel.com,
        tglx@linutronix.de, kernellwp@gmail.com, ricardo.neri@intel.com,
        pengfei.xu@intel.com
Cc:     LTP List <ltp@lists.linux.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ping Fang <pifang@redhat.com>
References: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5622c0ac-236f-4e3e-a132-c8d3bd8fadc4@redhat.com>
Date:   Mon, 1 Jul 2019 14:02:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/19 09:50, Li Wang wrote:
> Hello there,
> 
> LTP/umip_basic_test get failed on KVM UMIP
> system(kernel-v5.2-rc4.x86_64). The test is only trying to do
>      asm volatile("smsw %0\n" : "=m" (val));
> and expect to get SIGSEGV in this SMSW operation, but it exits with 0
> unexpectedly.

In addition to what Thomas said, perhaps you are using a host that does
*not* have UMIP, and configuring KVM to emulate it(*).  In that case, it
is not possible to intercept SMSW, and therefore it will incorrectly
succeed.

Paolo

(*) before the x86 people jump at me, this won't happen unless you
explicitly pass an option to QEMU, such as "-cpu host,+umip". :)  The
incorrect emulation of SMSW when CR4.UMIP=1 is why.
