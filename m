Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDADEC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 15:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940342084C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 15:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvpnV0tJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfGTPWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 11:22:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39383 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfGTPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 11:22:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so21155043wmc.4;
        Sat, 20 Jul 2019 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kjz29uaXOViEkvbQC/EqeL5ZlYftQJTWsTVkUNrscrY=;
        b=lvpnV0tJbpJ+ncTDvyQ7KQnJODNiS5oUHZczyaB97uMibBAXQBQZQoQmKgFVy013lV
         tzA3kv4VaVy50YdjTn8P21iZ3L/Uv/cVzzBOAvOMIRU+PGNbIpfT4wunxavXrKjDtEkt
         XX5ehG0lkzQEj9HvdXxr/upsVxXn6K8ORqzxKaCicZzrtxcVSnlRQKFlyxDwqNIwHsX3
         kN2nOSFatkfCPYnrw5Lq0g5ySxfw6jW4hascxKjF856+WE5I1fuPPN/Ks7bBtWgrFjru
         LsTEDzrsSLHLYAjvV215a7TKnKv2FNCO5vMQsr79Er/E4dtOkW9VtnQjsNinMhG0AgMN
         5VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kjz29uaXOViEkvbQC/EqeL5ZlYftQJTWsTVkUNrscrY=;
        b=V9J01K+0Qx9CDO67JLRw7frXiVh65VMd0j27izsZ9OC0eGp7AvL9Y91sbtkXv6OmTP
         0RPOSxhYuiw+xQC7clr2DWeeqAE42UKtPZPYpS7GbmCZCfca1/XbiierC0lzRFwUKSs7
         LrDsxffEGt4GMwdo2Dme88rRVfYSbPNfHfDsJkTZLHFr6aE6zDYXg4aGRCFB2lumRdRB
         3QHyQn4Z/kc0YMUBMXMwBQgY6nakOMQyMPuO+ERVkKQiCdm/NKlp7nO6KUKbRDcM2moR
         FLuI3kyeRPsDC60mgc4epxqxao3xPNrfOtnyrhiohWUGxkxfHqjmjC13uKvBkSw2cVhs
         TZcg==
X-Gm-Message-State: APjAAAUJEh+jURIyCzwe+b7TO8clzqPVtDvKyNOWV7k1abpj/iohKhG7
        YFe0o/kU//gSRM630J6zENs=
X-Google-Smtp-Source: APXvYqyYEjxaca0tMLQl4BdoJaihJKiSKJ9PRi8eRULuuc3M9KWAKgnjOeo1UmEFAG6ufmXpHoGh6Q==
X-Received: by 2002:a1c:7fc3:: with SMTP id a186mr2125211wmd.151.1563636122435;
        Sat, 20 Jul 2019 08:22:02 -0700 (PDT)
Received: from lenovodario.localnet ([151.52.237.69])
        by smtp.gmail.com with ESMTPSA id y16sm68550429wrg.85.2019.07.20.08.22.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 20 Jul 2019 08:22:01 -0700 (PDT)
From:   Dario Messina <nanodario@gmail.com>
To:     Stefan Assmann <sassmann@kpanic.de>
Cc:     Alexander Kappner <agk@godking.net>, ibm-acpi@hmh.eng.br,
        dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Second Fan Support for Thinkpad P50
Date:   Sat, 20 Jul 2019 17:22:00 +0200
Message-ID: <5490267.oBufKZg01J@lenovodario>
In-Reply-To: <20180926143449.bnqliemloqw7fuyv@t530.fritz.box>
References: <1522693621-3124-1-git-send-email-agk@godking.net> <20180926143449.bnqliemloqw7fuyv@t530.fritz.box>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Thinkpad P51 (BIOS version: N1UET74W, EC version: N1UHT26W).
This patch works on my computer and I can read both fan speeds through sysfs 
interface.

On 2018-09-26 16:34:19 CEST, Stefan Assmann wrote:
> Is there a way to actually control the second fan? There's pwm1, but no
> pwm2. And pwm1 only affects fan1.

I have played with the driver code and I noticed that it is possible to 
control both fans independently (unlike what the "Fan subdriver" comment in 
the code says).
You can do that simply by calling fan_select_fan1 or fan_select_fan2, to 
select a fan to be controlled, before calling fan_set_level. All control 
parameters (disengaged, manual speeds, auto) are fully independent.

What is not smooth is reading back current control parameters from register 
0x2f (like fan_pwm1_show or fan_pwm1_enable_show actually do), because the EC 
ignores which fan is currently selected and it always returns the last written 
value.


Distinti Saluti/Best Regards,
Dario Messina


