Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B7AC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 21:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20042075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 21:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iAW0aDUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfFUVjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 17:39:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34020 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 17:39:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so3607011plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 14:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JMoEMgrx9ABy/aeE9DljEmAzYJ+e2IWt04xwOpLWckw=;
        b=iAW0aDUcJ0jKVdqSoZM+ADII3msh5uwQR+1Wb/rOBQbCIoW7I+TEHmy7R1wsf5nrf5
         9KLaFAsd9DvnwYD/kYyjAqHLZ3cAWt6yTImzLV+bBc+oJZUHR+HHEA0wjHiJFNMwGPG/
         HbvH4Fk4EORE4Pt8EIeESxyklsFO8Pl8oKwzkUmUmMjMAY4uU6MqPDk4UMZSTPhu3/0y
         4lPPBcIOptNi+3oQWElkloY28MOcbfB8RWBzFrQ9NwLystZ+tNEwb9fKNhX/7UtfkUf0
         CSEr25T6LqV4SANHY6xyw3nRp7VrPSx86rhpX/4R7WXFrp6oI2tl6CaCsNBDle76lCvu
         Xu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JMoEMgrx9ABy/aeE9DljEmAzYJ+e2IWt04xwOpLWckw=;
        b=Y4amVnD0wtLYnY5zw/4xf5E8EUC5Fh9weWaU8VdxHZM9ws2HAHL7T9vipBSAwskgeR
         oPjtxzyY13mo7oOBkkQ6qn8nlDJ8t0kj55ZOvGz1NM+UXKoWfrOSsp/7UY3n8pTnxr4w
         VEs01vWXA1fTV9qQJ1VZnfodOXe3PVImNv5WiPVr5ZWaGdEfJjuVOaIMRg86lQCAu4t8
         EbAZsIZxd/7A3E6aR84bup4TbRlcdCcFsP509iYCJda8cT0dQCRV6HP/McTI4w0D1a91
         jV8iwh1+QSXShNLOXLSwQEi9CQSPA/73p6nOvr1wFU9yv1CMGImaUKNB70sVcHJ+PjJP
         fqwQ==
X-Gm-Message-State: APjAAAWhdWEIEoYO1ZI/8aFGps+pMmvKf0ncqIvxi0mjgxAASSzrsWlB
        69a/3TXBlwEGCdukXCKRoKZ1dw==
X-Google-Smtp-Source: APXvYqyblrrnBXKkDhx7UyIenPB3HwEhmGyd5F54TG0KrLjZjGruNROVTN0kh5NCGMpS/9u/4uyYgw==
X-Received: by 2002:a17:902:7891:: with SMTP id q17mr78824512pll.236.1561153194070;
        Fri, 21 Jun 2019 14:39:54 -0700 (PDT)
Received: from localhost ([38.98.37.134])
        by smtp.gmail.com with ESMTPSA id m20sm3367922pjn.16.2019.06.21.14.39.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 14:39:53 -0700 (PDT)
Date:   Fri, 21 Jun 2019 14:39:42 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh+dt@kernel.org>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Paul Walmsley <paul@pwsan.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: riscv: convert cpu binding to
 json-schema
In-Reply-To: <CAL_JsqL1a-irBa4MaVzak5DrTjxiySuqTJSQOqwzymVa=Uz=gg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1906211438210.16518@viisi.sifive.com>
References: <20190602080126.31075-1-paul.walmsley@sifive.com> <20190602080126.31075-4-paul.walmsley@sifive.com> <CAL_JsqJd6s6ta==AoxmNXdpzWL1RytSwR2P4MOfAFSEJavbt+w@mail.gmail.com> <CAL_JsqL1a-irBa4MaVzak5DrTjxiySuqTJSQOqwzymVa=Uz=gg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Rob Herring wrote:

> On Mon, Jun 10, 2019 at 3:46 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Sun, Jun 2, 2019 at 2:01 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > >
> > > At Rob's request, we're starting to migrate our DT binding
> > > documentation to json-schema YAML format.  Start by converting our cpu
> > > binding documentation.  While doing so, document more properties and
> > > nodes.  This includes adding binding documentation support for the E51
> > > and U54 CPU cores ("harts") that are present on this SoC. 

[ ... ]

> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> You all have applied this now leaving the binding checks broken. I
> have a fix for one issue validating the schema, but there's a
> dependency on schemas/cpus.yaml which I gave feedback on.

Sorry about that, Rob - will follow up.


- Paul
