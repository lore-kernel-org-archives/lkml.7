Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40DEC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936CC206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="V5dSsQTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfKNHkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:40:05 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41967 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfKNHkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:40:05 -0500
Received: by mail-oi1-f175.google.com with SMTP id e9so4404646oif.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 23:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YMn33D1fvbsOQjVLRYkAXXQ5Mr3LhRnG3fNN+0bZFqc=;
        b=V5dSsQTsDt8RrkZGi2u+8jj4+O7/AdchvYLEDWZDIOo1jiwBEUk2EHUk6GJPamFBX/
         tWExz2iSLQmnLRTubNgcib2g+uFBMXKV1hEHa6B1IfSZOLE/78A6OqjnSQ29HNCCnZe2
         tW8TTwxPNcHaAT88BCFrfQjGvlaTOlX8aOdtnIgUssLBZGT8jNu5wFyDkEILEjpHaFXz
         3pnf0wpm0xbiKozJpO3b0XhQQi/CdRLoWJXu4EZ7RkpFejjgDD6Hm1Yru2qwY7RsBOfd
         fPzpuVIEuehujelxjW6Cg7zZ+Y3uhKVikM6ijBx0d0hyWqRQam1VgA8FnsyR9FwvIBr5
         22WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YMn33D1fvbsOQjVLRYkAXXQ5Mr3LhRnG3fNN+0bZFqc=;
        b=jFikoyKXW9wu+z2u1GdhCs3AosLpVBRtxCkct+bur5ApxOiNqxuLVphsbC2aEi2/Pm
         eKbPSFmZwWvxYf4PnyKkCDcVRbRmtaDGws1+HDcckG39KufwIufXUgl84bFLYNLXxDXX
         lw5D7iqOTcyty+wjzw/+xJkxRIeiPUjMqtG3k5uDGXIYiax5Vm2jJmy4Wg/Euz+ttfk9
         qquxypgCxbOmTK8RYxiYSk/N0eMbyMiY4tdZFVPRjhfBjDEZ21BnenGruGc7NqjOjqI0
         8yCLumVUvjofXr/xhyG9EsH0PU280S7utBT4iwOO+0558QS8l1rMU2UluRXgMAzkjAlI
         aFGQ==
X-Gm-Message-State: APjAAAVQIri/D+bgrrwl5VqY4wnjUVlsHru+wD56cQy9qrwDzRA6Ykre
        EeSSzmiN7BdGvvOIZzHUwrsIWKT2Dpk=
X-Google-Smtp-Source: APXvYqwXkyMYI6Uj032rQa/wu9B9wzzpL5hREfSXGRjGQISEHzEQE1lpJRaydPGwDIIazZjbtphGmA==
X-Received: by 2002:aca:6c1:: with SMTP id 184mr2296358oig.84.1573717202583;
        Wed, 13 Nov 2019 23:40:02 -0800 (PST)
Received: from localhost (wsip-98-172-187-222.no.no.cox.net. [98.172.187.222])
        by smtp.gmail.com with ESMTPSA id e19sm1564350otj.51.2019.11.13.23.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 23:40:02 -0800 (PST)
Date:   Wed, 13 Nov 2019 23:40:01 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 10/15] riscv: read the hart ID from mhartid on boot
In-Reply-To: <20191017173743.5430-11-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1911132339360.11342@viisi.sifive.com>
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-11-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019, Christoph Hellwig wrote:

> From: Damien Le Moal <Damien.LeMoal@wdc.com>
> 
> When in M-Mode, we can use the mhartid CSR to get the ID of the running
> HART. Doing so, direct M-Mode boot without firmware is possible.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>

Thanks, queued for v5.5-rc1.


- Paul
