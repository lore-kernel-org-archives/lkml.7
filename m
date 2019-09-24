Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F87FC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6DA2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SqZJFRdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfIXOhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:37:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37548 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfIXOhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:37:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id i16so1847135oie.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxikhnJw3/A8qG2RBGpOW3013hsAOeoimlnP/KHpEIg=;
        b=SqZJFRdQo0/6PIL4MUF93oy7PQW59fo5ROQzgfg3pCmjdOb2aL8PEwGcIoKb6bCBFV
         OosuCqx3i87aHWXqZCVNTC/9649tuoZzsoZylnq2rHOqJNswbILTdB+oAbS4jZMrMIRz
         ypRE8nn1pmQSMOwonLu/eakh+Rfg9ru2dCWu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxikhnJw3/A8qG2RBGpOW3013hsAOeoimlnP/KHpEIg=;
        b=MQrSedD1qUEmUwk5uxAh5QKa60bp3/SNbTEzor90u3W0b9wkJCVA3PD27b75uGxaL7
         UhoT2NQVGNdcEZIGomTWb3+z/7Kx+SEf3iBqabXD2bJNQb3XA2ibUB31zhlnjOGuDoOl
         6BN1i7KK4Q8VrAS2IWtI5qYC+I/ZAKbqbVNSsQln/txs3kp9mH4PiQq8j2JYKzY4IOYx
         JQchkpyhn7fsuZKAKRQIn6QUIp9IlaPMpCuIRxxrSNYQCATriHMstZ76SJFqbk+K4swA
         QQAlI9043R9wOJrR3HdEaHkQooy2XIimMZRPXlQaHEu2msx8kKRzqEB+2388TvIjNPKP
         3Lpg==
X-Gm-Message-State: APjAAAXjyV2MaOOcwRiXUwFETnhaIS5JVXI9KgPrDhx/ri4CKypc/DYu
        Mh3xHp+LlH7Q8Eic9tNJde+x+VmJw7g=
X-Google-Smtp-Source: APXvYqy+ql63Nd7wrr6bqtgTB1bhu/2kD/jKpQXFCGbmj9ZFYwcE804rz2kv0fbVzy0rL5oftJ7I7A==
X-Received: by 2002:aca:4794:: with SMTP id u142mr354468oia.49.1569335867104;
        Tue, 24 Sep 2019 07:37:47 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id m14sm577073otl.26.2019.09.24.07.37.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 07:37:46 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id x3so1855563oig.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 07:37:45 -0700 (PDT)
X-Received: by 2002:aca:d4cc:: with SMTP id l195mr310118oig.171.1569335865225;
 Tue, 24 Sep 2019 07:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190916181215.501-1-ncrews@chromium.org> <20190916181215.501-2-ncrews@chromium.org>
 <20190922202947.GA4421@bug> <20190922204353.GD3185@piout.net> <20190924075549.GA20990@amd>
In-Reply-To: <20190924075549.GA20990@amd>
From:   Nick Crews <ncrews@chromium.org>
Date:   Tue, 24 Sep 2019 08:37:33 -0600
X-Gmail-Original-Message-ID: <CAHX4x84c57ogKUyO5wpZOekPOrQyhJmX-v99Jkq0Xzv3f0A=uQ@mail.gmail.com>
Message-ID: <CAHX4x84c57ogKUyO5wpZOekPOrQyhJmX-v99Jkq0Xzv3f0A=uQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rtc: wilco-ec: Fix license to GPL from GPLv2
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Benson Leung <bleung@chromium.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 1:55 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Sun 2019-09-22 22:43:53, Alexandre Belloni wrote:
> > On 22/09/2019 22:29:48+0200, Pavel Machek wrote:
> > > On Mon 2019-09-16 12:12:17, Nick Crews wrote:
> > > > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > > > ---
> > > >  drivers/rtc/rtc-wilco-ec.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > > > index e84faa268caf..951268f5e690 100644
> > > > --- a/drivers/rtc/rtc-wilco-ec.c
> > > > +++ b/drivers/rtc/rtc-wilco-ec.c
> > > > @@ -184,5 +184,5 @@ module_platform_driver(wilco_ec_rtc_driver);
> > > >
> > > >  MODULE_ALIAS("platform:rtc-wilco-ec");
> > > >  MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> > > > -MODULE_LICENSE("GPL v2");
> > > > +MODULE_LICENSE("GPL");
> > > >  MODULE_DESCRIPTION("Wilco EC RTC driver");
> > >
> > > File spdx header says GPL-2.0, this change would make it inconsistent with that...
> >
> > Commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
> > bogosity") doesn't agree with you (but I was surprised too).
>
> Still don't get it. bf7fbeeae6db makes MODULE_LICENSE less useful, and
> declares "GPL" == "GPL v2" in MODULE_LICENSE. So.. this change is no
> longer wrong, it is just unneccessary...? Why do it? It is not a fix
> as a subject line says...

All new modules should have the plain "GPL", or at least that's what I
was told when I submitted a patch adding a "GPL v2" license. Therefore
I assumed that if the distinction was worthwhile there, I should try to make
existing code consistent too. Sounds fine to me to drop this though,
unless anyone else has strong opinions,

>
>                                                                 Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
