Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2253EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72A72175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nORqcTXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbfEXGHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 02:07:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40066 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbfEXGHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:07:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id h13so6160991lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 23:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6DjOHpSOGiAQtqaZSVvnSZsCuiDPmUFs7J2NpGe6Nc=;
        b=nORqcTXCVV9nc9SK2YQWhJtsGOqSZD23NIUbnDdDxpL15XGhtVHKX0MfppXOLJFBwy
         0P9t6kFlbch9f1PPUI4mIvX4hzRrC9Dzyv2b5wI6YlnmSDo7a85L2k8G0y53pUO7qSSP
         tDnpGi4l+ev/I4v9YrPZJl0QFph7+OXMB3vpNBL3yk5sqQq0XXMerZ9VOfmBlTRfQlSF
         m9TLcHtU7IlfR4AEnuVAPxAQRy8z3P2g+DEOpRbEYUSI/n560HdYHlZGnjVhariXnLkm
         Q94mMO8WE4VXjnf4x40hg+tSoxGlTX0XCVnP7/Q/gthDC0x3mKFiLxIkemuMlfWtETFK
         N5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6DjOHpSOGiAQtqaZSVvnSZsCuiDPmUFs7J2NpGe6Nc=;
        b=St0NfSuV0XPi3dNGPlHD0Z1Ex/F/RV+BfT72LPG6qfI9w+jt4GL4EZncAoPSdUmO1e
         eSgIkbEfY23absukVERaqYo4P2hhuPlUT+ZfvO9sFSaziEMTh8WAtj8JVWkPR1S7l3Gm
         chg61e5Cx4i2rWAMrrY6/8sgLf45cccKvTp5LVfELtGPJOmDDFl42RxyvOJ9+qvNzDUk
         oCgUyfk5GIq3H4rURgeny7Yh/jaIjIHbm9mm/UpJ3lSUmbIN8EiV5bjrPPa8yWr27pIR
         SNNqSsMrD05605lmVIXPb1XQx/4i3UPHtrpcmsfoWSJ96rko031VFWJe9HwhE5AZVxah
         GIhw==
X-Gm-Message-State: APjAAAUbL9WvT0rYlyVT4vpqcV6+hMM0MoJxRLy5WlPXlDyFopV/+aY4
        TYkoXH3MXc2As+WzoY5scURPvLuHUvovPJ+/BFQ=
X-Google-Smtp-Source: APXvYqzjKfLz2wX1S735wBgBbGn4bC1gYHoT+lCNShIJ/Ws8P6ej5al2rZKZOnlROIru0SbdWql4JpatiYfsATTOfd0=
X-Received: by 2002:a05:6512:508:: with SMTP id o8mr7037970lfb.119.1558678043701;
 Thu, 23 May 2019 23:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <1558366258-3808-1-git-send-email-jrdr.linux@gmail.com>
 <20190521085547.58e1650c@erd987> <CAFqt6zZA32QA-6VtaKcrEtq=qkoGLHpirSvXb5wt7-wd_-74hQ@mail.gmail.com>
 <CANiq72nd5i4ADU1GbEt1Dkhp-5YkC9ip-h4a0G64oN+b95wAXA@mail.gmail.com> <CANiq72=zCD7AAE-OBzDYm5GXenoF48SdzwO1LunWSfexqBuH7A@mail.gmail.com>
In-Reply-To: <CANiq72=zCD7AAE-OBzDYm5GXenoF48SdzwO1LunWSfexqBuH7A@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 24 May 2019 11:37:12 +0530
Message-ID: <CAFqt6zaUhPJYozmq-m_BjJTh5EUmsQoE4yZ+Ovv6F-ymns+JGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] auxdisplay/ht16k33.c: Convert to use vm_map_pages_zero()
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 9:52 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, May 23, 2019 at 2:58 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >



> > Taking a quick look now, by the way, why does vm_map_pages_zero() (and
> > __vm_map_pages() etc.) get a pointer to an array instead of a pointer
> > to the first element?

For this particular driver, one page is getting mapped into vma. But
there are other
places where a entire page array ( with more than one pages) mapped into
vma. That's the reason to pass pointer to an array and do rest of the operations
inside __vm_map_pages().

https://lkml.org/lkml/2019/3/18/1265

>
> Also, in __vm_map_pages(), semantically w.r.t. to the comment,
> shouldn't the first check test for equality too? (i.e. for vm_pgoff ==
> num)? (even if such case fails in the second test anyway).

Sorry, didn't get it. Do you mean there should be a separate check for
*vm_pgoff == num* ?


> Cheers,
> Miguel
