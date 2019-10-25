Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BD9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E872070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Ml4IXHbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501918AbfJYLnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:43:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45153 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfJYLnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:43:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id q70so1383155qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:message-id:date
         :cc:to;
        bh=E9nwf1YnY9pgW+e3Ube7+XXgcr6xzGBKmokqCPeg0mE=;
        b=Ml4IXHboDAqwNWI0i/qzHerMfWI34df39mlOHYlModZhSVkgOb0DSm2OQajuHR+3AS
         puQCNAXeKUGSV4h1A1krXJmC3dajIbBkyY1J46X9jAOt7WXfJsYTdfC0jhZwqzaa017v
         g0O5utdk6/B3q5rEiLY50JOdWhwvPj8yDF4E4bLg3SkzeMt8gbBBAJFI9n88B/kwVyvI
         nqwrnjqJ1hxjM7cMqmLJ7L5Rkm0fY5AwB2xjAxu6GmTU1cALGRjBU60DIvIkdg/ixtWU
         3lmKtGU2iGzY+fBau3KjBnygS2eYfLS0wUYVQi32Wns6AcTHvtkBsmNJzXl6dJw8VYNB
         aKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:message-id:date:cc:to;
        bh=E9nwf1YnY9pgW+e3Ube7+XXgcr6xzGBKmokqCPeg0mE=;
        b=NN0dpHfG5j9LW4wKRGpSiYaa7Djt+FzPydbOKKR+Gw3cfI6HgCblTydcMSLNrWIymw
         vjv58kLXmJeLDyGca/HlKfarnSVcYaVIxJkVcGMfELVSwh8ElXFIx+3aqixQk8x5jIjB
         8PtOjwh3luM6WkkVxTVoTm2/lApMMi4RZao8UsdSXnRdxuTQuwdARsfI6HUKZ2pyZ6wq
         v9C2JVX3oUcQO8FbFPtZCp5ZXjoXelcTIwFyhsTizmlxZ8YvF8fSjj3/GLvQ07jsUsJV
         81i+82eCOt4e58R3aN9VjX5VgthsPR4Ao68ZKOwMJBhtxdx6EF3vBm9JxUhrLYixXsq7
         jjyw==
X-Gm-Message-State: APjAAAUXeoOCtZY4rr0xBcbu1MrUdmmBnScCBmSRi+laoKWt1iS0Kwlj
        65gmRTfI0jrw3fgkT18LUV2DQdspjtKL2A==
X-Google-Smtp-Source: APXvYqwHiSXHt83C8STql3OpjAcR4WCFyY4taXIzTx4s/TJDoXDAUTaaIe2TPILSQJU3aE1Kjpx27A==
X-Received: by 2002:a05:620a:4f:: with SMTP id t15mr2414890qkt.286.1572002345463;
        Fri, 25 Oct 2019 04:19:05 -0700 (PDT)
Received: from [10.250.15.239] ([76.191.34.78])
        by smtp.gmail.com with ESMTPSA id l5sm861600qtj.52.2019.10.25.04.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 04:19:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re:  [PATCH 2/2] mm, vmstat: reduce zone->lock holding time by /proc/pagetypeinfo
Message-Id: <192965B3-B446-499C-AEE8-DFF087D46B87@lca.pw>
Date:   Fri, 25 Oct 2019 07:18:37 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=EF=BB=BF

> On Oct 25, 2019, at 3:26 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> Considering the pagetypeinfo is a debugging tool we do not really need
> exact numbers here. The primary reason to look at the outuput is to see
> how pageblocks are spread among different migratetypes and low number of
> pages is much more interesting therefore putting a bound on the number
> of pages on the free_list sounds like a reasonable tradeoff.
>=20
> The new output will simply tell
> [...]
> Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >10000=
0  41019  31560  23996  10054   3229    983    648

It was mentioned that developers could use this file is to see the movement o=
f those numbers for debugging, so this supposed to introduce regressions as t=
here is no movement anymore for those 100k+ items?=
