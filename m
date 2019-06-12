Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C900FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927C42080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="DIDleIoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfFLSG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:06:27 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36679 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfFLSG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:06:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so10996867qkl.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=700itWyKjvYiFLhP6jEPTeNmhf7t12dW5GgxWWewn2Y=;
        b=DIDleIoBBRbSbyaPaKHTfUCkoX3V0qed/gmhgh/MpB+I7n+x7Wf4eypIwr94A3j01p
         CFtBmztxBehhkx2xB/qty0kA44RYXzkb3W8eo3axjRSX3ri6VBAkuNuMdU035uUwHYVw
         4VjEg40aFujRHdVN69xwSZo7QN4C/0uRdbu13unzNEt5X5pXdov+4KPeP6hWWbHpIC05
         duGHjQ+6tOx0I8N+rfPDKQe5Y4EhqkbLQkdicV4O9/K3dZGIjTIGfueCbThEiCX+CLGr
         3s1nf92yaFi+AsfIiXpq8R+4E6PReNn2enKx+i/CTEIH6tqqeN4F4yHUQNaTYKwkN10J
         4LEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=700itWyKjvYiFLhP6jEPTeNmhf7t12dW5GgxWWewn2Y=;
        b=K70NRb2q8XRJw/MxemqPpvMlqhFbGmVyKUEvuvwv3ouZGTXgEFY0xPvqGMPZLhaRLB
         dUpzxvQy6RChdbTtohR5vmeQ3YLk7YUs1UuU+ky45VU7TylG/D+TS0vcIWwW8Z4j/jIV
         6QdRLG+ABdhzEB14EMRrseVPQAI2kxlwUmt+Ib3d3laqBy9FxPmuSWal6mG6rBNhP27f
         1tvX6SUwWVJMBVBsJSbC9JppGg9pQ6eJxrr/SSleb3K3z1yEr79SPHkiS+M82y2gFiz2
         rX4VsIRtYyvYjD7+v8HglsdmC1BEdDRRAgcHjPUjJufLOyCL+MtaHq2KJcx91+1CKACX
         M3GA==
X-Gm-Message-State: APjAAAUc6UeI8tdagNeYWRe5dt/M4//ygxCt8+rx8mCCJ0+UqNeZ0nH9
        bWr3wsqY1UXVxIM9OG8mLeiSRA==
X-Google-Smtp-Source: APXvYqzgCHuronfryuLazzGzUcrMlDx+deLUn6ZDEgSF5HxrTd3U1Gn+N6X5ZC28QcrrGGy2eb0IaA==
X-Received: by 2002:ae9:e30d:: with SMTP id v13mr47611016qkf.148.1560362785429;
        Wed, 12 Jun 2019 11:06:25 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m44sm285864qtm.54.2019.06.12.11.06.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 11:06:25 -0700 (PDT)
Date:   Wed, 12 Jun 2019 11:06:20 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>
Subject: Re: [PATCH net v2] net: ethtool: Allow matching on vlan DEI bit
Message-ID: <20190612110620.5f1653bc@cakuba.netronome.com>
In-Reply-To: <20190612151838.7455-1-maxime.chevallier@bootlin.com>
References: <20190612151838.7455-1-maxime.chevallier@bootlin.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 17:18:38 +0200, Maxime Chevallier wrote:
> Using ethtool, users can specify a classification action matching on the
> full vlan tag, which includes the DEI bit (also previously called CFI).
>=20
> However, when converting the ethool_flow_spec to a flow_rule, we use
> dissector keys to represent the matching patterns.
>=20
> Since the vlan dissector key doesn't include the DEI bit, this
> information was silently discarded when translating the ethtool
> flow spec in to a flow_rule.
>=20
> This commit adds the DEI bit into the vlan dissector key, and allows
> propagating the information to the driver when parsing the ethtool flow
> spec.
>=20
> Fixes: eca4205f9ec3 ("ethtool: add ethtool_rx_flow_spec to flow_rule stru=
cture translator")
> Reported-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

LGTM, thanks!
