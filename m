Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD708C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807C620825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fTGcb3xX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFGFML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:12:11 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33172 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 01:12:11 -0400
Received: by mail-yb1-f195.google.com with SMTP id w127so356028yba.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 22:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=h725Opt78hWUyZOZqX4v0aqrQEDyoY/2hkomdBMgZww=;
        b=fTGcb3xXFdKONaPH9oQkjj23XRMg52QneHQ3o1/4KqrqzSi12zcaigy3bSDfyazyLb
         Yv+wiciiZCv/vzQSO6JHLgU4RlC3O5041wRfg/AzvszqmwncR+0lIW5ICXpf4Ex55m9k
         9gF9bl4930Bgid8pc3kehhY4qG1W2vCxcvtSjiyXPS34bIzB6ccC+c1A1whp80FT9+dl
         1Lss1mEbGdGzUxbM9AK0zHSTa5V11ydtv8qyKgarRrJ6OMwUha1UBHYqXgjsNDIqDLpr
         LXT4RbfkLpuxNPDXSIv+jUiyebXiKmdx2bromMdczIgNi2DEcHc/LgWpXmzjigwRZIrZ
         OTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=h725Opt78hWUyZOZqX4v0aqrQEDyoY/2hkomdBMgZww=;
        b=ST+jwwOeNw/TSUzC3YSfvmg0jx7eAUqgJHFGI60foQ7APDfaEl23xcs3xEV3sP5H6A
         Tal2+RDOCy7D3dNwjl+Cbox0sNGW1kEEs4u3T16iNxUVjXtauCRshIV79+Zmw3KoOpJS
         l2r0a6lQNktun42EgLxNKYFbZ8GpAfbbhUlHaALzCrQGYpBc5h7dIl3Cknye3D8Rv4XB
         MOiTHTiw8jwBF+GtIkoDCapyU59wFRFJyAHcvx9n58fBQle6ocyVl9fbpI/LwacKdyvZ
         mqGQag/OAK2Hgus9M9LmHeAhAoEc8OlU2lmffoMhaFRzHCRVwka3C9hgmWtvYEIaeAPB
         xC/Q==
X-Gm-Message-State: APjAAAW3zQoLa6FDZIkSZ6bKZuZzryhSQ2A6sr5FbzRzaHdUQfh2OxAD
        f4gOSfPaguta1MbN/GJBsZKf2A==
X-Google-Smtp-Source: APXvYqw9Ntq0WkyHFD6oP3tUDeWJS3376kczaCJoqdE1ou8pDAsvwRtVSzBjiAcz48pEQTefOP7PkQ==
X-Received: by 2002:a25:bc05:: with SMTP id i5mr22535739ybh.335.1559884330298;
        Thu, 06 Jun 2019 22:12:10 -0700 (PDT)
Received: from localhost ([14.141.105.52])
        by smtp.gmail.com with ESMTPSA id f6sm282977ywe.81.2019.06.06.22.12.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 22:12:09 -0700 (PDT)
Date:   Thu, 6 Jun 2019 22:12:05 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Loys Ollivier <lollivier@baylibre.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul@pwsan.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 1/5] arch: riscv: add support for building DTB files
 from DT source data
In-Reply-To: <86v9xlh0x8.fsf@baylibre.com>
Message-ID: <alpine.DEB.2.21.9999.1906062208280.28147@viisi.sifive.com>
References: <20190602080500.31700-1-paul.walmsley@sifive.com> <20190602080500.31700-2-paul.walmsley@sifive.com> <86v9xlh0x8.fsf@baylibre.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019, Loys Ollivier wrote:

> Always build it ?
> Any particular reason to drop ARCH_SIFIVE ?

Palmer had some reservations about it, so I dropped it for now.  But then 
as I was thinking about it, I remembered that I also had some reservations 
about it, years ago: that everyone should use CONFIG_SOC_* for this, 
rather than CONFIG_ARCH.  CONFIG_ARCH_* seems better reserved for 
CPU architectures.

If you agree, would you like to send a followup series, based on the DT 
patches, to make the SiFive DT file builds depend on CONFIG_SOC_* instead?

Thanks for the comment,

- Paul
