Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91338C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7CE206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPeN0FFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbfDQSx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:53:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44390 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733258AbfDQSxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:53:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so12499668pfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eP1rGFUQ98ZaT6S3HWtFbgX9hsCc2QUVRpYbQREl3dI=;
        b=VPeN0FFVgq5c2dHmQMyLNDeQXl6ogjEf5aYsUjSBNOhm46k7IxQ274LLIFrylDxp0M
         nY8MJtWwoVsI068/17AvV3Q4/xRr0e/W9znRA7HujBbHoKN8okNWc+qtuYtJ7iGnLdq+
         Ddue5hsZdHLOF56hYGnrT3CsfeAWuUsNEeHIoX/t4+3Bc/caxcsaHBm4wsZrXGuJEqM4
         hQHLg4OAEBj1MHmPvPF7fnOgA6XYJV0MVnMuow9QCx9tKuvP6JGtjMfnbjQFwobgMeXV
         OU+0aPmWXgNu90cEqWClGPv+TiXXR+6weuNfUOmEEsMaff/uRlfIbowtMMbjCOsc/xAw
         SZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eP1rGFUQ98ZaT6S3HWtFbgX9hsCc2QUVRpYbQREl3dI=;
        b=pZRyCBphKO2OysvFODZyKt/HhwrbD3L/IzLjLDCbpole4pyzASe23iuKAeZp0xcV9K
         hbZDJ0THidjBnel5fFAH8MT6CCqtWNPEdYtGA7QNoBZ3MGWeKHRRtP6KhTfmAX3MxaOT
         GuLmmoItZa9/TdUBpdSUKSesuh6nhJQu5yj1tcPft5jYlDG+uCfiXt37+v8hPSlyC8lK
         w9R0GLFYfF0zvgqwCLZ/BkA6rGc38wayco9Hiak2u8sdXi4AkEqfJMEjdSicINf8mnKo
         QyD3KwvQk/piXKkD3e+ooxnNJ7B/OzdXJpMehHO6Ifan9VLnKufaiyhfmhwsu4vcvnve
         ntiA==
X-Gm-Message-State: APjAAAXaZXhxMuzwcddklc+vWZuK4DSz7bZU01zJM0XQiTHJs5INZTmb
        e+Di+jPFcNjj+KIZfh7dzZw=
X-Google-Smtp-Source: APXvYqw5ojFX+sq6xQRQN7ukkKCbD3PNNSYLKx5NEmsAU7U7OUKEcKcu7DhHeM5QNilkxDslOA0BfQ==
X-Received: by 2002:a63:1a1b:: with SMTP id a27mr83218728pga.59.1555527231012;
        Wed, 17 Apr 2019 11:53:51 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id h16sm42451154pgj.85.2019.04.17.11.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:53:50 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <code@mmayer.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] memory: brcmstb: dpfe: remove unused code and fix formatting
Date:   Wed, 17 Apr 2019 11:53:43 -0700
Message-Id: <20190417185343.910-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402230103.25491-2-code@mmayer.net>
References: <20190402230103.25491-1-code@mmayer.net> <20190402230103.25491-2-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Apr 2019 16:00:58 -0700, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Remove an unused struct and fix source code formatting in a few areas.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/next, thanks!
--
Florian
