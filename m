Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDB7C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A8C22DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566325112;
	bh=hcIvAsln8wnzEQJDDI78pze/r/Emfk2TeN8p3rRa7yI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TGtdMo1Vm6ZdqjWe8D3EiATzQ97z4Jfow79sizcmE2oLVpVXOfHBoJoCeTGqEB178
	 kmNFlIzakEXbmqQw68kQoRCjngktQ7LzWbB3EDkZBadPDqU5R45db8wajnmmSKUCge
	 EbFNCOBCdyk+gXrmsO0vJljMQlkZcpkyNVFa3Yps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfHTSSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 14:18:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38036 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTSSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 14:18:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id x3so6021696lji.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 11:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Unj7sanS3yNoODbxunZyoxiRdRfNXJRcFXpspCkwhBc=;
        b=KOvRx7eNsZutcVb2h/CbGzFJ9FNMrazQic+Ap+XmQTajkv+xMrbfqrXHkSpDa0bsaj
         ROpKfpQNulGzgJK8T4yC+5oDleaylYeC85eUjeW+NcvvoAkFYgKA4KnRjVK4a8feReTH
         tGa8fFBrbbu8Rzi8iOR9f2c5H275q8S7KqwB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Unj7sanS3yNoODbxunZyoxiRdRfNXJRcFXpspCkwhBc=;
        b=KQEfJuqDWoLBHmMpHdNc/X69Kyo1iP8begDYr4iHt4K4hzAaxXJgcREi29wcIF6N/H
         tdElP+ZchhREzNtpStBgT211Mia1O3MPuITVyPRSGLSl8VXNbIBrIUpt3O/Q0uNQlyz7
         ZLaWwCNbvVBRAR/m5CndwierqQtl/iQ1QwC26lNlNYfveSCruXeUmVtw3vsFgVYag2rF
         IwGONyBXz6yXxtxZ95UoI3sTXZRJ+uf+OnMLArvfDe9YegfpfRee9bExICL5y3D1MQDl
         rA3smpFO1Pq3EeLhVskxvEqENdUTzRVqIRNJVWewBKw2NgP3ZH4/YGCT2wVC5R8tID8N
         klNw==
X-Gm-Message-State: APjAAAXSARTLsqLwl94VUy+MN4LhFVmu38zB4cLpCm0E9/S5UDjZVk+A
        wM7XeP4lOZuBJWsJBubtuQ5reYDakno=
X-Google-Smtp-Source: APXvYqzQhBQTR9cF4McEPqnZmUs2Qdw9nzdEZ1mCVOyQyIt9++RDoO//cKiWzdkStHdILNjhGjCAOg==
X-Received: by 2002:a2e:9981:: with SMTP id w1mr9568640lji.155.1566325108824;
        Tue, 20 Aug 2019 11:18:28 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id j14sm2889673ljc.67.2019.08.20.11.18.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:18:27 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id t14so6039838lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 11:18:27 -0700 (PDT)
X-Received: by 2002:a2e:9702:: with SMTP id r2mr15019171lji.84.1566325107442;
 Tue, 20 Aug 2019 11:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190524174357.GC9120@fuggles.cambridge.arm.com>
 <CAHk-=wijeJ5OjswsUkm0Fns=0kd7kgRo98uPsJE3HQfwP5mBRA@mail.gmail.com> <20190820093709.GD14085@fuggles.cambridge.arm.com>
In-Reply-To: <20190820093709.GD14085@fuggles.cambridge.arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Aug 2019 11:18:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxG=phQsXxfmeS83MEsks55faRODxxrxfCzdiEideGqg@mail.gmail.com>
Message-ID: <CAHk-=whxG=phQsXxfmeS83MEsks55faRODxxrxfCzdiEideGqg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: Second round of fixes for -rc2
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 2:37 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Thanks to the tech comms folks at Arm, this should now be available and
> work is ongoing to open up more of the documentation too.

Thanks.

> For example, the A76 SDEN is here:
>
>         https://static.docs.arm.com/sden885749/d/Arm_Cortex-A76_MP052_Software_Developer_Errata_Notice_v16.0.pdf
>
> and if you hammer "cortex a76 1463225" into google, then it shows up
> after the Linux hits.

Yeah, I have long since given up on trying to keep track of everything
going on, which is why "google finds it" is important to me. And I
verified that yes, now google finds the ARM errata ;)

Lovely,

             Linus
