Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5830EC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDAE205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="FEZMG5jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfEPIhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:37:13 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:52450 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfEPIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:37:13 -0400
Received: by mail-wm1-f41.google.com with SMTP id y3so2658243wmm.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X0zkQaio+t3Isoa+1OzyKr46ojREpowq03WuCew/y+o=;
        b=FEZMG5jokgF9IM3MW63+oH/owSHc9Mt7X0CRnpU2pQrFi2C9epmpieOJRTfULKW8s0
         1yEWzGF8PxCNCDcZIJv8ZcJDpWAYVe7gxLxMyku6POisarXUUXGoKtFteQLW3OFA5xjj
         vAk14fhTC6TniuPsQ1mJxrOZj89VvR0Ecnrn3LHm/SL6QwMZECtF9JMuq1rPzhJ/l1Rj
         YIYCSwuFdOWpqbDWX9tW23cCzlXh5HvaYL+s8iDAwcnvid8INbGQIRNfkNRUCnGkbGql
         E9+bG2syI737jg0HTlcqqduUo/+gtPZecsKZRufDJiK016wgQXfmDKlEP2eRoawi2F6U
         ihvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X0zkQaio+t3Isoa+1OzyKr46ojREpowq03WuCew/y+o=;
        b=ufckwhNILuwxNyQmz+IerB0A7QC4TkQGabzDHac4GMqQEj274tQ22yp7/6hCgtQ9Er
         +kOPlHBtDy2qxMl60cZrBdiAO2YIBdTlSmlD9+dG+DukYzIyCSaw92kH+jQ388/pZixL
         9REvvSLIwjA5UHwmSvj6rPlv4H2XrPGnTfLmlJTYloNsKYsugrQqIqt3NZwrTtKtTktE
         CPBo77Q3k51cEeInn0IGtge4YqFzaxmW8RxVVcF8W5+s2cL4Sy1UI3ZpDyFbtEkk6lbM
         bpxJ8D8uBY9XB3OEyhX4TTrQ4uQ78WrwPjECk9rcqe+VcALBvoeAJe07i846ObWkpFqm
         Ybcw==
X-Gm-Message-State: APjAAAV4V0tpOhfpnBsqwhfskNzDKXTYArUGrolgPzwv+dwJ3rKkaK/l
        HOMo+BKBgXYS57PmlCohfSr+NOOvE3Wd7HnCIM+HKg==
X-Google-Smtp-Source: APXvYqwF/2nWsGeagMYdw12EOcPA7geybvIqDdQIDsyNg9/UrIHWZzvOollMCLoIZ/RPJoJ3i9bQyYfjRnoOCEeVK/4=
X-Received: by 2002:a1c:a64e:: with SMTP id p75mr16072945wme.62.1557995831226;
 Thu, 16 May 2019 01:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190516075656.25880-1-yuehaibing@huawei.com>
In-Reply-To: <20190516075656.25880-1-yuehaibing@huawei.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 16 May 2019 16:36:59 +0800
Message-ID: <CAFRkauCSzkuNUugsfGY8jvcy-2hd-LfkuerJi56V3OM6oHu3yw@mail.gmail.com>
Subject: Re: [PATCH] spi: bitbang: Fix NULL pointer dereference in spi_unregister_master
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Alban Bedel <albeu@free.fr>, lorenzo.bianconi@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> =E6=96=BC 2019=E5=B9=B45=E6=9C=8816=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=883:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> If spi_register_master fails in spi_bitbang_start
> because device_add failure, We should return the
> error code other than 0, otherwise calling
> spi_bitbang_stop may trigger NULL pointer dereference
> like this:

Reviewed-by: Axel Lin <axel.lin@ingics.com>
