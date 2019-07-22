Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5767DC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2391F21901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK+PLUAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfGVTN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:13:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42937 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfGVTN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:13:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so25569131wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=434H4w2+Nc+kEvi+FXRoSbJrlL9XWqOVbmsm61hLvOU=;
        b=iK+PLUANCjf7nhzt+C7nG2htF6gqN4UMXytrLLB3BaNc2rQne0KGhKIf0/AnhNcu67
         5wBj7Wj8CQ/RSCndovwslHymPnaSL+Q4tjB8MGj8MWtH5AIIHm+RUh5D5OclufGLP5Vl
         0OueW8tkYjc1o8S3Z6+P9O5pUdSDgM06jhn85BxinPyfIAVT1YZLJ5mcW2FEYLYSDWL3
         JupiJ30v68TFCSzCnzE5y0mOVCBxcf7/oF1L5VNOy2o9Qvv+qAvjxRKRS4fB5seCZVMm
         s7FJv2sF/10Ba5HvffYgZ+l+swvZzGWKb1oBYkRazd+P2GTrrQbNJWGFkZPTH4L3QUtV
         MBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=434H4w2+Nc+kEvi+FXRoSbJrlL9XWqOVbmsm61hLvOU=;
        b=YwnDoXgeKg6E76U7zhk0QlVtbEhDX+uYC6Kk7PQZAaj2H0tF0Pf/31x7ecyewzaumg
         Nh9Smz3nx8HsXk8srWgDkl90xRq090T3Ak44TTs3AuE9vpBFaX+TDBNXzSXXD71HdrhY
         elmRZaT+oFjZ1ii03vxJ0lcRUDgI8uRXRa/CrLIuOCqabk5tQTn2i1WCJppRFE7b02pD
         WO2Q1H81yxGJUcEBcWTwKJ+a1VvaL9Sw8RJl3kt1Vm5qfqr5ENAUaXFd1qYJf5l7M7M9
         YIlbATN5Tp6eXdeNKDXNOZ3IQXBduLV98L/HzEzBDN3cNk6S/iasgd31Kcca3B9axXXu
         mU4w==
X-Gm-Message-State: APjAAAW10MhNoMPW6bdARMh+dnOGMq/sajlrVA4SzA525Lpk4vRo4ojr
        MNpC322I8llVmjWeU27S55bVmf9BHlC93hu1vGE=
X-Google-Smtp-Source: APXvYqxbCO8wLN0AyatMM8pt/BozR167LVRFbBFFFVOYWBSVlXBfDeCcG+ACzuNYEPgiMaAcFOp8+mUNJmw4xZAPnyM=
X-Received: by 2002:adf:a299:: with SMTP id s25mr68665075wra.74.1563822835637;
 Mon, 22 Jul 2019 12:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190722174716.GA17037@embeddedor> <7769041f-f321-1e99-a94f-52bdb7c016b5@amd.com>
In-Reply-To: <7769041f-f321-1e99-a94f-52bdb7c016b5@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 Jul 2019 15:13:44 -0400
Message-ID: <CADnq5_MqhTXyuAf-UubM7Ht7Ta56+_VmecWg1L2=5mhhox1Otg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Avoid fall-through warning
To:     "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Cox, Philip" <Philip.Cox@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jul 22, 2019 at 2:14 PM Liu, Shaoyun <Shaoyun.Liu@amd.com> wrote:
>
> Reviewed-by:  shaoyunl <shaoyun.liu@amd.com>
>
> On 2019-07-22 1:47 p.m., Gustavo A. R. Silva wrote:
> > In preparation to enabling -Wimplicit-fallthrough, this patch silences
> > the following warning:
> >
> > drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_mqd_manager_v10.c: In function=
 =E2=80=98mqd_manager_init_v10=E2=80=99:
> > ./include/linux/dynamic_debug.h:122:52: warning: this statement may fal=
l through [-Wimplicit-fallthrough=3D]
> >   #define __dynamic_func_call(id, fmt, func, ...) do { \
> >                                                      ^
> > ./include/linux/dynamic_debug.h:143:2: note: in expansion of macro =E2=
=80=98__dynamic_func_call=E2=80=99
> >    __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
> >    ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/dynamic_debug.h:153:2: note: in expansion of macro =E2=
=80=98_dynamic_func_call=E2=80=99
> >    _dynamic_func_call(fmt, __dynamic_pr_debug,  \
> >    ^~~~~~~~~~~~~~~~~~
> > ./include/linux/printk.h:336:2: note: in expansion of macro =E2=80=98dy=
namic_pr_debug=E2=80=99
> >    dynamic_pr_debug(fmt, ##__VA_ARGS__)
> >    ^~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_mqd_manager_v10.c:432:3: note:=
 in expansion of macro =E2=80=98pr_debug=E2=80=99
> >     pr_debug("%s@%i\n", __func__, __LINE__);
> >     ^~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_mqd_manager_v10.c:433:2: note:=
 here
> >    case KFD_MQD_TYPE_COMPUTE:
> >    ^~~~
> >
> > by removing the call to pr_debug() in KFD_MQD_TYPE_CP:
> >
> > "The mqd init for CP and COMPUTE will have the same  routine." [1]
> >
> > This bug was found thanks to the ongoing efforts to enable
> > -Wimplicit-fallthrough.
> >
> > [1] https://lore.kernel.org/lkml/c735a1cc-a545-50fb-44e7-c0ad93ee8ee7@a=
md.com/
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> > index 4f8a6ffc5775..9cd3eb2d90bd 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> > @@ -429,7 +429,6 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_M=
QD_TYPE type,
> >
> >       switch (type) {
> >       case KFD_MQD_TYPE_CP:
> > -             pr_debug("%s@%i\n", __func__, __LINE__);
> >       case KFD_MQD_TYPE_COMPUTE:
> >               pr_debug("%s@%i\n", __func__, __LINE__);
> >               mqd->allocate_mqd =3D allocate_mqd;
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
