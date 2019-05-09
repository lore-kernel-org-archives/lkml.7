Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C52C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8215320675
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Z3AHiYe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEIGIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 02:08:51 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:39161 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfEIGIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 02:08:51 -0400
Received: by mail-qt1-f178.google.com with SMTP id y42so1221026qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 23:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTW3b11tOzQl45dBo/UpkA2mKZfeZ/ETko9FvJUDZg8=;
        b=Z3AHiYe/Pl8HFXLwAU81fKt6hr7uxvNZcJsRT8n8yH04WYHvnBA73F+qJ2mHArAEEM
         C9TFGs+k8WOFE4T4tBSCUZxEl1vReTcgGe8KZHHFbHl5loQrEQmORA8TdIOIhlTCJ+fB
         esrysFnXKsUvD3RJdetAikLtyzSTCzHjlwGkTSo1Y8kJp3ZUYxIoRyPP8aV8A3dXLqcZ
         g77NqK/AUNZ2YqkgOrDh/tcrulDGJTDAivxOdQpKVEWV3OIRRYcCR/keLVhrQm4trZt5
         lz5wRlNyWllIZz3rYq00crYyoytxt6NcmZ8wnIZAotqj4qr6nYeGv9KS77THk7snzbIo
         8Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTW3b11tOzQl45dBo/UpkA2mKZfeZ/ETko9FvJUDZg8=;
        b=q17fO2EkSJKRqZaOWI7t6iqYl9jwYCk/62ngkRm9zy6SrC30feSwDgOYqV7MLisOwT
         Hpe0rgWupT7L7bGarNblkF63aJP81Nk/STwWjk0XBjCN59KhUlWWeBTWq4tzfBSGTKb+
         3kzcZEnIv4+a31nhlo2WRBiDTkdZWezE+3YLZ/Kh/s22Fei0Syk5dz12C4q0zGbKuOIW
         CPlhW8R+Y71ixycgpPvsZhD+Pk+ymSXTYpZ99fnIy6WqRzDj+jigAR8nACPFQ/9tZZEY
         e+we0HCtaMkT2mHsfStzKiwWR6qlqE7f3GOZzLSyh/nwrgnY3idBrEzkyPcXDC359vdZ
         cwuw==
X-Gm-Message-State: APjAAAWgzA4tH3bpwbeUECWNHHUmgH1daZiw4IhFcKAjqcqyK2PUX/Jj
        5XjQl7lCLQ4Xt+WfUYZ5fG+ixUq+32Hf0lLTEfvz5g==
X-Google-Smtp-Source: APXvYqyCcUcHfEI7Sx75neiypn76eCAVOp3moRVUYPAOK57VhxZ7GdJtRNbBRTVi2B408l2xOwrBJpfdVPD2R8dpenU=
X-Received: by 2002:a0c:9899:: with SMTP id f25mr1962232qvd.82.1557382129895;
 Wed, 08 May 2019 23:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <d6ee51cc-eb0f-2bb9-fef9-f8b4bf849076@gmail.com> <CAHp75VfMXAyUpWTrEHnv1NcQcHch+RHehWYTjk6KMTbXbtppPg@mail.gmail.com>
In-Reply-To: <CAHp75VfMXAyUpWTrEHnv1NcQcHch+RHehWYTjk6KMTbXbtppPg@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 9 May 2019 14:08:38 +0800
Message-ID: <CAD8Lp46tCfi3ZCmmXZv3-ZDbon+6P8qC4GPR9Bt3uFFr=Sn4Cw@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] platform/x86: asus-wmi: Improve DSTS WMI method
 ID detection
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -#define ASUS_WMI_METHODID_DSTS         0x53544344 /* Device STatuS */
> > -#define ASUS_WMI_METHODID_DSTS2                0x53545344 /* Device STatuS #2*/
>
> > +#define ASUS_WMI_METHODID_DSTS         0x53544344 /* Device STatuS (DCTS) */
>
> It's not clear from the description what 'C' stands for.
> Is there any specification which describes the difference and actual
> abbreviations?

The (recent) spec I have here doesn't mention 0x53544344 (DCTS).
However the spec changelog does mention that EEEPC stuff was removed
from the spec a while ago.
The spec does mention 0x53545344 (DSTS), labelled as "Get device status".

For clarity I think the constants could be renamed as
ASUS_WMI_METHODID_DCTS and ASUS_WMI_METHODID_DSTS.

Daniel
