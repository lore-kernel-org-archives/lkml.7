Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2845BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13C62054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYrtLb7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389925AbfGOPBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:01:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36006 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389567AbfGOPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:01:03 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so34624969iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9illoX/lgZgRmB149QSdUSTaY6vK5Drr6t7JdhNt6/U=;
        b=DYrtLb7sMB46zxNRJnG85/ftn6zE7TFfjTN+5wQYTnY+QHAqScIXon2svnkersHAFM
         1Xt023H9TNITyB9es+v0i3uxdSBQs7k/aSgH77UYwxi+alo1MNWQswVKqQ6eopKF1LIZ
         NT8URj+mVL/DFnYl/Muz3CQgjN2adCpdRSD5HnjTDZV6yQNc0gnUu5nr7umVAlbVymQI
         csKl3kN6GiwinqBddVagShTG9XJfDZupWVw3FPLpe3iCiJsqmuOMxAVttKeN4Xmw0gE4
         gG8FPB2e8OvvZYz4/qQ9JYMCpEkbX4+WHPbgqrdMjGi6V80YGO6hytcCGvr356uZf0fh
         Rz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9illoX/lgZgRmB149QSdUSTaY6vK5Drr6t7JdhNt6/U=;
        b=kTsMfW5Z4/18sarS1FjnmUo4hAfP8mJN/l1bWuidwVgja/BGgcne9tQga3xCjkXh1d
         ZzCMNQ+hZKJDE0O2Yucnfgff6ctgg/As8PNRkRTrc7YTRS53Zr6tvcniIOCeAeYlyzzB
         WbSb8dBu5RTmHxy1z8lBNrOaQUhXVMVldKCyTpIcBLdiKWDJRjgCdV2H4x7RpZrr54bb
         IP2x20V8WNbRJThHznJa/g5zICjIQsUXYZ3UT53TW3ZmIGNBbNNcgPtr+/T54ZtTIFmM
         wTqprfrPrQZBHap3C0UMVxK4sOvK7hzu172DyfLqBoM1Yz2bmHMUg5GikCDaO0OrPgda
         p+vQ==
X-Gm-Message-State: APjAAAXCWX4XZAb/6QFTsUO5sjWPOm+0bW621KBcw+n6ZdCSk9jO/ead
        LeqSw9BNfVYXxjhE6wYrvf4=
X-Google-Smtp-Source: APXvYqw5kBdwEgrkIu0ycndJ5NQWWHs1lfEtl9tiXRzValvEj283Zhs4c5zmyc8yumSoqEQ1yFRoWA==
X-Received: by 2002:a5e:c803:: with SMTP id y3mr25041911iol.308.1563202862289;
        Mon, 15 Jul 2019 08:01:02 -0700 (PDT)
Received: from [192.168.1.249] ([67.167.44.43])
        by smtp.gmail.com with ESMTPSA id m25sm10511707ion.35.2019.07.15.08.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 08:01:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable __GFP_NOFAIL case
From:   Catalin Marinas <catalin.marinas@gmail.com>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <20190715131732.GX29483@dhcp22.suse.cz>
Date:   Mon, 15 Jul 2019 10:01:00 -0500
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F89E7123-C21C-41AA-8084-1DB4C832D7BD@gmail.com>
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com> <20190715131732.GX29483@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jul 2019, at 08:17, Michal Hocko <mhocko@kernel.org> wrote:
> On Sat 13-07-19 04:49:04, Yang Shi wrote:
>> When running ltp's oom test with kmemleak enabled, the below warning was
>> triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
>> passed in:
>=20
> kmemleak is broken and this is a long term issue. I thought that
> Catalin had something to address this.

What needs to be done in the short term is revert commit d9570ee3bd1d4f20ce6=
3485f5ef05663866fe6c0. Longer term the solution is to embed kmemleak metadat=
a into the slab so that we don=E2=80=99t have the situation where the primar=
y slab allocation success but the kmemleak metadata fails.=20

I=E2=80=99m on holiday for one more week with just a phone to reply from but=
 feel free to revert the above commit. I=E2=80=99ll follow up with a better s=
olution.=20

Catalin
