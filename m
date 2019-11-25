Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99275C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675A42071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574690068;
	bh=3Q+2jsIxAhqloZ17DwYYf6zIXIIjuWh/8wINIz2T3qw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=r3wCsISjy9vk0p8lB6F/ENgp8nj173vy1N+pH6LlGPLIXM3Z9j24eGvoi34gy4FDX
	 Gxvf5bjwmk3m8uuKVPFxEPrko+BFJHsBkX95rxmZ4Cy846XPDkgTXdIhmUUzBJrnKm
	 uDTl04UvblTOjOvo1ob3Ih4oZ8rf+Id60tyVotT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfKYNy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:54:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36858 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfKYNy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:54:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so18133949wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 05:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DUs7xIPEq8HuH9HRLFhIBCsoGzAjTaBhsn+0/UNrYOM=;
        b=ls5LLe++25JCVr2L2MKs6vDIuaHlOkplQMDKoXNCxN7KxBupA7x5nZqZ8g/RV1XF8q
         UBpFOVsjRLl+5Tg9+fwXXybZMAklZRFcWKERxYEpa9RNePkKqVhibyVmEUcW59p0bAFc
         8IT8BTmRjTyl/hv92GsC+nICTvY8sJ2wpjAYLgsspInBBf6FqmnY4dVaUtNSmAyUNoz6
         QCZUXzM5Ee8wAEh3xlK/Pt9JBCInFM8wHV1xdDf9FW+khbI90NGEDBpAyN3AnPuOWQs+
         92I6w3A9ljg11fdXAP0xb05MEolN/AYdvLIGgTWxb5MHZFfn9c4+KGsyubYJIdk5mU01
         FMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=DUs7xIPEq8HuH9HRLFhIBCsoGzAjTaBhsn+0/UNrYOM=;
        b=oZIU6rT2uevA+wcXpLCg8L7qvcxEHdQUHJ3bUzxL7nhfLROkTyx5u5/8u2jNR+v4/F
         juXuDJG8To3+XesM1tz5Z6NrLwRSt6HQwqa0CDZUM3URHJPfd/zBbpNQ0SnVkS33Nr9S
         fh06twEBvjKLf7wg+GuqM+RFK27BurbQAgkGk+OifmejQMzPltUgW4UHNx9ZkrEADhOx
         lGYt1Myxhwi5vKVCNMi05nLK9X4gD7Y0ipjLwUtDEWw+v07Vl9ugJE5M9ANvk0edh1Nx
         kMxPOLKrKFErW/bZVY7zVAFwfgfO2J31EjsNuqABc3UANCICgi8zNidske6IajlqaWIZ
         w/7A==
X-Gm-Message-State: APjAAAWpkNovsuYIHwNhs8xf3VGM+AFil73pn/IHH1HtcMui25owbaXC
        IHhlBAGfHf7F2u4hM+9/BVE=
X-Google-Smtp-Source: APXvYqzc3/4ZzzWD9YTKSp+LcecEwRF00ZwRAQA2V8S4/m4itJ/YtJg0nlNrSuyezrSBHubIlLt3jg==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr32092584wrp.5.1574690064061;
        Mon, 25 Nov 2019 05:54:24 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w13sm10408762wrm.8.2019.11.25.05.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:54:23 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:54:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/fpu changes for v5.5
Message-ID: <20191125135421.GA11526@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-fpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

   # HEAD: 446e693ca30b7c7c2aaeaf09e90ec224c7538fec x86/fpu: Use XFEATURE_FP/SSE enum values instead of hardcoded numbers

Misc FPU related cleanups.

 Thanks,

	Ingo

------------------>
Cyrill Gorcunov (3):
      x86/fpu: Update stale variable name in comment
      x86/fpu: Shrink space allocated for xstate_comp_offsets
      x86/fpu: Use XFEATURE_FP/SSE enum values instead of hardcoded numbers


 arch/x86/kernel/fpu/xstate.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

