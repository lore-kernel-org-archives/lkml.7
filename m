Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5DEECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58B920815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Ey59fqbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfJHNdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:33:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35855 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbfJHNdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:33:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id y189so16758491qkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnQzIXsBirdC9ZGjzsM1M3X/RwdPQQ7F+7TxSRPMNrM=;
        b=Ey59fqbx1Y2Eb6IGPCNXsY7xoiPbBNRsc9vMKzUETVH0/4nu8i9qwD4Ovxhft2vTAN
         lGELYw9QYNIAz3VIcb9v3JBSIu0b/gSt1O+WsZXn7iAxeSMeuzPyyOQBBc1rqIT1esR4
         B3bc8yOB+0xpj3+BilklfufVZo7UkC5B0pUes3biBm4QJkWCbNxcus3wdNZoX/3QNZyV
         yFuhcMz0g8u9XKn2Km80XMOtEwHDJcM+zZ/U4L2GIDblC6izBYPTqOZuQjSNHoQ1sV+I
         NlC04V0V+WMKjYrVIPSJhmRtln/gF8bOUF06bZTv5GmccmXwWBZ8NOM976AcbQRE/FS7
         1kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnQzIXsBirdC9ZGjzsM1M3X/RwdPQQ7F+7TxSRPMNrM=;
        b=VaGX/5z9IwbX6Kh1T77cSJT4i6j5PztZWBhJth9Gt2XkmRLQAym+Kz/hpiS15iCbPr
         1bwIZYj9yTYLB8M8SzF0oLisC7lwA9kS+WJwWUKKG6hSTo9Hz4rOIB9Xe+SAH4Gts5kA
         k8blBXmLGX7tj1O4m2AE0/r4x7sQGcsOrCLCmtY3OU+QqzCxvcYH5KRFlFfbmZ3Canoy
         nc9vLT8bucLQIYU2SiLpH0J6pNtpirAJF1VkQ02RrUieb1y0EAZ57/NRCy5QFSI4zRkQ
         /UUeo1PwD9cYWV7psUTRfQoxROQU4qkax6zu9T/dcBSKliQk2fyp5xPI533SWLlf1244
         e+jw==
X-Gm-Message-State: APjAAAXCMRtYDoqdUXTOxmo2iGcW+AJ0wKWLcCnJ2/muJEbEq86EkFjk
        EHcnVoc93DCT5lrrNtrrmLxtug==
X-Google-Smtp-Source: APXvYqwrDHdts1zTqtkZ7c+p3YRq1MEHwkTEGeoW3azCPVXwvYJn2GTYynQQE2g0CBnnVTuCJ5k/Hg==
X-Received: by 2002:a37:9782:: with SMTP id z124mr26583062qkd.78.1570541623638;
        Tue, 08 Oct 2019 06:33:43 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c16sm9514575qkg.131.2019.10.08.06.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 06:33:43 -0700 (PDT)
Message-ID: <1570541621.5576.299.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Petr Mladek <pmladek@suse.com>
Cc:     sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        david@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 08 Oct 2019 09:33:41 -0400
In-Reply-To: <20191008130803.jf3xdtyt3qpfotn5@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
         <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
         <1570460350.5576.290.camel@lca.pw>
         <20191008130803.jf3xdtyt3qpfotn5@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 15:08 +0200, Petr Mladek wrote:
> On Mon 2019-10-07 10:59:10, Qian Cai wrote:
> > It is almost impossible to eliminate all the indirect call chains from
> > console_sem/console_owner_lock to zone->lock because it is too normal that
> > something later needs to allocate some memory dynamically, so as long as it
> > directly call printk() with zone->lock held, it will be in trouble.
> 
> It is not normal the something needs to allocate memory under
> console_sem. Console drivers are supposed to get the message
> out even when the system is in really bad state and it is not
> possible to allocate memory. I consider this a bug in the console
> driver.

Again, it is not directly under console_sem. It is *indirect*.

console_sem --> lockA
lockA --> lockB
lockB --> lockC

Anything allocating memory with lockB or lockC held will form the problematic
lock chain to trigger the lockdep splat with memory offline.
