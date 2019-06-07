Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B63C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3FA212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TNIHxn+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFGFA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:00:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36722 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 01:00:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so347097plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 22:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GNyxhCfsORr2e6M8vPY8+L5gnSVQwdktACAugcErG1s=;
        b=TNIHxn+tFESTWzJW+ZyuBRPd3t6RRyEnrDKP4AiawT/1wDdQyioePTAqbomtN0wWN2
         y1c0b+3ePB/bOyDr+kf8D84Vc1txJKud22aFGd2KVgCwyqnLylvrnJWDrXvj33vqGOpN
         OjLtZ+kqyLxgTCVJxkSpI71SYb/v4U6fH1gaOaHKHbcc70mxuZu/GuXAVp81oMqIknE8
         2kQSUVCdXR68/ViRhMKfv/UXz7kH2otBS6Bo8LA9tb6J9JCEoXc5+bFUv1vYHdHC0Lt7
         iVr6dKcezKhC5Aj5b9OFbBiu3Cf7MLLnlZu19VtFVi87q4n7ztQFWsGbPzSbdF/5GGoX
         HjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GNyxhCfsORr2e6M8vPY8+L5gnSVQwdktACAugcErG1s=;
        b=VoEMuOmC/UWgWk5lTqRyAdZm6hfDJ4Fa+HrCFwzxNke/LOqACAcdBXT6QwIr2GYLAF
         P/NKsGr/o1BwOI4iJGz2BIC57eD7EW5XJjSJVFIKU+JMbXoh/VxvO54huCLzasOvkxxq
         ntBMEqa7Ah5DzuKyQvwT+bm0oZaTQXYNrcWVVsaOzBtv+YV/li+bxrbNjIr4JhF8bnxh
         Pj800tm27N7X+i5R12GX0H4LjBvruu6P3M4MwvLLESNOLaeGBdtJT5FkjsWkYWwgHxdx
         GWNbX2BP44UCfWl7h5ZqoIML4bcR8Od/YJdfIsg67Ma9XstLNrDRW39xF50j4N5htYjj
         Mnwg==
X-Gm-Message-State: APjAAAVx2FwqTA/oa8W6XkxaApnLY+XkGu9JTCGz64NNONVCum/xt6l3
        YzVCHdX48mlrkmEq6H9OFeRZEQ==
X-Google-Smtp-Source: APXvYqyUw+DSN9BiUBvaRMwQnFBxQ6SFZJjWJHMVUssQoXJy4hDGI7eMn36g4CBZ3Y53pZ456i1wZA==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr54153246ply.234.1559883655599;
        Thu, 06 Jun 2019 22:00:55 -0700 (PDT)
Received: from localhost ([14.141.105.52])
        by smtp.gmail.com with ESMTPSA id 10sm811396pfh.179.2019.06.06.22.00.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 22:00:54 -0700 (PDT)
Date:   Thu, 6 Jun 2019 22:00:51 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 5/7] RISC-V: Parse cpu topology during boot.
In-Reply-To: <20190529211340.17087-6-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1906062159380.28147@viisi.sifive.com>
References: <20190529211340.17087-1-atish.patra@wdc.com> <20190529211340.17087-6-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019, Atish Patra wrote:

> Currently, there are no topology defined for RISC-V.
> Parse the cpu-map node from device tree and setup the
> cpu topology.
> 
> CPU topology after applying the patch.
> $cat /sys/devices/system/cpu/cpu2/topology/core_siblings_list
> 0-3
> $cat /sys/devices/system/cpu/cpu3/topology/core_siblings_list
> 0-3
> $cat /sys/devices/system/cpu/cpu3/topology/physical_package_id
> 0
> $cat /sys/devices/system/cpu/cpu3/topology/core_id
> 3
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Looks reasonable to me.

Acked-by: Paul Walmsley <paul.walmsley@sifive.com>

We're assuming, on the RISC-V side, that these patches will go in via 
another tree.


- Paul
