Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB91C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AA721897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CptOw0hF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfIRNH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:07:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45897 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfIRNH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:07:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id u12so447465pls.12;
        Wed, 18 Sep 2019 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8PF5nIJ+jYt7X/oj9VI26YgDuXnqnvQElnGgf6PKBKU=;
        b=CptOw0hFcRgsZzonPLlM5hp/DQ4fCfs36m+tm/qkQal+OHbaPwmbp0UGP0VGTdbS6/
         1N70hF12R5oe2JyYIMvPrK7nklhgd4gcrhjscYmIoGChtfShE9npcuFH0uPnU8a2BXv6
         04PQVNIb4x6PX8v0dAZty2bnJvy1+FgB5iXgMaunYBNmy4h3YrUUqbX/QZK13FRByd3g
         BoXIbTMCiBLu/CphQwShGqjTZxhqFrky8MOxO9mLTZ8u3pWgT2AAKBHmhZObNuzV+EuL
         YKut4pMBr+n2tLT46NUdVaZiPovMimUCiLPtyJS/sQ0YnjmC0w1xZOcmtpnetdKJjVxs
         qdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PF5nIJ+jYt7X/oj9VI26YgDuXnqnvQElnGgf6PKBKU=;
        b=M8wTMH+fEzRvgSSg7IvXKCyQk86JHTxx1RzOJO1E9wjwsaqmYGo3VIylmpLhV+75o6
         v9bTjMssrC/m/IGS3XK4RPr2a8hsy6I4o2YLkdioxqH21C999KEPLpieo3E4l+lnf86B
         0JEmHYn1gkpSrM0Kw/qDjh9CXXwGgfYc3FmRR7o63aZ017/oNaM+bUF5BbCEkN7m1D4C
         cAj97r87aQvIXtgR9NmyH/M8tbZg7TkNFEXMzTnL9SjWfZTm0sa3pW7LUMqTTB7O2JaN
         tpS6OL3EYjNcAuQZPYgjg8jBvJxxdi1RYgZU3UgGIz7jh04JXrhoMHoPoAPM8A2iFIw+
         7UqA==
X-Gm-Message-State: APjAAAVegng4HyAtiFzE6WMp8sDiu0yt1LZ6d3LEh/kYfe4YiTvYUi+0
        PmWh5XQozHwwIeqWiBbd654PyZ8mg73z+ElF0cw=
X-Google-Smtp-Source: APXvYqyHpOkH0A4Lg6RzofKUVA+U6jrBv3kh07YnVojlVqJxsaAVDPZmxzXots/ocDQKVAqG6Kvh8Nr+MMBw7hYu1Io=
X-Received: by 2002:a17:902:968f:: with SMTP id n15mr4216536plp.18.1568812046476;
 Wed, 18 Sep 2019 06:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190917194507.14771-1-jekhor@gmail.com> <20190917194507.14771-2-jekhor@gmail.com>
In-Reply-To: <20190917194507.14771-2-jekhor@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Sep 2019 16:07:15 +0300
Message-ID: <CAHp75Vc1puy01=Ki6EiJfZTGPtgkWiar9GhEb7EX0OF7CmNo7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 TypeB and TypeC variants
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 10:45 PM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>
> Existing intel_cht_int33fe ACPI pseudo-device driver assumes that
> hardware has TypeC connector and register related devices described as
> I2C connections in the _CRS resource.
>
> There is at least one hardware (Lenovo Yoga Book YB1-91L/F) with micro
> USB B connector exists. It has INT33FE device in the DSDT table but
> there are only two I2C connection described: PMIC and BQ27452 battery
> fuel gauge.
>
> Splitting existing INT33FE driver allow to maintain code for USB type B
> (AB) connector variant separately and make it simpler.
>
> Split driver to intel_cht_int33fe_common.c and
> intel_cht_int33fe_{typeb,typec}.c. Compile all this source to one .ko
> module to make user experience easier.

Before sending new version also check that you spell correctly
"Type-C" everywhere (except variable / function names).


-- 
With Best Regards,
Andy Shevchenko
