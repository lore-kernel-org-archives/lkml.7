Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AFEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9FB21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4RDlIi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfDHNac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:30:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37639 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfDHNaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:30:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so7359042ply.4;
        Mon, 08 Apr 2019 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FR32i1gO0EOqWQx+GyUPA3tkw0RmNwzVB3Pb81weqtY=;
        b=f4RDlIi7I6qTiYqt9TbohFHICmcEe84wiiDIDBU2dzgRRi6qAuzTsT5kiRFZGxVXQw
         421ZbGUwB6OJLs3ZFq8aIjuTqPLD/5ekbs//uPKxapsVh4TYH/xiIgGdFXLDRZSwPjPb
         b4h6wLjY7JO+rJODYXaYiI4ZVzOniAiJaSORUVmBRYZH8wjY9u8gu8UDtKj0a0/ylBSZ
         zStvbVhbT5DWFKirTX7/yxIv6k892qrBteOKDRqp8P9JMwC9SMyk3npskDKCaSCUSmaS
         HwSiId9rOwSIJGWao5ccKLjZs0lRvVPdObA30RCdRsGNo6JWTJd2VkE/L2FgcdSD5mOs
         PeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FR32i1gO0EOqWQx+GyUPA3tkw0RmNwzVB3Pb81weqtY=;
        b=Scw/YehKh8pvXj5WPQZZLe4nqweC3ecibOMLcaQXpWOdbz8paLq5wvYs4rraMoxMRr
         qelV1m8IfOT1MduznLx66baFv8DMBruHgE0GuvIPSEwRd7CfFEPjqb++et911g1AxkmL
         Pv9SOQGcJRpn290sQMNQ4C3uveE3+//SE4b2n9WUTNp80HOpXwQamyulIlXsWsaqB4nK
         wJKLUqOXZoLzqHoGpVPbAtd9egWIWsIYE83Z4M1OeanPZSKWmWwFvVr8vqaPmJat+nPA
         C+Hp2RRFgHEFh0rbGbLB2qOk0b4NfQSCbBeD6RlYC0whuFN5J23zMJ9YZTlq546U+WAj
         IJNw==
X-Gm-Message-State: APjAAAUam1GelrWd8BvEEs1Bw0wy5SLecu/xfb+Sb9sOQVnxDSI04pyL
        q2KqnbP7zVRVyGslfKoKIqc=
X-Google-Smtp-Source: APXvYqyqKbcNhx7tPZqkCGVC/APFQ9Es7W/z2B219hyl4iBEZjFP2q4nkHw+2oRwbpvajzIUjsvQyg==
X-Received: by 2002:a17:902:9a83:: with SMTP id w3mr30641128plp.241.1554730229574;
        Mon, 08 Apr 2019 06:30:29 -0700 (PDT)
Received: from nishad (p640014-ipngn8201hodogaya.kanagawa.ocn.ne.jp. [60.46.49.14])
        by smtp.gmail.com with ESMTPSA id g5sm7525306pfo.53.2019.04.08.06.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 06:30:28 -0700 (PDT)
Date:   Mon, 8 Apr 2019 19:00:18 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARCH: Use the correct style for SPDX License Identifier
Message-ID: <20190408133016.GA2662@nishad>
References: <20190323132808.GA10547@nishad>
 <20190331010549.GA17669@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331010549.GA17669@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 01:41:26AM -0500, Rob Herring wrote:
> On Sat, Mar 23, 2019 at 06:58:14PM +0530, Nishad Kamdar wrote:
> > This patch corrects the SPDX License Identifier style
> > in the Hardware Architecture subsystem.
> > 
> > Changes made by using a script provided by Joe Perches here:
> > https://lkml.org/lkml/2019/2/7/46
> > and making some manual changes.
> > 
> > Suggested-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h     | 2 +-
> >  arch/arm64/include/asm/pointer_auth.h             | 2 +-
> >  arch/arm64/include/asm/sdei.h                     | 2 +-
> >  arch/arm64/include/asm/vmap_stack.h               | 2 +-
> >  arch/nds32/include/asm/assembler.h                | 2 +-
> 
> No reason to put all arches in one patch. Please split by arch for 
> maintainers to take.
> 
> Rob
> 
Ok, I'll do that.

Thanks for the review.

Thanks and regards,
Nishad
