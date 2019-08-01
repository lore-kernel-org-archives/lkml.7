Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD0FC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0D3206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="H1rBOX4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbfHARtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:49:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36626 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731061AbfHARtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:49:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so34494390pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y6hdHpqGEBI+iVGPp14PxolI5mp64P3aoDRclef1uXs=;
        b=H1rBOX4e1UB8ZnKJ7SDE6klXGJFF3zsPjduSN8Z02OId7gY00conT5jk0RaL2uwfBx
         aPVZxDsYAshkjMZ257WbkZfNRR7PdiePMxjFeWn2g93Q9sTPRv6V9OCXAIz971KnliG5
         mhA5ONZyx7jNiWP5kYa2471dy4bF6cxu98jZbjlSPvg1DKgriB6dNbyIOHAMIAa8eJhK
         jAx7Gx3scQVZDiEgnF4b0b99HuzHJIZaioGVMgPP5YA0Lq1VN2O5dlqfdXoN46xlllGH
         pe2YPuV3WWwqiIBvMj3V7xpuM7RsPCjGIhJbaETmKoDsb4w/HJQ18qNCq3OPVaSwjUML
         /OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y6hdHpqGEBI+iVGPp14PxolI5mp64P3aoDRclef1uXs=;
        b=EsbO3edZdTpMFpRujKU9xLoFFcZbPpafSSE7TFfdkvJGQ6B5dIQuDgNLYAx8Qgdudk
         +dK4Xz4meCI7/EuV18uCIOC9EitQAuutg2YxLtt3LsuxTIkMezULKlMVqtAANZ929olm
         vBZ4IQ1ELM5Q9qMI8NpBL/1Mjxwe0bjPVLysicIk0gC8v4p2scU+bVyBvnIznexKzIyf
         yhoHmWgTsvpdu+/GqpzGCSi7t8G2UWuQH6wsdt+AV+94rPuimN8UiYvTN5Ktm9Ev48fv
         hryR+RXJCy+lFi3jl6wUo4cld1rBvs8z84bJCwBIUoKEQmjaUZUfHmEYWpvuMox3zs76
         Fmxg==
X-Gm-Message-State: APjAAAVJ0HcC8f/pEGK0rbFrJaVWkUqhLa8qaQD1e1ZJ13XrKzy9FyjM
        P9HX4MxHUfz8Y+N+Zv8aysI=
X-Google-Smtp-Source: APXvYqwG6QCNgn3q8ZubpYM4sdBg+SifuSKIr4EsSNa27iacMuRB6yqyNVkq6uIotPklc5Bav20CHw==
X-Received: by 2002:a63:4041:: with SMTP id n62mr49026346pga.312.1564681750112;
        Thu, 01 Aug 2019 10:49:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:533])
        by smtp.gmail.com with ESMTPSA id b136sm93410600pfb.73.2019.08.01.10.49.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:49:09 -0700 (PDT)
Date:   Thu, 1 Aug 2019 13:49:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/5] sched/pci: Reduce psimon FIFO priority
Message-ID: <20190801174907.GA16554@cmpxchg.org>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.685367413@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801111541.685367413@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 01:13:49PM +0200, Peter Zijlstra wrote:
> PSI defaults to a FIFO-99 thread, reduce this to FIFO-1.
> 
> FIFO-99 is the very highest priority available to SCHED_FIFO and
> it not a suitable default; it would indicate the psi work is the
> most important work on the machine.
> 
> Since Real-Time tasks will have pre-allocated memory and locked it in
> place, Real-Time tasks do not care about PSI. All it needs is to be
> above OTHER.
> 
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Subject should be s/pci/psi/
