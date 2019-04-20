Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6F8C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F9920869
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+hi05Ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfDTSCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 14:02:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42391 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfDTSCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 14:02:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so10698654wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vcn/n/X5d/CclgKHMWvNAquPx4LnjEvGqVIN+Ib3dmI=;
        b=Z+hi05Oxza1q7d7IRwZ3bFOhpokMseiOLDWU1kwjEGOTsbv0UWy2KwLey4HftrNdcn
         NhFpeZfwSU9lK9K8qLwny50x/BGG8FmsxzCgRC6MmS8ElfTusR4rXt2H1/l1BaEp5dpK
         BTuYCF93vdps8ckim0xs15P1050goRMIP6Ijl8vtPt+IBBFOOUNa1KozLn084b0l7mSB
         ufoQG2ZjD+cS0tLhVGpVtQIvPNWbmGeBuIQb1DUTi+eepp7mIUD4RNEJMtcd1PjOenBN
         v01gVazfbtORrbC5x/GiQt0bad3t9pxxyTjuJC2y8TxNPjxA6Nx/IwPylHojlltZuPNY
         uQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vcn/n/X5d/CclgKHMWvNAquPx4LnjEvGqVIN+Ib3dmI=;
        b=aTrnP8kiNSjheDwdeBl84zLGaH9n2otz/eJSaKZ2X1/ioRjgPKxAXtnpGxM1R/Wr0E
         LdNI+k4cy3vNaJXESfFN5Zje5AJPI1W5bvaJPN5+ObeNCwlqdH74zllSkQe/AlgO6WkL
         jrx13EuVo486MC3CB0fqDjhH+vcWzy4HjFBMCBv4c2OwCK9Od66RorJHgjq8nasyNpri
         V0F58p4CEGZNnVdbQNOEPT1d2vig1nNmU0ahB/yHiDYYFboTuQxe/tQA2YY0jxUu87J+
         6Bq4M+JK55Ye8rB03sF58fyJloFOW0Br4rNdYC2+ap0q44YeQ66VkhNMvKXcCHs+Nm0v
         WbCA==
X-Gm-Message-State: APjAAAUmxWKw9DLemtccf7zTgaoCGVJBvHMk+Dx0THUQQmE7zARiZsLu
        mT8JVMcj23cFPEYG7swQWsa0Qd3R
X-Google-Smtp-Source: APXvYqyDQmKTZc7FQiE1YFua+uQAahGC5m0IBFXJvae+1fQPOv61UiHskpdBtqATm2R0Rw6T5wV43w==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr7637761wru.117.1555783335372;
        Sat, 20 Apr 2019 11:02:15 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id v1sm7223353wrd.47.2019.04.20.11.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 11:02:14 -0700 (PDT)
Date:   Sat, 20 Apr 2019 20:02:11 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] misc: mic: Remove linux/miscdevice.h include
Message-ID: <20190420180211.GA19319@Red>
References: <20170918165252.22242-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918165252.22242-1-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2017 at 06:52:52PM +0200, Corentin Labbe wrote:
> linux/miscdevice.h include was added in commit 1da2b3eeef36 ("misc: mic: Remove COSM functionality from the MIC host driver")
> along with a struct miscdevice miscdev in struct mic_device.
> but the following commit ef39830c3583 ("misc: mic: Remove MIC X100 host virtio functionality")
> remove all miscdevice.
> 
> This patch remove linux/miscdevice.h which was forgeted and now unnecessary.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Hello

Gentle ping

Regards
