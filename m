Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B05C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80245218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TZ8vM0VH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGYVLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:11:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44913 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfGYVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:11:48 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so100164207iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dA9BWec89vDrK4sNwuycmJwH0QLl3t9FK5TEZwiOlSU=;
        b=TZ8vM0VHcO0hC55LMc+PM7ql22DZmj9+opwNwcn0uPnwHfyCTj6D7L+c0UCZiszL3F
         hSpHPzTYLOYZ137GsFPRN3P/GOwdccByQQA5Jgcjh4hdxqIqhMV/vL4W2zxaFW5hWpmt
         lRiZug2LQ+6xgg2GJ4DJH8f8SrkI2bxfdyXHGkzJ+VRDhQUTT5TS1N+B2SyYHJyeoG1V
         pYubbIxifUk+pCRunevKjHUjtxE2fjsrpy5aNwxUuAPt0VWdO3poK/tio9ULHSrjrnh+
         AjRG8zwq/21utx5EH1vuZU7wvi9dPS2onrI5+9IMy5rj6qdRV5KCl+SxJJn6xSAq6aXW
         h2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dA9BWec89vDrK4sNwuycmJwH0QLl3t9FK5TEZwiOlSU=;
        b=a0VMOIGU96RZPxC285f8bPQnGe5GHdaQNwZ1AmiR4PkjNCc0Mq2ITHiu4TTh9irKaJ
         avOEbtJOA5I0GyPAqEuFvOiamepHNBdmqmOAMHuW4fJgqIZ4ICiqmu57lKm72BsnAC0B
         n8Sk9vCbEgtbbwuQ5b/UVCOzZP4cWrha1M6Q8kaGhNLSHHG6svAwmpKwiQ1fsEntgFVA
         +vP5kNbAesGPwmpb5j6itqhXaIBT9XQL3b+x4q7mTWAb/uq49frL+gHDPjhiV0Cesfen
         u+XDN6SfJF3K8Z9ADYOCV7RXYIUFE0qXu6qiUu6kd0e8Lr1qgHzexM4UBROhL1rP0+8F
         YzTA==
X-Gm-Message-State: APjAAAUD9d4BvfUWyawvORIuBC1YzHSpAbOTpzQ/qJLg+BBkczmg2FlL
        E2sUwvFKlKLmdsIvufn5+R9I0A==
X-Google-Smtp-Source: APXvYqxce7dOtti9WfwqIwfsDwFKgGFk3PvnUeyVSm1YUvuoCwWcdCFYsqk07eOVXB7qXsh69w9J4g==
X-Received: by 2002:a5d:9ad6:: with SMTP id x22mr56002184ion.136.1564089107990;
        Thu, 25 Jul 2019 14:11:47 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id d25sm40678729iom.52.2019.07.25.14.11.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 14:11:47 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:11:46 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mao Han <han_mao@c-sky.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 1/1] riscv: Fix perf record without libelf support
In-Reply-To: <96b979a523210628de8a8a3d6e48492f6f1ff02d.1562812381.git.han_mao@c-sky.com>
Message-ID: <alpine.DEB.2.21.9999.1907251410240.32766@viisi.sifive.com>
References: <96b979a523210628de8a8a3d6e48492f6f1ff02d.1562812381.git.han_mao@c-sky.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2019, Mao Han wrote:

> This patch fix following perf record error by linking vdso.so with
> build id.
> 
> perf.data      perf.data.old
> [ perf record: Woken up 1 times to write data ]
> free(): double free detected in tcache 2
> Aborted
> 
> perf record use filename__read_build_id(util/symbol-minimal.c) to get
> build id when libelf is not supported. When vdso.so is linked without
> build id, the section size of PT_NOTE will be zero, buf size will
> realloc to zero and cause memory corruption.
> 
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>

Thanks, queued for v5.3-rc.

Also: thanks for your patience on the perf callchain patches.


- Paul
