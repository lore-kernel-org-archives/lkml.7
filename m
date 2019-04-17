Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FE1C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227D3206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxgGPNHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbfDQSyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:54:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34185 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDQSyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:54:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so12530799pfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qsjzJkqdlnv6TqmYbTZ/k4ggvnYzrdp3XDw3Tms4H2w=;
        b=dxgGPNHzhwBm/Ikuq4E3ZSKt4+GJq8LRVVavLq/wRn71w2YV/y6Zu4ZqHWVS+zlrqB
         Ax4umOGAvOweQi1ckRT3NEqEdsVYH9FhkQ/DtDq+iETqXY9hFOyzln0JI77i4fIA3sUT
         YdjG3/P68PQak+MJyTxHe71ZzRQGQkyF0fwSSCxLFN7a0vac7EcCB/H+UnC1xKM169AN
         mC3Lw940YNWZ8gz25DIV1C48F+NDSrqRCl+jI807xjxZ+K9duy2ZVNMqPn4f4mwiKDh7
         P7nI5lJGoA3lDs3BQWfn9lDbjTlJVt35z0R+wshAkYo5FpA4YZ48oMIMRJFC//h8geoM
         thpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qsjzJkqdlnv6TqmYbTZ/k4ggvnYzrdp3XDw3Tms4H2w=;
        b=pE63Zeealmb6px22e7f3hm+8JN1TCWVC2pZ7HZp6zpP/u0/JfyPCkoHBMid26iY6/B
         JF3vtSk/KQw0PBj+eo1vtMSxY4sQE/RvUg0nhFRFwpfVPwhMeV6KKYivoqwaIxN1t1bu
         d/SmYc3baDc2LdL++OlTrIfg9xSfJrRKW+BAThKXPU+h3+/DPWMTCWRXXbgMJgomAYsb
         cgdf2tIRsp+TI8dJCqA3Q6jQfzNH4wKlZ3AgOTfwXjOKo4yvFZgnkGlolgFyDF03a+D7
         s8T0uziFVdDLTeRGMA6OzG63IzWjedBM4LV9QrXloST3TmnRKCqpo5ISlsXj9nda8TcP
         evWw==
X-Gm-Message-State: APjAAAXDIf+6Um8o8ogvW9d2GGMMzkV/q+saQzv9lDPMeX2KCaMZFVnb
        J5xSgJTaEwCM5YZGXdJn4Po=
X-Google-Smtp-Source: APXvYqypfl2UL5Bs2Rdbgv0WhUG3JeaL2LM4ucubIZqr0ehR1e2eGJYIvbSZMdpnNGruln3tLVVXvQ==
X-Received: by 2002:a63:3281:: with SMTP id y123mr20518302pgy.272.1555527258314;
        Wed, 17 Apr 2019 11:54:18 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v188sm82119643pgb.7.2019.04.17.11.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:54:17 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <code@mmayer.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] memory: brcmstb: dpfe: prepare support for multiple API versions
Date:   Wed, 17 Apr 2019 11:54:16 -0700
Message-Id: <20190417185416.1177-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402230103.25491-5-code@mmayer.net>
References: <20190402230103.25491-1-code@mmayer.net> <20190402230103.25491-5-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Apr 2019 16:01:01 -0700, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Extend the driver, so it can handle different API versions for
> interacting with the DCPU. This is in preparation for the upcoming API
> v3.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/next, thanks!
--
Florian
