Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82D7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B2A20659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439914AbfJXQqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:46:22 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:47242 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2439902AbfJXQqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:46:22 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OGkKMr023696
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:46:20 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OGkFB8017741
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:46:20 -0400
Received: by mail-qk1-f198.google.com with SMTP id h18so2881238qkj.22
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=EsIPMrPy/NQRL+kAPu6vRsFGMxp34/kqcwgNBhAoed4=;
        b=PhYnVmE33dNKbtXpJDHTFmdwXMU/8hJgkY61mLDjbU5OF4AHN7nBbyGGx8yfU1H5fX
         0mrf0ru+X+ADbcTwLyrxHDfuNevMWvRkEjqbuvq0okfm767sMlSigoqvqgsvrTSyR9w1
         bOTA+ylcF2i2stVkhcPVNiuYCe2M/1A7AOWjlkV2nVnxLvSyul55SPxehDvy28DqEqZI
         SithGdn/YwBAXKBltJgOMW2bDCxiVbzPckbbOejVK1rz1vzUU0zsq+cvLf3TagR6z9rf
         mCfIFwZkBuuJ+Ft29VaMaQnTEBAAWWpPLCPCC+/XD2i0Vr+RdvWx6J4EPsEbKNn0KCWe
         8Riw==
X-Gm-Message-State: APjAAAU1cEzJ23mJKd7jK+lUU0r5/elNe2lMPVABCtEIEWORcssske/O
        ONDTJx3UXKABwZYtteIiwQITUsjUrbeAkqU8VPVn3rJj4IODFUAz/zqFiV1+g4ILasw/Y3IepRo
        e8vRFBLYqj0KwCQqK1TX/E6Kv8GMTe5Q18YM=
X-Received: by 2002:aed:241c:: with SMTP id r28mr2210120qtc.148.1571935575568;
        Thu, 24 Oct 2019 09:46:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwOx2g9Rq1d1Pyls0CB0utL2xABAepZupau/TdbqZ6xqsFeKRv/w6rIr8Gn2U/r+gM8+T5hg==
X-Received: by 2002:aed:241c:: with SMTP id r28mr2210083qtc.148.1571935575248;
        Thu, 24 Oct 2019 09:46:15 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id c21sm11331089qkg.4.2019.10.24.09.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:46:13 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] staging: exfat: Clean up return codes - FFS_SUCCESS
In-Reply-To: <5c7a7fe972469296d367dba504f0b6c8063a7d55.camel@perches.com>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu> <20191024155327.1095907-16-Valdis.Kletnieks@vt.edu>
 <5c7a7fe972469296d367dba504f0b6c8063a7d55.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1571935572_59326P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 12:46:12 -0400
Message-ID: <1116783.1571935572@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1571935572_59326P
Content-Type: text/plain; charset=us-ascii

On Thu, 24 Oct 2019 09:29:00 -0700, Joe Perches said:

> > -	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
> > +	if (sector_read(sb, sec, &bp->buf_bh, 1) != 0) {
>
> Probably nicer to just drop the != 0

Again, that's on the to-do list.

--==_Exmh_1571935572_59326P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXbHVUgdmEQWDXROgAQLooBAAjVK/FBta4kL6kv8k49RtGTrWLd5FD8zr
OtoLLQLewcYlbmpWjneJPKZpTjg+nsOF0cHELzEXKkIzCmg5YAnlG2w8OOlEW6AO
jTdhUTY9rrFOKuQeZmzalltqYjVHCMOie+oD8xGNXT1bSj5DTKarJfHwFGD3yPss
nJBhADhUm1L/n1aviplbSsm7BFjrFbqWjtMLKW3+qOLeA+OpEQMAf877I+3CYNPS
k7evBj/qN9sVgvPM0w86nff0mo5s+fYNak6V22KrnX39z+7zb+DA5NjR3Bd1u930
gr/ZdVPOuepeoZnNvDIR/bj6NMqsPhkP/YE8QYr1jHAE7ZPc3ADaDVP0mPV6ekIC
DymnE7CGhz0fBAQwaOnEeylkQilfx9XPGYedPPA9/QjbA3R2n3Vgtesa74QP505a
UuEtf0YeQde+46a0t7M1KIix1MGnAMYrB7zlqwyaCMeEQQZ0laHPRUkLQEMxd32T
WT0m0n6/pL6aXAuvPkoAzsQB1bFPsrf/Bz6Gx58ZRlk0303MAD0Lr8oVGpaEV5rT
AMdJ8TM8CdvvkASuC6fzHHpsf68YfXaIq0uvQtu/bvYi7TMtlYuOVowuCYWvZEtf
i01HkSLHyBUbGj+hzgoDjXafMFt9q7nKtrgsYT6tFForrf3FGIKHWVetwGbaKJY0
i0VtHsFXSMA=
=hBtD
-----END PGP SIGNATURE-----

--==_Exmh_1571935572_59326P--
