Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23B5C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF2B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="moy9hST8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfEMVHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:07:07 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:42985 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEMVHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:07:07 -0400
Received: by mail-io1-f53.google.com with SMTP id g16so11246976iom.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 14:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+7m8qAQjBviaFmOghs6Z+97Gn0Ch4ti3J4o9pemJXns=;
        b=moy9hST8u3nZL8K7X9LmUOb8sPFjKOZk9jjU7eXuqiU+rrXYV1JBnO24vrOKZO6Ly2
         1Mge2VulaUA068g32/5UvGe2Gaf7cRcv/9Q0E1GEBQIRu3pJGtfuAxDe0Z/MAT9zghwr
         SPEDzdu68/OGdeXkJY6u/QCMEQdFFEOdaG/7Z930tzvmGpEJB680G797FIRNJGxe14cl
         ZvTWtSAcgbSB2llJ2wy38UOvx07Nhko1YRrL8ccK8492ipBnnmcq0BSFNaYHB7vpH7pF
         nzJjFa5Xh+Wk5Yi7uZDsUfD5o/EfLNJ+mRniDrilmgVo7dYEgx9ZKd4OfLQL0mzYQAOX
         36UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+7m8qAQjBviaFmOghs6Z+97Gn0Ch4ti3J4o9pemJXns=;
        b=UVkLsKvJjDBzJCZvWsJqx74GUHaDDcoc7V3MtF9MQNY411nEFCoc0M2P9D9GobJQYA
         vJJolxmCDhBD5tEbn6lkTmL1aoBxxy68T7GBbUg4oyjs6ob9/DKV/yCRzmZiuKRcuKTd
         hdIXXX8uS1bfOo7Z3E4AzncwpwDzUhP+yop2USX3ijoo3BdJMepXIxwuJTvDCxW4tNaQ
         io5VnpA0Ag354abjxPLSvXH6APhw2Haq8Uf0k5QQS59TJ9u7w5T1cjpg2ieThLUfBnqG
         qfV5zMz5zwFsFKVFsAVe/VLREaiYCYVQJYf9TdYEeatpvEfa/GajuT7WazgB3CbzrlU4
         y7WA==
X-Gm-Message-State: APjAAAUUm6UrO9/IHEu0Fzo8I4L17fCAhEXs4d6N+SnKGXgTWgOb+UiW
        UGTUCO4OHsc+mhd1eWRaTas1Lw==
X-Google-Smtp-Source: APXvYqzAKBcFsS+Y7adHO16lbwFC8l2Evh0Cd9l2abi8zINYBOvpufFAj53P8LJXw8+H5xm3l6EJtA==
X-Received: by 2002:a6b:c386:: with SMTP id t128mr16804601iof.167.1557781626383;
        Mon, 13 May 2019 14:07:06 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id p78sm300323itp.35.2019.05.13.14.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 14:07:05 -0700 (PDT)
Date:   Mon, 13 May 2019 14:07:05 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh+dt@kernel.org>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
        Megan Wachs <megan@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] dt-bindings: sifive: describe sifive-blocks versioning
In-Reply-To: <CAL_JsqJRdjoTo2hGrKWvcyer18wt9N6w0nkfa9xx_e2xJ6pkYg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1905131406480.21198@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1811211704520.16271@viisi.sifive.com> <CAL_JsqJRdjoTo2hGrKWvcyer18wt9N6w0nkfa9xx_e2xJ6pkYg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 May 2019, Rob Herring wrote:

> I just noticed this was never re-spun and applied. We now have
> bindings in tree referring to it though.

Will send an updated version shortly.

- Paul
