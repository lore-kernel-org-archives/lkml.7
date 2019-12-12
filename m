Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73C0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988C42464B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXq1DcNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfLLKGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:06:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52324 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbfLLKGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:06:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so1678960wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yjaelNEpHlSPaEPMVZRUcn0tGaPBwWQdVVhX8cKNfLo=;
        b=TXq1DcNgVOT0I7tNBiC2GNjlxEY+OnVefCtWs6WSuvZq1ZI08hEpBW5V28w18LT4lJ
         zoS79TRBZLoaQrFy3RSyR0c8/TdGMWyvIjs15DtX5gcZRu8K+83yeukvN22oBn2m4RnH
         R1dXdiem9BV4YvQbEaU3Yypz/93f4KELvozA110JJswzS3WzdUtB96SIY+ZoX6FgMYmf
         ydM9nVMmaN0ZGvOLJsWmj/nv8I7v2FtCwdSqQ+oEVVzDcQrRQI1kDhYH23GYiPWenegO
         fbAFpCW3lPjlR4+A5eidUmuvvgMNvB+dwowoVox9+kb/1XKSLBEcYJFYcxss3kDrN9k4
         J53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yjaelNEpHlSPaEPMVZRUcn0tGaPBwWQdVVhX8cKNfLo=;
        b=c4B4U4g2krBK0WLyXNOi3mtlsTGOMBXah3an2GGWa31q3uozcoa3+dLYZyjK+KQ95H
         ljMWLyOGNtLpHitUBdahV3nhTOXVNom7b4qB9suiPz0wjxU+94OWciFl3DFzOLFoyTfF
         5H/THBVysJNylrFv8k/gy6Ehi5saDFLvZdJXOdwynTv2Epr+helTgEsssjjWH0V6imCJ
         eza9F/An8xWUSar/BsEBnDsfukq55Q9m7a3l/fTt5czd0YRMv2iFX9WOqA5pQ+rWrD+x
         fBi0bumNPrnhiBoM5vs1k1k2x64S1VQoOXOdDsmF8L/UTozI1ikr+CbRtvkFflh6aJWD
         Yypg==
X-Gm-Message-State: APjAAAXbYrb+yeNTohThc/DYhjoiLjy5U7SjoTFpmsxyUw8Nde82GnFu
        OOYmHO7/cr+9guFUcWyR5pk=
X-Google-Smtp-Source: APXvYqxhho9zKga8+owdTEGrPzY14vljmobwCI8T+3V0Nv+AR+I2wO/R7hxC5VSWA0LQVd3KrcLE7w==
X-Received: by 2002:a05:600c:2254:: with SMTP id a20mr5564373wmm.97.1576145171307;
        Thu, 12 Dec 2019 02:06:11 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40f6:4600:8d93:6670:ad6b:1c91])
        by smtp.gmail.com with ESMTPSA id k8sm5493941wrl.3.2019.12.12.02.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:06:10 -0800 (PST)
Date:   Thu, 12 Dec 2019 11:06:09 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: make stub function static inline
Message-ID: <20191212100609.hadfiiivm62obyfc@ltop.local>
References: <52170.1575603873@turing-police>
 <20191211213819.GG14821@zn.tnic>
 <186227.1576107233@turing-police>
 <20191212085757.GA4991@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191212085757.GA4991@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 09:58:09AM +0100, Borislav Petkov wrote:
> On Wed, Dec 11, 2019 at 06:33:53PM -0500, Valdis Klētnieks wrote:
> > Were you building with W=1 (so gcc issues extra warnings) and C=1 or 2
> > so sparse is run?
> 
> [boris@zn: ~/kernel/linux> make W=1 C=1 arch/x86/kernel/cpu/microcode/
> ...

The Sparse warning about reload_ucode_amd() is only present if your
config has CONFIG_MICROCODE_AMD not set.

Best regards,
-- Luc
