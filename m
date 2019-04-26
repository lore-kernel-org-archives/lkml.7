Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47296C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D7D206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556315080;
	bh=hzMCaXq00R7Ba0Bl3/TM5mRKao7pulosDrD4EQ1M+2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kiw9pDUgnty9njPlF6kaCvtvlNKO23blxGnOIosqd0pRkLTl0rVcjfiGVYHmXcW8D
	 yHCUSrNqS3lE8B0xdU8gkQCOCy4XfeOfp9CX1KEWhaMROV6pUBKC/Xt39lL3pj5ByS
	 +2bvQ0131+NwMqcGIWrCg8G3bYjcNuDm7Vt3NgZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfDZVoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:44:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39125 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfDZVoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:44:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id o39so3907125ota.6;
        Fri, 26 Apr 2019 14:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v/cjsNw2NB4sPUKQIAWaww9R5us1EWq66EYd/vmRR+E=;
        b=uB70AVVdHKpPVlxaAkxsw39ziri7FXjrkNdV8EKT7NSbL5C4rVg6rraoizdkWe+fLe
         3oKQLR+7f4LvDv9PN6VNu0+VWHq1nhDBf2LBTqTe4mvRtRoFk3LQzDu2e9zmKgYAlW48
         yJcNXmVowIqsCHM74YNlI6g6fKzLKs6jeQ42vuCMB1fd34Glpf/3t8ySG1hOA6DfJZ4e
         sJbtFM6Jp7rzQkgCmQhhucF9CM96mV9Xx3voyP3ppFjLLH7Rn8ok1SH3gb1cwnFaQaVz
         JBJ3U8dKshiqu+KGldcwv96DGmibe4e93oJTwCJW9bchyA/uyt4rLpmmg5Ll8Br7NpjL
         K8mA==
X-Gm-Message-State: APjAAAUUJP02yg4+/sWQ1ovcPOzEopq9SZu5dncHAwz2nGWB4R0kp7rP
        c/t4c6nrq09Y4TKvhzrqLQ==
X-Google-Smtp-Source: APXvYqzPSNoMcHwqGgKXwZYQEUCOgGIwLLUpLR0zTjMv9LXIZE0oOPjbbspsIWWwFcX2LEIJqdRiyw==
X-Received: by 2002:a05:6830:1656:: with SMTP id h22mr482995otr.144.1556315077874;
        Fri, 26 Apr 2019 14:44:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n3sm10998762oia.46.2019.04.26.14.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 14:44:37 -0700 (PDT)
Date:   Fri, 26 Apr 2019 16:44:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: clk: add documentation for the
 SiFive PRCI driver
Message-ID: <20190426214436.GA29815@bogus>
References: <20190411082733.3736-2-paul.walmsley@sifive.com>
 <20190411082733.3736-3-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411082733.3736-3-paul.walmsley@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 01:27:34 -0700, Paul Walmsley wrote:
> Add DT binding documentation for the Linux driver for the SiFive
> PRCI clock & reset control IP block, as found on the SiFive
> FU540 chip.
> 
> This version includes changes requested by Stephen Boyd
> <sboyd@kernel.org> and Rob Herring <robh@kernel.org>, and
> fixes some errors in the initial version.
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Megan Wachs <megan@sifive.com>
> Cc: linux-clk@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../bindings/clock/sifive/fu540-prci.txt      | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
