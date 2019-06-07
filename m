Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582DFC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2830420825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="g4C+4UQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfFGFSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:18:24 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44053 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 01:18:23 -0400
Received: by mail-yw1-f65.google.com with SMTP id m80so240093ywd.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 22:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=eoRzeYAqZlJbfZh4zAUKVpebco1RBz3PtP4CtRfM7Do=;
        b=g4C+4UQ+G7+n6CWfezVr0aU+9R1Vs3kM5/Tj5EFf6GBfexZsW6nX6JNP9adG0p6i8E
         wdXtGRA56JO+0eu/mflysRFrPogTbP1VbXwahD9ERnp4SBGOQgNpohY0O+STd85SPZCp
         0D14mot/I51dgtzY0kdlj6gVSirT/x6IcLJuMI9bSG0KelC8dSDTugSyTE8CxMTWJR4T
         lAEbZ/iVjEfTfwuo/+JgN643SkO2F17oJ8v5n/4u0m+pXbefmLimiM0bmwM2A8TE8Jc/
         vr+QMfSFfpIW0fC0zU/TzqEGHSYn59mw5RLpnIfbsfqGfxzH9aOHqZ+szgn4zGE3IyX/
         3b5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=eoRzeYAqZlJbfZh4zAUKVpebco1RBz3PtP4CtRfM7Do=;
        b=IAqlWC0qT7JIM43XqU//YY6S54QzZcaR8q80xUqevy/cR3j/NIKpFFypqiWOlpyUs6
         mbZy3bKwsdDDhahBoGE7cj/iNqMK4lo+KqJY8r8eR2Z58Gfm+qSq0Zsuk06JBEjxWGlp
         uD62yEDBIQ3tv53dcEDinCaMe56byRB2cZ9O4kndgI+k9N63+BGhgn/D6KuioTMmtrAK
         fk6HoLwgC1NlNeM6iaLudHqsSCw+fJGUWTPFUIvaeFMKH9tUNnaxw+4rTBWAZDLKxIsw
         R0LX4tyiU6vzgjEJtOaV2x7w305qEK1p39Z6jo+oDcg2yex5i01yMWPK7NySCEzLvM0i
         nTgA==
X-Gm-Message-State: APjAAAXFRdFW1KQrAztBwUw3gQdh9j8MQAWkyi9Gu5xZ4JLzphLzmIFU
        TtA8D/hc64S/pev+tivcsJm8+d4FQWw=
X-Google-Smtp-Source: APXvYqzRtoKbEdmGiDBrHOJnawjQHJ5r7JhN0MHE+bODwJs8PBihqGbMjQEf3g9xcuXnaW8nrha44Q==
X-Received: by 2002:a81:2702:: with SMTP id n2mr17821596ywn.464.1559884703085;
        Thu, 06 Jun 2019 22:18:23 -0700 (PDT)
Received: from localhost ([14.141.105.52])
        by smtp.gmail.com with ESMTPSA id 136sm298723yww.63.2019.06.06.22.18.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 22:18:22 -0700 (PDT)
Date:   Thu, 6 Jun 2019 22:18:18 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Kevin Hilman <khilman@baylibre.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/5] arch: riscv: add board and SoC DT file support
In-Reply-To: <7h36kogchx.fsf@baylibre.com>
Message-ID: <alpine.DEB.2.21.9999.1906062216220.28147@viisi.sifive.com>
References: <20190602080500.31700-1-paul.walmsley@sifive.com> <7h36kogchx.fsf@baylibre.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Wed, 5 Jun 2019, Kevin Hilman wrote:

> Paul Walmsley <paul.walmsley@sifive.com> writes:
> 
> > Add support for building flattened DT files from DT source files under
> > arch/riscv/boot/dts.  Follow existing kernel precedent from other SoC
> > architectures.  Start our board support by adding initial support for
> > the SiFive FU540 SoC and the first development board that uses it, the
> > SiFive HiFive Unleashed A00.
> 
> Tested this series on top of v5.2-rc3 on HiFive Unleashed board using
> OpenSBI + mainline u-boot (master branch as of today).
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>

Thanks very much!

> > This patch series can be found, along with the PRCI patch set
> > and the DT macro prerequisite patch, at:
> >
> > https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1
> 
> nit: I only see this series in that branch, not any of the prerequisite
> patches you mentioned, which made me assume I could this series alone on
> top of v5.2-rc3, which worked just fine.

Yep, just forgot to drop that part of the sentence from the series 
description.  Those prerequisite patches were already merged.


- Paul
