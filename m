Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518C2C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B8520873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557768049;
	bh=+42OnEo4knbov9V5HDyBND3wTKu4zdOkDUehzeDGg80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ba0l9gv46vxZ8Ozme9U+wam9dQHxQF1t5gM611wfAWGqTcbwUD2Kek7L300f7pnBC
	 h9gPIIU9oPWRZrAMq2LETqz5aDoRx6DsjFCh4gUPzSJMJvyvPVF6MnOsfQrUISmX1k
	 2hl79aZLpH2riOh9xJ+Ueky35htoiGBVlzaFtdcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbfEMRUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:20:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41863 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfEMRUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:20:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id g8so12500144otl.8;
        Mon, 13 May 2019 10:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6lzt8+79/YXe1RIAgMQrfkL/2w3nR8+pbpD1D7X7dZs=;
        b=mzYBbZoFiAoH0K8kMMO10Af2wgi0pxPVKo+TQsCDqpVjSNkpU5r7Ze5qn/jilo1h+S
         IQwC+YP/xDb4MNaab6eGEz4r2v1wkjdLOuUD80LJ0NFXCaAA+BxPtphMlRbMDbn5HEPI
         Nv4YgnGDCTfaK1l39nbXmX1YSCPYV5fWwFQh97WpPGuDyxFjYXSBIJHfOuQc6RqZkv9K
         lRqGUyfi/aYMkh7fXVa6T+udCnn9IOhYzEORuD5z9WplLeG1ea1h9zqU4IwkqoUPIuUC
         sNeqBoe4NCBpojDx0VpuejJPDNje6XkM3pq0EpQHMssoMso87Y2FJ+UEeq+6NpyZ43b3
         wgWw==
X-Gm-Message-State: APjAAAU6558PeUDT68LvVKF4WoxHw7ymnvvylNvDapzyyGSTA1HZbpLI
        oVn8b2+MhFuEdHWCi6T8hA==
X-Google-Smtp-Source: APXvYqzsH1mqH6ub44FM+TlRJfY1RFcsoPG0Ib6mN86yJC0AWQ7f1gf70pq1BaxFaLVpTID/KR6xlQ==
X-Received: by 2002:a05:6830:14c6:: with SMTP id t6mr560925otq.3.1557768046408;
        Mon, 13 May 2019 10:20:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o5sm5230136otl.44.2019.05.13.10.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:20:45 -0700 (PDT)
Date:   Mon, 13 May 2019 12:20:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v3 1/5] dt-bindings: interrupt-controller: Add Renesas
 RZ/A1 Interrupt Controller
Message-ID: <20190513172044.GA593@bogus>
References: <20190502123220.3016-1-geert+renesas@glider.be>
 <20190502123220.3016-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502123220.3016-2-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 May 2019 14:32:16 +0200, Geert Uytterhoeven wrote:
> Add DT bindings for the Renesas RZ/A1 Interrupt Controller.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - Use interrupt-map (+ #address-cells and interrupt-map-mask) instead
>     of renesas,gic-spi-base,
> 
> v2:
>   - Add "renesas,gic-spi-base",
>   - Document RZ/A2M.
> ---
>  .../renesas,rza1-irqc.txt                     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
