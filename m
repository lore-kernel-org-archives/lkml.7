Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DD7ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8E82064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571176150;
	bh=xHnNpqc3N61JqT/+Rx2uGWGhU95oyzbi5PShcD2/BKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O3P01GRWNagfgXqOkrHnoKdQdQrMmHoPr7kAM3GFCoW+TwM8maZ1fGOfag43kDBEo
	 72s+5idiSGlZPWduh4g7vlPWvmjep6lZUxiHM6GMWlSrCnV1xpi4LSC/uiuhCjrqHw
	 4qYXi1R3CtrU3RKiknDZHiTne8dddAooLWhjXFzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbfJOVtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 17:49:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38726 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfJOVtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:49:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so21841403ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 14:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wItDXbX3LEWoTo1/kp4dk8aeAZ/2xJzKQP/tyONQ97k=;
        b=hzBYiXjPBdQglMHyHwZdH7Hfwgp8qRgeHE6/0plo981vFS0npABggAoHWs92Y0M4j4
         6yInWWbjRDRm/aBcc9LUQovQyVPjXs9u2abaLNMMyRfQw3SRznL+/RbI8WTdojuOz1np
         +b80D6JSR28AZDW+EGzyd7AudQJVj7qyOksd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wItDXbX3LEWoTo1/kp4dk8aeAZ/2xJzKQP/tyONQ97k=;
        b=Zb2DSQb84rMTjOHpXwIXEwsMhJ0+1Ay4I+EjIdGfvG/TkhW/cRaURHVOoSI15qbuyA
         dJitIq6dLAOzl2Eqef66pYqEqGMaZH8coKByQN0+rs3kVFM81TG48xE8XSwDo/835a3O
         blzEGzwDoAivoF9XiLDOrMR5S/d4uReXPNkuoHGbkxplR4zZsf5HHZuc28KiKswous9t
         6fzMZcS1TL6mTzPKAzTNs6zcsW+g57kcJnNwZ9soSc114O3Y0fT2mN2LXznvytldUoJh
         Q27Tsae75qQEsqf2i24W5T3MwqlyFPiDhAdRKlvpNXlMR8WyUpxKxYUa+NAlUpqeLXiU
         eOQQ==
X-Gm-Message-State: APjAAAVv93JQZ5G9LqP1gOmrgVPUr29+SBAzcGDemDZP2ZmJTww+3R3y
        3BWhotpi518xnR24vlgcfRFuJTHPcj0=
X-Google-Smtp-Source: APXvYqyiVPGFSwmJcMom5H1/F7MbLgdSm4aydtjMMA476umVmuC8Qieu1vxqBqAUvQW8hwsGcorGbw==
X-Received: by 2002:a2e:55d7:: with SMTP id g84mr24223235lje.255.1571176140244;
        Tue, 15 Oct 2019 14:49:00 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id q24sm5258562ljj.6.2019.10.15.14.48.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 14:48:59 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 195so2723350lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 14:48:59 -0700 (PDT)
X-Received: by 2002:a19:5504:: with SMTP id n4mr4137650lfe.106.1571176138790;
 Tue, 15 Oct 2019 14:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191015191926.9281-1-vgupta@synopsys.com> <20191015191926.9281-2-vgupta@synopsys.com>
In-Reply-To: <20191015191926.9281-2-vgupta@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 14:48:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3QC7tj3rmTPg5RmK_ugVKYs-jKqX=TaASWfd73Owaig@mail.gmail.com>
Message-ID: <CAHk-=wi3QC7tj3rmTPg5RmK_ugVKYs-jKqX=TaASWfd73Owaig@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ARC: mm: remove __ARCH_USE_5LEVEL_HACK
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 12:19 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> This is a non-functional change anyways since ARC has software page walker
> with 2 lookup levels (pgd -> pte)

Could we encourage other architectures to do the same, and get rid of
all uses of __ARCH_USE_5LEVEL_HACK?

            Linus
