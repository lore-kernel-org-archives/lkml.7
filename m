Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6A5C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF08C205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+DEu0u3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgAHKop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:44:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36188 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgAHKoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:44:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so1390072pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 02:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pPSGSrGdzIg8vRawpxMeo6cXJ1x2WOKm8ilf6PbGFiY=;
        b=o+DEu0u3CBgdYDHDe40RKlrxeF7X3i9yuLlnsF71UJzVP2V3aCLJukzYJUr51DP930
         xZDRW+VIDDeRs+7TlkYROsxsD/utZZCAh5n2FHEq9JkLMUSIUQriPUicsX/+ODearFu5
         sFOPNKV0w6NPgizaBZdkbEso4NYx6HAXPypZjct52e9iAF66JKSzaRsw88mty9H3zC4e
         cOwC4zYN8vsqQegHHJj2yrSEmtmpKrhmosckujpXt9rfAlxPj7/gyFpn+YJRkTSFk8s0
         5834LjRA7KKGXhKYCs2K1L4RLmBjdF1AhsrRiSnGmMshRP9UDtUdQD4ttLJCzOSUnVha
         H0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pPSGSrGdzIg8vRawpxMeo6cXJ1x2WOKm8ilf6PbGFiY=;
        b=udTEuJ5zaKstfSgELAO+XHJn3VtNXX5hvuewMT6ex3vYid5PcBA+GNK6V2XDG+IrXV
         yfkwgec7YtYAtCxvyI+eUQJTij4K6+buu1F0yGWhoektTks55qL1YgWmnauLf0f44N7J
         U6Lk+YaFy7VK1kDfeq95rApBPNXRfqrV9IFNDNUvoufs1xNd/X0FVC3i36KEIW/z8j41
         CLSW0sLicMA4Lwwe5tJAik1OnQE/X8MYhoXPWz6a1KOnYMctWuNQTmt9nVsYI23JAPxA
         PTxdpQtP3O2EZ2gE1HT4GOH+1h8aOtPoDX6r3uTh8cKtGhZdGMtKvf+k1bc9jrQ3I/6p
         UIJA==
X-Gm-Message-State: APjAAAWTx+oWoYDU0XJ9v/vNx4XAk4tYBx6Pf+H3ZzvHVVIvq8KaXDsB
        E1EhZglRBvYzLAAOZUvfTdJGw9VCFA0=
X-Google-Smtp-Source: APXvYqw7qFdrmCr3knpkwOxW1klKI6Xe0vbIDlWkMoWvIZ8wSMKnmI/czTB650l/EjjpryyuWdb8Zg==
X-Received: by 2002:a63:28a:: with SMTP id 132mr4408119pgc.165.1578480284001;
        Wed, 08 Jan 2020 02:44:44 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id o31sm3204565pgb.56.2020.01.08.02.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 02:44:43 -0800 (PST)
Date:   Wed, 8 Jan 2020 16:14:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: fix of_node leak for unsupported entries
Message-ID: <20200108104438.yp4nva3yjlwlh7ey@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <20200107063616.a3qpepc46viejxhw@vireshk-i7>
 <20200107140449.GB20159@qmqm.qmqm.pl>
 <20200108073338.4z6gktglduigfo5p@vireshk-i7>
 <20200108103846.GA6894@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108103846.GA6894@qmqm.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-20, 11:38, Michał Mirosław wrote:
> On Wed, Jan 08, 2020 at 01:03:38PM +0530, Viresh Kumar wrote:
> > On 07-01-20, 15:04, Michał Mirosław wrote:
> > > On Tue, Jan 07, 2020 at 12:06:16PM +0530, Viresh Kumar wrote:
> > > > Discard my earlier reply, it wasn't accurate/correct.
> > > > 
> > > > On 03-01-20, 20:36, Michał Mirosław wrote:
> > > > > When parsing OPP v2 table, unsupported entries return NULL from
> > > > > _opp_add_static_v2().
> > > > 
> > > > Right, as we don't want parsing to fail here.
> > > > 
> > > > > In this case node reference is leaked.
> > > > 
> > > > Why do you think so ?
> > > 
> > > for_each_available_child_of_node() returns nodes with refcount
> > > increased
> > 
> > I believe it also drops the refcount of the previous node everytime the loop
> > goes to the next element. Else we would be required do that from within that
> > loop itself, isn't it ?
> 
> Indeed it is! This means that _opp_add_static_v2() is storing a pointer
> to a node without taking a reference to it. Is there something else that
> guarantees the node won't disappear later?

We do store them, but don't use them other than comparing the value of
the pointer itself which is harmless.

-- 
viresh
