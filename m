Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12181C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2442184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554479762;
	bh=AIUQmEJXDsY3GEcph7bSt7nxSpV0ues5FfD1PAAI9Ts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pyOC7R/HnEak1MUye82erLeSZ5heb6xUFWk1PoYN4uvxtSd8+E3y4azpjwyvuwuMC
	 XCFmLhCHmGDumoPNWkhSmRiM12SNPHMlYumSeGIJVm22ucDTInlWtWUYx82v1OiLSk
	 GB3O/hbiN/1m5HMpljQZvc7LCW5LdgypO1MI23pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbfDEP4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:56:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36876 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDEP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:56:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id o19so4745974lfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKgYB2mVUR0Dy1jeWmsQ2zw6whgBFdaTcN8ryeRQxYU=;
        b=En7g5DbTB0+7aRdhu8OBnPnZ9+ZlEJaR1r9ErWCI+duw4vATeEzKPCRpAobF+WRmk0
         hjvTnZyoeMFjMTq3zXPjuW/XYqOBeZHT/hrtOM1N71erTIThOhp34DIwLc57sfvEujgh
         I7shJ5vNJcv7aef6f+haCIepXeGasfuxVCBn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKgYB2mVUR0Dy1jeWmsQ2zw6whgBFdaTcN8ryeRQxYU=;
        b=VAj83QXLGCzA3Zp5GOIXb1jkxIgo0msllKFoc6grLvUEtIG4EJ/xNkesdUN1+XkZYz
         +46Pmamshge0sxbzxskPcxCLL8G6pWm1Pp592r8D+gxsE4nKIRj9OTSdw2R6WB/YRxVu
         G8zry10Lhwx8LiNNC7HPxoL9l1Mq1Ib9Twr3X2kG7WcDt/8Uv6Da2uS53oveDHTKPmUs
         wzuWs8XvABeM4gBnjbmWQoqDiuawpSEYj+MI0oHGIXJtxpygINQSxTs2Hxjw/NdyYUYG
         gE6hto3jLANqdNRyIG/4ga61mxaw2ptc6sN4sXw4Mie35QGOAgFbX0lrLHN1kktjCIo+
         cEzA==
X-Gm-Message-State: APjAAAXFpAYFCV1PPof4B744+AFtv2nc/b5Reh0cthBwcQBHCI4sylk8
        9n9p/ROmH4TKgQ77Zgs7RIFMq6Nimu8=
X-Google-Smtp-Source: APXvYqxZ/uC/H9cJ2g3nPvxetceXX2mHLOoVEbLCUncko/AjceN8H63C1yF6AdvjZugHCXzUJFc40Q==
X-Received: by 2002:ac2:5629:: with SMTP id b9mr3828841lff.100.1554479757141;
        Fri, 05 Apr 2019 08:55:57 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h6sm4427720lfj.77.2019.04.05.08.55.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 08:55:56 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id o19so4745897lfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:55:55 -0700 (PDT)
X-Received: by 2002:ac2:485a:: with SMTP id 26mr7146710lfy.128.1554479448457;
 Fri, 05 Apr 2019 08:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190405135936.7266-1-will.deacon@arm.com> <20190405135936.7266-18-will.deacon@arm.com>
In-Reply-To: <20190405135936.7266-18-will.deacon@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Apr 2019 05:50:32 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj6ymuXDS1Azr4fFJC7Z77zOfN5vaKZjDzUA4izvULWXg@mail.gmail.com>
Message-ID: <CAHk-=wj6ymuXDS1Azr4fFJC7Z77zOfN5vaKZjDzUA4izvULWXg@mail.gmail.com>
Subject: Re: [PATCH v2 17/21] drivers: Remove explicit invocations of mmiowb()
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 4:01 AM Will Deacon <will.deacon@arm.com> wrote:
>
> mmiowb() is now implied by spin_unlock() on architectures that require
> it, so there is no reason to call it from driver code. This patch was
> generated using coccinelle:
>
>         @mmiowb@
>         @@
>         - mmiowb();

So I love the patch series, and think we should just do it, but I do
wonder if some of the drivers involved end up relying on memory
ordering things (store_release -> load_aquire) and IO ordering rather
than using locking...

Wouldn't such use now be broken on ia64 SN platforms? Do we care?

So it might be worth noting that a lot of the mmiowb()s here weren't
paired with spin_unlock?

                    Linus
