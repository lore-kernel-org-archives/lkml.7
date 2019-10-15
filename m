Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1747BECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D1921848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PanbLKwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfJOIig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:38:36 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45953 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfJOIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:38:36 -0400
Received: by mail-qk1-f195.google.com with SMTP id z67so18382735qkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=uWQ6Z/m/ZDOV1Cq6uOj2bgGUSJ4jAFpiEa/ETfmRIz0=;
        b=PanbLKwT95zYTPNoDfQLUrTe8LpcDTpB/+8zrQaOJvO5wRF0jR9uiFNODKCeXO3ZDd
         mCzV7G00OU7j/SbdNN1vSsAPox72wynTKGJ+h3bQHnOA3u+fe7MW89YxKHBoSKuODn/L
         /gfF2y3pCE1SDIPiURbC5llKyb/x9gxYP34ad0GzStWE0temDtHhQlOty9MHNha+ylh0
         7x1EwgUAdTd3PyFwwh/RBMwROq3TXjUPMbRc4nFXlL9PMtlAdyUjSDI5zJzMU576dwDx
         2SV9i1yIhN0j5VEHttttOtgB33kx3KbHGhinH5R2m5EnpMQbAiYCQdgTfBF2jcfNzraZ
         ODkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=uWQ6Z/m/ZDOV1Cq6uOj2bgGUSJ4jAFpiEa/ETfmRIz0=;
        b=KDQUcoibXjjCfM8l0T212qbWVkqZm1czwUpq1p5UASKeo2jk9mjAA9+x8we1Qe0Noj
         RcrzJkPLc7jwG8yXGZ1zXZaGCIUmsl7IbkvTHz8I/WOtVcXusrKKMeR0kwXETT/o4+QW
         dX8cQj8OARdlNUIVaMnyo2s3yswnuksX4TAEOx0Fg9ryBfeCHznMo1TDnch/sb+fuGwb
         X2dROMjnK5oU6HxxsWivtJZgD2582gdT8Gm8vlft4sDGblwwENOmuqMZcepivB867dtZ
         aiLi0P8cGofTxH6hz/OkTP0RnQpUwjWkFhjgIndI0+SoSgZQr63DUpIuAh4zVtIq7c/U
         D/4g==
X-Gm-Message-State: APjAAAVA0FMxYTgR3DaBj7GmioJFJ+sda0hVwm1YvxtBr42iRXPUQ3M2
        TKTV32xQO6ng01K6eUPYFjg5uA==
X-Google-Smtp-Source: APXvYqwsK2EsGslXg9ZERZ0s0xLmXi6sseHDBOW4+UFU6how9/uDB3OrwnIXla2BLbjasR6UBLcqNw==
X-Received: by 2002:ae9:f707:: with SMTP id s7mr26514828qkg.82.1571128715239;
        Tue, 15 Oct 2019 01:38:35 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 22sm9035786qkj.0.2019.10.15.01.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 01:38:34 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V2] hugetlb: Add nohugepages parameter to prevent hugepages creation
Date:   Tue, 15 Oct 2019 04:38:33 -0400
Message-Id: <3340809E-6529-4A14-9D42-B14D7E54A8F3@lca.pw>
References: <20191015045158.5297-1-gpiccoli@canonical.com>
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, jay.vosburgh@canonical.com,
        kernel@gpiccoli.net
In-Reply-To: <20191015045158.5297-1-gpiccoli@canonical.com>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 15, 2019, at 12:52 AM, Guilherme G. Piccoli <gpiccoli@canonical.com=
> wrote:
>=20
> Kdump kernels won't benefit from hugepages - in fact it's quite opposite,
> it may be the case hugepages on kdump kernel can lead to OOM if kernel
> gets unable to allocate demanded pages due to the fact the preallocated
> hugepages are consuming a lot of memory.
>=20
> This patch proposes a new kernel parameter to prevent the creation of
> HugeTLB hugepages - we currently don't have a way to do that. We can
> even have kdump scripts removing the kernel command-line options to
> set hugepages, but it's not straightforward to prevent sysctl/sysfs
> configuration, given it happens in later boot or anytime when the
> system is running.
>=20
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> ---
> .../admin-guide/kernel-parameters.txt         |  4 +++
> fs/hugetlbfs/inode.c                          |  5 ++--
> include/linux/hugetlb.h                       |  7 ++++++
> mm/hugetlb.c                                  | 25 +++++++++++++------
> 4 files changed, 32 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
> index a84a83f8881e..061bec851114 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2982,6 +2982,10 @@
>=20
>    nohugeiomap    [KNL,x86,PPC] Disable kernel huge I/O mappings.
>=20
> +    nohugepages    [KNL] Disable HugeTLB hugepages completely, preventing=

> +            its setting either by kernel parameter or sysfs;
> +            useful specially in kdump kernel.
> +
>    nosmt        [KNL,S390] Disable symmetric multithreading (SMT).
>            Equivalent to smt=3D1.

No, it does make much sense to even mention kdump here at all as a justifica=
tion. If somebody blindly set sysfs in the kdump kernel, it will be garbage i=
n and garbage out. It is trivial enough to disable it, as it is what have be=
en done in enterprise distros implementation of kdump where it has no such p=
roblem for a decade.=
