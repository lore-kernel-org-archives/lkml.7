Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9656C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71CB20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izvtbYCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfJJXel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:34:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45834 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfJJXel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:34:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so5648695lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 16:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OzTCu5I04s+EnaAbwN6eYgKI0KQPTUphwOlhf37qoKM=;
        b=izvtbYCZRJQnH6TCdDLZC0uFGCK4uHtEx+/NINpDi8P3ng/wp/4lWDOs1Ho2AcBdel
         p44UhCtPD/wH3Ki3TQO2pdYGeWEvn9ZaAwZRqJavX9Lma5Ui52o+XaWM9V8LMugdQu3e
         uYGmbCd3fmn9g4FT7i9cWMQKZ6H9Gq4N6uYmpJoTg/pf40KsMGPFVThGECBAQrrokBKN
         UyMS54tT1I3yHtxknsQ5BAfgn3N61ZZWp+/HyY3tgubshEQ4/7keFfPTnNZh11e+BnMB
         uihu0MMw4yZRFuBcmQXMrRsTesF7+P1t0dzGpnhsTxkjyCS2Xi65uniSlNJ4WdvwTnzW
         yPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OzTCu5I04s+EnaAbwN6eYgKI0KQPTUphwOlhf37qoKM=;
        b=PO+Cxv3vymGVrn7zCfxRyUXVeGruAjWFNdd1o8APswlY7Uda/S18k3USqMTpnKXfaS
         pK+gHnxDyITq0LhQnsZlF9hv8FRZKG7dvKXzpIFKYq61e8V9FlugIXITyMj074k2D8Y2
         8hGhtPGeCt9RaZV65RPFsbRI0hqXiRo2sBBRoh+HSq7W366BFgJLdyR5MiQIlr9xMBdp
         83vd2X8nkML2PBBhrN5GgAyEW5wX3cw50w3/eLADT6oE85gm5DrWR0nH2brJrRJ5N3fm
         7a6jnaDbuGkQpaiASqDkqH/bt2pyUpmgeTxqoT/T08nCgdlVFczKjdpxkid54chiqq6F
         1oMA==
X-Gm-Message-State: APjAAAX1ovGqdi9KJJ7EQAUAtCslk/6eob0+iEqKN23h5SI4scp6Iki1
        J4eBg1NtCnJArn+kHz1N3aJt/xPz42KtY8a1WOqUaIHiZg==
X-Google-Smtp-Source: APXvYqy3SIYI31R+EmdX4s4IYa//aTqrlhyKysAJJuq8mJhKiFdjY7189S10bJX2gMIbWgAlvDqUgkSl4Q+4KdktoKk=
X-Received: by 2002:ac2:424c:: with SMTP id m12mr7351197lfl.140.1570750478898;
 Thu, 10 Oct 2019 16:34:38 -0700 (PDT)
MIME-Version: 1.0
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Fri, 11 Oct 2019 01:34:08 +0200
Message-ID: <CAEJqkgi-9_1D91GUm_MbS-=RRRwMZjqEYWhCCdk+STvc0PeYXw@mail.gmail.com>
Subject: [amdgpu] ASSERT()'s in write_i2c*retimer_setting() functions
To:     LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Zeyu Fan <Zeyu.Fan@amd.com>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've built recently a new box with a Ryzen3 2200G APU.

Each time I plug in an HDMI cable ( to a TV or Monitor ),
or boot with HDMI connected a lot ASSERT()'s from
write_i2c*retimer_setting() functions are triggered.

I see the same on a Laptop with a Ryzen7 3750H with
hybrid GPU configuration.

Besides the noise in dmesg and the delay on boot,
everything is working fine. I cannot find anything wrong
or broken.

Since the write errors seem to not be fatal, I think a friendly message
would help more instead of flooding the dmesg with dumps while
everything is working properly.

Why is ASSERT() used there?

I have a dmesg from the Ryzen3 box with drm.debug and a snipped
from the Laptop ( not near me right now ) uploaded there:

https://crazy.dev.frugalware.org/amdgpu/

Please let me know if you need more information,
If needed I can upload a dmesg from the Laptop with drm.debug too.


Best Regards,

Gabriel C
