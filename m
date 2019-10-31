Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3168ECA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052C520862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572561967;
	bh=Kb9SD2YTFmPRiJO+Z34huGSPFITDTrlM2qtT/jKPRaU=;
	h=Date:From:To:CC:CC:Subject:References:In-Reply-To:List-ID:From;
	b=mQTkCDcrwfxTqDBjsG281a3YourLleh8qkpsoYM3mFK2AC7TAi38TAb7jkapcYzSL
	 QGgO6n2LaLRFcrhZcDhyE0618qHSTwdEX9ilnNCCYEyI/V0RQsYTutqFBJCDBqWJ/j
	 vZL1ElRGhKXNGNNfZwdc3GnSUYIIwxfE9//XW+Rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfJaWqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:46:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38763 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfJaWqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:46:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id c13so5517799pfp.5;
        Thu, 31 Oct 2019 15:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:subject:references
         :in-reply-to;
        bh=QVItefipwjGqrppuci+M+vM6162XpV9VZniQZODk/Ko=;
        b=X65wtPTQII92rF3v9iJx/Y/4nyjoC6GonHOKSp1f3WzvVNGq2Jlh5oL1hi8eT0RnDZ
         jMEJJ5rJ3+vPkKV/XCSxv84zMBNh9ppTKARKDpD/3iv2BbFYGBkEgTmmSKH7w8DvrnIu
         uenDtxGJIWyijgA14i99QNQd05yK6dJhsvtzI0ih3YBJVR1Iy6wAFUc13dIGaAeAoUcA
         UDtBJPFuRMcWB+E8IaHf1iUD2w98LD0eC8FZRv4v1ycNom47TRHEdErfPSowXswfSkC7
         uZ3WHyBGON5PnPsG8TfQvg7AVcrFXR00HL+MfP9YaoZfwQaB84nvMtMNRMoU3BjMzOXl
         VuCw==
X-Gm-Message-State: APjAAAUp4FWk6NVJ8yqyrmNYwpOoMa+FdQJuWpzIs04fx8sS+M+Go8Vg
        B4LXeJmt3i+iaJ4QEXPnbBg=
X-Google-Smtp-Source: APXvYqynmCI1j0rBTGTVR35qYJ2EdUO7wxgQliAe5zq8TQKKAW6SVW2TfhSo+ap3b8ItfcbM18Saqg==
X-Received: by 2002:a63:c442:: with SMTP id m2mr9270433pgg.67.1572561964317;
        Thu, 31 Oct 2019 15:46:04 -0700 (PDT)
Received: from localhost ([12.94.197.246])
        by smtp.gmail.com with ESMTPSA id e1sm3996126pgv.82.2019.10.31.15.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:46:03 -0700 (PDT)
Message-ID: <5dbb642b.1c69fb81.fa7a7.be3f@mx.google.com>
Date:   Thu, 31 Oct 2019 15:46:02 -0700
From:   Paul Burton <paulburton@kernel.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: SGI-IP27: fix exception handler replication
References:  <20191031094605.12380-1-tbogendoerfer@suse.de>
In-Reply-To:  <20191031094605.12380-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thomas Bogendoerfer wrote:
> Commit 775b089aeffa ("MIPS: tlbex: Remove cpu_has_local_ebase") removed
> generating tlb refill handlers for every CPU, which was needed for
> generating per node exception handlers on IP27. Instead of resurrecting
> (and fixing) refill handler generation, we simply copy all exception
> vectors from the boot node to the other nodes. Also remove the config
> option since the memory tradeoff for expection handler replication
> is just 8k per node.

Applied to mips-fixes.

> commit 637346748245
> https://git.kernel.org/mips/c/637346748245
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
