Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A58FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BED20409
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rPdOmD+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfLKRTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:19:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38505 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbfLKRTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:19:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so20330258qki.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 09:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=KG1B1/XNdtFtj52rr+keQdkSlXVNtixvd3xO9+2XJ3g=;
        b=rPdOmD+9MCriMKlGpN93RjC2asNR0TjQF5EX6nSzzBHq+kSTO1lDDr7cicx5REQ3pD
         8KA2llMqbpABZbkxF60kjsQjTbbbrkzVY4smbkHgkWr7VoiEPxnBUS3FwYduw/17QxG3
         6GXpRv5e3ru8+IL6BhxkZaq4+HGxjs1okYOqaQIFGo6QgjZrKVx9vJzKGpTWDW9zkwHI
         8uyYpUr0hCuWXLMhTzkMMk9nMVYLJD8SPxV/Imhe2pZb64yY5qsJzCD8iQI3Hx7Wmrgx
         V1zMmPLQEuhnOhtLfuZQ4Lh63s/P1jeYhrG8hpEF2xLGHZnOFuzj/QPhRo1OQoiz7AHo
         WzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=KG1B1/XNdtFtj52rr+keQdkSlXVNtixvd3xO9+2XJ3g=;
        b=XZ8tktqkqmYkoJopNU7DoyRwQxqv42MO/rTi3RwyDLegkQRhxNO0GqwM7yiYbOBSU3
         lsFljAScY4YDzIw/HdNIpbVB8Dg+fs9r2BrgSjahLf435tdCU5Qk0O43lima//lj++Uz
         ABm/TjqBNpjEiYS/EVeGAZmtyKir65Rwz/GnJnBlNxI0ROUWnM7aiOx6cc1pS67isyUu
         Y8r257FaPA5gRtDhmaGznJ67v6Pgr1hTYETleeFB5ccTkLPJLBumerzxu8Lv8OKPY282
         LeAKNkS0GUxlVHUPNwU0Gk8VHY+xxWzXYPSZfd2GcNCoU7X+V0oh+suF372sZCDDKrhs
         AL2Q==
X-Gm-Message-State: APjAAAVjBmFqihJ587PZIirChztlupvN6hHO83ozJZ3H9fMB7TtbyDQn
        PuT8I3h6lW+yO4Jmx3PT+3a2Iw==
X-Google-Smtp-Source: APXvYqziSQ2OU4OXjzdNoNYeczSwDlStzGJAob4piuigMuCkjbj07ZxDhMEWk9MKjPgnwpfe9JISVg==
X-Received: by 2002:a37:27cc:: with SMTP id n195mr3658562qkn.428.1576084776776;
        Wed, 11 Dec 2019 09:19:36 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r5sm849819qkf.44.2019.12.11.09.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 09:19:36 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v16 13/25] mm: pagewalk: Don't lock PTEs for walk_page_range_novma()
Date:   Wed, 11 Dec 2019 12:19:35 -0500
Message-Id: <728FAC8D-AA0C-4326-8990-A3D5D0DA1EE5@lca.pw>
References: <e0fd5594-fb4e-9ead-e582-544f47cb1f8b@arm.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?Q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, kbuild-all@lists.01.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <James.Morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <e0fd5594-fb4e-9ead-e582-544f47cb1f8b@arm.com>
To:     Steven Price <Steven.Price@arm.com>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 11, 2019, at 10:54 AM, Steven Price <Steven.Price@arm.com> wrote:
>=20
> I believe this is a false positive (although the trace here is useless).
> This patch adds a conditional lock/unlock:
>=20
> pte =3D walk->no_vma ? pte_offset_map(pmd, addr) :
>             pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> ...
> if (!walk->no_vma)
>    spin_unlock(ptl);
> pte_unmap(pte);
>=20
> I'm not sure how to match sparse happy about that. Is the only option to
> have two versions of the walk_pte_range() function? One which takes the
> lock and one which doesn't.

Or just ignore the sparse false positive without complicating the code furth=
er.=
