Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BBBC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3124321951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QRxolnZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbfGVVqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:46:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44369 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbfGVVqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:46:31 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so77264395iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VWIZBvI5lCbidvXKY6O84lqCZ2AjaGY2QVwWc2bhom0=;
        b=QRxolnZMSRjr7BTm00Z8wwbzzUyOLZZvVERqLil5ipazTc2XhnIF6C70R84dF+etKK
         WpObHA4zIcJv8+m05XstTbyF6sBH1EGDTFBnPfsk6yOxc+A+b+xply+hM1A5RzrT6HuM
         ROpw+KdsvciRm3w1quQySFv3XIOP7tbwz4KFM/jO2etmZxVfPAwmNwqV/sHgdZ4lVw8X
         0ucGKbgZRWgL5ixPf9JnKL7ngRO65i1fCFJI/CSQUr12AdIakOCqkGfZg29b/es/N/N0
         aIHkJHZxbOYMPazFYdIeLMsmd2ecRQ5bVatC05ATHZI3daEtEXkF5QO2W7Nsv7frreB1
         0NsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VWIZBvI5lCbidvXKY6O84lqCZ2AjaGY2QVwWc2bhom0=;
        b=fz12+L976bHuf9nCXxl2F0z98pW4ga2OpQcrvbrHcLJYcj9LBIRQ/5UPlTeMj+E8ve
         krLrYS2VjcqiqmUnRiGuNmncP1kv+U16oLTHj8HyK8Is9dCgHXeZcJNSHgyZ1+LFxECj
         Sx0Ji389tG08zYDgODlkFi6RBjK1OnLUBgHYFMBjy4oSouQkWgsuHKM/9rMO0RSZRCOa
         8Bnu32bFY1+XIjxEjDPr4751QD4+NrDTTJA56HlnX3CQi8I3T6ZtI3c3A67gOu7vP/Nl
         4cTN91gKa51BSLqtMULrz2b70b4CTEDt9X/RrSxomSNSNtH+Gi5OnnzBsUlzeAN/eSZJ
         f+Dw==
X-Gm-Message-State: APjAAAVNR1ZE6va4ZOFJBVJQC3YA3p59eVgb3VMJELYec/amfQryNBnc
        QbChMv/6GxV657xx9eNATsqNlA==
X-Google-Smtp-Source: APXvYqyd2dW888lhV8CkKjbqoz2NLahTQzYkKlmc3wSjVe+iOryGMbi075TFpJ6Xc0oCjN8Cgg19Lg==
X-Received: by 2002:a02:1607:: with SMTP id a7mr73356673jaa.123.1563831990677;
        Mon, 22 Jul 2019 14:46:30 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id x13sm30725719ioj.18.2019.07.22.14.46.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 14:46:29 -0700 (PDT)
Date:   Mon, 22 Jul 2019 14:46:28 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     davem@davemloft.net, robh+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        palmer@sifive.com, aou@eecs.berkeley.edu,
        nicolas.ferre@microchip.com, ynezz@true.cz, sachin.ghadi@sifive.com
Subject: Re: [PATCH 2/3] macb: Update compatibility string for SiFive
 FU540-C000
In-Reply-To: <1563534631-15897-2-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1907221446090.5793@viisi.sifive.com>
References: <1563534631-15897-1-git-send-email-yash.shah@sifive.com> <1563534631-15897-2-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019, Yash Shah wrote:

> Update the compatibility string for SiFive FU540-C000 as per the new
> string updated in the binding doc.
> Reference: https://lkml.org/lkml/2019/7/17/200
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Tested-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul
