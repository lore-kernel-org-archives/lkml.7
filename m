Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83500C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545612067D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="cicZLyeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKXXSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 18:18:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44402 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfKXXSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 18:18:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id e6so6083873pgi.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 15:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=RQBmwWdIIGgnDdpvfkEM//aOqRA5KBb41NFCx63N7s8=;
        b=cicZLyeZUh1ZA/1xCHw1eP8L8XEmzJ90PY5aDtWxQ9Aqq1sgKXjE2fdCuw0qblc/bT
         s2lB5uAouGCo/8VtARjRZJtl0dqwYHWJyGLT0QwXZSMa8lz3n5Lf4B+WFvtjQI27vyNy
         tZ9p1kA163MHTM2h5tHLrjZ+ljOjcB51zP75SohuxLtIBmqBjJu5ZiX8cTP1FbgAAfnE
         hbiFlO8IDdsp3Dw1hlgdGvsDKsnP1QPEmej+oUqkaJDeZ/M7h5qiCAMUy7Yr0Hf6vw6W
         qVfIMgrqncFIlbL/wrDAD6i35tqvkMrVtAeTodMaRYEuKJlTjBTFurvuAPoiMieM5X7J
         H3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=RQBmwWdIIGgnDdpvfkEM//aOqRA5KBb41NFCx63N7s8=;
        b=NROn0DZPeqLOQuyG6vVvkygHuuFkP67izZUIPr2aTZEP5t6IfIfRKWN9WqkVO1rrjc
         KUDRHnqyWPX2uPugubE9prvY7lffcSm2JWDb/jJviNF2Npn+aR+o4CwujiWZX/oxDBHs
         hiEowiJnea8scOG1ehh2t0lVeuEKPTpzePz/CEoHaPafXlQjhPaFDWCYEzKgpP/01YXI
         fiZ9WCAxlKuCkH6CvB9JG9YSCkLNzzbNcQMxvl5O8rxKQtR5Ol5oXxTKwnQq2cxgKEFi
         jdjr7H2ufrbbfo+YSTzkULawvOjnhMqUZMv+DYPvrTc6DcLZBlMcOUzbyZFtHtm0iVrS
         pUGQ==
X-Gm-Message-State: APjAAAWLZwSPHErISTjOUyBrKTATLWsNuaAJW8VszmpiNcvikKG5GZ4z
        N2DSphsrYJYs7U8oYLYvJAhExw==
X-Google-Smtp-Source: APXvYqwfqee9EFV7qi5/de/OZmKTc+OVsA3hRqpxIOyEHHYm8ud3mIiED6B+pv+05DPGITadwK78cg==
X-Received: by 2002:a62:e308:: with SMTP id g8mr31804436pfh.121.1574637511579;
        Sun, 24 Nov 2019 15:18:31 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id c17sm5559731pfo.42.2019.11.24.15.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 15:18:31 -0800 (PST)
Date:   Sun, 24 Nov 2019 15:18:25 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, sfr@canb.auug.org.au,
        linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] powerpc: Add const qual to local_read() parameter
Message-ID: <20191124151825.70d15916@cakuba.netronome.com>
In-Reply-To: <20191120011451.28168-1-mpe@ellerman.id.au>
References: <20191120011451.28168-1-mpe@ellerman.id.au>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 12:14:51 +1100, Michael Ellerman wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> A patch in net-next triggered a compile error on powerpc:
> 
>   include/linux/u64_stats_sync.h: In function 'u64_stats_read':
>   include/asm-generic/local64.h:30:37: warning: passing argument 1 of 'local_read' discards 'const' qualifier from pointer target type
> 
> This seems reasonable to relax powerpc local_read() requirements.
> 
> Fixes: 316580b69d0a ("u64_stats: provide u64_stats_t type")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to net-next now, thanks.
