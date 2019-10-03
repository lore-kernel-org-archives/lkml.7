Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D705C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F1721A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nv81P6T6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfJCJrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:47:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59062 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729088AbfJCJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570096040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Slr5vJy6mbyz1qs6FInoT5bsgy6V9VipGUl+FsYhiIY=;
        b=Nv81P6T6FYn9cQ/lhjI9K31MxqrWVviIHBbPAUvw0twpKu5FGeiRqXXaFm3lUiVxRAcgtP
        1/JELNkuaNlWL9AIsSPPihcBoWoB8bWfu7h3AG/VYV/cwX3S0DtIVe05dns0tzpJkK5v46
        zfSkYiSlkbwfPl5rS2MIjftuvv4OI60=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-sIxN4bZfMmC4OpMCYuVNgA-1; Thu, 03 Oct 2019 05:47:19 -0400
Received: by mail-ed1-f72.google.com with SMTP id j8so1263330edl.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 02:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5u7AYILS1XoHJtXlAmd4z9JODYl7wd80zKyrfd1Qcsk=;
        b=sbVe+95S3PYULlZlwHnGivmkrfoheNjEkfvc4mTkPB/78gNcEtF7gmCdWyqPdKSGF7
         Q5JhM+vjjqDmIvgVihKAht1G4d+s270B82sXIUd68e5Va2yNnkjtuT7eoIpXKzixPTzQ
         wjccshJfUpYb2WCnMeU7p5xtE0ESNnpxef/Idlxxhf13eoAW/JrH3H1z+/iCLa02Wu9b
         Nq9TS0Uo7TxNWhMCrotDtRlz6d++y3Sh1JG+7oHsyMRFPaJnQZnN/WySgCZgTLojPVoH
         +0y1+JYqfKn5ofDfmnOhOZK+E0rTCmkrv04V82TnQamSPQHJhvV3ZfQjvNlrn2lRCZal
         +y9w==
X-Gm-Message-State: APjAAAXjyrLXcbfcG2d4v25z53spCdYmal09cRI+oGjjFW/Qf5n28SLA
        r/Hf+IAEqHfb+JE/LoSKKVHe7YdtdfcJFXAn2Dch7kYOPj6YEyjntRMBxxuDg2h9dzHqDt7Y1/l
        nxalTLPie1JhYfHnvEXs+S6aY
X-Received: by 2002:a17:906:d04f:: with SMTP id bo15mr7072171ejb.296.1570096037499;
        Thu, 03 Oct 2019 02:47:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5TM/uO//Q6CLjKMwfsNTO7vdU4B0OhTH/gHaatMNw6g6IwUxAmkhGvfOv8PJ7Si/jqoeBmw==
X-Received: by 2002:a17:906:d04f:: with SMTP id bo15mr7072161ejb.296.1570096037244;
        Thu, 03 Oct 2019 02:47:17 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id 30sm371562edr.78.2019.10.03.02.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 02:47:16 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] tcpm: AMS and Collision Avoidance
To:     Kyle Tso <kyletso@google.com>, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, Adam.Thomson.Opensource@diasemi.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190920032437.242187-1-kyletso@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bd03390e-35fb-2885-d026-b8df58f02283@redhat.com>
Date:   Thu, 3 Oct 2019 11:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190920032437.242187-1-kyletso@google.com>
Content-Language: en-US
X-MC-Unique: sIxN4bZfMmC4OpMCYuVNgA-1
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

I've finally gotten a chance to test this on one of my own devices
which uses the tcpm framework for its Type-c port.

I am afraid that this series breaks DP altmode support,
specifically, the dp_altmode_configure() function no longer
seems to get called, leading to no pin-assignment being
selected by default and DP thus not working.

So sorry, but I have to NACK this series since it causes
regressions.

It might be easiest if you can get yourself some hardware
which supports DP altmode and uses the fusb302 Type-C
controller (which unlike your controller is actually
supported by the mainline kernel).

2 devices which have this are the original (version 1)
of the GPD win and the GPD pocket. Since the version
is not always clearly marked, make sure you get one which
has a X7-Z8750 CPU, those are the version 1 models, you
can still get these e.g. here:

https://www.geekbuying.com/item/GPD-Pocket-7-Inch-Tablet-PC-Intel-Atom-X7-Z=
8750-8GB-128GB-375711.html
https://www.geekbuying.com/item/GPD-Win-Intel-Z8750-Windows-10-4GB-64GB-Gam=
epad-Tablet-PC---Black-378018.html

These 2 devices still need 2 minor patches to hookup the DP
support, I have just finished these 2 patches up and I'm
submitting them upstream today, I will Cc you on these.

If you combine these with one of the many DP-charging pass-through
+ USB-3 out + HDMI out dongles, e.g.:
https://www.aliexpress.com/item/32953320909.html

And then after plugging in do:

cat /sys/class/typec/port0-partner/port0-partner.0/displayport/pin_assignme=
nt

This should print:

C [D]

But when I add your patches into the mix it prints just:

C D

And these debug pr_err calls never happen:

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/a=
ltmodes/displayport.c
index 7845df030b72..d14f94078dd9 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -106,6 +106,7 @@ static int dp_altmode_configure(struct dp_altmode *dp, =
u8 con)
  =09=09break;
  =09}

+=09pr_err("dp_altmode_configure pin_assign %08x conf %08x\n", pin_assign, =
DP_CONF_GET_PIN_ASSIGN(dp->data.conf));
  =09/* Determining the initial pin assignment. */
  =09if (!DP_CONF_GET_PIN_ASSIGN(dp->data.conf)) {
  =09=09/* Is USB together with DP preferred */
@@ -115,6 +116,8 @@ static int dp_altmode_configure(struct dp_altmode *dp, =
u8 con)
  =09=09else if (pin_assign & DP_PIN_ASSIGN_DP_ONLY_MASK)
  =09=09=09pin_assign &=3D DP_PIN_ASSIGN_DP_ONLY_MASK;

+=09=09pr_err("dp_altmode_configure masked pin_assign %08x\n", pin_assign);
+
  =09=09if (!pin_assign)
  =09=09=09return -EINVAL;


Regards,

Hans

