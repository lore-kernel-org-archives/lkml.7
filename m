Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3902EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6BF20673
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="liA8TgG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfHVBwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 21:52:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37065 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730647AbfHVBwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:52:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id s14so3744010qkm.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 18:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f5/b6EM5llXI7wbQ95XKS+eTiQfi8CiOgyUNELxbz44=;
        b=liA8TgG1W6iZeAa9+70rFbWjKcqn5+YCZNPq4ZFUoUxdc8fe4ITH/EhJhXNLxLlpWx
         4hZZpx/YtJ2oyNeITVRI2P6yGZ9wR3/jZtrWDnOLHnWFlSqq23FUyMlYTdLYl5umh9Fl
         tEAIiLfZ2VycAd3ib1a2j2MRFNAwyktc5uxdjHTCsm3bvCKYtayVOEm5M451cOPTKOpo
         FtHJe2VpQfkw2pG3WHutYH17VTlmEBfxApng7hdTr31iLi4qyr2tu1Gy0AxbM6T8OBob
         qKJxvRRMVszsDJJCE7vak4CHaUJ1pFfWrWtQYmbOgIrlYU44ZYeyHLaeXZdgH7C9h3nF
         p60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f5/b6EM5llXI7wbQ95XKS+eTiQfi8CiOgyUNELxbz44=;
        b=Yaf/4ZyhSXThCZFCXRghonCSu2Ztk6vKKHH2Q71UzB4QCWt8drXd0MA90oXfOM2jQp
         UCIC/j28TWlAs3UBNpJ8acuSjKCjP742Nq3Irazg8QntJJsLf3FCp52ONdUykOitHMLK
         QbYrL0Ua1F/RfcEqC08qcVPfB4/sqc81mhIisXKe46fLbloXnqsJrah0L9iVaAVmj2L/
         5ZIHdOVGqDR2IPbVEMtnK2G3usPJZtpTrdNmy274uikohcH821PvQcQlcKi/Glv9veqw
         +dE/09FndiZ096L+AnzrCYGlmb/Sy0JSEAFZkAl8IzHBmaRWHzapwMViBvDl0oSuG0qN
         y5zg==
X-Gm-Message-State: APjAAAVhkKuESXEN9b5+sfPFzXFR1rII9uJnAvWjTmDvGQUUauYiRiEu
        KmxZadYFTKeKAmKRZES2YhZSZg==
X-Google-Smtp-Source: APXvYqxUve7UdEp+jCWfHeLX4rsl8Y4/WA+O4MncLknAPC+G2GjOVUN/aglze/CttKpX1cWQmHr6XA==
X-Received: by 2002:a37:7b06:: with SMTP id w6mr26784846qkc.436.1566438723558;
        Wed, 21 Aug 2019 18:52:03 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d37sm7289872qtb.80.2019.08.21.18.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 18:52:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: devm_memremap_pages() triggers a kasan_add_zero_shadow() warning
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190822013100.GC2588@MiWiFi-R3L-srv>
Date:   Wed, 21 Aug 2019 21:52:01 -0400
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com, Dave Jiang <dave.jiang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90D5A1E0-24EC-4646-9275-373E43A17A66@lca.pw>
References: <1565991345.8572.28.camel@lca.pw>
 <CAPcyv4i9VFLSrU75U0gQH6K2sz8AZttqvYidPdDcS7sU2SFaCA@mail.gmail.com>
 <0FB85A78-C2EE-4135-9E0F-D5623CE6EA47@lca.pw>
 <CAPcyv4h9Y7wSdF+jnNzLDRobnjzLfkGLpJsML2XYLUZZZUPsQA@mail.gmail.com>
 <E7A04694-504D-4FB3-9864-03C2CBA3898E@lca.pw>
 <CAPcyv4gofF-Xf0KTLH4EUkxuXdRO3ha-w+GoxgmiW7gOdS2nXQ@mail.gmail.com>
 <0AC959D7-5BCB-4A81-BBDC-990E9826EB45@lca.pw>
 <1566421927.5576.3.camel@lca.pw> <20190822013100.GC2588@MiWiFi-R3L-srv>
To:     Baoquan He <bhe@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 21, 2019, at 9:31 PM, Baoquan He <bhe@redhat.com> wrote:
>=20
> On 08/21/19 at 05:12pm, Qian Cai wrote:
>>>> Does disabling CONFIG_RANDOMIZE_BASE help? Maybe that workaround =
has
>>>> regressed. Effectively we need to find what is causing the kernel =
to
>>>> sometimes be placed in the middle of a custom reserved memmap=3D =
range.
>>>=20
>>> Yes, disabling KASLR works good so far. Assuming the workaround, =
i.e.,
>>> f28442497b5c
>>> (=E2=80=9Cx86/boot: Fix KASLR and memmap=3D collision=E2=80=9D) is =
correct.
>>>=20
>>> The only other commit that might regress it from my research so far =
is,
>>>=20
>>> d52e7d5a952c ("x86/KASLR: Parse all 'memmap=3D' boot option =
entries=E2=80=9D)
>>>=20
>>=20
>> It turns out that the origin commit f28442497b5c (=E2=80=9Cx86/boot: =
Fix KASLR and
>> memmap=3D collision=E2=80=9D) has a bug that is unable to handle =
"memmap=3D" in
>> CONFIG_CMDLINE instead of a parameter in bootloader because when it =
(as well as
>> the commit d52e7d5a952c) calls get_cmd_line_ptr() in order to run
>> mem_avoid_memmap(), "boot_params" has no knowledge of CONFIG_CMDLINE. =
Only later
>> in setup_arch(), the kernel will deal with parameters over there.
>=20
> Yes, we didn't consider CONFIG_CMDLINE during boot compressing stage. =
It
> should be a generic issue since other parameters from CONFIG_CMDLINE =
could
> be ignored too, not only KASLR handling. Would you like to cast a =
patch
> to fix it? Or I can fix it later, maybe next week.

I think you have more experience than me in this area, so if you have =
time to fix it, that
would be nice.

