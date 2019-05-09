Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4ECC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59712085A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csRbYuV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfEIRyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:54:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34887 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfEIRyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:54:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id t87so1714126pfa.2;
        Thu, 09 May 2019 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPJnsmnbbtxrDZHRLqJxmq/pGvnzWodzxoeaAVrrx0w=;
        b=csRbYuV/YQoG/m+PWbg4GM2ZtJqNIUV1JifY7zPrpNQY6L65J49DjbipxYbSTdvFxA
         bY25ECdIsv4bwlI5FCFEqrBuj9JVQFhGCNdjZf0XAGLsxQzeifRXrwv/9KLzW0wO4RxY
         xS6AOzTlPRwOtj/11JTMhtd2h1owlF4aLdMROQCnZLvUQcx79HI4PhDHPNwrkT8iiSsu
         iR1STNen+iOJaGlvePjFIPQKJQ1C+rzEuXq+Kq9peARyZhn8oK74z3+NDJP39P6LKVkw
         3DY3++WOl6NFmXT1bfXq1VTScsts1uz+v7xEVOolsBO0IX4N7ZaoGRZ+D1WVfePOPVs+
         9SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPJnsmnbbtxrDZHRLqJxmq/pGvnzWodzxoeaAVrrx0w=;
        b=aRkQ5TIf/iJJ+7Y/YwN/lwMqVzpqSqcx2NataWUB0Ub1f0CsKEnXr+9Ot0Ncnv36Aq
         Y963ZhIiJO/wsotk5QRZRbbVkE+zSKITLAotvABREB0oBpPPoBw1arEuzfRwVt+TMAYr
         uV7LgB1lYn+FVXg3sysNj74qfC2iOTHXEiOxzAtRom6OlAwDjDqGWTnaj6xJPOr0S0Ky
         Gma4kcLz9oPMdLCynP1m8DU6tql95i+UTSv51bNqrH7X2zObiU//sb+F6qCceRjM6jrD
         iqTeZP4kYrBy73D8TT1JNLxGfFMSO4sYOgUi2B+r61izkYtBj6p4fQlYXU4FIy6bDW16
         EAHw==
X-Gm-Message-State: APjAAAWwWeQnMfv/k5r00rPZJ2MiL/+7EEXbEfdu55ADt3PRLl7qoz2m
        q3gQ7B20ujeCqzZ6lyKZcvpZSwYj9DXcxO8QMCA=
X-Google-Smtp-Source: APXvYqwi1wPIqbmZZ9yHN2HPLzSr760OaYUZkEDUjbE+SNIJqkqSVqtC/yTzd1bmML7aQj9bce4FOj2UjbfvcnTVTx4=
X-Received: by 2002:a63:8e4b:: with SMTP id k72mr7533301pge.428.1557424488139;
 Thu, 09 May 2019 10:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <7595c4f0-3dbb-2fe5-4daf-4b9a266f67d7@gmail.com> <CAHp75VdE7MBjyLj=9bS6oc5jc8+BC_hftWUJgZGG02iDd=saiQ@mail.gmail.com>
 <0d7f6a9e-d508-65ba-9646-39f1d1a42a13@gmail.com>
In-Reply-To: <0d7f6a9e-d508-65ba-9646-39f1d1a42a13@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 May 2019 20:54:36 +0300
Message-ID: <CAHp75VcgjF7uQAbdA74vivBaVvdto+1PXRX2_QZA=Gwu0BsAdA@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] platform/x86: asus-wmi: Enhance detection of
 thermal data
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 8:49 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
> On 08.05.19 15:58, Andy Shevchenko wrote:

> Yes, looking at this patch now I'd guess the refactoring there is really
> misguided as it adds a lot more code than it removes, will drop it
> completely and just add a new condition to the current check instead in
> next version:
> -               /* If value is zero, something is clearly wrong */
> -               if (!value)
> +               if (!value || value == 1)

Perhaps here makes sense to explicitly show value == 0.

-- 
With Best Regards,
Andy Shevchenko
