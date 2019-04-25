Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D077C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F182067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VVf3dTts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfDYSdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:33:16 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45238 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfDYSdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:33:16 -0400
Received: by mail-yw1-f67.google.com with SMTP id r139so245732ywe.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzyf0v4+qorHObxQJIarsmYBRGRmN6zpccuNNSL44OU=;
        b=VVf3dTtsKaAfXBPBmVkoppyV2gw2xq6TYANFWb+6Vq5JFwilh3+tFe1/CG3OPPJkP6
         ruIfynbny0jjANfyWol12KMILx292VUx3a6BYRhTqG+Gh25Je6Zgv+QQyd7YelJCgYrM
         892XfsDOzraUvmp/rYU4O3fkw0CMCmp8mhbuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzyf0v4+qorHObxQJIarsmYBRGRmN6zpccuNNSL44OU=;
        b=EXJk7zIYEKzBq3lpDJ430MzIY/6JIl/qsrragPxmRgwbPTbRPwAxWo1zkJ17NShxkm
         0abeHslKRBKxA2cPi240dsbEl++6L4mEDAFT7XzG8kDgtfbxvHmhwXgbju/7/53QX1A4
         cL+lxYTscyvHAyFbG9Dtq7IS1oTmOaqHXF+3f4mb5xf4K7XNMHDQHSOhRaaQzr28fVaJ
         DCQh3CN0JD/nV0RVJ2udbPbJkMvuuAxxBmUBnezksdr1d7XvLT0+tGnLkgYAiP8v6sC4
         hPOXbkOrShCkuEPe2Xud/IY1LGYhEpuu4sKnybFCGBN1ZXB3221I35SiTKcdwu7+TL+K
         azMA==
X-Gm-Message-State: APjAAAXe0FJchwgbYq96OJMY1wdUEWMosDfpDqyiG/y/mdlXIyrs5nHC
        KONwdhi0w//agxn9H38D0kEU/rHzDY9NtZYT9P2p2w==
X-Google-Smtp-Source: APXvYqxdY8Iuvb3b5qXwyXA6A4/PdGfn314MhXhx7P5obwxet5ooms4jobZ+/QDqjAwgk6U13axMvCf/rqtRzdVurtY=
X-Received: by 2002:a81:7009:: with SMTP id l9mr32009686ywc.306.1556217195233;
 Thu, 25 Apr 2019 11:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190308005735.GA4122@archlinux-ryzen> <20190320190849.GB28744@archlinux-ryzen>
 <CAKwvOdkekJw-wLn=9K=xKE0X260MZCCRtD1r5Erp=fQTwn+p9w@mail.gmail.com>
 <CAK8P3a2gkvkDidV6t82RYj7sydaaGkUOVvrjfuKfPtdd9vj-eg@mail.gmail.com> <20190425181411.GB4507@archlinux-i9>
In-Reply-To: <20190425181411.GB4507@archlinux-i9>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Thu, 25 Apr 2019 11:33:04 -0700
Message-ID: <CACKFLikGY0=_FBosBdp2nq8F+Upmpo-Oi8kFeMH8diBEZP_0AQ@mail.gmail.com>
Subject: Re: -Wsometimes-uninitialized Clang warning in drivers/net/ethernet/broadcom/bnxt/bnxt.c
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Eddie Wai <eddie.wai@broadcom.com>,
        "jeffrey.huang@broadcom.com" <huangjw@broadcom.com>,
        "prashant.sreedharan@broadcom.com" <prashant@broadcom.com>,
        "michael.chan@broadcom.com" <mchan@broadcom.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:14 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi Arnd,
>
> On Fri, Mar 22, 2019 at 03:32:50PM +0100, Arnd Bergmann wrote:
> > On Wed, Mar 20, 2019 at 9:41 PM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> > >
> > > + Broadcom folks from commit c0c050c58d84 ("bnxt_en: New Broadcom
> > > ethernet driver.").  Looks like Michael wrote and is still maintaining
> > > the driver.
> > >
> > > On Wed, Mar 20, 2019 at 12:08 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > On Thu, Mar 07, 2019 at 05:57:35PM -0700, Nathan Chancellor wrote:
> > > > > Hi all,
> > > > >
> > > > > We are trying to get Clang's -Wsometimes-uninitialized turned on for the
> > > > > kernel as it can catch some bugs that GCC can't. This warning came up:
> > > > >
> > > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:6: warning: variable 'len' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> > > > >         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
> > > > >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1703:19: note: uninitialized use occurs here
> > > > >         cpr->rx_bytes += len;
> > > > >                          ^~~
> > > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:2: note: remove the 'if' if its condition is always false
> > > > >         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
> > > > >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1540:18: note: initialize the variable 'len' to silence this warning
> > > > >         unsigned int len;
> > > > >                         ^
> > > > >                          = 0
> > > > > 1 warning generated.
> > > > >
> > > > > It seems like the logical change to make is this; however, I am not sure
> > > > > if this has any other unintended consequences since this is a rather
> > > > > dense function. I would much appreciate your input, especially if there
> > > > > is a better way to fix it.
> > >
> > > I agree that `goto next_rx_no_prod_no_len` appears to be most correct;
> > > though I don't understand why this function is a mix of early return
> > > codes, vs setting rc then updating *raw_cons.  The alternative is
> > > probably zero initializing len, but I'm not sure whether *raw_cons
> > > should be updated in that case or not.  Thanks for bringing this up
> > > and the patch.  Sorry for the delay in review.  Can folks at Broadcom
> > > please clarify?

Sorry, I somehow missed this email earlier.  "goto
next_rx_no_prod_no_len" is the most correct fix.  The "cpr->rx_bytes
+= len" logic was added about a year ago when we added the DIM
(Dynamic Interrupt Moderation) support and we missed fixing this goto.

I can prepare and send the patch later today.  Thanks.
