Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4C8C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 18:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC43020706
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 18:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="l6Bnyxxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfLNSLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 13:11:25 -0500
Received: from mout.web.de ([217.72.192.78]:35755 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfLNSLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 13:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576347064;
        bh=rLZunKlfvqgHLg9f3GstT0IURilADZJAFil/F/8wa3k=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=l6Bnyxxqwgweld/9uMqahp97anE2/063MplNuhlITPAZiWoTEOH2V4NaOFHyDyePZ
         6AY27nFltme+dxoImGy/dkH+e42fUetYHK4GEN0lrkVu7PAZ9sCDNQWCcf/eDu1lqG
         LtMzFv9p/bm4Bh0fvpdDd7cOr6tZmOaMugkL5VPI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.133.107.49]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXYeQ-1iAtNG2HTy-00WWsd; Sat, 14
 Dec 2019 19:11:04 +0100
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Navid Emamdoost <emamd001@umn.edu>
References: <20191213223751.4089-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH v2] mm/gup: Fix memory leak in __gup_benchmark_ioctl
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b167e207-f919-be9a-08cb-1d1a56e25e37@web.de>
Date:   Sat, 14 Dec 2019 19:10:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213223751.4089-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z2llYW6Q3ZSeXcueD70uzihWFfG/5gKIJOlWGa0ESJq6KmWMBa0
 DlqOa+J1K/IYRU4SQGDrat/VJvagrPcfdazp87N44x1QIyZNbI7ADKUMF9iAPU/Ws2HyMGw
 ua9D+7MN4Teof8XWCEQnLcIA7zMCrpRRmdZrJFDqmWbFDU+1aZW4kQxYciMowo7lreO/D7W
 Oxyt4fqGxLk5OtFBEparw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ugHcgFata8U=:lTaahgWn8Cdd6Uxl62UVeK
 4C714fl4OSE3sxAOTPWBCL5FhDtYwMlAhedUNl5XzWZWvc6ArnCcqEFV8zeAc+j437Ee0hrB+
 HAidjA+Z3XyCioDSxpBylRbzaFQjBBM3t9UF7CdAwAci6wcgPOg8LyvXGLwQgG8/M3E7/gdKF
 DQbfImnuDseo531mFJzB5beVG1Wt1k9+RN89oRo3bxZssABujvCiT7KeM0xY4UBBbXPt8/x1P
 9oY35hyZDE3cSNWyFR+txyUIwfNERVIMLben89Co+cA9yK32tQDV2PiD1g0ofoxxsaRskTjtp
 QNJp87DvHhmKcTlzbAGaoy33tQHOzJK/Xc3OLDjffzYDI/nJQFhYCb2aaP+BiU+HgqoYs1C38
 oWrCYZYhCWyHQ6VKutJQK2HI1TZyX2SKKoCOzYIaVm/X7klP04ack7FHUGkBoipxr+yTC/CX6
 3exMGLCQnRirZ97aWdO3vToHi76WzRtFTcE9LKTniK/Mkpvx9IA5SKsqtyzAvBVJ7pEdvGN5M
 CZV+bl/pImIJV5zdX7Ph2dz8w3wVLQWlHJYAQ1DjBzTDT3lAMRrIryC8vNdtACsO229y85tzF
 QCUPn7Rj4qib9ezLUOQH+n0lf/CHlzZL2fdOxjPSG3Ed3H1EECpPnsrkAIBMGpYENpYExPj8Z
 8kaQ1oChtDF+vT5gqC015HVCDrqLxCTBJkeJCpfpRBBDE8ubhW3lL+ZDUumCKbjbOsyZvLVWI
 CWsJrtFYBLzTPMo3mz+YsIgDskAuCA47YV9A7GqfDt4Q2ssEZkvpjdKOX7woFkTRy1bK+ZcA3
 GvYbeUbOjPUrvwQWbMyVRTUqBnE83SwCG7WzZGItkYgi6HvOVLgB4rqHftktnP84k07eD0JlN
 j/en5MLb1T3zC1a50v2fKFAnDWXxIm3BGylB1quNc7zRRx54KSf5LsA73WCVJQxU0Nc7totX3
 RFo4nSbPUz4P/j2Y2FuWdoISdPHlPeJwIOs0rMy/h/Jyz/Ov0V3g1vNvYdz78wqlOSDt9+Nl2
 IJxI4mTc6QEfip/bXfKVqRTso+dNs0Ka0UYc4Z4pZcsZjt1m+rk2VQFV+UfhscbY/3Dnt6Q2n
 9deAZ8b/qKX/+G2bwymHF0/wuy460hrXf/Nq/u46z3m+/GJeVyFyW/lTbEpAUNtKQSqThzH7P
 Dt6fUiEni0vcXf7MND7xn8aZ3S+K9x0qPDnhcWYFowQPzCNcyaZVquaSWieMvc4enw3asf/mj
 Zr0qztsmUBZpg7wXXwk25SrI8mls4pGXejazQ+XKe+722BunnXIyEZQkbbWA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/mm/gup_benchmark.c
=E2=80=A6
> @@ -85,8 +85,9 @@  static int __gup_benchmark_ioctl(unsigned int cmd,
>  	end_time =3D ktime_get();
>  	gup->put_delta_usec =3D ktime_us_delta(end_time, start_time);
>
> +done:
>  	kvfree(pages);
> -	return 0;
> +	return ret;
>  }
>
>  static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,

Can the addition of a label like =E2=80=9Cfree_pages=E2=80=9D be more appr=
opriate here?

Regards,
Markus
