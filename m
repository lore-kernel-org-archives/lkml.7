Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DA5C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A272067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHiDOF7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfDYSfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:35:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45931 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfDYSfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:35:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id k92so733361edc.12;
        Thu, 25 Apr 2019 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CcsWQkVwTV+bLmDpw1npAJEUH+41kYWvMdJkKYUa2fE=;
        b=ZHiDOF7Tw2xqDmKXdcVRRv+tYye+waTiFRbejpff4nVYK6l35uhONdFT8Uc4qkbtLM
         XuQCP5EBa2g/yxmqDx2L4ytX0zawuDgqqj9XLq4uqwpYJ9V/TmU8AtZSBxv7kc3DEqEl
         u9cuSqCyw9URqz4biRGEeoIEGUhBL8+hqyIoSXqOofGHVyQ63HrH6T95vCGHgxamV+Qa
         Bb2W2MQCeuVRCD3XqKtIw+3wF2DhloVEp0AZqHVS+IiVQmAyTBKNIGhsJwIfwY3XqwzZ
         4oo6y0e7gmGak0zJLDoKVS4L1opuZo9iddgggw/lc3jD/3+9o9SNnUSwFMB0VPubv3HE
         1AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CcsWQkVwTV+bLmDpw1npAJEUH+41kYWvMdJkKYUa2fE=;
        b=MGLOS1UVFWtzodSfezcMgWTF3l1es4rnrGpWfB6qxlb3kBpUr4c/tiOJFq27sYTei0
         NdYM2JciBOLQ/dOO/Hj6UO/Rce9shtYHIQzIeNn9A/PKmzz1szZ/cptZTt2cNA/4QUSW
         n4FoByJQRYygYPW4f3gy+yY/Q6HtqnxJOjXj1BazaJjUtuahV0wqCCgJQCKnJr11KxZQ
         P9jCIb/icmSBxe3jY8hPNvguHPeE5wGoXfTdfBMvBZU7HkC1/ORb1w44pawFFz0agzSe
         pib27/yANRnHwayTGwjoD+s+LrOWusNjuJeJJ0MvuBiiTL3FtHPkJWtJgfkQIJNAFzrg
         qyQQ==
X-Gm-Message-State: APjAAAVU6T0kPwSkp2VugAfpLS/hZgxPHKmb3NH2hCqCKx7GvnGx796u
        WFEfdTmTJCwP0BmW1Oxv/tg=
X-Google-Smtp-Source: APXvYqy+VlwkPk0NNIaxq4A0O5d1DaW2k8iVzC9JrtYlogz/Df4u5qYYi6rOa1NH6gWcWUNa0hwNrg==
X-Received: by 2002:a50:deca:: with SMTP id d10mr24602505edl.25.1556217304967;
        Thu, 25 Apr 2019 11:35:04 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id v9sm6486808ede.32.2019.04.25.11.35.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 11:35:04 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:35:02 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Chan <michael.chan@broadcom.com>
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
Subject: Re: -Wsometimes-uninitialized Clang warning in
 drivers/net/ethernet/broadcom/bnxt/bnxt.c
Message-ID: <20190425183502.GA7812@archlinux-i9>
References: <20190308005735.GA4122@archlinux-ryzen>
 <20190320190849.GB28744@archlinux-ryzen>
 <CAKwvOdkekJw-wLn=9K=xKE0X260MZCCRtD1r5Erp=fQTwn+p9w@mail.gmail.com>
 <CAK8P3a2gkvkDidV6t82RYj7sydaaGkUOVvrjfuKfPtdd9vj-eg@mail.gmail.com>
 <20190425181411.GB4507@archlinux-i9>
 <CACKFLikGY0=_FBosBdp2nq8F+Upmpo-Oi8kFeMH8diBEZP_0AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACKFLikGY0=_FBosBdp2nq8F+Upmpo-Oi8kFeMH8diBEZP_0AQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:33:04AM -0700, Michael Chan wrote:
> On Thu, Apr 25, 2019 at 11:14 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Hi Arnd,
> >
> > On Fri, Mar 22, 2019 at 03:32:50PM +0100, Arnd Bergmann wrote:
> > > On Wed, Mar 20, 2019 at 9:41 PM 'Nick Desaulniers' via Clang Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > >
> > > > + Broadcom folks from commit c0c050c58d84 ("bnxt_en: New Broadcom
> > > > ethernet driver.").  Looks like Michael wrote and is still maintaining
> > > > the driver.
> > > >
> > > > On Wed, Mar 20, 2019 at 12:08 PM Nathan Chancellor
> > > > <natechancellor@gmail.com> wrote:
> > > > >
> > > > > On Thu, Mar 07, 2019 at 05:57:35PM -0700, Nathan Chancellor wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > We are trying to get Clang's -Wsometimes-uninitialized turned on for the
> > > > > > kernel as it can catch some bugs that GCC can't. This warning came up:
> > > > > >
> > > > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:6: warning: variable 'len' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> > > > > >         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
> > > > > >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1703:19: note: uninitialized use occurs here
> > > > > >         cpr->rx_bytes += len;
> > > > > >                          ^~~
> > > > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:2: note: remove the 'if' if its condition is always false
> > > > > >         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
> > > > > >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c:1540:18: note: initialize the variable 'len' to silence this warning
> > > > > >         unsigned int len;
> > > > > >                         ^
> > > > > >                          = 0
> > > > > > 1 warning generated.
> > > > > >
> > > > > > It seems like the logical change to make is this; however, I am not sure
> > > > > > if this has any other unintended consequences since this is a rather
> > > > > > dense function. I would much appreciate your input, especially if there
> > > > > > is a better way to fix it.
> > > >
> > > > I agree that `goto next_rx_no_prod_no_len` appears to be most correct;
> > > > though I don't understand why this function is a mix of early return
> > > > codes, vs setting rc then updating *raw_cons.  The alternative is
> > > > probably zero initializing len, but I'm not sure whether *raw_cons
> > > > should be updated in that case or not.  Thanks for bringing this up
> > > > and the patch.  Sorry for the delay in review.  Can folks at Broadcom
> > > > please clarify?
> 
> Sorry, I somehow missed this email earlier.  "goto
> next_rx_no_prod_no_len" is the most correct fix.  The "cpr->rx_bytes
> += len" logic was added about a year ago when we added the DIM
> (Dynamic Interrupt Moderation) support and we missed fixing this goto.
> 
> I can prepare and send the patch later today.  Thanks.

Thank you for the reply, I appreciate it! I'll be on the lookout for the
patch.

Cheers,
Nathan
