Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCE9C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6EE206D4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UtE6bh2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfKQXgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 18:36:21 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46184 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfKQXgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 18:36:21 -0500
Received: by mail-il1-f195.google.com with SMTP id q1so14283475ile.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 15:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=msWSzD8IfTAYrl4tYtx34pXBNjkOEIKpiBWKfcfxxgY=;
        b=UtE6bh2ev/JFO+i+hDnU0aVPBHoI+suqm0t2ovLD19rNgUhRaNpp+IXSGPaFkvSkLq
         XgYT2OjAhl1FCEdZLEhNN54EVu0spzkuDQKzhZjsjmy2+UiQsLH2eWpOJ6sgZ9kas4ej
         r/sHBXUjGE+MEj6j2+32iAIecBsQceIPzhVCgukTvzEtASRDpsjXymPbtm5nCscAM6Md
         pMCVirZGMJO+1EV9Y4RBAYmrCSLtXR5rRoEDNqgDYds+5nsRPPHbxQzuSlRr7r6ZNma0
         botnVNVahkGGGtdtBS/ZMreuwts1H2GIjakW1sMc18U5fEgCZdhBaDkHLIjRo+f4soAa
         laBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=msWSzD8IfTAYrl4tYtx34pXBNjkOEIKpiBWKfcfxxgY=;
        b=gub4lRIYFJ9G3VaOt/Zqk9GDeS7SeAFTEeTMWsgKSK41IIraSPQCge1plz02r9KnoV
         AdNlBFl4pz64un13MxHzRW8wLgEWRs9LBDB8Y259IP/7CHWZhriS3xiEX4X1TR50aFCo
         HMQYyukD4SpQyBUkt8q0gwZoCk8MsHDGUe0/0IUR/tmmufh5VsZFZbGClbFDQMSEDYZG
         6h9PQ3irsP+OrRhmNKhATwAsCUF3wBxp8sPxTPyBYJZB0buAFtc0XzDF3p6kcYfLge7J
         7YU7V/5r936tr7vDFb6jsyTWW7hP1noUAoBToqsxMthcA4NkjCl3XYXd3o4lOEzWuhMe
         UMcA==
X-Gm-Message-State: APjAAAUzW+esPtrSZp185SLf3KgMj+PAVGbtlgjz3tIJx45km7X3DKlA
        /WSKShVmwKN9TkTr6cJNfOqjtQ==
X-Google-Smtp-Source: APXvYqyJs9bWjm0GDpDmcty6YsVNmG1z32hUAsZ+dTXTjuPsJfqqtHxzoGKfzjAiw1BPxG/Vg4uOKw==
X-Received: by 2002:a92:c981:: with SMTP id y1mr12624894iln.53.1574033779357;
        Sun, 17 Nov 2019 15:36:19 -0800 (PST)
Received: from localhost ([2601:8c4:0:9294:cb6f:4cf:b239:2fee])
        by smtp.gmail.com with ESMTPSA id v15sm3967781ilk.8.2019.11.17.15.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 15:36:18 -0800 (PST)
Date:   Sun, 17 Nov 2019 15:36:15 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        yash.shah@sifive.com
Subject: Re: [PATCH] riscv: separate MMIO functions into their own header
 file
In-Reply-To: <20191031155608.GB7270@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1911171533580.3813@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1910291053450.1601@viisi.sifive.com> <20191031155608.GB7270@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019, Christoph Hellwig wrote:

> I think it would be a better idea to move the kernel virtual address
> space layout out of pgtable.h into a new header, as pgtable.h pull a lot
> of stuff in.

Agreed that we should do this at some point also.  It looks a bit tricky 
to do this cleanly due to the usage of STRUCT_PAGE_MAX_SHIFT in the 
definition of VMEMMAP_SHIFT, so I've passed on it for the time being.


- Paul
