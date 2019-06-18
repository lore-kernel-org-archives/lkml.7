Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77309C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE5220B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq1e67QV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfFROkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:40:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35692 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbfFROkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:40:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so22134594edr.2;
        Tue, 18 Jun 2019 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FPmqGlLqRaYsv5QgGolRusboFAose75I5VSohz4ueiE=;
        b=jq1e67QVaCOiRylO+VQp9tG5iEzpSV3Duy6Vx85CDYXe8syEMBWuDUdmcD64H7IpMq
         W9c6L4lHj15dOo76pOWnvBzGNVVnK+864NonAnwpaJGSU/lMFPE/C1mkzH7N4SJNHquM
         FAponMKenVFYn31s8XhfkSR3a1P07b8s+/oWqJhqIIBrRTnISjK5AcxEj4IciiQxG+3Z
         0OO4hXNX7uvzkpFJzCYKBSMLmOx9nqkEqf4aGjHAlGnSS68Et9fTjaC6yNGjDOPhB86U
         n1OJF0/6KNCxofUYqcZDFXmwZg7lnW79IZvBg3OWyXsJUimsAnvornV5k/a4v2WbL9aL
         Ybtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FPmqGlLqRaYsv5QgGolRusboFAose75I5VSohz4ueiE=;
        b=rJuDrVbp0kxbpQaXH24sS8j4vYSMXP6WWM5MmXH77l6gESgQDKkVtX/z/EUWD/ZYi/
         qQbMt2dFMSZJ/WNx189bbGCux95sRpZoxGQiSGUnSzaZc/mcmI3Z4PULi7N/x/JuDD1p
         /+EmWH6puIVn7QV0lMBXcc//e4CAqsY6bMzve0gI33W/yyMtoWOEgpj7ZPda+cBHb/Fj
         K5fbvFsr0JAtTFvKr8AjCsyCG8pOUcgvbwR/LjXxz9hDquVj9hrv+IOwwqpbDwYYuW0C
         KYVm6zL6Sz+4WsAP5MyxIuCt8x4Ei2WvCZRtoosrwi3Qfi526Qox1uUybwNlfe3bKumt
         rgYA==
X-Gm-Message-State: APjAAAV4bdwAbATVGo6i1gdfJrQN90NJKJN99PsRfr8QBZcUSBDN4Sdv
        r1lbcztgkmdCXZc6bE6thNU=
X-Google-Smtp-Source: APXvYqxt5h1W6a2Ca8NWGsKSDu10az3ukyEF1VBfMOe5R41qedc4r8PZzY8U/w815tPnxWZXL9raBg==
X-Received: by 2002:a50:996e:: with SMTP id l43mr102049233edb.187.1560868821425;
        Tue, 18 Jun 2019 07:40:21 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id y22sm4810536edl.29.2019.06.18.07.40.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 07:40:20 -0700 (PDT)
Date:   Tue, 18 Jun 2019 07:40:18 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] clk: imx6q: Annotate imx6q_obtain_fixed_clk_hw with
 __init
Message-ID: <20190618144018.GA63161@archlinux-epyc>
References: <20190618022405.27952-1-natechancellor@gmail.com>
 <20190618134253.GK1959@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618134253.GK1959@dragon>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 09:42:55PM +0800, Shawn Guo wrote:
> On Mon, Jun 17, 2019 at 07:24:05PM -0700, Nathan Chancellor wrote:
> > When building with clang, the following modpost warning occurs:
> > 
> > WARNING: vmlinux.o(.text+0x974dbc): Section mismatch in reference from
> > the function imx6q_obtain_fixed_clk_hw() to the function
> > .init.text:imx_obtain_fixed_clock_hw()
> > The function imx6q_obtain_fixed_clk_hw() references
> > the function __init imx_obtain_fixed_clock_hw().
> > This is often because imx6q_obtain_fixed_clk_hw lacks a __init
> > annotation or the annotation of imx_obtain_fixed_clock_hw is wrong.
> > 
> > imx6q_obtain_fixed_clk_hw is only used in imx6q_clocks_init, which is
> > marked __init so do that to imx6q_obtain_fixed_clk_hw to avoid this
> > warning.
> > 
> > Fixes: 992b703b5b38 ("clk: imx6q: Switch to clk_hw based API")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/541
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Thanks for the patch, Nathan.  But we already queued up a patch [1]
> from Arnd for that.
> 
> Shawn
> 
> [1] https://lkml.org/lkml/2019/6/17/317

Ugh, sorry for the noise, I should have done a search and seen if
someone had sent out a fix already.

Cheers,
Nathan
