Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274A5C4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB03121479
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 19:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV6Kb/eL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfIOTro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 15:47:44 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:37020 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfIOTrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 15:47:43 -0400
Received: by mail-io1-f41.google.com with SMTP id b19so13951818iob.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ps21+yPehanjsccA3pZUx6ng3VBZ3IcyIL4amI2VF5w=;
        b=YV6Kb/eLk881/ykb8u2SWxFYQbT5+5klEOmw9fV/zDtdCEXG2iqUY5MzfrwySkLxwA
         OOM5PQ+xIojQQ5LBiMmhcB1Wx7/Hbm9nPn9MaAN3E3WEh7tKYvWP+D+mbJHC+gq+ci7l
         lEFDRVXbFzHU/lcd1Xih/GPBSfzAkCin/NidSim9UJdwJkqPkFiNfr5Z30Zj2QUKbSAo
         U4YRgmm4KUwBTCm7oUOQYzyTyAEZLSpvbNJumG39JiW3FIaulBXeSfrqfgCrJkiStqPU
         VgB5aSWZ81AI8zwpnk8LBsy7iC45NMbOcu9iVQI4mMywSx+UeCI7D+CglgHmwcxaoNLh
         tqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ps21+yPehanjsccA3pZUx6ng3VBZ3IcyIL4amI2VF5w=;
        b=N2r0wsdkRTFQjyPdOHV+an7Do0Lqv9W1wETEBYQpdOdyb1cP7yibDrF6BeyyCVxlSx
         jwWxClsICMjbXKMP8CCUQCKHKWEDaZ7iBBvYnvFxMIxODUFrjXAj+3bI1aMsvX5Kv8NS
         mMQqdoUtWSMXkY3l3NpVJYGVJbv21/jUkm58FjaNdBFqqKbVAi+TTb7aBkQuGM5B4XD2
         qTbsmQ50A4e5cZnRGTnyBIoBeBabprFQ0Eqj0Y5ZrYJ5XASt/O5ZLKLCn8Uhu2LcnA2+
         vsJtReZ98SNuwz5C2+QIMFLqDfi7vBxZuzZ/t7FHOimlgkA50kZm6DNzn4WR/aHwvow8
         qPqA==
X-Gm-Message-State: APjAAAVbhW3f5KaVVBREPbIbvXap+hKAL1wMHDHoadVX3zgv0y/Ex9Of
        t/mj4bbSI9kuxmCF9CYrFkv1Qbv6w42HKIsI7/Y=
X-Google-Smtp-Source: APXvYqzouMT3490kgEIyPMulv062Ufqzn/3+z3GgV9OLnyn1nVykUuPn/Soja6AbuPnNw1wewiIpcMto3ChbI8F7FYM=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr5045599iop.36.1568576861178;
 Sun, 15 Sep 2019 12:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190830032948.13516-1-hdanton@sina.com> <CABXGCsNywbo90+wgiZ64Srm-KexypTbjiviwTW_BsO9Pm11GKQ@mail.gmail.com>
 <5d6e2298.1c69fb81.b5532.8395SMTPIN_ADDED_MISSING@mx.google.com>
 <CABXGCsMG2YrybO4_5jHaFQQxy2ywB53pY63qRfXK=ZKx5qc2Bw@mail.gmail.com>
 <CAKMK7uH9q09XadTV5Ezm=9aODErD=w_+8feujviVnF5LO_fggA@mail.gmail.com>
 <5d6f10a6.1c69fb81.6b104.af73SMTPIN_ADDED_MISSING@mx.google.com>
 <20190904083747.GE2112@phenom.ffwll.local> <CABXGCsMEjP-UQ5A1xpL-xWHxtFEsOUO14+cmWJUS1ff1hgReFA@mail.gmail.com>
 <CAKMK7uHQFpQjE8qxw5UUDg6xdbzcr0zaZ7P6WsBK7m0ksKdg3g@mail.gmail.com>
 <CABXGCsN_r6614xDft_FY5N-B1QRFkhz27Q5U7nnr=mwtOWyCUw@mail.gmail.com> <1d23703e-f6df-e663-a205-45c98cd125e8@amd.com>
In-Reply-To: <1d23703e-f6df-e663-a205-45c98cd125e8@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 16 Sep 2019 00:47:30 +0500
Message-ID: <CABXGCsNA+p8QCGPduiTfOwdYsk+qGMXL9JTGsQXGtnDEDy4-xg@mail.gmail.com>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux kernel <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2019 at 14:15, Koenig, Christian <Christian.Koenig@amd.com> wrote:
>
> I agree with Daniels analysis.
>
> It looks like the problem is simply that PM turns of a block before all
> work is done on that block.
>
> Have you opened a bug report yet? If not then that would certainly help
> cause it is really hard to extract all necessary information from that
> mail thread.

https://bugs.freedesktop.org/show_bug.cgi?id=111689
It'll do?

--
Best Regards,
Mike Gavrilov.
