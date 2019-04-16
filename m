Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D53CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C593120868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axmPzitK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfDPP0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:26:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34698 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPP0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:26:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so10538103plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19GOTwtI97mJiAIP+RA+2iQqmxaYUc14FnV0g8ZO8xY=;
        b=axmPzitKE6Ccela9QCNqirAJUeUghwnXpNbxlztPx30GKcytnqWEgnExzi2DU+CDtU
         JnEJmddU69Lmr1XZGNyplAv5Q44TeuyL0/eXok6XaM0fqbbcrnCSU3/IDktSugs56iGC
         3r8dl/YSr4do+OueVqj4YP4T62aNlgjQIn4gcvk2I4GVi4XfmrSHy5hnZt7lMFsf8CUZ
         e91Tz2gBZGmgbmdf7/PUyJ6tzHS7w8yN0NWpWz7D9ap96W1LhT9Gbzmv/sK/g7YZVLtT
         9QbjmbkZC257M7f12VBGtgz7L0JBP+nVTzbY5PdacH3UmOz0VuoYI1rB6Kxg11r2AxP9
         GeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19GOTwtI97mJiAIP+RA+2iQqmxaYUc14FnV0g8ZO8xY=;
        b=Ly/5cHqmRCsEdw8sA6JsR+ihsLXvbANnsoDWv4nxXtvFXLWyUk5S1tPX1jT4w0por6
         HvMlYM1OPGY6k9qnaUCIExliPyJXERL77qJC4FeXTDRR9pARKiSKUO7VJI/NfCvZsJ6y
         0WKXd+ScUt4S/apx6xPi5xeWgZ83gVIrjVfUcQhQ5gjRJmgZ8bftbeYe5bZGq/xn85e/
         hG6Sz0XidpG4KfQcZIAVGcD4eJr6jYF3BGqr/E47FJe37cs24JOIWwwl//hYHoHZmB37
         lDukmNekpI8L5luG/69fFVd1m/VPCDdcKi/JbMoWCuWH9dwhexQJBHWTyG/egV7T4GE6
         5Aiw==
X-Gm-Message-State: APjAAAWTj+0G6nuCIBO/FzHVltzTkRdP2lkGr7L9eBZMpqt8SgbyslHV
        T8dD77WY3ASfRUHaADmG87k9n6f92DKYKQTqy5a3MQ==
X-Google-Smtp-Source: APXvYqxs0yGzU9//tKZLPqEHbdXmEoFQBz6Dc0eQq1ke68TGJmY9bLAlqdcmfhkBT7CNGihDA6wRtkHB5ZElaPHPpKg=
X-Received: by 2002:a17:902:778a:: with SMTP id o10mr71319085pll.135.1555428399668;
 Tue, 16 Apr 2019 08:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190416145257.101945-1-venture@google.com>
In-Reply-To: <20190416145257.101945-1-venture@google.com>
From:   Patrick Venture <venture@google.com>
Date:   Tue, 16 Apr 2019 08:26:28 -0700
Message-ID: <CAO=noty9DwJO9sU19C30zTAigkrOYbAhqjEFkxNv5+eZ1k7kQQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add vendor prefix for intersil
To:     Patrick Venture <venture@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     treding@nvidia.com, khilman@baylibre.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        heiko@sntech.de, martin.blumenstingl@googlemail.com,
        johan@kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 7:53 AM Patrick Venture <venture@google.com> wrote:
>
> Add vendor prefix for intersil, known as Intersil, a subsidiary of
> Renesas Electronic Corporation.
>
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 8162b0eb4b50..ffc69a8bedaf 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -191,6 +191,7 @@ innolux     Innolux Corporation
>  inside-secure  INSIDE Secure
>  intel  Intel Corporation
>  intercontrol   Inter Control Group
> +intersil       Intersil

I see there's already isil for this.  I'll update my device-tree
patches to use isil.

>  invensense     InvenSense Inc.
>  inversepath    Inverse Path
>  iom    Iomega Corporation
> --
> 2.21.0.392.gf8f6787159e-goog
>
