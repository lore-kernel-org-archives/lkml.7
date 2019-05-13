Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE794C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FA921473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557762397;
	bh=OcS05eqt08syOJc9XJ+Dq4To3jKF7QcT29fpWx88obU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u/j0ffDpwBijWuu4BSSXv2/GlVFbdA+bKh45IFYuH8XgDK0K66Q5NDmoguB0HGNHW
	 8gHbjRNdJWjzcr63xsAnkReXyM4OVaIYRbpJLAMTG3TEctfLftld5o4TyyBIjr5BCn
	 D9soDPwwEwJYO0ltWBZ678mOfe8p+kPAk2ukP6kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfEMPqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfEMPqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:46:36 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B692147A
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557762395;
        bh=OcS05eqt08syOJc9XJ+Dq4To3jKF7QcT29fpWx88obU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mImlR6Is3TMf8fni+IDHdVAZsE7/1M0GTnfOaMuLRGfn1j1/BDu3RGxid6M+0vEiu
         TFTwQ6jlT+YHrBRxipQ8awjHA/fJy38yEvFDnls8nlN4k82xHuQ7q8V28aXBH0UBQe
         sppUfQgNAihbuliOSVH+T+E061V8MR3QzVezRa2w=
Received: by mail-wm1-f50.google.com with SMTP id 198so14357617wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:46:35 -0700 (PDT)
X-Gm-Message-State: APjAAAWcxwKKE9IUNqmeXVJxgo8SkpVyyPGvzVf8afbfATaeKkKYORwy
        m0MJ1vXtUzgv/k6FT/uTpGn9sXnDUQwQNGvbcCzYnA==
X-Google-Smtp-Source: APXvYqy0TwclFLqOX6RpVV3KoKOlZdQ8RNcD/rtLCLdFTmws6W80DbiuXvJEyd8KUstfYJ7nC31kdBiSQSFUT51LIs4=
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr16973110wmh.32.1557762394127;
 Mon, 13 May 2019 08:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <1557758315-12667-1-git-send-email-alexandre.chartre@oracle.com> <1557758315-12667-3-git-send-email-alexandre.chartre@oracle.com>
In-Reply-To: <1557758315-12667-3-git-send-email-alexandre.chartre@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 13 May 2019 08:46:22 -0700
X-Gmail-Original-Message-ID: <CALCETrUjLRgKH3XbZ+=pLCzPiFOV7DAvAYUvNLA7SMNkaNLEqQ@mail.gmail.com>
Message-ID: <CALCETrUjLRgKH3XbZ+=pLCzPiFOV7DAvAYUvNLA7SMNkaNLEqQ@mail.gmail.com>
Subject: Re: [RFC KVM 02/27] KVM: x86: Introduce address_space_isolation
 module parameter
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kvm list <kvm@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 7:39 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
> From: Liran Alon <liran.alon@oracle.com>
>
> Add the address_space_isolation parameter to the kvm module.
>
> When set to true, KVM #VMExit handlers run in isolated address space
> which maps only KVM required code and per-VM information instead of
> entire kernel address space.

Does the *entry* also get isolated?  If not, it seems less useful for
side-channel mitigation.
