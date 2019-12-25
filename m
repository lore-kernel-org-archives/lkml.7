Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20672C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 13:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBDD20722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 13:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mZit9suz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLYNxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 08:53:15 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37959 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfLYNxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 08:53:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id n15so20329817qtp.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 05:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=KUrCa6xAYjppP+kYyaFb1kK7z66EPpyNc7GyOaqtVdk=;
        b=mZit9suzmem/cS/gpTcNGVlvF3wGKIXuNs61u7kNov92m4+hdxWzR7feJ21VbWW7Cw
         UjcRkz5+CqAocHebwCuhi9iMarvn2JU1/its/7R0LLOdi7KiXXKlPNcI1EFsbsi3VnyO
         WOtUWv/y3a5h1qkyugjDmpvkvUXu6BVzL8ZmZ0EEZzMyGxDC0LfOYQt3DQ63p9Mw3be+
         7vGssLfKj8RXnuajMHWSN77Pm50+9DgrqtfxqpAe+JSUMfDyWNzFI8fR1IpGqa+Xg1h4
         1TIbCplYVDsctABJqD/m/ELpHGAg7ufzgpu5c8dzgdb+sp2HSZVSqxU0x6CKI2boQlBP
         UOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=KUrCa6xAYjppP+kYyaFb1kK7z66EPpyNc7GyOaqtVdk=;
        b=EQYE4ri0y2PPVfeUcjsQzWX2/VZQ5He1kMrCo/R8klCal6Io+eF2IRaSU1WljjtPN5
         gR0e1uKTjbGXfrpvQZ6aQZR8frftzRcCP2zg+1PtXACcgG+Z96aePnUt1UeM2EWHcwNP
         cZt6pOxiWS1WbYKF7bpWKd2CYmk5DWNwgVKzpHJ1omkUxuJOj57ROUOvwMZ2zJ6tBGXo
         AO9qglHztEmeed1Z2jkYW0lnm2xm3zcXnpMsAPFSgHFnY/C/mZz6g0gLXv4mGxih/3jh
         O+DhyZ2ft3dsiirNZBw0ogWZ8UyQk81G1bpnByxVhMwlonNkmvDvtjERI71frUMlk5ae
         LVlQ==
X-Gm-Message-State: APjAAAV2+BrPQPywKcUUxDV9XE6G6oXHmwhNxUhVYmNgSN4IWBYQcvxS
        YibR778F3QVfTh8kqeEA42Iu4w==
X-Google-Smtp-Source: APXvYqyYd1Qrn+cNoCtdF1a9JXv2sOcUEywIf7eukL77EDLmSZ8iElk8z29HZl+sFgCMnO7hAsELsw==
X-Received: by 2002:ac8:5313:: with SMTP id t19mr31565483qtn.375.1577281993999;
        Wed, 25 Dec 2019 05:53:13 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e3sm7057253qtj.30.2019.12.25.05.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Dec 2019 05:53:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_owner: print largest memory consumer when OOM panic occurs
Date:   Wed, 25 Dec 2019 08:53:12 -0500
Message-Id: <1806FE86-9508-43BC-8E2F-3620CD243B14@lca.pw>
References: <1577266145.31907.4.camel@mtkswgap22>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
In-Reply-To: <1577266145.31907.4.camel@mtkswgap22>
To:     Miles Chen <miles.chen@mediatek.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 25, 2019, at 4:29 AM, Miles Chen <miles.chen@mediatek.com> wrote:
>=20
> For example, we're implementing our iommu driver and there are many
> alloc_pages() in drivers/iommu.
> This approach helps us located some memory leakages in our
> implementation.

Not sure if you have code that can share but I can=E2=80=99t imagine there a=
re many places that would have a single call site in the driver doing alloc_=
pages() over and over again. For example, there is only two alloc_pages() in=
 intel-iommu.c with one is only in the cold path, so even if alloc_pgtable_p=
age() one do leaking, it is still up to there air if your patch will catch i=
t because it may not a single call site and it needs to leak significant amo=
unt of memory to be the greatest consumer where it is just not so realistic.=
 For debugging point of view, IMO it is better to annotate this one alloc_pa=
ges() call when in doubt, so that kmemleak would catch it instead.=
