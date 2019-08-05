Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE3CC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F302147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXpsRxvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfHEV7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:59:43 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40703 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfHEV7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:59:43 -0400
Received: by mail-yb1-f195.google.com with SMTP id j6so7740793ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fd7ZnrQMa7ZTXSUJY+OfZXB5pnyekIxx1tLCZQSFfD8=;
        b=BXpsRxvoHH04OvpOdGBmJ0QXuITzxTFNIOhcG8XhG68lEmgWGHmQpovE4y46CpWyjc
         R+0EgMtLT0PosjnnLZP4MRfzn1hWkCCax6cJfwwO1GbSf9Ygr23rpiArWWZzI+ZSzpl5
         LAYdh1hRBWJVmiRFx/4IG1ymxnTXEMXisV/EsiA6Pa7CynTstAeiqSQxTwByYZLI2dKk
         xhfKZ9vfUJeRQNPDagpEcXb83oSHNgtnewiVmL0HDiR7iB2FuFUau/DhZNHN3tVcFwKV
         iBeFdB64VN0xpHekrmqXg5Vyo1L8Q09X+ZB+KhVwMW73JwQRCRWpHHNfTEswU7pM5F+M
         Umjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fd7ZnrQMa7ZTXSUJY+OfZXB5pnyekIxx1tLCZQSFfD8=;
        b=hUyAPeWkpDMHBv6Rxo6WlubDHrZCgXWQ92oKBe2CWOlqqQdSaAAnpCyS2mnaFLK+qT
         5LDK7bLcLFgcj+krbk3MT3g5aWxmqw5z4r7AADNZtO1Et+eSkRVAMPUawNjrO6pszXRX
         ynqSkd9GL4+2bGeDuUTHZ8s99pLrWYQRLLEzC2dLdNeQ7nW2VSselohmMWL7Hpkn5WJh
         7KcgPFdtnL58ylixiuDMWjAMSYpZuMxMMNO6vDVwQZZI0Qciel+9sXLgRX9861inSgvS
         AJe1vLRIsAnKqVix5zDBEXnYgdL4lKHGFvbo88fMJwSwCa7IYOLw4dtbTapx/vDAq4Qg
         wDtw==
X-Gm-Message-State: APjAAAXsnQfEyzsYZksiUtd5Gr2q7tTph4/sHio9Fmf6xB9ve2PPHN+p
        NFfla7eQHORCA7FOFJCr3sFWBL+S
X-Google-Smtp-Source: APXvYqx0PqWHmqzxJfI5fcwl7uAWaHUcZH5gSer0wKekptSoN1pTyFLFr6RAS/t8rlK8OO4t795sFg==
X-Received: by 2002:a25:9782:: with SMTP id i2mr255930ybo.437.1565042382029;
        Mon, 05 Aug 2019 14:59:42 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id r85sm19553403ywg.59.2019.08.05.14.59.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 14:59:41 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id j6so7740761ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 14:59:40 -0700 (PDT)
X-Received: by 2002:a25:2516:: with SMTP id l22mr241544ybl.441.1565042380444;
 Mon, 05 Aug 2019 14:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190802105507.16650-1-hslester96@gmail.com> <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F174@ORSMSX104.amr.corp.intel.com>
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F174@ORSMSX104.amr.corp.intel.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 5 Aug 2019 17:59:03 -0400
X-Gmail-Original-Message-ID: <CA+FuTSf5vWxBxCBEzCGmUg+BMUS=JOk1nzcG7X9Kt-evAxmeiw@mail.gmail.com>
Message-ID: <CA+FuTSf5vWxBxCBEzCGmUg+BMUS=JOk1nzcG7X9Kt-evAxmeiw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH 2/2] ixgbe: Use refcount_t for refcount
To:     "Bowers, AndrewX" <andrewx.bowers@intel.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 5:43 PM Bowers, AndrewX <andrewx.bowers@intel.com> wrote:
>
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> > Behalf Of Chuhong Yuan
> > Sent: Friday, August 2, 2019 3:55 AM
> > Cc: netdev@vger.kernel.org; Chuhong Yuan <hslester96@gmail.com>; linux-
> > kernel@vger.kernel.org; intel-wired-lan@lists.osuosl.org; David S . Miller
> > <davem@davemloft.net>
> > Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: Use refcount_t for refcount
> >
> > refcount_t is better for reference counters since its implementation can
> > prevent overflows.
> > So convert atomic_t ref counters to refcount_t.
> >
> > Also convert refcount from 0-based to 1-based.
> >
> > This patch depends on PATCH 1/2.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 6 +++---
> > drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
>
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

To reiterate, this patchset should not be applied as is. It is not
correct to simply change the initial refcount.
