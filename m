Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F94C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1F420835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQuOuLPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfJFThd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 15:37:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54868 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725811AbfJFThd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570390651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=md1VGHpPCYWdmA8M50yw1vhe+847XkUmuOiHBgmLIBk=;
        b=eQuOuLPdhtfR4val2+J3soO9SXsseHyWGKjmjKkob+phu21fXvj7wgrzz/dCvUzGigjuVt
        HweQrwfx2967urj9p9KVTdmvafyQpiKII67WOTsVl4A6LjPRD1Oo0oHx7/RAKeRpgKFGnp
        RpivLO0dOUIKLjC30rpHP0xLJ3RYCus=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-tLM19sKPOhabdUsgvtlLZA-1; Sun, 06 Oct 2019 15:37:28 -0400
Received: by mail-ed1-f71.google.com with SMTP id n14so7622901edt.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 12:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/EUNnnB4iJj41YotY6xxIusdJj0QHQ51a1QG+BiD0qA=;
        b=Sf9rbIsQSZWj6hQR8VTzdI9BGrjXlMH4E3/OLJ4JTWS1x3gPQV0ZS1ZZcQLKI/iE9m
         0RE8MgOQkcA4r9g/BgPV0wJT1WlUhLfW3eaVQqaLaRC2neyni8zdog3OojEj7xKNvMWl
         uxt5wGvcGi3xCOqRJYkIdOCAflvcRuapSXCAhcjuDyoTarhRH0lIk1B9pa8PmHDGjbD9
         6KQbzTeo//LMaVRPe90tZieYTnrXEBeTpXswlhqH25dqbwLGJ+/ic6o6ZDv6y/6gO7+n
         a3nXK30P+2KHhkwDgro4ze+s6jebnn4bp4S4/p1Z5ReutxYhaAiI/LudrAAGDZf8ruFL
         wCnw==
X-Gm-Message-State: APjAAAW9fkhjsn8YJFERY90OC2rJNrSPB7PgUyJUhzh07zQZMdrf/bYN
        RWZxnoGVV2P+Omih7ca3ipeXWfalvlWeeJDFl/7Y21CN6sVeJipE4kOd6UfC/uKhGP/AA9b2Glp
        BnE0XLu6NfaMZ87HcERvSEQNa
X-Received: by 2002:a17:907:211c:: with SMTP id qn28mr21138447ejb.244.1570390647408;
        Sun, 06 Oct 2019 12:37:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyLjzrJHf2a5ybPPnLlBS2yLENsojjJhdYCI/4qIvlYhNM/K0rhakPMnSidWnf3Mn9TuLRChw==
X-Received: by 2002:a17:907:211c:: with SMTP id qn28mr21138428ejb.244.1570390647136;
        Sun, 06 Oct 2019 12:37:27 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id f6sm2848886edr.12.2019.10.06.12.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 12:37:26 -0700 (PDT)
Subject: Re: [PATCH 0/2] extcon: axp288: Move to swnodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20191001105138.73036-1-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b1691d61-313c-ad57-3ef4-2dc2dc8263a2@redhat.com>
Date:   Sun, 6 Oct 2019 21:37:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191001105138.73036-1-heikki.krogerus@linux.intel.com>
Content-Language: en-US
X-MC-Unique: tLM19sKPOhabdUsgvtlLZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01-10-2019 12:51, Heikki Krogerus wrote:
> Hi Hans,
>=20
> That AXP288 extcon driver is the last that uses build-in connection
> description. I'm replacing it with a code that finds the role mux
> software node instead.
>=20
> I'm proposing also here a little helper
> usb_role_switch_find_by_fwnode() that uses
> class_find_device_by_fwnode() to find the role switches.

I'm building a kernel with these patches to test them now
(on hw which uses the axp288 extcon code-paths with the role-sw)

No test results yet, but I did notice this will building:

   CC [M]  drivers/extcon/extcon-axp288.o
drivers/extcon/extcon-axp288.c: In function =E2=80=98axp288_extcon_find_rol=
e_sw=E2=80=99:
drivers/extcon/extcon-axp288.c:333:9: warning: assignment discards =E2=80=
=98const=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifier=
s]
   333 |  swnode =3D software_node_find_by_name(NULL, "intel-xhci-usb-sw");
       |         ^

Regards,

Hans

