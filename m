Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2169C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB4422BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuEXaHtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfGYNWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:22:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39456 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfGYNWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:22:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so23461846pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mut94+Ig0D1WZMLMgqjo0fdxOTgp/jmf0ROWY/8OjU4=;
        b=AuEXaHtwq+L/h4JxWqbaAhpFHIeodbFkpOaWMctSKijpFsbgqRzg98FMNfSGbEC8n8
         CX8iLRFFsglvEoPLmjobFmWwFO1c9DVT4gimzG8dnhKUwvX44d2Ih8PeNml3KVGpmwQ2
         fQEiPSCI1thyRSPL3c5cWJIYHbc5T2032XUHNrIsXRHkUlg++QGv8voXNmLwvEnJXuFR
         qjzy00ZPKwTDEFZ7IZiwryUXQ0V3VBQMZe68pxSd7hu2sHO4JC8Zgow5EGTiZ26Q244E
         +3QmS/eNb1BKND8oxQtga9TRby2LKT0TvAKoNp9X9sWAsvpJ59FHz6W2IIoKjpzDZ3JP
         iBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mut94+Ig0D1WZMLMgqjo0fdxOTgp/jmf0ROWY/8OjU4=;
        b=LgxaYXrRyDhqFzvRSKnt9JSbHhf5XN22dEEape3RNHxKvij+0QQoXah0iluY1LcPXZ
         s4jZkRoWqID64vWuR3EBTbo0hLztuoDZjauLujbZr70pxxoxf7l2cS9Ho3e79uL1HwKP
         cqLHNvgkPf3y9t87aJ0MLAVzNx/yrWjOM7tNzVhGIHwOGPDpMW0uyyv1jFHJ4SATBTZr
         Ia9Bj5/qu5c1qnZByezn55ERUbFsVGhQCrKFiROpBhBcLx3BL7EfDZdQPsEh8dFvmIZN
         vEzovcVEwVNmsR+vQZn11EEpo+31wQvNqaoy8ddOcrG6ksbJ6BJqiTvXF/oAUQWQv2T0
         pRYg==
X-Gm-Message-State: APjAAAXMvt4mLkmjZKtuO040No69kuD8AZbJVJczq5TKmoDCOI4F63jY
        3n0kdMak0NDE/7618d3J8BY=
X-Google-Smtp-Source: APXvYqy6T4/8ZgLoXmJLsxsGqwB7Eo0HtOFOD79qEVhzhLWLIE0qcgikbTe/aMXNISkuimwhGPo/mg==
X-Received: by 2002:a17:902:da4:: with SMTP id 33mr83216202plv.209.1564060470842;
        Thu, 25 Jul 2019 06:14:30 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id z12sm31263772pfn.29.2019.07.25.06.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 06:14:30 -0700 (PDT)
Date:   Thu, 25 Jul 2019 22:14:22 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] nvme-pci: Use dev_get_drvdata where possible
Message-ID: <20190725131422.GA7289@minwoo-desktop>
References: <20190724122235.21639-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190724122235.21639-1-hslester96@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-24 20:22:35, Chuhong Yuan wrote:
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
