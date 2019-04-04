Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB03AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10862147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfDDNg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:36:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39302 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDNg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:36:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id p20so2237138eds.6;
        Thu, 04 Apr 2019 06:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXssZY3v1mDadh889m+sS7yba0XGJcLVpOmuYv44Krg=;
        b=JLrAqlwxEvYmDA4STj3Q1b8XOrZQzyw3mQkcSdn/eiPYzhvYmJa6ftvq62HU3nsgku
         n7eCbzGgNAts0MwseMDnbcdnNkecPBdxL4+v2UyKb+MfOIYULqqXpixO3EsG7SjWQV+w
         OInYDYrBIh/kNqrDBD5KA/Vy2SbRFWBa0XsQscqDl/MExhBYViD6YNEYe+WWnbBZR/TN
         Oq9ginf5Z1kpatqmHdbXkJYBBKrf4SJzcSqpqqFZ9OU6WNBXlgNOQ0X0PFY1bIyZIjtH
         t/A/5+2rT8xeUnaYNlopRczVk0768yOJjTE1zpP5sCFzDCOMwhHzjsbLXVFQBg0g+JF4
         y1Kw==
X-Gm-Message-State: APjAAAV3NmTXj2JILZW9WPW6t8ZBs2yTNqQFPkMlTBxxvAh9VE8KnHkj
        5yzqXvI+7im0eneevXkhj7wLva7FTGc=
X-Google-Smtp-Source: APXvYqxSLkN4uB5l77rJkGNrOH0EZhr1lkk4gKUbC+c03nSLsTg36dALsTyFA6l1d5PQXbG7aSkPOg==
X-Received: by 2002:a50:a725:: with SMTP id h34mr3880908edc.201.1554385016571;
        Thu, 04 Apr 2019 06:36:56 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id x3sm2031120ejb.53.2019.04.04.06.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 06:36:55 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id h4so3845866wre.7;
        Thu, 04 Apr 2019 06:36:55 -0700 (PDT)
X-Received: by 2002:a5d:6646:: with SMTP id f6mr4042761wrw.68.1554385014871;
 Thu, 04 Apr 2019 06:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190402154514.11284-1-tiny.windzz@gmail.com> <20190402154514.11284-5-tiny.windzz@gmail.com>
 <7dc60dd9-3bbb-f215-4554-a0051c0cfbfd@linaro.org> <20190404110508.rbk3z5urndtiqbmq@flea>
In-Reply-To: <20190404110508.rbk3z5urndtiqbmq@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 4 Apr 2019 21:36:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v67mZU+iNG=_ROqanPT=u3ybV7i+EJ253TiXiNaH4Ky+Cg@mail.gmail.com>
Message-ID: <CAGb2v67mZU+iNG=_ROqanPT=u3ybV7i+EJ253TiXiNaH4Ky+Cg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] nvmem: sunxi-sid: add new reg_read func
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 7:05 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Apr 04, 2019 at 11:59:44AM +0100, Srinivas Kandagatla wrote:
> >
> >
> > On 02/04/2019 16:45, Yangtao Li wrote:
> > > Because there was an endianness issue. It seems that reg_read
> > > function which the nvmem the driver currently exposes is wrong.
> > > So add the new read function, the new function is used when the
> > > native_endian flag is set.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >
> > This patch and 5/5 does not apply cleanly on nvmem-next.
> > Also I would need an ack from Maxime to be able to apply it.
>
> Chen-Yu has mostly been taking care of this recently, so I'd like his
> feedback on this.

As you previously requested, my patches already switch everything
to native endianess. There's no need to differentiate between the
old and the new now. So this patch and the native_endian flag is
not needed.

ChenYu
