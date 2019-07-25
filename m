Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D52C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A6C22BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LvIZiJGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfGYV0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:26:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37823 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfGYV0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:26:31 -0400
Received: by mail-io1-f67.google.com with SMTP id q22so100331291iog.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=76/gf9wFjHpTUDE6FbprmTNUjZsTgezSyFFVzVXR7sk=;
        b=LvIZiJGza3pKmSCbWyc7TTTl2OoTMKpU2DU+CJ88atN9zvt70BjGxMhE8khQszS08R
         B+BkmOtok5QjBd0CNmzQovLkSqNeWy1nkAL78WV/5VjMe2EOJK4KrRcSZIyv+ft2yG36
         rGUchtH3UsuNM09rqm7G7TPk2NVZQbNkdWHOBTFgOjF8jtKYD8v6hbPDckPXiiEsK6Hy
         6UBP1VETBolc/9LXsDFQQxf9vf/AzCxn+dDyhrhXKbFl3RXq33BTBqLh4TfEBljdtB/h
         uL3TxzqhMjDhvk8EGTxoJk72XZRsFuUVEIE0yqs4HLmeDcBeOxrHg0OoI0taTq9UKfy5
         St1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=76/gf9wFjHpTUDE6FbprmTNUjZsTgezSyFFVzVXR7sk=;
        b=sKmmHo/jxnxohKHvST4cAW4dNXxU9+nMQGiXsgZC504V8ImqnJ+2njoXb6FvIBQauA
         5SXpQw3izN9fDi/opgI7X8lxESeXrID1Md215l4hZ66DRQWOKAZxiStErpWxSEtHAIqA
         T5S5/cbIl+lRovYrx1xVZLMsxcwkKZpemkfCgX0nGAmUC5gfVsWoeO//r49bcOWuWAD/
         HuGd/bUjaJval34YhJeGhYxqEGjwQ7tKzEW2UrGvtimKMDWHGQd7ZhUJP09Vexa5uh6v
         btk4J5Rs3baSzGOK5tYyyd11sxD9rH1HZQqqpaGuyXrgSbwT7RhEsOiuvPM5eq5sr7vP
         +jSA==
X-Gm-Message-State: APjAAAUGruTFdu/eRNUdr1PWIZ0gbqQj9ZKdbN7yUI+WvXeHTZ/0Qepr
        ovPrDaMj0eX3vGYy2A9lKOuU7Q==
X-Google-Smtp-Source: APXvYqyhHmO1gUw1vzdQhPJd+YQtrM3wJpJ62sVmiyXexiirus39t9vFwVY26bMD21fVqSBlVx9y/Q==
X-Received: by 2002:a5d:83cd:: with SMTP id u13mr80672996ior.297.1564089991129;
        Thu, 25 Jul 2019 14:26:31 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id s10sm118939163iod.46.2019.07.25.14.26.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 14:26:30 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:26:30 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     bhelgaas@google.com
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] pci: Kconfig: select PCI_MSI_IRQ_DOMAIN by default on
 RISC-V
In-Reply-To: <alpine.DEB.2.21.9999.1907251422040.32766@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1907251426010.32766@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1907251422040.32766@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019, Paul Walmsley wrote:

> This is part of adding support for RISC-V systems with PCIe host 
> controllers that support message-signaled interrupts.
> 
> Signed-off-by: Wesley Terpstra <wesley@sifive.com>
> [paul.walmsley@sifive.com: wrote patch description; split this
>  patch from the arch/riscv patch]
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>

This is missing Wes' From: line.  Will resend a fixed patch

- Paul
