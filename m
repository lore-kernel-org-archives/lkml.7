Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02F8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CBD20679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b4EDArzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfJYTSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:18:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43031 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfJYTSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:18:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id b19so450314otq.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caqZS73ujV6Zdyymag8M26Wcqn5G2+KweE+j+HquELA=;
        b=b4EDArznp02keGtvfHllt+4DNwPB/wY2U4iXZgPoBpUBy8JsPeH4Qmg4aCBwc6NoZI
         ROfGAR3pXNQolhTlvEZNPiHhNH2bsdtOAfFz3jSVdFsDyUAJnt1KcP//X/ufZs+uHGQR
         mUz7uQkpYvQ7dgGjREk0laFRoO9N3Z+3on59o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caqZS73ujV6Zdyymag8M26Wcqn5G2+KweE+j+HquELA=;
        b=QOQlw33YQppnnoELT+dnluhs9Dcwao8OkYAdWvOb9rQk97FKKcz0jrRt+ba2oaSJGz
         NqQCEU525mLsan+FJI4h+wKB08QldqDUBjDCStiCnY/LYIU4IBkpXlLUiDSPf56awAJG
         QikjautzqA0/7rBM1S6dXnFB1PioNDnK2Vou9iAr0JXyOdloO+aONHHU39njSGPd6AZb
         dXwvy6F8lUam4uF1jLa5rRWYDKECJFKHY12kX7zqUHY/rqDKEdZhujQxJquh9ZjrdT5c
         1OYbP8NfX9fLrbwGGgfmChQ4IJ6xgJ8Ha+HNdWuM42WpQ07TDa18wY1hY85z4kLYa3TY
         yI4w==
X-Gm-Message-State: APjAAAVfQfbe3Y5QG4JHcQ6UJ2HV5lNDVwBtYy+0gIitjrM0HLziwwil
        r4FvKuHDpRrlgol2iIRBhwSX+IiWeI0=
X-Google-Smtp-Source: APXvYqxqZ8YOnsUWfVbdvHLNAfWAfubX3r+ec0SMzv6URuwvehZAuzLrLeANTnh0OVl4EfuwvgCcVQ==
X-Received: by 2002:a9d:6043:: with SMTP id v3mr3936833otj.6.1572031112168;
        Fri, 25 Oct 2019 12:18:32 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id n27sm980319otr.32.2019.10.25.12.18.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 12:18:31 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id b16so2783760otk.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:18:31 -0700 (PDT)
X-Received: by 2002:a05:6830:1147:: with SMTP id x7mr330026otq.349.1572031110654;
 Fri, 25 Oct 2019 12:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191024222805.183642-1-ncrews@chromium.org> <20191025173319.GA1768@chromium.org>
In-Reply-To: <20191025173319.GA1768@chromium.org>
From:   Nick Crews <ncrews@chromium.org>
Date:   Fri, 25 Oct 2019 13:18:18 -0600
X-Gmail-Original-Message-ID: <CAHX4x87jLHxZwvaU6nAX5VKy=LZutiRohE6rGd1GffJg-Pt0JA@mail.gmail.com>
Message-ID: <CAHX4x87jLHxZwvaU6nAX5VKy=LZutiRohE6rGd1GffJg-Pt0JA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] platform/chrome: wilco_ec: Add keyboard backlight
 LED support
To:     Daniel Campello <campello@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, groeck@chromium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:33 AM Daniel Campello <campello@chromium.org> wrote:
>
> LGTM.
> Reviewed-by: Daniel Campello <campello@chromium.

FYI I realized some of the imports in keyboard_leds.c are
unneeded, so I sent a v8 version that fixes this. I presume
you would LGTM that one too though.
