Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED29C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E0F2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YKZDqNeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfLRBFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:05:02 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46785 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLRBFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:05:02 -0500
Received: by mail-qk1-f193.google.com with SMTP id r14so106313qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 17:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=sld6a89pn07jnCTreDbWf+XCvPgeq/jEdPdZR+zlDiU=;
        b=YKZDqNeBlB1wJXmrEsjksdSKNP2eFC+JDKM/dvaGGsfsPwS3HmikNNkcp4Nk56JrCP
         rq/5Q2/xbV9kR78+EiA+5adBzg6Rsgt8a1kXeRkxWRJPWBXUtmEI8Gb4YtbK9K12qEla
         cXd4fQuCfpYgOhGG091qvqpWsSf7JRUEqhcQ6tP0eN1hf5CpCEXPIy6EzIEQhpg5ncj1
         yyBtTZHcXaERQp0TGlc5Ybc1e4Oy1fS+Q+N0L6Jo7ql4V2jRWj+p13iEjfZWupDUAHgA
         X6DsEncdww8yY8rnHlBJLZfKvFsaw36nZs/oatycyHwS2u+8W4jwccbhAYegj1lCvhut
         DAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=sld6a89pn07jnCTreDbWf+XCvPgeq/jEdPdZR+zlDiU=;
        b=s6YBg/fxV8c+qXIHUgtI+tDXiSLJYNguHAJmcJ9qAicxBkY9LtnZ73rm7E76g+gjbz
         TVYPb1RvreXeGRu+0aYMvIROfI75iehPPwQ0qaH+loj4GcayrVns2ogJG8GzFAbUTbGC
         A5hmUfqqw1bgZGf1mxbyZXDPUpmPi+L02ou84qunPXYnbp81bOOG1EnKbghH2Jfs2K3s
         zYqBnVrRN7VRLUZ9YQTgasabfavC6g7ty7QkRCHDBrOV0dE6mAtq5K0uSTNVUuwGaET4
         QXBWaq1m10vutuEimy6uH1c72KFUi46i+5fKPmQeHiwkEx7dlMYAZUzvvM2Y1idpoyq8
         ZDhw==
X-Gm-Message-State: APjAAAWlSnLrxW+GD7jTmz/T8jXSv/R2znzl9QWujyVYeiU27E7dIdDl
        1hNWVMeqKOzPtWSih7JfQHx0B9RHKaM=
X-Google-Smtp-Source: APXvYqwXmfxhnf9EpgsNYHh06aUb9+Y90bNn0CHHgO+wdS7QKw0g2HNFVywIZtIQRaeOjeCDgQippw==
X-Received: by 2002:ae9:ea08:: with SMTP id f8mr905091qkg.489.1576631100565;
        Tue, 17 Dec 2019 17:05:00 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t73sm133770qke.71.2019.12.17.17.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 17:05:00 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: remove dead code totalram_pages_set()
Date:   Tue, 17 Dec 2019 20:04:59 -0500
Message-Id: <C45FD4E1-CD2E-472E-A762-CCB17C4D8AB4@lca.pw>
References: <20191218005042.GB23703@richard>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191218005042.GB23703@richard>
To:     Wei Yang <richardw.yang@linux.intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 17, 2019, at 7:50 PM, Wei Yang <richardw.yang@linux.intel.com> wrot=
e:
>=20
> Took a look into the history. This function is introduced in=20
>=20
> commit 'ca79b0c211af' (mm: convert totalram_pages and totalhigh_pages
> variables to atomic)
>=20
> Even in this commit, no one use this function.

It occurs to me that function was a part of API design as a placeholder whic=
h might be used in the future.=
