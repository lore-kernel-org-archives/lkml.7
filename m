Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3671C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9865021A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPpu0jmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437702AbfITICl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:02:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52265 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391092AbfITICk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568966559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=omv7+mbGxPVf+0lSkKX4kVmao62GbbYXILt4i5WxIAo=;
        b=cPpu0jmGxZ7lWifVnLxUatezDsGss6+EFGFXoA7lsSaZSsgGjKQZfHqER1u5BjU8crAd/5
        pk/dJ6TVdhersB1HtWk3QhGTLoRevK/DSsmnFqVVI5U7bkUTPOcLMK3YcstJyF8Uum1r+S
        4jcNn6Xm+h1ui+6I+5fD+1GH9T4hjng=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-IbOgUB2oMHO0_zx6xbCk3w-1; Fri, 20 Sep 2019 04:02:38 -0400
Received: by mail-ed1-f72.google.com with SMTP id c23so3673611edb.14
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y/OJqZHSGkyT8kFjd1lJtlh+ntUpVdhTuyPyBbh3g+w=;
        b=CyoPc1+6CMKxbCShWIheyxYiCa5Hn6GE4L8Rf1pxAzqullJSCqWQDW6wXY4wWSux4y
         gEv7a6GD/FoARuT66Lgz37ypoHJWLixLGuyIIDVTNm8kZrip4jyFpDCoGI3ssf+zqLuj
         GtRElHYA/2O0UEvuMzcKVtJJVr7L1oApqPrLGp9ykcZUoIpwXYA8VuewXBfCUa9WYplk
         9yTk60OJE4GDp4wc0k8VZbquE92ooB9cT40Xm/q7/RfxMsfzOOo8NSvhsOcnaelxglEH
         JwZs6r545loZVbnFv9iBJJ6Knsc1DHYb83raJyONCQ2rWFJXXDdHVhLTwryMgVs+9L9W
         xBow==
X-Gm-Message-State: APjAAAX1n8cdeZK5pBbdTwmAjs/a/ooJXolqbDFrkZt/dCS0isMqq0km
        Ui1Nh0SpmCjSMzsG3oL0vQq3IGi7y6jaK8TO8UMrV4s1hRLxn4my8Ly2NZx+2teyElLfFAoq0Or
        P24Iv8ITNmtm4K/Ct2giMs8H6
X-Received: by 2002:aa7:d718:: with SMTP id t24mr19310595edq.300.1568966556892;
        Fri, 20 Sep 2019 01:02:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWaaT9DrifLzV+dSh9GB8CGVoZ5eA0zf6DFmKbqgk48C0ZCbjACBj2Aw5MgUhmUfCQoK1VHg==
X-Received: by 2002:aa7:d718:: with SMTP id t24mr19310576edq.300.1568966556699;
        Fri, 20 Sep 2019 01:02:36 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a50sm192418eda.25.2019.09.20.01.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 01:02:35 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] tcpm: AMS and Collision Avoidance
To:     Kyle Tso <kyletso@google.com>, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, Adam.Thomson.Opensource@diasemi.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190920032437.242187-1-kyletso@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cb225c94-da97-1b47-48b6-3802dc3eb93b@redhat.com>
Date:   Fri, 20 Sep 2019 10:02:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190920032437.242187-1-kyletso@google.com>
Content-Language: en-US
X-MC-Unique: IbOgUB2oMHO0_zx6xbCk3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kyle,

On 20-09-2019 05:24, Kyle Tso wrote:
> *** BLURB HERE ***
>=20
> Kyle Tso (2):
>    usb: typec: tcpm: AMS and Collision Avoidance
>    usb: typec: tcpm: AMS for PD2.0

May I ask how and on which hardware you have tested this?

And specifically if you have tested this in combination with pwr-role swapp=
ing?

Regards,

Hans

