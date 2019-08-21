Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26E0C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A264E23402
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dYfsQD/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbfHUVod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:44:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41857 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfHUVod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:44:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so2110329pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=UtdjlTTwPPpAjm4AUF1n+63QfaoAivza/ox3sRCZdnA=;
        b=dYfsQD/boswD54RLhQ9rPhB5Jy6CC9kMzU4yhUW97mYq6mK7qizOAnVuaB3skD+o8f
         gkaB1+cIQZk3UAAjHaJJBTLB2QcsIXcrXyWK5vOyZLE8iEwS0kpOUsZHdtvFPa2AqhKe
         HzcptyRqxA+zceEHHD9F0tbUbW9qA5dOM8NKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=UtdjlTTwPPpAjm4AUF1n+63QfaoAivza/ox3sRCZdnA=;
        b=Pprmm+aXRR0tzzwVTMP6tpWPymIB2CsCa2Dbz4TfmC6yEoEVGqBnIqcAmGPJaB2v+o
         svQYqNC2kGCYOxlRONYgbgcirjs1UNF0tfrhZuJgZKiGGVgkTlvGf7jI32jrz9KHSPaw
         LjOHLN+HYZtFAI+SPG5NgXMXkIwiMQz6drBcg3xIWyBnzLUw5/3g+sYbwAMYgZcr7lAc
         YFwcl2lU7f+WCDw0YatHOfygR3lvW4FTYZUzEpGCFxN5eQw2FW0D42+HLDZVPpTQfp3u
         NoAnzQCnYz2ZVjOnzj11aqhBOZp/yUZIzcK7Ilg//7tr9Brq1ms++ux+KDnE3s0PNZ3Q
         Y/fg==
X-Gm-Message-State: APjAAAUKGACvABUAW069MdtnCTuYtV1a60EI3RO7LDNPlSELWwkwY2/1
        IuhBiKbbp/2iydvZHay0bUa6ng==
X-Google-Smtp-Source: APXvYqy45+Mu6qMPOpu87JONLRNOdIWhh0t+/JhxZBGNWIjM32cz2JoD0Y2H8PFtoZy+NtXUCTBprw==
X-Received: by 2002:a17:90a:bc4b:: with SMTP id t11mr2104340pjv.87.1566423872553;
        Wed, 21 Aug 2019 14:44:32 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e26sm27118599pfd.14.2019.08.21.14.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 14:44:31 -0700 (PDT)
Message-ID: <5d5dbb3f.1c69fb81.eaa49.52b0@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190821191131.y7cmdtkxfs3ojmv6@linux.intel.com>
References: <20190812223622.73297-1-swboyd@chromium.org> <20190812223622.73297-4-swboyd@chromium.org> <20190819163505.wnyhgrtg4akiifdn@linux.intel.com> <5d5ad75e.1c69fb81.43fc3.5a77@mx.google.com> <20190821191131.y7cmdtkxfs3ojmv6@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v4 3/6] tpm: tpm_tis_spi: Add a pre-transfer callback
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 21 Aug 2019 14:44:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-21 12:11:31)
> On Mon, Aug 19, 2019 at 10:07:41AM -0700, Stephen Boyd wrote:
> > Any name is fine for me. Any suggestions?
>=20
> What if just add @ready to struct tpm_tis_spi_phy add drop this patch
> altogether?
>=20
> It is only used only by CR50 but I think it is less of an overkill than
> adding a callback.
>=20

Ok, sounds good.

