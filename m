Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5911C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FA921537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6LPSm3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfFNLgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:36:07 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:39458 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfFNLgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:36:06 -0400
Received: by mail-qt1-f182.google.com with SMTP id i34so2007631qta.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iYWTfHNOGy0zCm7qjiECEcfyYn0UNGZv0fcAcGdSdgg=;
        b=o6LPSm3YPDMrL/3E2NtKGfuENLZmMWBdAt0M2fXDRjTnM/hpNZZD+gQx4nuzZRErRi
         OOXafc/BXwn0ssoqtMNrRgteXvsZ9xAn9QCgJjykO7RCluQFxU248dF6f0gsXfVgDHhP
         trxyZq65xhrp0csV+D/zOKyYqleu7RIq0madxSfNVQW1qIL/UK4qUV1OFM0dwJf4YXvR
         bI5jwS6oaZJ3+a3+myzITXwleNevb9W5SCrLkZM05SU8z3xCk3LixFOIvODGbEXUMe0Y
         Hbl5Q0UCcaVzqBAHmIEpHRa57mo6U0i5aO1uDLd2NJTI9uLJ1jQ8pufjjrNYqf7PyLNr
         KWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iYWTfHNOGy0zCm7qjiECEcfyYn0UNGZv0fcAcGdSdgg=;
        b=sP+H4DDqiqG7FS1tJ7l452Vq210TfJaUIx6UmehKIsm+UIvne7Lum5v7wuqaIktBGj
         6BVyeW5QEY5Sdr9sadlYQQXYJr9c2D1zSwgXb4c0hpkicgIc4Bhj14t3OoiJtMBjhtTP
         Tq4Xzh6ZI0MT8u9CKHmT2nOztzgvAjwoASSPY5C2RCfFr7nNsolWgHWlSVlyLjoVPS11
         vgVCNT8pQ6ev/SLrIDPAKtPOEOpqG93EXnhSyKLYW7SMRgcERyHrOmgczaabtkpeJ9Mb
         Ib5lYmKb7n1bb6hU1U0Gu335Q8KSaELWAVBC1/gRKQ7sRGp3A5W35UQdWjC+JbndoPZ+
         LT6g==
X-Gm-Message-State: APjAAAUWM/8dCJPXIzwr0hYnh6o2I+UszbvKfNU9NKlRSEgxzuh1fO8i
        9PXN9bexl6EiZ7K0WWOaAAoH6ZiDo3XjdaujCyc=
X-Google-Smtp-Source: APXvYqw4LNT9mOOlCh6RRAJMYCnVol0xQsRuD2GZQqReLTW7gc+Qtdxocgbn/MDYypq5T/Qb1tgZsEIDbXySavtO6ts=
X-Received: by 2002:a05:6214:2b0:: with SMTP id m16mr7805135qvv.23.1560512165862;
 Fri, 14 Jun 2019 04:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190614100928.9791-1-hch@lst.de>
In-Reply-To: <20190614100928.9791-1-hch@lst.de>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 14 Jun 2019 19:35:29 +0800
Message-ID: <CAEbi=3dnZNfMeLeuf9Y-d0HxTe_v1F_45Tb_TZwaat_LJq66SQ@mail.gmail.com>
Subject: Re: [RFC] switch nds32 to use the generic remapping DMA allocator
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> =E6=96=BC 2019=E5=B9=B46=E6=9C=8814=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:09=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Greentime and Vicent,
>
> can you take a look at the (untested) patch below?  It converts nds32
> to use the generic remapping DMA allocator, which is also used by
> arm64 and csky.

Hi Christoph,

It looks good to me. I just verified in nds32 platform and it works fine.
Should I put it in my next-tree or you will pick it up in your tree? :)

Tested-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Greentime Hu <greentime@andestech.com>
