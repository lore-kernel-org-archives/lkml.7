Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD4AC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117A9208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ghENWpAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfF1U7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:59:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45487 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfF1U7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:59:17 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so15299362ioc.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=STUNHcZ4hxOZiod6u/3V1J8ZChBosSMoQGGe/lSDBs0=;
        b=ghENWpAAVzjbt6oM5hyVzf70X1DiGlFi89Bdqe+7m0aOwd0gs6r55kdMdjWrE3ONfx
         JaH14I+2HCdc/eCei6DpI4p6c0FNK9z0ygDH0qvEjwGggxSvd8ikRv3/OHjVFZMPjpMz
         jqbJHQV1/IJf+VdXISXfgT2VByp1YtvqGI3BWUsLtyZxTExbYxReW9zWUlz7b1Br5k60
         bGUbiq0ZY9id6VJqboNCXDb5vZv8e9UVboLJ4Vz8b0Xr25u6RJ6CsYcgT2zxlmcIi6ZK
         M7VUqWqwSNocDJfSHYoKa9/pdWcrAP1AAxoGny8AZgQ+TH4vxaQ0g9OSfGP8mMZzEvhf
         bM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=STUNHcZ4hxOZiod6u/3V1J8ZChBosSMoQGGe/lSDBs0=;
        b=X/Z6sDAydIPVF9400Js//wyJRs946Kp9VXHUiqdv1ZwJA8co28nrPfo2MMek82Es21
         p0AcsQJhdvioF2xQEESQZ+/i4ubHDHNCUJ4pykqMJCyGQWEJ83ceXZKimknc1Xm8eVwC
         YWMf75wK/S3gABqrfhzUGmGY/W9CgG25IUT9QsoXi4otwJxTLH3OrILCmI+KakmGKMso
         TUV7JHHeQRzytHHXRGEW8oqZMrT/+ckl/Y4OOMJ5lyTtWuf4ZkWS+rpT4NvSbQR/CfNp
         AoKH09eUyq1/IcM2Me+1XTssvHH0SPfl3zvghK5k0rGODi04EX1Ntxl96a0tzb+8SdRa
         OFEw==
X-Gm-Message-State: APjAAAXhzxVM2n6kL7T6o4QS5FfyhHgcQRIKzonH9MHOtXM1aiikExcA
        axFRBKQ9K3nBXpjA4x9orwm2VQ==
X-Google-Smtp-Source: APXvYqxXFZwkCq/2JrQtMexw56mdAgVIzXPkjYw4TSdLaDVipd/LicRSt3CQ4GKhXW+y9Vsk0zxqrA==
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr2537366iol.269.1561755556522;
        Fri, 28 Jun 2019 13:59:16 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id n21sm2918468ioh.30.2019.06.28.13.59.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 13:59:15 -0700 (PDT)
Date:   Fri, 28 Jun 2019 13:59:15 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] RISC-V: Fix memory reservation in
 setup_bootmem()
In-Reply-To: <20190607060049.29257-2-anup.patel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1906281348441.3867@viisi.sifive.com>
References: <20190607060049.29257-1-anup.patel@wdc.com> <20190607060049.29257-2-anup.patel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019, Anup Patel wrote:

> Currently, the setup_bootmem() reserves memory from RAM start to the
> kernel end. This prevents us from exploring ways to use the RAM below
> (or before) the kernel start hence this patch updates setup_bootmem()
> to only reserve memory from the kernel start to the kernel end.
> 
> Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, queued for v5.3.


- Paul
