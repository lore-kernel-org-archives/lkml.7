Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21567CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB40E21655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qSFAuONw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408437AbfJXFdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 01:33:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34326 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390377AbfJXFdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 01:33:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id e14so16337143qto.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 22:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=kMDjWt3IE/hDXSObRKUSkNCwiB5LLLieG6mbeqZoc6I=;
        b=qSFAuONwVuK72d0RCzO+D9LCLNcdwOXyo7/yg+1eNGAzNXRmumE9PitzLP20N/DZGI
         HR/UoWoqvGGTEPhjsX8eyxcGHnRI55zfniAFLC6Wrlq9gM8PB4IekZjlhBFXYNhyqdoF
         AvbQwoQQhgyXGS+3UybNAVUsly+w2D+Tfc/X3ei39VeZc4QzP11gJrKeGhNiA9UZ/7Mu
         luLaXMxiG51NKsuIgCI+BipogCEoVQeVKUJmt5iP8UwpwrEVZGpuR+Eout2ARSununLt
         +R5o82XPX440T3IJxI03a4ittQAMKXbrqY5ZEbWW3emTwhtJJEJLKQT6gK/gxJz4uc9/
         CxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=kMDjWt3IE/hDXSObRKUSkNCwiB5LLLieG6mbeqZoc6I=;
        b=mJmsDGQZhVbF/rOEtK5fTWIiWW08Lf4GtlhFBirOMaUY1BvUGZTxHFQw02fZXacs52
         jiucLAoZLHqhw7SWOiPgfDer52/ag4yND0SwwjZKMO0IF0AT1Gmb+iO+0gmV5DUcxhYW
         kWflTbwId6D5Uywg8q7/4HCJCapZY1eGtOEu7zmNsDAQqEME85xvMe1AWaoeE6MxY8iu
         LZwc3mE7sGfhpGLTcaDfoMxPauJO7YiFZQKFAoKE1l1IxCRqzpOjkDkcPjEIeAqQYcSd
         wl2+boWWpSyI7IpRtaa80sXHv2VR0vUZ0z2JdOPjRaEMXGrXfoxQ/IBrkhguBTKH2F7+
         8WfQ==
X-Gm-Message-State: APjAAAWTv0Bxs6rRFitqpQt/PZKXSmoVqztCdNr76FA+HWHgISXxUcdj
        jmMAW/HwE8U3WBBWFHTfmsiclw==
X-Google-Smtp-Source: APXvYqxIOXo8+O0i2f+RBhdetbx5+uSeNzfxmzleanKDeCXm0cmT5jv0Mci1wr2JPPioOB9yMpiyHA==
X-Received: by 2002:a0c:8b5b:: with SMTP id d27mr12792896qvc.29.1571895183254;
        Wed, 23 Oct 2019 22:33:03 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c14sm15931537qta.80.2019.10.23.22.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 22:33:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading /proc/pagetypeinfo
Date:   Thu, 24 Oct 2019 01:33:01 -0400
Message-Id: <4D23D83F-190F-40B3-9EB9-C167642321B2@lca.pw>
References: <20191023153040.c7fff4bc7c86ed605fc4667f@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
In-Reply-To: <20191023153040.c7fff4bc7c86ed605fc4667f@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 23, 2019, at 6:30 PM, Andrew Morton <akpm@linux-foundation.org> wro=
te:
>=20
> Yes, removing things is hard.  One approach is to add printk_once(this
> is going away, please email us if you use it) then wait a few years.=20
> Backport that one-liner into -stable kernels to hopefully speed up the
> process.

Although it still look like an overkill to me given,

1) Mel given a green light to remove it.
2) Nobody justifies any sensible reason to keep it apart from it was probabl=
y only triggering by some testing tools blindly read procfs entries.

it is still better than wasting developers=E2=80=99 time to beating the =E2=80=
=9Cdead=E2=80=9D horse.

>=20
> Meanwhile, we need to fix the DoS opportunity.  How about my suggestion
> that we limit the count to 1024, see if anyone notices?  I bet they
> don't!

The DoS is probably there since the file had been introduced  almost 10 year=
s ago, so I suspect it is not that easily exploitable.=
