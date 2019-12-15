Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88053C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F71524679
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DUvMIF0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfLOT4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 14:56:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44945 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfLOT43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:56:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so2407143pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xVlHo/nlCMF/qBOiT/VWeXY0vmm1o3tLmTZcUn6/oaU=;
        b=DUvMIF0QFOTQxH81JOUzG93EnqkGo8iYo7Lrg7rDp7kmCy6fNi6LPYdGbuqMmmu2S/
         vMk5R1Tekf+KM6khmVWfEBHeKGd+Wcv2jCAhovSwh8RjJZaRBfk28pjyuiMG8HNghhN+
         RGpRL7jhtzoad+EEq+rR/V5hOa4pErRPSq+SaZBigyAKRf6YXqLM1hQ5euCCFf5xtp/Z
         YTgjPnsFknNsrc1ov6fL8oK+ABWoNVAW7bwwxEeErIJKhQ5iJrzk2MqKPm/NVGCgIcbt
         bXcJnvnnxPH+i+AGlY8aIW2Iout+LDUg9YYF2Yw9Oe3rgYWimi2IYVB3vRIfTrBbz3yN
         9hiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xVlHo/nlCMF/qBOiT/VWeXY0vmm1o3tLmTZcUn6/oaU=;
        b=Dl870ldUsoFGLfo+aWsYK98GXbn8QXUKrdlEIc5weKtauvQMLxPe3DOXs1Sq8UY7+y
         /lJfPMJQtsAl0MRTXdcE3JkIObVDeihBRSAf7QogR6NaU4JJLHpduIM8wxwiXcdaQbxA
         OpOD63qbGy9fsW4r8MlMF7Og3BLODCjwvhwpnQEsXxDKQkI4EUYggIzEyH2IO3nd7+qF
         muT1v0Y+GDhCSPGr8w6H2VvXIYZuAk8Tc1jqQCotnfcFQXAnrnrcy/FV6LGmcoWo0aU3
         Dx5LgdB5bNEyoWpneuv2Do85ttyEc2MCD/KaF9Rq2jGGKYzYRMdoJyOhnjVc+Zj8OeWL
         GK8Q==
X-Gm-Message-State: APjAAAXMlO4ya8CB9WZxKv6BpxRCguM4UHAkPlSXA/v0SiD48bBgxd9K
        1Xrp+ozNDrcmWGKU6uLSPNOU2A==
X-Google-Smtp-Source: APXvYqxEKsNxK2ArifpMSeV3q5mX++F0jrdmxTOyWcJDZYYNJOVdT9sdTwJBe4gGIhdguz3qVIfILA==
X-Received: by 2002:a62:8205:: with SMTP id w5mr12272097pfd.136.1576439787225;
        Sun, 15 Dec 2019 11:56:27 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id i3sm19528061pfg.94.2019.12.15.11.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 11:56:26 -0800 (PST)
Date:   Sun, 15 Dec 2019 11:56:23 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Palmer Dabbelt <palmerdabbelt@google.com>
cc:     yash.shah@sifive.com, robh+dt@kernel.org, mark.rutland@arm.com,
        aou@eecs.berkeley.edu, bmeng.cn@gmail.com, allison@lohutok.net,
        alexios.zavras@intel.com, Atish Patra <Atish.Patra@wdc.com>,
        tglx@linutronix.de, Greg KH <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: cacheinfo: Add support to determine no. of
 L2 cache way enabled
In-Reply-To: <mhng-a1ba4b8a-4c6a-43e9-a87a-f8bbbe3555d8@palmerdabbelt-glaptop>
Message-ID: <alpine.DEB.2.21.9999.1912151155010.64438@viisi.sifive.com>
References: <1575890706-36162-3-git-send-email-yash.shah@sifive.com>  <1575890706-36162-1-git-send-email-yash.shah@sifive.com> <mhng-a1ba4b8a-4c6a-43e9-a87a-f8bbbe3555d8@palmerdabbelt-glaptop>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019, Palmer Dabbelt wrote:

> I thought the plan was to get this stuff out of arch/riscv?  It looks like it
> only got half-way done.

That's still the plan.  Will probably send that one upstream in v5.5-rc.  

Am not a huge fan of moving it to drivers/soc, for a few different 
reasons, but some people seem to feel very passionately about it.


- Paul
