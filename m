Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BDFC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E20216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEISmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:42:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50549 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfEISmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:42:40 -0400
Received: by mail-it1-f193.google.com with SMTP id i10so1419956ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 11:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RAPPdEdzAC7Nt0I8+scXV0pUykQdkkkD3cPHgHiKjU8=;
        b=RHO4MaT9A3dg94yATiVfdlnOcNJ00w+dlJeyvC9kPOfz9O9nLSDooTncc9xZD/Cvai
         tGkxe5OP6emVysPpOvyJVbh6SZaMhhAH6bUnJyHX+2FDtRVLeJjeVcBNuB7/9f8QIpvf
         yJuhvIq/tnVt4PJu15xbS94QR+ooYkyEv445tDOLiIsY75vjPF6UXB+yvjgrscOcCuzy
         0tREfSNoEFWEnOmnEoqGrpe1c4D3EvcI27HChW2LJbujuljFRpxCgCGcT0QrHR1S5Luq
         /JcK9zKFCjz1lo9F/0TNMulXYGRkHYSogqvUHcFZvvR2u9wUEtgnrahfjmR3EcUfnndV
         8nCg==
X-Gm-Message-State: APjAAAUu1lP0OfDvtp9qymvl3mAn4BDcLUkYyQaRCpn5g0gnsJbVd8FZ
        KsYgEoI0pYpy/7FqCpzMR7/ejA==
X-Google-Smtp-Source: APXvYqz/8tymkjQmLnwRihvpLkgn17Ri7VMfntsvcRf0uxgb8XJaXi9AYQEnf2j9n/EgX0JRGNMKcA==
X-Received: by 2002:a24:17ce:: with SMTP id 197mr4164215ith.21.1557427359216;
        Thu, 09 May 2019 11:42:39 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id h16sm1021805ioh.35.2019.05.09.11.42.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 11:42:38 -0700 (PDT)
Date:   Thu, 9 May 2019 12:42:34 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mmc@vger.kernel.org, djkurtz@google.com,
        adrian.hunter@intel.com, zwisler@chromium.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: v4.14: Fix null pointer dereference in
 mmc_init_request
Message-ID: <20190509184234.GA197434@google.com>
References: <20190508185833.187068-1-rrangel@chromium.org>
 <20190509060456.GA17096@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509060456.GA17096@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 11:04:56PM -0700, Christoph Hellwig wrote:
> On Wed, May 08, 2019 at 12:58:32PM -0600, Raul E Rangel wrote:
> > It is possible for queuedata to be cleared in mmc_cleanup_queue before
> > the request has been started.
> 
> Errm.  I think we need to fix that problem instead of working around it.
So mmc_request_fn already has a null check, it was just missing on
mmc_init_request.

I could move `blk_cleanup_queue(q)` above `q->queuedata = NULL` and the
lock. So that would mean cherry-picking
https://lore.kernel.org/patchwork/patch/856512/ and then a patch with
moving blk_cleanup_queue.

Should I do that instead?

Thanks,
Raul
