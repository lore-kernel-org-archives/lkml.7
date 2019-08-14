Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A37C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78F120842
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hjIYO+1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfHNCYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:24:24 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42549 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbfHNCYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:24:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id o6so1629031oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 19:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1G/a7WS8pUpL1zmvbKTHzrkVwD487e3W+2smn5ktODc=;
        b=hjIYO+1dYGPbiBq+dHbXBz3TuAYU415ba+1qYeiXmxFN4NqMFXVq7AezPzQ5RozDKt
         OhVMOWSsix2AGx/5/KosEclzeVG+q4u4QX6T9v01GB2WbUHzhz+qKUgSqqvElDNcxguA
         QAdWWDM0D9Fj4YUN2+SKnPEtgzLmRpQ3y6nT6JZdgsFTmheqoPdPSl710HrUWFxn1xx2
         3sxXG13GhNUL+0YVJq/Fz2comXRXfon8+AUK8elZg51t2o8dQcKuUAKho0OPCl9ISl/l
         LSkGWZOSVuTWk5+OCzWwwN5CH7GdzBhxogTwKdH9DHY/CN1agrEx5q/hdh32dTkjHcql
         9KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1G/a7WS8pUpL1zmvbKTHzrkVwD487e3W+2smn5ktODc=;
        b=VL4oAVUaeobnM4up0rRuQU9U7QIWzVYEp7D2sUEZXy8+P4lfJAnUt3HlcCkXV76AqJ
         L8VtbRvyc+Bo2Yi9PNydcAtrm6+FMYusYNS8uzVsfQnNUgMB9MzkS3tshnI613rAH8np
         V91iPUOrNQkCZYXg0xY8aurIphSVlyFEwNo74ITTpmlTB0NZd31U9GLP0JzTjdHSJzSM
         kVxaRUw+nc2AF1R8ooqBV8/YHPgBWHWe0GpsTc6N52+D9UaOda46mxUf61jKciYoQD5d
         lyKlPGyJQ6TxCj/hrAbF6cmhsuQBgUVIVyiLrzc8AT0+P/2bgMjl4Gl7GfUOv6RzPksL
         kC5w==
X-Gm-Message-State: APjAAAXdx1jLJLBsL9gcC3CD4xZjbH083rJfwfDA7zyD7GZ7BX5nK9xQ
        x1NTMoMV2Gy7uaxVcLtlEefwtg==
X-Google-Smtp-Source: APXvYqx1NahTVPRWa7m2oJ0W4YhsQAxXbI6gehhVtgk+OAiDDzj+CshHjmVcVPHC2vZxZqmTXgtrNg==
X-Received: by 2002:a02:a18e:: with SMTP id n14mr980021jah.84.1565749459743;
        Tue, 13 Aug 2019 19:24:19 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id y5sm114834811ioc.86.2019.08.13.19.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 19:24:19 -0700 (PDT)
Date:   Tue, 13 Aug 2019 19:24:18 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alistair Francis <alistair.francis@wdc.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        alistair23@gmail.com
Subject: Re: [PATCH 1/2] riscv: rv32_defconfig: Update the defconfig
In-Reply-To: <20190813233230.21804-1-alistair.francis@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1908131924100.19217@viisi.sifive.com>
References: <20190813233230.21804-1-alistair.francis@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Alistair Francis wrote:

> Update the rv32_defconfig:
>  - Add 'CONFIG_DEVTMPFS_MOUNT=y' to match the RISC-V defconfig
>  - Add CONFIG_HW_RANDOM=y and CONFIG_HW_RANDOM_VIRTIO=y to enable
>    VirtIORNG when running on QEMU
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks, queued for v5.3-rc.


- Paul
