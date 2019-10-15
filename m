Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF1ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E091214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ot/Q/Dpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbfJOU0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:26:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45327 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfJOU0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:26:44 -0400
Received: by mail-io1-f68.google.com with SMTP id c25so49290930iot.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 13:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=E2TroodgPQKmv+4uUx4dDzQXwZFOfczvCYND8JsZxGc=;
        b=Ot/Q/DpkCACr6yFs94vqx/zpralaCbwt7zT6/B1uONIvwqFbclyPz0+qDJCAR586Km
         i8zI1C3wL9kQqjEFKeKvnxfY0Po79E5QyCoCNam15K2GhIPIttu6gAktaAwgsrFLvDEa
         ht1hnLyBq8JbhgZzNZ40ky/Rgk0NCMUAGK6dWEmBOs+WBo3oBDSNwNaCAeQPyFlkUsXa
         BFge1PIjJVqz6eiZuRtoJmHwj7A/5kVX5+hLgPohPeD7uaDfVlu3/jk3xdsrrz9c9k1G
         g2uot4qVsejTCf6KAF0N1beGQR2IYn+z+aCjDVwYrWn7J/0WdvW7+EgD2wLg2rS24sC4
         IBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=E2TroodgPQKmv+4uUx4dDzQXwZFOfczvCYND8JsZxGc=;
        b=ssK3wEw2X+y81sDHpjXUK+fXWBf9FE+zxlP1ZjWD7yl5pM5IILJpTVsh3vG+PcXle6
         RRmYM7F4tSmEHwQDu3CJe9uR6yv7grxAYDRra1RZ/Q/VhIQHhfoKlmpgvhQPPsk9X/n/
         E9sNhRrmK/erJ54dPOUgKiVC18vQNlibWkyrmAgGhl0+zaxwkvq7FdFfUJNV7BljyAmd
         2XRDRZKBWChW77nY9G+0Xe69MKb3QB/hOh+VZE4b7gDHu6NnVj8bGWr38XeaxDmljlwc
         7F9IzVq+QmX+bbMLKhOuO+VuGj2UyHaTjf8CKw4vQ3r4uT3at4CRxEdyQOMbr/3XJDUL
         oB7Q==
X-Gm-Message-State: APjAAAVKuVTup60usQEqAt91GT+oviL/xVTFQmepslAPw/V0n+6zSFgu
        3p/7j2Tnqk/W57pmRu8mRbPpvA==
X-Google-Smtp-Source: APXvYqyoRm5IeFfTJZdypxJg9pjW2NaTWI+ZrDMYnJ1nqN1xUse5f20kUBSa8rWSTKcUV9e7ZctxzA==
X-Received: by 2002:a92:d5d1:: with SMTP id d17mr8364619ilq.55.1571171203509;
        Tue, 15 Oct 2019 13:26:43 -0700 (PDT)
Received: from localhost (67-0-10-3.albq.qwest.net. [67.0.10.3])
        by smtp.gmail.com with ESMTPSA id i74sm3175644ild.74.2019.10.15.13.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 13:26:43 -0700 (PDT)
Date:   Tue, 15 Oct 2019 13:26:42 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 16/34] riscv: Use CONFIG_PREEMPTION
In-Reply-To: <20191015191821.11479-17-bigeasy@linutronix.de>
Message-ID: <alpine.DEB.2.21.9999.1910151326110.17973@viisi.sifive.com>
References: <20191015191821.11479-1-bigeasy@linutronix.de> <20191015191821.11479-17-bigeasy@linutronix.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2019, Sebastian Andrzej Siewior wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
> 
> Switch the entry code over to use CONFIG_PREEMPTION.
> 
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # for arch/riscv


- Paul
