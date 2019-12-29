Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69000C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 15:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4639C20748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 15:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfL2PEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 10:04:21 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:39295 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfL2PEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 10:04:21 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N5lvf-1jo3kv43Gl-017DMl; Sun, 29 Dec 2019 16:04:19 +0100
Received: by mail-qv1-f48.google.com with SMTP id f16so11620588qvi.4;
        Sun, 29 Dec 2019 07:04:18 -0800 (PST)
X-Gm-Message-State: APjAAAXbk/D7K8RJIe9OxqaLwBrHbfDIn4M6nq9xyfxloM7ajJXeYAns
        cXnZ0wr/qhF7rym/9CR71JpxYlTboCTDzhTmkPQ=
X-Google-Smtp-Source: APXvYqxUxXT/D/078XI1LlLrxyQBorTz/AC2zq3x4KHkyas9hkBnO2Xi0jo0J8feFrGnUFEBHkIL4pf/yjmbXdEHv6I=
X-Received: by 2002:a0c:e7c7:: with SMTP id c7mr48140669qvo.222.1577631857753;
 Sun, 29 Dec 2019 07:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20191229104325.10132-1-tiny.windzz@gmail.com> <CAMpxmJUggb7srWeLNzkcrb+L1THhP4DNH8nkkDaYDEs316ywDQ@mail.gmail.com>
 <CAEExFWt+8FL45kLMWc3odS4GsCRkskD1Z08q6UAF1sYx32Hf-w@mail.gmail.com>
In-Reply-To: <CAEExFWt+8FL45kLMWc3odS4GsCRkskD1Z08q6UAF1sYx32Hf-w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 29 Dec 2019 16:04:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a00nLxqb6ZYt9HswmFRGEXntjRdAfAW9vMnoH4CgSfcZQ@mail.gmail.com>
Message-ID: <CAK8P3a00nLxqb6ZYt9HswmFRGEXntjRdAfAW9vMnoH4CgSfcZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib: devres: provide devm_ioremap_resource_nocache()
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        saravanak@google.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Joe Perches <joe@perches.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tuowen Zhao <ztuowen@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1niLBfWCQdqfI3a4OaicmjCLZyEvRMc4GIw0ZKjj/nxFGrmjlBJ
 lShmrHbayYbiotUIW3mFPnMTQILO+NoQT9zFNefCYz3VDzb65N5FnklnwSXU9zKyRwFCKoj
 cDGYbD0Yg0wXVHsnWa5WNdlZtCUeEqQDwKdEPHN0ShQJJf2WaR1yYxXslw8a7N5qdE/OH6C
 CO7oDQHXRY6563EjxatXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EZhydo4IAP8=:6VxsjYcOzGi+EOA1BvwfZh
 N7GXCeoWTOeY+jeuU67EU6evr9qe2nj/KYu7XAZlTYBQZN9U0bfXKoJlNMf1UFsV00Y4D7g0c
 zc5wnZxNbMuIV8jAKO1jMGLMN+MuOMCBbQx5JpWW9kvJAhcDo8LywMSCPj/z9Fsl26TF4PG26
 uT67kk4TNksTspUNYL/bfAJkAmJUmjPBc6Fv94G5DfegV/usgAcuLy0F5GTg9SXegffCvvw5x
 JW+6VM1BxDV9sdmSgSPrnE8zxJDVAe9yzw1uARH5E3dVLO00f/swu2d8fryFoGdDF8nKglfWS
 5LipQsHKxlEBW83dBVTlyEgxGPT3YlvGWPX6gBL5bewdGBpMf6gjp4yDctvt8IEpxF2ZfbkLZ
 deyksHRNLcUexwLqPrGszGxXcr9NcAPe9ReQ/fmQ6oOlEGWQoYmJ5CCQD2L8R4H8iQ65I4cOR
 OtTn4AERVjMVdsDLGIUSf6pxfYJZrmsvSgu/igWp52pYcSckGqCz8/KgTM6lbbrtLajmFikms
 CK9gxrxMoylbzLOvmH13QMuex2GPmsCd/hUobrJNv7RofNHwLIG/t1nzucTw1uCPfpd/MCKMs
 8WMriZmR/FO8jmkmY5pq1J0HUKix3k/kw7vmwTLx0r/JjwfEmaUgxV3CFNzxSzX9wo/h8M7pZ
 yUkUibBSLUrv5cremUUPP+fwGHj4qe1c3iTG6MFQzpkiJ9i9IPR8Of8bW9KjLr4xr25xQlzS/
 ZW6yozsH3tbVKAw3o3E54VJ1MJFf2yaVXFNdu6710romkQEhEvof+uDiCXWV5tHIabyWL40C8
 o7iDGgXVYsTIrsKXC461hm85hcDYVUNE99LNKi+tzLAOnSxEMaQMi7iBsIs30YNJc8CdQqxS7
 rpjmMauV474AO16/57Nw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 3:36 PM Frank Lee <tiny.windzz@gmail.com> wrote:

> Thanks for pointing out!
> I have seen the use of ioremap_nocache in many architectures,
> so they are wrong and should be changed to ioremap?

Yes, those patches are already part of linux-next.

        Arnd
