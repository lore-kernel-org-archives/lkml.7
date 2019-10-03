Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F5421D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BjlPEm6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfJCIgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:36:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35274 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJCIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:36:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id w2so1547323qkf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 01:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=4CeVWWjChe4JVh4dmU/4+mZJCI7ZUrE7w4sXeS5XAUY=;
        b=BjlPEm6OXFq1mVyI8rYGVVJDZyQKrmtgEvSfhhUSqsunbJAxuislyFQihRpphfWfg1
         XibCg+kUjOHR8MdJwAQ4J9cPTmAMalW8zn4ubrWH0iKSHaeewTeK+YvxquFZo8JNYAn0
         GwJKXg/eVAPyGxIiTroT4kOn3O66qr+IRNMM3N/SX/YhbaZHakZnFKAKCJW5UvhnpHOO
         Q0mXRy4XEWEkD8XDOvOr1wkNM2GapJbTTUgJ9b3xnTNr4JicOKt4i4dmA/B8TZv/v7PD
         /OupqfIN924GEkmyN4drm472U7BSfVEMdw6gJHFBUAoOoLE9sUT1amFEy/hC9S6SGyVs
         2S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=4CeVWWjChe4JVh4dmU/4+mZJCI7ZUrE7w4sXeS5XAUY=;
        b=Va26vaG3T3mJz44fpRY1k3xTFMPO4WPpzWuP1fL//DKOsszyI2lQA8Ha+nDxY0nWdV
         0tVIhCJ8eaxzuRdw2ScfrOuMIOv9F/w5VH+BFPoU2TOUvaxAUTom8OGBnjrQP7Kmoksq
         nlJ7gOqLPhNUnJE2PMY1aKL1Mx6T/XibYBKdh2i2hx0X3kGdc2wc4YTxyNi9I9tcciva
         7hLrHDk3rZ0U/B1kVxaO9onkIZ7ROz01UyNWxOnrsp0KRvOKSutDThjbJr6UMf5a1kNn
         yxngUL1mzZL+Urz3GkdTEFs0pycSKbIfOAE4WVLI/iMQDoV0G7eKF+eSG1iXnbTSZRvf
         QNew==
X-Gm-Message-State: APjAAAUVab/m33/u7cVwkK9emBJJEfIIbisjV/hMx88+5GHJCptBlOYG
        65oIqQOhkHT8iRGP5sQgDWcXJg==
X-Google-Smtp-Source: APXvYqwU/eHga2r/bmmNvbCeJ0VJW+Mx2EC5xyF/7WKWX7O5pehJ+MfzV+FrlnVMiLgfMwU2flt5Tg==
X-Received: by 2002:a37:713:: with SMTP id 19mr3254349qkh.490.1570091800694;
        Thu, 03 Oct 2019 01:36:40 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d16sm861676qkl.7.2019.10.03.01.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 01:36:39 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 1/3] mm: kmemleak: Make the tool tolerant to struct scan_area allocation failures
Date:   Thu, 3 Oct 2019 04:36:39 -0400
Message-Id: <934700AE-CD78-43B8-A59B-2E968DA44DBB@lca.pw>
References: <2ac37341-097e-17a2-fb6b-7912da9fa38e@ozlabs.ru>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
In-Reply-To: <2ac37341-097e-17a2-fb6b-7912da9fa38e@ozlabs.ru>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
X-Mailer: iPhone Mail (17A844)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 3, 2019, at 2:13 AM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> I came across this one while bisecting sudden drop in throughput of a 100G=
bit Mellanox CX4 ethernet card in a PPC POWER9
> system, the speed dropped from 100Gbit to about 40Gbit. Bisect pointed at d=
ba82d943177, this are the relevant config
> options:
>=20
> [fstn1-p1 kernel]$ grep KMEMLEAK ~/pbuild/kernel-le-4g/.config
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> CONFIG_DEBUG_KMEMLEAK=3Dy
> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=3D16000
> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=3Dy
>=20
> Setting CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=3D400 or even 4000 (this is wh=
at KMEMLEAK_EARLY_LOG_SIZE is now in the master)
> produces soft lockups on the recent upstream (sha1 a3c0e7b1fe1f):
>=20
> [c000001fde64fb60] [c000000000c24ed4] _raw_write_unlock_irqrestore+0x54/0x=
70
> [c000001fde64fb90] [c0000000004117e4] find_and_remove_object+0xa4/0xd0
> [c000001fde64fbe0] [c000000000411c74] delete_object_full+0x24/0x50
> [c000001fde64fc00] [c000000000411d28] __kmemleak_do_cleanup+0x88/0xd0
> [c000001fde64fc40] [c00000000012a1a4] process_one_work+0x374/0x6a0
> [c000001fde64fd20] [c00000000012a548] worker_thread+0x78/0x5a0
> [c000001fde64fdb0] [c000000000135508] kthread+0x198/0x1a0
> [c000001fde64fe20] [c00000000000b980] ret_from_kernel_thread+0x5c/0x7c
>=20
> KMEMLEAK_EARLY_LOG_SIZE=3D8000 works but slow.
>=20
> Interestingly KMEMLEAK_EARLY_LOG_SIZE=3D400 on dba82d943177 still worked a=
nd I saw my 100Gbit. Disabling KMEMLEAK also
> fixes the speed (apparently).
>=20
> Is that something expected? Thanks,

It is expected that a debug option like this will make the system slower.=
