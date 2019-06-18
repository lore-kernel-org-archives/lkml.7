Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFF7C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BBE20679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUyn0HUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfFRHRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:17:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33985 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfFRHRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:17:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so5316851plt.1;
        Tue, 18 Jun 2019 00:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=6ls+i1u+lWJagjHM7534F8Uv5sC5LPRBjSxm2ecigcI=;
        b=WUyn0HUpRkDvaQuENXAK0PGnCB5TxeJa5MJFSJVY5qlfM2PUnK5Rh65Uup9Zxg+KlC
         Sd7mPCIvGKAePXHwuo+zAEW9XGDehg/1O3k+rWNlq4dsrDKDlTqcZ7Krh/T2g686FARo
         Y92y/YV8KouEjNRAqpL94FZuxw3zyVxYzezozpU8W826c6QXnef6F2C45Pvx/FX4i23d
         7wHDKsUcvU7W4QE2h3LvEKfROtqzhJB0WnLsRhzQn6x2sAR+arNrGkHwRn7UeY+dOm3r
         jWWxUQXsgdp9BpXZVBvrscdbNgS4iVXRHYv2mvojh4ZIfG8xhb+7MV44tCh8qitjES6f
         buoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=6ls+i1u+lWJagjHM7534F8Uv5sC5LPRBjSxm2ecigcI=;
        b=BjWqy5hwAU2Rh7ung8oxvWkXNhO+Dtfc5oY8XOp+tfyU6OydjjHbs1j/HsYjebCBZg
         cCvkHivt+Bc3RosICDP5FMrvd9Z+q1wUGZZnPIdfHJztptFD5UVEt07qPCQRwRA199NY
         +tLtCOxCpgKNTuNwjbBfKu33TaOadPdvM1Fka6333McHUoivGTcy6ESSxpMiExbJLtqq
         nAgD/OXkUNxtDapV1m0rfKzuozwc02bqZ1XAFIpCWGXIFx69A4d9U2jnO3doy4zackcr
         4htfFP5l9nAfo4JMIYaDdLHdDXej9O0FZfrm5fwOW+o52GT6EQAVonXCjXRlYcn1q7Ab
         nZXw==
X-Gm-Message-State: APjAAAVRnu+UMabGw3tS6C0Ngc3ydJO6Y+oNq9kQev8ryq3rQwU8CKFG
        GYekJQSFcgwi/ClIXSR8YOYrcpFE
X-Google-Smtp-Source: APXvYqyINnOm+mjTZ+CUFcz86nookJ6AW/68jaX/bNlGiAR7RzP3b1FIxJN6D1gmjwWmvIHE04lGQA==
X-Received: by 2002:a17:902:a504:: with SMTP id s4mr42724651plq.117.1560838363437;
        Mon, 17 Jun 2019 23:12:43 -0700 (PDT)
Received: from PSXP216MB0662.KORP216.PROD.OUTLOOK.COM ([40.100.44.181])
        by smtp.gmail.com with ESMTPSA id m96sm1195616pjb.1.2019.06.17.23.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 23:12:42 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Han Jingoo <jingoohan1@gmail.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] video: fbdev: s3c-fb: add COMPILE_TEST support
Thread-Topic: [PATCH] video: fbdev: s3c-fb: add COMPILE_TEST support
Thread-Index: AWIzNHA0y3vT+npVfJhuNQKkYC3mSWVjM2Fi4rm3H+w=
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 18 Jun 2019 06:12:27 +0000
Message-ID: <PSXP216MB0662B10864E4DDEC1EC1823CAAEA0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
References: <CGME20190614144634eucas1p1b04dcfcc040c3c886d2b33592c501d3b@eucas1p1.samsung.com>
 <e771b89b-0e38-a712-b635-8d53cbf95a8e@samsung.com>
In-Reply-To: <e771b89b-0e38-a712-b635-8d53cbf95a8e@samsung.com>
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

On 6/14/19, 11:46 PM, Bartlomiej Zolnierkiewicz wrote:
>=20
> Add COMPILE_TEST support to s3c-fb driver for better compile
> testing coverage.
>
> Cc: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/video/fbdev/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Index: b/drivers/video/fbdev/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1877,7 +1877,8 @@ config FB_TMIO_ACCELL
> =20
>  config FB_S3C
>  	tristate "Samsung S3C framebuffer support"
> -	depends on FB && (CPU_S3C2416 || ARCH_S3C64XX)
> +	depends on FB && HAVE_CLK && HAS_IOMEM
> +	depends on (CPU_S3C2416 || ARCH_S3C64XX) || COMPILE_TEST
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
