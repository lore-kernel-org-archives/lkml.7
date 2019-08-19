Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E1DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B612063F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezw4XWKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfHSN4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:56:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36465 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHSN4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:56:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so1280714pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=39/k8iI4wKhtmhee8gWVY7ASF3R5OBsTld60CZUT6Sc=;
        b=ezw4XWKp+t4ah2r4cQe34oQjbF1z9O+w4gszDJ8HrBYxpZq65brA39qI2LiFXF1rAw
         dUH5COYyDWypNDZ6f025q/2G/wxcAf+BZ/NPv3uZpFGjsE0ZX+oaUXaH8yDwBg71WBRn
         fl0Ui1qFS4zPuQhRptEo6Kpe3hcPH2ECmDr3f4vcYQtM3XUag7BFFs8bGBaUurFb7uyS
         w9m3nVVSXDuSJt/8tOYFEBaLWMgzYljvOYKDLuor9AIThqxpQc4yiXzz7A0gJYUULo3X
         YSyibsUagjr+DHCHinTG1Aqla6OqDPI1E/ydiqgCqL7/kUYfkYQ+n3ZPNxAO1rSVbMqB
         67VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=39/k8iI4wKhtmhee8gWVY7ASF3R5OBsTld60CZUT6Sc=;
        b=pbltTqZtBHSHM+/Kb/e29ejE4Rdjxah73I60bzSZB3rZ+SSm4Diyi4bYfyk6+5IzOh
         0iPBHdxvaRr3idwetfsHcpvG+XgkS/Y+wbISK7TTnxnsocGSsAF1DVd0w9UroUQAxETz
         uj0VTjuFqfLPJlCjLU0c0MKxLcFGb57KlnNJD/EtX+sKXXkF8F5rHJ1Q/gPr/zjMh4mq
         el/wDBctCxkBYe1nXBrY1aMckuNwXnUW0gsvdlzPbtp/2gmsdc61lKOjGUoNYr9Ign4K
         6Qcw/bkd4Ui58xu0vM2wRLNqOxpYlu+qvBRGG6qkwTMM/rQ1txAfzDbpDeYbmQF5mD0r
         j+FQ==
X-Gm-Message-State: APjAAAWiYVn0qWdZDZCCaPvZ3nhKhTRqT2P7bheeSiWtLUlhkOkGF8Md
        xPbJrck8TJKwqiqdKt7JabE=
X-Google-Smtp-Source: APXvYqz7lfv4IEui68yrz5NozTdCayhWRB5+5mYZJn2xV/JKreY7cMTYGK1gQV5oqhONQ98sDtyPzg==
X-Received: by 2002:a63:b904:: with SMTP id z4mr19572193pge.388.1566223014873;
        Mon, 19 Aug 2019 06:56:54 -0700 (PDT)
Received: from localhost (193-116-95-121.tpgi.com.au. [193.116.95.121])
        by smtp.gmail.com with ESMTPSA id v18sm16628116pgl.87.2019.08.19.06.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 06:56:54 -0700 (PDT)
Date:   Mon, 19 Aug 2019 23:56:43 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 1/2] powerpc/time: Only set
 CONFIG_ARCH_HAS_SCALED_CPUTIME on PPC64
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
References: <d9ac8da98f53debb4758b98d0227979aca9196f7.1528292284.git.christophe.leroy@c-s.fr>
        <20180607114304.327c4ab5@roar.ozlabs.ibm.com>
        <26969bb5-c01b-0674-5773-027f1851bd44@c-s.fr>
In-Reply-To: <26969bb5-c01b-0674-5773-027f1851bd44@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1566222563.zuxi8x5ryi.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on August 14, 2019 4:31 pm:
> Hi Nick,
>=20
>=20
> Le 07/06/2018 =C3=A0 03:43, Nicholas Piggin a =C3=A9crit=C2=A0:
>> On Wed,  6 Jun 2018 14:21:08 +0000 (UTC)
>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>=20
>>> scaled cputime is only meaningfull when the processor has
>>> SPURR and/or PURR, which means only on PPC64.
>>>
>=20
> [...]
>=20
>>=20
>> I wonder if we could make this depend on PPC_PSERIES or even
>> PPC_SPLPAR as well? (That would be for a later patch)
>=20
> Can we go further on this ?
>=20
> Do we know exactly which configuration support scaled cputime, in=20
> extenso have SPRN_SPURR and/or SPRN_PURR ?
>=20
> Ref https://github.com/linuxppc/issues/issues/171

Unfortunately I don't know enough about the timing stuff and who
uses it. SPURR is available on all configurations (guest, bare metal),
so it could account scaled time there too. I guess better just leave
it for now.

Thanks,
Nick
=
