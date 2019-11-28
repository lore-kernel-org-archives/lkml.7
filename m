Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F725C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F2C217AB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RiROsxoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfK1P30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:29:26 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34838 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfK1P30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:29:26 -0500
Received: by mail-qk1-f195.google.com with SMTP id v23so15232111qkg.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 07:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=o25gVTM3POIQu+gqgts69ZSJpER0xLxj/NptxHj1lGY=;
        b=RiROsxoQeTjFzPUjV2tSMBSlHoWH14G7MKaat8rAiHMEsMRQ6uHJWEZko66S5ZLYRR
         D8Rgaa/jk1lC/LpAQ+SqVl8oJv9NPtAb6ozlqx1+a5x0sdEtQRpGPeMi5f3y7SrbXXlV
         z9r/FfReU/k8ZaRBkh7jPNkTQPnCMD7cqmCoU1AxOX/3vE7MVg2yLblVUuPH95n1ayTG
         seWpwnF2SGi+e1nrNnosoaZEwNXgOWc7m1vhr7PgcACk8jrd+ANE6nb3s0oRFh9FrKsd
         N3C7AGSTPrAFbVlDWwJeuVA2mkHWEayVnRtWl/NmvtZmaGadHPfrWkawv+zLC7SK3c5o
         5aTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=o25gVTM3POIQu+gqgts69ZSJpER0xLxj/NptxHj1lGY=;
        b=MIElty9oEyWhHtOxPPy6Po1gCvgMLg2O2ldqxo0f5IugsCOHE3o0ymJaVhKZ4LinM9
         f59FCnSZrE+Bs1p8ULdTlYxPV4i8+yXYG5oHDvxqfLmwAjMEZLLvq9WrlD4CVIvfBPen
         dLrWW+1a9PwJPEwW0NmcztQq5G5HhxcwnNc083YonFiPF+nOLRv0P+P616aBH5ZNhMLa
         pKXI5t2MXYJKlToWsIqMnueMS2wbROnC/qADk7AMVfzyCFaOBDflNiIySmP0K6O7VFUw
         bN6yAXQkRBG6pRWMEe2AHbJoXib3lKdRtUhq7e8aNpZHS+tMSNbd/mZ3m904A1yM/TUG
         fPiw==
X-Gm-Message-State: APjAAAWy7aXX0i5MK/oC9u6O6bHdAbjc3YQ+s6oUHZUOz4JH7sxv57FX
        AdFzN/sF5OuPwCwaxgjhGN4qHQ==
X-Google-Smtp-Source: APXvYqw1pdKo9iQXakvY4/z67dTdEia642ja75qtt6+Zp2jRCx47LSMi11S8cgfmAeOTImpKbpXPfg==
X-Received: by 2002:a37:9fc9:: with SMTP id i192mr7687196qke.364.1574954965256;
        Thu, 28 Nov 2019 07:29:25 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u4sm4055273qkh.59.2019.11.28.07.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 07:29:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in find_(smallest|biggest)_section_pfn
Date:   Thu, 28 Nov 2019 10:29:24 -0500
Message-Id: <687DAE43-C40F-4527-876D-CAC750D150B6@lca.pw>
References: <c1857505-4565-99c8-d86d-efa6c076312a@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <c1857505-4565-99c8-d86d-efa6c076312a@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 28, 2019, at 9:52 AM, David Hildenbrand <david@redhat.com> wrote:
>=20
> I also agree that it should not be used for basic functional/compile
> tests (I said "It is a way of giving patches *more* testing."). It
> should not be the only place to test stuff (especially to let somebody
> else do it).
>=20
> However, sometimes we really have to get additional test coverage via
> linux-next, especially for weird archs/configurations/setups.
>=20
> ... and if we don't have enough reviewers, it's really hard to get stuff
> upstream.
>=20
> I wish MM patches would get reviewed more thoroughly.
>=20
> (If we all make a wish, maybe Santa Clause will listen ;) )

What I don=E2=80=99t understand is that we have an policy prohibiting code c=
hurn like code optimization in cold path, but allow those micro cleanup of c=
ode. Those cleanup also tend to be unregulated and is subject to personal ta=
stes (for example, your CS teachers may have a different taste from mine). I=
 can understand developers want to have fun, but perhaps there are other pla=
yground areas that worth taking more risk?=20=
