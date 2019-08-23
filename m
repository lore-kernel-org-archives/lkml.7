Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F143C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90F122CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="sAoj9rah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393438AbfHWLwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 07:52:17 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:33322 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfHWLwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:52:17 -0400
Received: by mail-qk1-f170.google.com with SMTP id w18so7929011qki.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 04:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c78+wpE5NtAkckuxK2dQr7Uguc2X5h5Uf88Hnt+OH4o=;
        b=sAoj9rah6K5BokDfPT19/4uD3oY8HqR9/TMn9gYhRMeXpNNLKoLCVM6zXbB13cSEaX
         XRQLlaqhbZLBKZ6CHE8SNKmMVmNjHNyyEPKdRe3mMLJwCd4OLjdGDZFy7lea/5Z9IjHP
         KfNMH8gypu5960lc5DDjhe5dRH4E0kKlKm6WikNERGfuCyzz4wEqrvzx8Hf7DTqB/HOB
         7tYKsMI2MyOxl81jVL9VdRnjaHUckQER7RAIgXBI9Gx/jT0wKhiJDPBYyQrY6tdSqaq+
         rTr3IS/eeTyZwDqD/voJ2MBuMdF4q63nRkmlnszGQbLX6ch6gLzvN7r4jvYtzb2uhWMz
         Mcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c78+wpE5NtAkckuxK2dQr7Uguc2X5h5Uf88Hnt+OH4o=;
        b=P/6kah26JqGe2iGbwvpTohR2E3JmSpYjtCGanHg2xXHGCe1dGKUWBBiizrSzvAek93
         1CMfvskUR9EuAZTRL55oO30Lwnz9FQSSKKYnA8hqxFizEZ9gdVCnWvvDPRlnA8Ma6Se5
         YJJV04VI5yqVcwouwSJQPUeZvttWIubOXLo4oiYvwLjpDZJSkw3RnBaQooUxsBejN9QN
         nOcvF4TSXoDwxeorAquySAOvRSyxCtwaqtPx2Xkg+l3z3sLFwxECRVB5q9hCd14RklVJ
         XoGmPlsdI3hbx1+0Ar5r+FTsunUPeDykG4b5ht/0acyuz1KsWE7IBOXzUMovmVx0oyxd
         F55Q==
X-Gm-Message-State: APjAAAW9MO1LIEkKNHht3Cg3DmL7hcMe0CXyMD5O2x+P1juTOkWyGwka
        xD7SBhG1ZyCVTyUNyilf8Nqqrw==
X-Google-Smtp-Source: APXvYqwH3MawXbPD2LmUDGMAota0KHoYSVT973YOIwpmhk73kYGH2B14rNwBdq5MBNv/MYwDoZqbHg==
X-Received: by 2002:a37:b004:: with SMTP id z4mr3622368qke.103.1566561136162;
        Fri, 23 Aug 2019 04:52:16 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 136sm1313279qkg.96.2019.08.23.04.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 04:52:15 -0700 (PDT)
Message-ID: <1566561133.5576.12.camel@lca.pw>
Subject: Re: page_alloc.shuffle=1 + CONFIG_PROVE_LOCKING=y = arm64 hang
From:   Qian Cai <cai@lca.pw>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 23 Aug 2019 07:52:13 -0400
In-Reply-To: <20190823113715.n3lc73vtc4ea2ln4@willie-the-truck>
References: <1566509603.5576.10.camel@lca.pw>
         <20190823113715.n3lc73vtc4ea2ln4@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-23 at 12:37 +0100, Will Deacon wrote:
> On Thu, Aug 22, 2019 at 05:33:23PM -0400, Qian Cai wrote:
> > https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> > 
> > Booting an arm64 ThunderX2 server with page_alloc.shuffle=1 [1] +
> > CONFIG_PROVE_LOCKING=y results in hanging.
> 
> Hmm, but the config you link to above has:
> 
> # CONFIG_PROVE_LOCKING is not set
> 
> so I'm confused. Also, which tree is this?

I manually turn on CONFIG_PROVE_LOCKING=y on the top of that, and reproduce on
both the mainline and linux-next trees.
