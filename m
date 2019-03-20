Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F579C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB48218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNnN1UQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfCTUlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:41:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46655 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfCTUlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:41:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so2507045pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xfmFuvaJ0wiTzFqRDTGnHEWpM2PkxsELB6wVDBsD18U=;
        b=pNnN1UQ+XORt+TRWJwPDl7EEkMemyu8NvQuWdAK86UoPMlbgx+ooMYuciotXnR9A3F
         K9rxTov0MqI9m+UKsDKTXDBW9B/FzrlleM5Rk3OpuIZHAw6asvDavGX8tRJ/0lApaiLK
         UKaE4nIA0tjfxvCUZKTdhv3s31C3rzBtGMMbOLS+XamDuYH9imAAn8eUCelkjeEnmtIJ
         6qctFGTVxbOB64LKYNsoGmEIHyfwuIgz115VrDO0rJ5wBDibrguG3+c5/Zs9HqW19Bu/
         aBF8TkYJLiUeVOs01Lfvolj8Xe7lCelwoQ1xJqrAUrygIdFa6nwpUze7r+1bf6gdKDRA
         ybtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfmFuvaJ0wiTzFqRDTGnHEWpM2PkxsELB6wVDBsD18U=;
        b=YrS9X2Us0LLK6xLsFOKLut4lkkCG7YcNwYFEV7I7RuJ+omnk4bbajdS5CPeAq95tJ9
         JmTOdwncifCwllNIraZCx2Goi/wudqb2xSnie8RmIQW6Yg2KkxoIW34m9/unBYR310Jn
         wmKsJE+FxqbvHcfwMUAEQoiNADPlmkAEKl4NBDERuEqTnBy+moqCzjb+2N4Oue8x78sc
         gaS4d4obQrYPAwXaDQxff0JbycGutCA3WC0/aGhZaiRQ2R3h0ynIB0LVuIpSoGmVASQB
         OSEbmx/+vO5dDkfDGdCVJSwjL8ovZkrqH2S+hkjogOFy5ec7tTLtDeXyU8Rvo6hpcLfA
         wl5w==
X-Gm-Message-State: APjAAAXFClj7SLE1YfVmYv6OJG80i1v8FzWvyUJki1wEtrgtRuWnmkJp
        dShSPcWtagTJoQOkkOkf6syhQwYG/CQF+mcGmJF/4Q==
X-Google-Smtp-Source: APXvYqwgYdwVETosN63EOr07l+mqB8apd/5S7F6xTujO0/nzQEAmNCIc8JLltiTsu/MI+k7epo8TpleIo+0gwoiBYn8=
X-Received: by 2002:a62:e904:: with SMTP id j4mr31920496pfh.174.1553114475025;
 Wed, 20 Mar 2019 13:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190308005735.GA4122@archlinux-ryzen> <20190320190849.GB28744@archlinux-ryzen>
In-Reply-To: <20190320190849.GB28744@archlinux-ryzen>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Mar 2019 13:41:03 -0700
Message-ID: <CAKwvOdkekJw-wLn=9K=xKE0X260MZCCRtD1r5Erp=fQTwn+p9w@mail.gmail.com>
Subject: Re: -Wsometimes-uninitialized Clang warning in drivers/net/ethernet/broadcom/bnxt/bnxt.c
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com, eddie.wai@broadcom.com,
        huangjw@broadcom.com, prashant@broadcom.com, mchan@broadcom.com,
        vasundhara-v.volam@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Broadcom folks from commit c0c050c58d84 ("bnxt_en: New Broadcom
ethernet driver.").  Looks like Michael wrote and is still maintaining
the driver.

On Wed, Mar 20, 2019 at 12:08 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Mar 07, 2019 at 05:57:35PM -0700, Nathan Chancellor wrote:
> > Hi all,
> >
> > We are trying to get Clang's -Wsometimes-uninitialized turned on for the
> > kernel as it can catch some bugs that GCC can't. This warning came up:
> >
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:6: warning: variable 'len' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> >         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1703:19: note: uninitialized use occurs here
> >         cpr->rx_bytes += len;
> >                          ^~~
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:2: note: remove the 'if' if its condition is always false
> >         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1540:18: note: initialize the variable 'len' to silence this warning
> >         unsigned int len;
> >                         ^
> >                          = 0
> > 1 warning generated.
> >
> > It seems like the logical change to make is this; however, I am not sure
> > if this has any other unintended consequences since this is a rather
> > dense function. I would much appreciate your input, especially if there
> > is a better way to fix it.

I agree that `goto next_rx_no_prod_no_len` appears to be most correct;
though I don't understand why this function is a mix of early return
codes, vs setting rc then updating *raw_cons.  The alternative is
probably zero initializing len, but I'm not sure whether *raw_cons
should be updated in that case or not.  Thanks for bringing this up
and the patch.  Sorry for the delay in review.  Can folks at Broadcom
please clarify?

-- 
Thanks,
~Nick Desaulniers
