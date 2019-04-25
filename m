Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28E6C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B85D20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiGIee8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfDYSOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:14:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41934 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbfDYSOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:14:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so701055edd.8;
        Thu, 25 Apr 2019 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mSYDqetsZPJeQHMyd/mvWooQeI0Yrfu3YJ3J34U92a0=;
        b=jiGIee8qd82UJQVY+TdyOK2DgYWyjkraGP0mAq6U47RUXJmEQfpHlxdQbsXtLkOeed
         3kdDZVrDvoY1gudXBA5M3nIxqDBz+SIpYpLp97TfwvzxoWA+l4yTPaebX/bQlyvHI+o3
         DgjOOZB96GOFMJFQHp1WLSJllwQRig3zOu1xu+RsjKJgIPRGZwyBGTzhuMyM3U+heivG
         BKfLRZIxbVlKMHUysXSt/wY96dQzwznkel87fRRdWMiOksRQk4r/jaRyxpuD0NSKQRo/
         PXWHl2hwddsI+5qPV8N+5/jrYlOjmofdm0q0MXb5EnPkSi+/N5mEuc+klc0ie8Pg2pfL
         6Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mSYDqetsZPJeQHMyd/mvWooQeI0Yrfu3YJ3J34U92a0=;
        b=BuWpFNkjaR2Hc3ZIbuND6zDrNVu+ZYdRN77sgZmKAcl48Sqg/OE855SsX534cI6xOc
         CiKMOYN9GdDDESK9sRL5bX/+1fJMJVjF2gCMxMK1r4JdatJlF8YV1e1YH3i3S/hvqxXp
         tL62MgY9byBiY/2+D+fEhhDwQqsQ37SBdmOjBTsRqyyh0zflpcoVR3+Zql9eETbYd9Df
         Isb7vzuWS9fYloxukt+R7NDtqH9R1cqWWYJnFPYLY1tCBRjvepwEKkg7g1B7dHRUzSUy
         bsZ4lWbSdrsNnylvU/b+D0xSp7Uf3pHYceuxeOQR0DYm7U5WIV7E/90n7QsOARW97iNk
         GsUQ==
X-Gm-Message-State: APjAAAVWGjIs094eWwEndQyZqSqN0/0fkci9jfcbSG4kjmmpjanW7Wb1
        QY+2/x/rgRkIQwJgo2VeqZE=
X-Google-Smtp-Source: APXvYqw+CDR6bs3INoBwrJOcMD6V2UgPo7smWH9y3oHd4OGkmDWAwrg5SH+TE0FrS7vXaZuNnHLA5w==
X-Received: by 2002:a50:9161:: with SMTP id f30mr4029676eda.47.1556216053958;
        Thu, 25 Apr 2019 11:14:13 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id d17sm6408995edp.84.2019.04.25.11.14.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 11:14:13 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:14:11 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Eddie Wai <eddie.wai@broadcom.com>, huangjw@broadcom.com,
        prashant@broadcom.com, mchan@broadcom.com,
        vasundhara-v.volam@broadcom.com
Subject: Re: -Wsometimes-uninitialized Clang warning in
 drivers/net/ethernet/broadcom/bnxt/bnxt.c
Message-ID: <20190425181411.GB4507@archlinux-i9>
References: <20190308005735.GA4122@archlinux-ryzen>
 <20190320190849.GB28744@archlinux-ryzen>
 <CAKwvOdkekJw-wLn=9K=xKE0X260MZCCRtD1r5Erp=fQTwn+p9w@mail.gmail.com>
 <CAK8P3a2gkvkDidV6t82RYj7sydaaGkUOVvrjfuKfPtdd9vj-eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2gkvkDidV6t82RYj7sydaaGkUOVvrjfuKfPtdd9vj-eg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Mar 22, 2019 at 03:32:50PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 20, 2019 at 9:41 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > + Broadcom folks from commit c0c050c58d84 ("bnxt_en: New Broadcom
> > ethernet driver.").  Looks like Michael wrote and is still maintaining
> > the driver.
> >
> > On Wed, Mar 20, 2019 at 12:08 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Thu, Mar 07, 2019 at 05:57:35PM -0700, Nathan Chancellor wrote:
> > > > Hi all,
> > > >
> > > > We are trying to get Clang's -Wsometimes-uninitialized turned on for the
> > > > kernel as it can catch some bugs that GCC can't. This warning came up:
> > > >
> > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:6: warning: variable 'len' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> > > >         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
> > > >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1703:19: note: uninitialized use occurs here
> > > >         cpr->rx_bytes += len;
> > > >                          ^~~
> > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:2: note: remove the 'if' if its condition is always false
> > > >         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
> > > >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1540:18: note: initialize the variable 'len' to silence this warning
> > > >         unsigned int len;
> > > >                         ^
> > > >                          = 0
> > > > 1 warning generated.
> > > >
> > > > It seems like the logical change to make is this; however, I am not sure
> > > > if this has any other unintended consequences since this is a rather
> > > > dense function. I would much appreciate your input, especially if there
> > > > is a better way to fix it.
> >
> > I agree that `goto next_rx_no_prod_no_len` appears to be most correct;
> > though I don't understand why this function is a mix of early return
> > codes, vs setting rc then updating *raw_cons.  The alternative is
> > probably zero initializing len, but I'm not sure whether *raw_cons
> > should be updated in that case or not.  Thanks for bringing this up
> > and the patch.  Sorry for the delay in review.  Can folks at Broadcom
> > please clarify?
> 
> I also came up with a workaround for this, but did it the other way round:
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 0bb9d7b3a2b6..48bdb87574c3 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -1608,6 +1608,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct
> bnxt_cp_ring_info *cpr,
>         }
>         *event |= BNXT_RX_EVENT;
> 
> +       len = le32_to_cpu(rxcmp->rx_cmp_len_flags_type) >> RX_CMP_LEN_SHIFT;
>         rx_buf->data = NULL;
>         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
>                 bnxt_reuse_rx_data(rxr, cons, data);
> @@ -1618,7 +1619,6 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct
> bnxt_cp_ring_info *cpr,
>                 goto next_rx;
>         }
> 
> -       len = le32_to_cpu(rxcmp->rx_cmp_len_flags_type) >> RX_CMP_LEN_SHIFT;
>         dma_addr = rx_buf->mapping;
> 
>         if (bnxt_rx_xdp(bp, rxr, cons, data, &data_ptr, &len, event)) {
> 
> Presumably one of the two is correct here, but I don't know which one ;-)
> 
>        Arnd

Did you want to submit this a formal patch? Since no one from Broadcom
has chipped in yet, it'd probably be better to submit this for review
and get comments that way. I cannot imagine that this is any worse than
what is currently happening (adding uninitialized stack memory to
rx_bytes when jumping to next_rx) and I like it better than modifying
the goto statement.

This is the only other warning I run into in arm, arm64 and x86_64
all{yes,mod}config so I'd like to get it resolved soon so we can turn on
this warning for the whole kernel.

Cheers,
Nathan
