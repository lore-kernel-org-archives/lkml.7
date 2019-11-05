Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7484BC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DB8217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572991788;
	bh=OkAzPBWAjAe+diVtWjb/mYuOGJLL+Yx2Cib7q7L6uYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hQzNDikLuS5Rh/V/CWK7TbWUes3nnlllCFmIfHa1PHUe8uqqh1hsDIzCyJslth5VU
	 xDyFOQDBEFXYxuD8pf0p0BAkMo+5TjrAnd68l4w2E6bdcaw1FM7zhz1vtvqk3nylaj
	 0u+uxPB5B0DbUij9Mf+Fe64RQJn2DREfhsFT0SNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfKEWJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:09:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44677 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbfKEWJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:09:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id s71so19065960oih.11;
        Tue, 05 Nov 2019 14:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkAzPBWAjAe+diVtWjb/mYuOGJLL+Yx2Cib7q7L6uYw=;
        b=qk0zMj4SybdQcDCRbZ4o93JfvlHr0TNkAqypFEY5xRUaI9kDk48T5dmIDaGlNt0Bpv
         Hz9fFzO6Wzof8y0yBR94D9m773qicjKHyzkgC8NbyuvY7YOdSVuIA1hkSg+KIsz2Sjr4
         KgeanYhl5hm22DlN5ATuG0sPOlg3H+/S8IWXhRGlrddfoEVIcplWZ3Afr9IW9rnnkAWr
         9kcyAvQUgkAONGNAjDnRwUjEmhhUiOeB3FIY185H6x0O7KHZLqrq/SlZ46Ifqzavznvk
         hvcUycYvRG+WqOAgPF2rd9AkbTW5aNZK3i7QJcOFQhBQ4A5tyKToG9TsNEHbgKV6awpk
         VFmw==
X-Gm-Message-State: APjAAAUWV0oEEk6qxecdQWCZ5QXJKY2QECAzB2A4nF2ecUqx7aO25tAG
        tCcWGOEZh1L30o95hemw6tc5K+7dxCUGNqTfYMw=
X-Google-Smtp-Source: APXvYqwuPh7ZhgfFBcsX7RC7HKVF4j3RKFOljgvBfkmpSwFWsVOKP3TQOWZ1doIiK2FwcQKSUOOEe2aEzQOvaWhDplM=
X-Received: by 2002:aca:c753:: with SMTP id x80mr1029051oif.115.1572991785760;
 Tue, 05 Nov 2019 14:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com> <20191030224304.GH57214@dtor-ws>
In-Reply-To: <20191030224304.GH57214@dtor-ws>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Nov 2019 23:09:34 +0100
Message-ID: <CAJZ5v0iihCMCc9xozdafrxjwH7cXYDMu_Vfx1snYfOEYTYRJVQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] software node: add support for reference properties
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:43 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Rafael,
>
> On Wed, Oct 23, 2019 at 01:02:18PM -0700, Dmitry Torokhov wrote:
> > These series implement "references" properties for software nodes as true
> > properties, instead of managing them completely separately.
> >
> > The first 10 patches are generic cleanups and consolidation and
> > unification of the existing code; patch #11 implements moving of small
> > properties inline when copying property entries; patch #12 implements
> > PROPERTY_ENTRY_REF() and friends; patch #13 converts the user of
> > references to the property syntax, and patch #14 removes the remains of
> > references as entities that are managed separately.
> >
> > Patch #15 adds unit tests to verify that the handling of property
> > entries is correct.
>
> Do you have any concerns with the series? I think Andy did all the
> reviewing that he could...

Yes, he did, and he is unconvinced.

I basically have no problems with patches [1-9/15], so I'm going to
queue them up for 5.5.

Patch [10/15] by itself is kind of pointless IMO, so it'll depend on
what happens to the rest.

Patch [11/15] kind of causes brows to rise, so let me reply to it directly.
