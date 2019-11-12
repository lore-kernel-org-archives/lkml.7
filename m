Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CFDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AAE2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QD70fxh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKLT62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:58:28 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37185 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLT62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:58:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id e187so15630818qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 11:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=47lQ6/DLN6Xo+wWf7tnAV7rO9fUUtwUf7ZitRmJCvMI=;
        b=QD70fxh8o3e5RCQfeBx8taEyqzIsuI/UYkfnLH9sLIb3zQSrvawKbCbQs3SPEQftzJ
         b5WAwc6yxwlYJsDno/f7O2Jypo4qLauVvxQ/itV5BbxxxK+4t5sA0xovbQ5odld4cMDN
         9Uu34nG3AXxDo50k7dEKmn6IPe+teKNoVyvFcTraKEyJO5tqed1w7VGkKVQ83Cw6mIsB
         RK1Ts09el5D+oIjx1QiL+tAWSKjKge+N9aB1fJc4SD08ht5jj/vJF3ARbEArYAyiFZck
         5GOdVUcfnCaBkkiE9faXwAQFMCU3vpIlsPh362cY7SuW+Eb9tHe4q3nEnBTm/VZ4bfk3
         S2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=47lQ6/DLN6Xo+wWf7tnAV7rO9fUUtwUf7ZitRmJCvMI=;
        b=t/VE6o7tRi8/r4Gcp2aJKohFv46WjMduKnT3Orpm6aZJ04hOVA/BGvHUQRixtvW5p4
         XfIC0BbbrMRXJyCh20s+OCbD0yn8XmAQc8O2BNLKTJlb2OhQCbWpomF+GAjeGMWqQ3JS
         u/GPIyGV83h7krQCGg0Jv7+XGxWbUT1ixZRQHEDe/nGJxdJc8HjykPXA8RFPSuEKNgui
         PZpqBRHKRikXmsOjHao6SXSG7aP/i4t0h89qgZE7l1vyvnBBRnsG82DUO4bol7BlT6Kd
         WFogDxeI4QrmBGSstHXYpRoKhetVFQaRvvQSL26dyIu7mCKoYjuGZeUlNJhvVLWhXA1Q
         WPGg==
X-Gm-Message-State: APjAAAVX1KljdMyJ9DV5WDvUrfbUMUFCI1vmUBuIzy5jmDnzJKsaLw0m
        ixpTqru4D5j3sGbTEKz0UZCR8w==
X-Google-Smtp-Source: APXvYqw/M35I+/IgDKyf6BI2QzLCpV7eUbLwGQPMxPRgbREwkgt15L4XA3RjjTe/HYMKOJrT79ZTfw==
X-Received: by 2002:a37:4a03:: with SMTP id x3mr16412893qka.301.1573588707381;
        Tue, 12 Nov 2019 11:58:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u67sm4845726qkf.115.2019.11.12.11.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 11:58:26 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUcJ0-0000pI-97; Tue, 12 Nov 2019 15:58:26 -0400
Date:   Tue, 12 Nov 2019 15:58:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.5
Message-ID: <20191112195826.GA5584@ziepe.ca>
References: <20191112195542.GA10619@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112195542.GA10619@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 09:55:42PM +0200, Jarkko Sakkinen wrote:
> 1. Support for Cr50 fTPM.
> 2. Support for fTPM on AMD Zen+ CPUs.
> 3. TPM 2.0 trusted keys code relocated from drivers/char/tpm to
>    security/keys.

Just to be clear, this is for the next merge window right?

Jason
