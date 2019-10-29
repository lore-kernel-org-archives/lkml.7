Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57554C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA1220874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572373571;
	bh=0KTYYh/jhIbkXAxzdXFRSuGrcd7MS3TmgKMN3V8tevQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wfmESgfiNuQ9Cy+AcPsAuEdziPSyz0H4pIicWOFw+bBNS7FA/hoHf/8ln1uS/phZG
	 fpshzVbAjLxSfKin8xjPPBoPk7Rwax0dx6MVnDhtac+dSvsx/5i5NuD+ACxmS+tATo
	 n8SQiA7WO9HFPe9JIgPM3DSCd6g9K+uiKlqp2BT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfJ2S0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731329AbfJ2S0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:26:09 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 721D8217F9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572373568;
        bh=0KTYYh/jhIbkXAxzdXFRSuGrcd7MS3TmgKMN3V8tevQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=miCvECNShxOUEFwBQ5hmMk2oasl0FiQCUEArwKtWxsW4UifClVjdmIEgYIgZ8mLl4
         QABvnlyl+jkl1CrBilXkuqdh1G1yjS7xJw00a9CfFTgcqpVeiPx4G5MuycyQcq+Mg8
         oe/a1ctmd5Gh4BtmckE4VntCT0cp+jUaEXVroOh8=
Received: by mail-yb1-f178.google.com with SMTP id m1so5757645ybm.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 11:26:08 -0700 (PDT)
X-Gm-Message-State: APjAAAVVf5WJ2TidGW6lmYXQRdFn72SWiJJxNCV2tCr19YBAtbCl6O3n
        /9WZeZB9KVcELOAC2CBcMhQHaW150zCVUiBztw==
X-Google-Smtp-Source: APXvYqwFNWuzIjHFIw4D1DrdoBULCXJ8PyRfbcXJhzZThgQrb2mqofhnB0oQTAt2TqFMwYk9GkYYmUHEYUt6vWHFEtA=
X-Received: by 2002:a25:3ce:: with SMTP id 197mr19217412ybd.255.1572373567370;
 Tue, 29 Oct 2019 11:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <1572314250-6463-1-git-send-email-wang.yi59@zte.com.cn>
In-Reply-To: <1572314250-6463-1-git-send-email-wang.yi59@zte.com.cn>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Oct 2019 13:25:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJiT5t1xsOR6LkCHQgQu=jSo_KCKxf78dhnzcNsxRj3=g@mail.gmail.com>
Message-ID: <CAL_JsqJiT5t1xsOR6LkCHQgQu=jSo_KCKxf78dhnzcNsxRj3=g@mail.gmail.com>
Subject: Re: [PATCH v4] drm/panfrost: fix -Wmissing-prototypes warnings
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     Steven Price <steven.price@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        xue.zhihong@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 8:55 PM Yi Wang <wang.yi59@zte.com.cn> wrote:
>
> We get these warnings when build kernel W=3D1:
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:35:6: warning: no previous pr=
ototype for =E2=80=98panfrost_perfcnt_clean_cache_done=E2=80=99 [-Wmissing-=
prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:40:6: warning: no previous pr=
ototype for =E2=80=98panfrost_perfcnt_sample_done=E2=80=99 [-Wmissing-proto=
types]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:190:5: warning: no previous p=
rototype for =E2=80=98panfrost_ioctl_perfcnt_enable=E2=80=99 [-Wmissing-pro=
totypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:218:5: warning: no previous p=
rototype for =E2=80=98panfrost_ioctl_perfcnt_dump=E2=80=99 [-Wmissing-proto=
types]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:250:6: warning: no previous p=
rototype for =E2=80=98panfrost_perfcnt_close=E2=80=99 [-Wmissing-prototypes=
]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:264:5: warning: no previous p=
rototype for =E2=80=98panfrost_perfcnt_init=E2=80=99 [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:320:6: warning: no previous p=
rototype for =E2=80=98panfrost_perfcnt_fini=E2=80=99 [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_mmu.c:227:6: warning: no previous proto=
type for =E2=80=98panfrost_mmu_flush_range=E2=80=99 [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_mmu.c:435:5: warning: no previous proto=
type for =E2=80=98panfrost_mmu_map_fault_addr=E2=80=99 [-Wmissing-prototype=
s]
>
> For file panfrost_mmu.c, make functions static to fix this.
> For file panfrost_perfcnt.c, include header file can fix this.
>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Steven Price <steven.price@arm.com>
> ---
>
> v4: make the parameters aligned.
>
> v3: using tab size of 8 other than 4.
>
> v2: align parameter line and modify comment. Thanks to Steve.
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c     | 9 +++++----
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 1 +
>  2 files changed, 6 insertions(+), 4 deletions(-)

v4 didn't seem to make it to the list yet (non-subscribers get
moderated) and I missed this. I applied v3 and fixed up the alignment.

Rob
