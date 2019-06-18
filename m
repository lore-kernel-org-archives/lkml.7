Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E732DC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAACC2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkcgKMLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfFRHUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:20:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43483 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFRHUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:20:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so7162382pgv.10;
        Tue, 18 Jun 2019 00:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=CslQ849M1Db5mIkFJ5eazlY+Ewel3BYfmjuNnmrj/MI=;
        b=JkcgKMLTMU+vFlyJCX1IAHOQVfTUgSvxB/uXYZ+Fzf8u5b18vf5TD943h7ewSaaXEV
         uoUShHPyNYhT627H/qDUtc0F3u096CARV5Bfu7Be5z+qGWwCac/+zExkU8+ZcW4nfTxm
         fbIpMHXog4vGxizzJPc3nV5Iy7Gby9gvD6qWQJwhsOk3awqCoF+tb7BAlaCTr8So6yRR
         9FlD/Ej7afPkPZEEjaerBLcR3sBoEdYSlU/e2w7uz0hs+FeLiMl/hfup9RXca/auwpOF
         mb1vkLl6ruUUFFP39/zhkFDtAq8yAL+FLgIAgsJ7jDZwpL+JCVoaNJD2AZUT4iiZGDNU
         aDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=CslQ849M1Db5mIkFJ5eazlY+Ewel3BYfmjuNnmrj/MI=;
        b=D7blKfpxFHs8EUh9sPFDwOydomoYN32C0GGbfOoFYdW8g0zPmgJIaA+cdMcPzQs91D
         mqd8j7E6FQCHPH3E0G/9ChsELRnpNNBcLmgNYglNsS2oSevXWUVCto2ruu26n6rpsh7O
         abEBDts1mAammtUbE3+8Lj1tMauaOr2yQhNc06HgEFEnV+vMIkRht+S1hqvNtJ+0Ghps
         HhfgVFZnVlzjHzQ9CyFAt1GVdL08XFtLFyS9YP2xeGPEALOcxKnJoeraYZJ7NstT9+xp
         IbGoyrpIUW9gkD3GsNW95rC+4yRCtha9sPMF1n/NoN5I4o+OFmClfMbEcbKV4L5Mje7d
         hMXw==
X-Gm-Message-State: APjAAAUugAANKgKKcHcIS/Rc3YGOw/Exc1nBAFZLK7nH3jwQ00Vw+44U
        6OjK8+gZzyPBSMF2Lup+1dGpFJqe
X-Google-Smtp-Source: APXvYqwnbdU5BnubJLJ+WVxXv1g0uES3n9SY7KAofvwe3MkKrQE7902pC5oMAwymmXxHNasC8jVJsQ==
X-Received: by 2002:aa7:9254:: with SMTP id 20mr1688580pfp.212.1560838420984;
        Mon, 17 Jun 2019 23:13:40 -0700 (PDT)
Received: from PSXP216MB0662.KORP216.PROD.OUTLOOK.COM ([40.100.44.181])
        by smtp.gmail.com with ESMTPSA id 196sm10334598pfy.167.2019.06.17.23.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 23:13:40 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH 1/3] video: fbdev: s3c-fb: return -ENOMEM on
 framebuffer_alloc() failure
Thread-Topic: [PATCH 1/3] video: fbdev: s3c-fb: return -ENOMEM on
 framebuffer_alloc() failure
Thread-Index: AWZkMnA0HIwkbu1fGnDQIvP1wx9CWGYwZDNj2lFR4qc=
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 18 Jun 2019 06:13:29 +0000
Message-ID: <PSXP216MB066270BD6566CA5CDCEB1C7AAAEA0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
References: <CGME20190614144735eucas1p2f71313b752ae4ea841ddd4ea502fd79f@eucas1p2.samsung.com>
 <bbf32fbc-b4bc-39fc-e8dd-db9f0cd0d83f@samsung.com>
In-Reply-To: <bbf32fbc-b4bc-39fc-e8dd-db9f0cd0d83f@samsung.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/19, 11:47 PM, Bartlomiej Zolnierkiewicz wrote:
>=20
> Fix error code from -ENOENT to -ENOMEM.
>
> Cc: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/video/fbdev/s3c-fb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: b/drivers/video/fbdev/s3c-fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/video/fbdev/s3c-fb.c
> +++ b/drivers/video/fbdev/s3c-fb.c
> @@ -1191,7 +1191,7 @@ static int s3c_fb_probe_win(struct s3c_f
>  				   palette_size * sizeof(u32), sfb->dev);
>  	if (!fbinfo) {
>  		dev_err(sfb->dev, "failed to allocate framebuffer\n");
> -		return -ENOENT;
> +		return -ENOMEM;
>  	}
> =20
>  	windata =3D sfb->pdata->win[win_no];
