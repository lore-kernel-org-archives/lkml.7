Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F08C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88B721738
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZkxMQGgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfHGB0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:26:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40228 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfHGB0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:26:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so40579357oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 18:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=owDgp928SO7GH+S1pO+PzwOPO8cCYUIRKUw/BGVnu6s=;
        b=ZkxMQGgCsorzr8S1tgzNj9F6fgdzY2E/QxK15CRf06TG3YxfMwhyqegE30ZnSaqX/x
         qO4j7mdbjy7rxvghk9Jm7gAqyhGrx5Utox/Xcur3nNXlJgHjv9rDRzWpAndzNPcf49Nh
         T9hhUF9OrQu+G7A9jcKkXZGDlgYfJkGYep3RIiu1d+VjwhKGCaBPomRyq2wGVjWuJkJF
         gS1FpqKj8NpRqAaBnV9L1kH05/r3B1JPUJ9ubXMSEPFaaVAa7/aC9oh6wVatJ2H76kqF
         hunXnG9O4PCUKokkQf/sho24dSc8lTLPJa4P+BH3vb35HYddQRrQypqHYeq1uBxax7+y
         BBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=owDgp928SO7GH+S1pO+PzwOPO8cCYUIRKUw/BGVnu6s=;
        b=tZ7WVCLjF+Y6Orm8uvbVX6BYZJGwVzLkO5LHqaWTsG+Yist9dXtnQtsDb5krxfhJX2
         TLLfeT4aN7Ky+ZXc3jEoCB9TJ6AGeeAWqNoeYmajJ9JDmNpA+tiIX+caiW1YM3fFrwUc
         XUpcEb54wEeTLktssvo+quK5m5RZ0crtXxGY4NdLIvhIbQ/U8rN+BYDb3E8pLJdgiTsX
         yZVh+AqZJi1QjEOxGeUIS6c3WH8yuEfopqCk9E6uIgcDWbdZ95zPj7uQnl4hFlxtlNA8
         RDYVCDzRcvVoAe1BMmcUUyOHOmQORj//hRG6JUsq7qZIsOMVv79tJa8b4U+BLAmVGA/o
         ko8w==
X-Gm-Message-State: APjAAAX0jbTUCjpUbIHWHVzkth9d3yJJYmtHdOeuL1K/teXhq0VBH3TM
        WjHZxlKmnLXociMOdyCeVKAIcw==
X-Google-Smtp-Source: APXvYqwKdXrU1QqOa0yUvILl6xbOtT4vxTEkIzkVaZdnctYu+HuNnikE4y89DOgFp6zNih0Q+qcyEg==
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr6990541iop.293.1565141170206;
        Tue, 06 Aug 2019 18:26:10 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id j1sm78000195iop.14.2019.08.06.18.26.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 18:26:09 -0700 (PDT)
Date:   Tue, 6 Aug 2019 18:26:08 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <Atish.Patra@wdc.com>
cc:     "info@metux.net" <info@metux.net>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 3/5] RISC-V: Fix unsupported isa string info.
In-Reply-To: <1e23ef1face9d323fda4b756811f922caa5f7689.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1908061818360.13971@viisi.sifive.com>
References: <20190801005843.10343-1-atish.patra@wdc.com>  <20190801005843.10343-4-atish.patra@wdc.com>  <alpine.DEB.2.21.9999.1908061625190.13971@viisi.sifive.com> <1e23ef1face9d323fda4b756811f922caa5f7689.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019, Atish Patra wrote:

> On Tue, 2019-08-06 at 16:27 -0700, Paul Walmsley wrote:
> 
> > Seems like the "su" should be dropped from mandatory_ext.  What do you 
> > think?
> > 
> 
> Yup. As DT binding only mention imafdc, mandatory extensions should
> contain only that and just consider "su" extensions are considered as
> implicit as we are running Linux. 

Discussing this with Andrew and Palmer, it looks like "su" is currently 
non-compliant.  Section 22.6 of the user-level specification states that 
the "s" character indicates that a longer standard supervisor extension 
name will follow.  So far I don't think any of these have been defined.

> Do you think QEMU DT should be updated to reflect that ?

Yes.

> > There's no Kconfig option by this name, and we're requiring
> > compressed 
> 
> Sorry. This was a typo. It should have been CONFIG_RISCV_ISA_C.
> 
> > instruction support as part of the RISC-V Linux baseline.  Could you 
> > share the rationale behind this?
> 
> I think I added this check at the config file. Looking at the Kconfig,
> RISCV_ISA_C is always enabled. So we can drop this.

OK great.  Do you want to resend an updated patch, or would you like me to 
fix it up here?

I'll also send a patch to drop CONFIG_RISCV_ISA_C.


- Paul
