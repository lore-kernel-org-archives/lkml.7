Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2E7C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814382133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fR8RE84n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfEWHhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:37:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33419 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbfEWHhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:37:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id x132so3659403lfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 00:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cx8kg7WymCjtyRcPfqK4zjuEJ4lhy55B2Gkin5DJtFU=;
        b=fR8RE84n1odppI3p20OTG7XaGgUYqo6kXCldCRW8or5Z3hIBeoEMGNKMB5ZPtdNJk/
         mgByEQfAV30URjnhve0FLDZCf3VjYeJTLxrXOtpebu/WgWJa95xV6q/bzJIWfQu5kAM/
         lb+2YJRaFCyI9zlUIgxWbqOGBQ8GH9WL7wLHOn/TeVF16dYN8cUyFpGCJTNx4/m3BA6y
         WhJFolJShRdIpJ8lYYTZrjQzkt4A0fSuH6IOy7MSadTiKYexx/vuh+O5dw6MVcnvh0iX
         6FmVEvoLxExnr+FvKCG/9HFdK3pBLFR3kjTdxjnhyNRcvh8Flzh1gs9FGLySsBOjgh/R
         +vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cx8kg7WymCjtyRcPfqK4zjuEJ4lhy55B2Gkin5DJtFU=;
        b=iHbH+RfH9sZ19jN7bEaejXJytnqm84GJUqmNVCdvogYsK7Y1ri5T9a1ofumLv1i0wA
         ggVonfKt/mtIAKNQqJ5YUDgr5ONbm6NcNX34AvtzZoeHv01SelIZsIr3S8puxHk+aGkO
         lm1Mwq4khTch0Ng5B28gEJlZOhvT+CcCMzbKMI03ZIaLj2nMdu9KL51+bVpBPr7HST/Y
         iGdRHA18KaKGA2oc8/Kq76FB+9P+vZSLD6S0I7Gt0PyrXo74p4hPUDIyPougsOJ/sAoi
         Kbo9TlZJgMmWg7k76QO1ARKCEhhMAjVFIdA/oHIBahoobD+ZE/f5vtXbrViJVc4aTnOB
         2QHQ==
X-Gm-Message-State: APjAAAWXA+HgFl/o1who6u2q9MXWNN/ApP1WKasK4eDmTQwmyJu/J57I
        7nrTPNtteM/VHTDY4HH5KPqSY0ryP9wpqYvf86g88g==
X-Google-Smtp-Source: APXvYqyBRsqXPk9Dhzbeg2Oz3JZyzA3NjwECl9TBODwCZZrOK9/RFjOdjOlwiSIFYgEUEDYHs19a86bibzY+Aklnf3E=
X-Received: by 2002:ac2:5935:: with SMTP id v21mr4885287lfi.117.1558597053613;
 Thu, 23 May 2019 00:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190522152925.12419-1-benjamin.gaignard@st.com>
In-Reply-To: <20190522152925.12419-1-benjamin.gaignard@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 May 2019 09:37:22 +0200
Message-ID: <CACRpkdYOS0UrXPtJb0--4RW6QM_Xq8wb=9Gj5X9fk7JWCgpWfQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Allow pinctrl framework to create links
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin!

On Wed, May 22, 2019 at 5:29 PM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:

> Some pin controllers may need to ensure suspend/resume calls ordering between
> themselves and their clients.
> That is the case for STMFX (an I2C GPIO expender) which need to be suspended
> after all it clients to let them call pinctrl_pm_select_sleep_state() before
> perform it own suspend function. It is the same problem for resume but in
> reverse order.
>
> This series allow to let pinctrl core knows if a controller would like to
> create link between itself and it client by setting create_link to true.

I changed the name of the boolt to "link_consumers" and applied!

I will send patches for all other pin controllers that are I2C or other
slow bus based, as they will definately need this. Let's see what
happens!

Yours,
Linus Walleij
