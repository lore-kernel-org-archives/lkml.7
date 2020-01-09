Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860EEC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51011206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578595973;
	bh=0beG2pDkUzzZFxIC42AcghJ6UqnLlsPpZsyCASA+bl0=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=vORtYkOgKXshUDT4H1/F5eOOiMS9DfyRF8R90TCtu9geYKWUZbaCkbR781gBb2q5a
	 ijKUEPgeIsXhZqOA9avYwy85ne50rnzqDKxVYInPmu8D1SDKhzLGHEORBDKr6Zu0UV
	 IgEnMC+dQzQZtl88HD3VSciCM7CljhkF6J2ANb5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbgAISww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:52:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41061 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbgAISwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:52:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so3625488pgk.8;
        Thu, 09 Jan 2020 10:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=hBV74Ydk6mDQDuE/3ONK0QaQ31FjZx8A18SMygQocsM=;
        b=OGfAgD+0djo97dIWnUmXMIDBh/t0JOEs/u6FkS1IW6oV4LcCp0K/NPTzYaQJ+Kg408
         Air9xZYESNuE2C1z6h8wodgs4b4fK3/cxJ5UzYQnsqOXn/4/drL53fcY7lmnBOg0tiA+
         wBDOBgMNg1e6yjUoJj9x8KIjAXmGmhlljHjVpx/b4WV+Caze37FQ6RS/EF4Ufw8OTdao
         BpS9Xn+BROzHTK27DMu5bIuCoM7/apJvUnuZbyedJKAr1gEDKvIyDILZQoUCHte7KeE3
         bUO8IUFT2F6p+m9XzSXHCLXhrHXU0FGk3BWGIYqQtjA4MNx7vBWV79y3x4UhbWbLuBUi
         9GeA==
X-Gm-Message-State: APjAAAVAwAPMUAtYrbXgnmm4U7JUdoU0TNzXQtbpZRXKv8JaywdZ92YE
        /EzThN1Crd6ewJ1KPN+dv6o=
X-Google-Smtp-Source: APXvYqzM1MC2kDmR4PiizMSnJKZKBlArFoxv+nUHDf4ftkSK3NfkN/tZ4G1n2hyNM/upXaE85qLq6w==
X-Received: by 2002:a63:d411:: with SMTP id a17mr13541550pgh.333.1578595970656;
        Thu, 09 Jan 2020 10:52:50 -0800 (PST)
Received: from localhost (MIPS-TECHNO.ear1.SanJose1.Level3.net. [4.15.122.74])
        by smtp.gmail.com with ESMTPSA id e2sm8956379pfh.84.2020.01.09.10.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 10:52:50 -0800 (PST)
Message-ID: <5e177682.1c69fb81.b79ec.61f3@mx.google.com>
Date:   Thu, 09 Jan 2020 10:52:49 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Mao Wenan <maowenan@huawei.com>
CC:     <jiaxun.yang@flygoat.com>, <ralf@linux-mips.org>,
        <paulburton@kernel.org>, <jhogan@kernel.org>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <maowenan@huawei.com>
CC:     <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH -next] MIPS: Loongson2ef: drop pointless static qualifier in  loongson_suspend_enter()
References:  <20191204010851.160284-1-maowenan@huawei.com>
In-Reply-To:  <20191204010851.160284-1-maowenan@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Mao Wenan wrote:
> There is no need to have the 'T *v' variable static
> since new value always be assigned before use it.

Applied to mips-next.

> commit 11d06df7b9f2
> https://git.kernel.org/mips/c/11d06df7b9f2
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
