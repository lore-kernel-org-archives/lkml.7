Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDD3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951F0218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfCVOdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:33:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39171 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfCVOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:33:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so2711966qte.6;
        Fri, 22 Mar 2019 07:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucroH62Z3+m2/IWfOSDNop/GJa9ZKRAtJCMbCNKWvLk=;
        b=nxaW2lHL6hSDRYFRALaOvt0RJGBJH4Iog9UTpUBkEAafJOas2AfziT4OEzVHvO3PMA
         T6YA/NAzxTAMP8P/zsWJraacilnk3fDoH/T3pxiQMJjUYhKMYxbURm1cQLpsGxcQKbmB
         j1wVRsBv/K4Gpwfjc39hclARzmkxvKuklRHPSM7z1AowF3zOq2vMY6U0GlCEwg05ZnQ2
         D39Wq837iD+Fm6mEZr38uNpVswQhrJQrRRjqdGE68jfUtADfv9bGFAscIPDLQijWZq66
         d9qHYc95XLmQZiae1s0MxR3CWw/uGwb1AJE9hMnahoeDwI38WziyECNd88ehOZr7QKpm
         QZbA==
X-Gm-Message-State: APjAAAU/oI+wFhDNUY2IJNHtJ/xsmi+XGxvYb/OzX2Vc7cX8kKZF9gjX
        OT9ZpnvCxBPBinyxgdGTHfE9Lntbvu+wMcTMvT0=
X-Google-Smtp-Source: APXvYqztQWU0DMqQX4oIC+/tYeN44ZN+ymJ8gpoGf+KKJvo4IyuepmTY06qQKqbYrXdDf1gZ2wVtLwvfMa81a2Mt8xY=
X-Received: by 2002:ac8:2692:: with SMTP id 18mr8316983qto.343.1553265187918;
 Fri, 22 Mar 2019 07:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190308005735.GA4122@archlinux-ryzen> <20190320190849.GB28744@archlinux-ryzen>
 <CAKwvOdkekJw-wLn=9K=xKE0X260MZCCRtD1r5Erp=fQTwn+p9w@mail.gmail.com>
In-Reply-To: <CAKwvOdkekJw-wLn=9K=xKE0X260MZCCRtD1r5Erp=fQTwn+p9w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 15:32:50 +0100
Message-ID: <CAK8P3a2gkvkDidV6t82RYj7sydaaGkUOVvrjfuKfPtdd9vj-eg@mail.gmail.com>
Subject: Re: -Wsometimes-uninitialized Clang warning in drivers/net/ethernet/broadcom/bnxt/bnxt.c
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Eddie Wai <eddie.wai@broadcom.com>, huangjw@broadcom.com,
        prashant@broadcom.com, mchan@broadcom.com,
        vasundhara-v.volam@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 9:41 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> + Broadcom folks from commit c0c050c58d84 ("bnxt_en: New Broadcom
> ethernet driver.").  Looks like Michael wrote and is still maintaining
> the driver.
>
> On Wed, Mar 20, 2019 at 12:08 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Thu, Mar 07, 2019 at 05:57:35PM -0700, Nathan Chancellor wrote:
> > > Hi all,
> > >
> > > We are trying to get Clang's -Wsometimes-uninitialized turned on for the
> > > kernel as it can catch some bugs that GCC can't. This warning came up:
> > >
> > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:6: warning: variable 'len' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> > >         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
> > >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1703:19: note: uninitialized use occurs here
> > >         cpr->rx_bytes += len;
> > >                          ^~~
> > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:2: note: remove the 'if' if its condition is always false
> > >         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
> > >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1540:18: note: initialize the variable 'len' to silence this warning
> > >         unsigned int len;
> > >                         ^
> > >                          = 0
> > > 1 warning generated.
> > >
> > > It seems like the logical change to make is this; however, I am not sure
> > > if this has any other unintended consequences since this is a rather
> > > dense function. I would much appreciate your input, especially if there
> > > is a better way to fix it.
>
> I agree that `goto next_rx_no_prod_no_len` appears to be most correct;
> though I don't understand why this function is a mix of early return
> codes, vs setting rc then updating *raw_cons.  The alternative is
> probably zero initializing len, but I'm not sure whether *raw_cons
> should be updated in that case or not.  Thanks for bringing this up
> and the patch.  Sorry for the delay in review.  Can folks at Broadcom
> please clarify?

I also came up with a workaround for this, but did it the other way round:

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0bb9d7b3a2b6..48bdb87574c3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1608,6 +1608,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct
bnxt_cp_ring_info *cpr,
        }
        *event |= BNXT_RX_EVENT;

+       len = le32_to_cpu(rxcmp->rx_cmp_len_flags_type) >> RX_CMP_LEN_SHIFT;
        rx_buf->data = NULL;
        if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
                bnxt_reuse_rx_data(rxr, cons, data);
@@ -1618,7 +1619,6 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct
bnxt_cp_ring_info *cpr,
                goto next_rx;
        }

-       len = le32_to_cpu(rxcmp->rx_cmp_len_flags_type) >> RX_CMP_LEN_SHIFT;
        dma_addr = rx_buf->mapping;

        if (bnxt_rx_xdp(bp, rxr, cons, data, &data_ptr, &len, event)) {

Presumably one of the two is correct here, but I don't know which one ;-)

       Arnd
