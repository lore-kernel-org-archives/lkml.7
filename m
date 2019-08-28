Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EF3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699152173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfH1Rer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:34:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51160 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1Rer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:34:47 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dan.streetman@canonical.com>)
        id 1i31qG-0004QB-SE
        for linux-kernel@vger.kernel.org; Wed, 28 Aug 2019 17:34:45 +0000
Received: by mail-io1-f70.google.com with SMTP id g23so446129ioh.22
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JDO/ZAWmDwqlIFQKgZ7irqNQBWEkXm9mnlvbokZ/EUI=;
        b=O4xuN2J1nqMa+5gNbVgnjExYuYye1u350+uzKT8wo76g4c4AAPVo0CB8HPa8XM1RZK
         JvGCHyA2Qs8yXH99xreXsEKvMPUcitugC6fcdwMju/kLU2aVMVP1SjeaUaCytRrKYiVq
         YTdNNPwV5iVmPlwTTUnr1EQsOTkXYYWz35SKR8buvBUZ5ntTXRrRSzm4dkilaS9q+Yjn
         gz0kkwJb2IKJ8pHg7SyRdZGRoGYDNI8JdKW+yJXHSl1CdXJ8ABGgssPwvvxs1IeaeeBd
         afQyJl0op8xd8oFkpa7CerrYSLwQOWu1VsGT9b27fH/ni/v+ij4hl+eNcPAtuttRkS+s
         nTow==
X-Gm-Message-State: APjAAAWRNjb+11fkDHwzQ68pTsSttURStKmpxRYLr4JoX9yBSps7E/eT
        /tQOnBIpjQZVK/C92PoaNjhxsoKbe/OoWMC/KbBBe0TDaGKNGsx9bYEIta97psHU0OHRzhbddPV
        igUBB3R0++n65pa3VJ7FQGRKmSbFxg+8FlGWaSTvEHk7Fql8wFflkzDL8Ug==
X-Received: by 2002:a5e:a80f:: with SMTP id c15mr2335635ioa.270.1567013683896;
        Wed, 28 Aug 2019 10:34:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwReRHDJzBqbcjCQ9ykmP4NTlw5EHtIzg+irqu6rpg7RNmmuhDExVR/uYQLTliuqctvbpgIOdsecvTgW7hQ7aY=
X-Received: by 2002:a5e:a80f:: with SMTP id c15mr2335603ioa.270.1567013683665;
 Wed, 28 Aug 2019 10:34:43 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Streetman <dan.streetman@canonical.com>
Date:   Wed, 28 Aug 2019 13:34:07 -0400
Message-ID: <CAOZ2QJOZStRYa=5fyod_AEJcJQw90_yX40dPYY3Dhvfso1e=RA@mail.gmail.com>
Subject: Follow up on hid2hci: Fix udev rules for linux-4.14+
To:     linux-bluetooth@vger.kernel.org, ville.syrjala@linux.intel.com
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Kay Sievers <kay.sievers@vrfy.org>,
        systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like this patch got lost at some point:
https://lore.kernel.org/patchwork/patch/902126/#1138115

but it seems to still be a problem and I'd like to pull it into Ubuntu:
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/1759836

Ville, did you ever follow up with a v2 for that patch and/or do you
know if it will be accepted soon?
