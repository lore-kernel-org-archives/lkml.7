Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB98C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CAD21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X2Xgx4vZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfEUTBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 15:01:41 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:34465 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbfEUTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:01:40 -0400
Received: by mail-it1-f178.google.com with SMTP id g23so3485729iti.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+12NmtAAbFJaroPAA2lM4Iqx0/EqHN6iwK3Od+LxSqY=;
        b=X2Xgx4vZAiee18RcsPFWU6PrNbYl+0gDe7etynJiXePQV+JuiHLHV3NwBOznyDy3IO
         nDIDDwzlAMl9n/4G6mz0ZMaCHrdo78bxeZA4bMTGV5WcAzAT60z5396dHWDgusZQtnO0
         jfMwt52+vpBEKgcXMpkMf1zV8UpGmUX9OsrcwiIll+QWlzNPj73ryFqS8czXvE+9SsBq
         6Sq+BVvDywZph0icJ9QHClQH4D9kLu7u6J/Zb6AFCZy9DoK0lOu6+XqWBCW9Mww+1sUx
         1wrahw1u2fRs+ac7ja9kSZpshBvrE/kD+RuzMB1aSW18aCyKxOUb6zVuDNfuKJzR4u2d
         /MhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+12NmtAAbFJaroPAA2lM4Iqx0/EqHN6iwK3Od+LxSqY=;
        b=Wb3mrzljQbbgbRgE6xtFMPu5Yrs7qf134C30bMGzLvwxhlQYCFg+QRBPcndxRRVTGE
         e5i8WdNhXEqXGYzMlCj7LgHsQdcetYunet3AxM+EBpbJtxpUUXP4I3vhQXsdcw7nNVdt
         Z0XW/migIzbjz/snLaJjTYQ6iHS2jmhFG42pV4wKYPxUaKiA6fQoGTjAErCOmn8SJyys
         hiDH6rE8P5Hb29cJrCq3HazEb7AS8EGZARsZ9dUdSXZj8jRWEhn1XqSJQSD9fzAoz3qv
         ZuGmo2IvX9g1ZfbmZFT9MXVDIA3EOujlMc6CEcbn4oXN0N8t3EHaORuZJJ92l2zO4PSI
         DkRw==
X-Gm-Message-State: APjAAAX0vMV+JmrMmEHhfgG+DstreMYS3MMb/s/F90Bd5bhUOJVS1QA+
        CnlWm7BsK3oHV4E/PpCuwdTq6A==
X-Google-Smtp-Source: APXvYqxL7Gz556HpzxmOWn6WIJ1XtT46LhMiKgs9kG6zAcRPMf+HSFGPzAUbbB7pzw8kD+bRYrDs4g==
X-Received: by 2002:a24:910b:: with SMTP id i11mr5636355ite.76.1558465299744;
        Tue, 21 May 2019 12:01:39 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id z14sm6980089ioh.48.2019.05.21.12.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 12:01:39 -0700 (PDT)
Date:   Tue, 21 May 2019 12:01:37 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Wesley Terpstra <wesley@sifive.com>
cc:     Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] riscv: include generic support for MSI irqdomains
In-Reply-To: <CAMgXwTic9WWjVviEdvh2+0+LB1va--+7zJOt7C2YxsB=hu72WA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1905211200560.24268@viisi.sifive.com>
References: <20190520182528.10627-1-paul.walmsley@sifive.com> <20190521063551.GA5959@infradead.org> <alpine.DEB.2.21.9999.1905210110220.24268@viisi.sifive.com> <CAMgXwTic9WWjVviEdvh2+0+LB1va--+7zJOt7C2YxsB=hu72WA@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Wesley Terpstra wrote:

> Signed.

Thanks, will repost with that and add the PCI folks also

- Paul
