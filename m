Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C43C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6CF20874
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FisnbY9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436663AbfFKVyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:54:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36680 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436650AbfFKVyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:54:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id f21so1686069pgi.3;
        Tue, 11 Jun 2019 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gqlg9mlQrzOnNuGBRs6FVMKN07w9DfmWW8w0BvZncyA=;
        b=FisnbY9x5/R5pS7dhi82yjpYpTWMxnbt50rgYFFiOXlaGRBQNXa5MoQajQeqKJQ8xA
         8AktdSCbhDpwyp2ClVkrupNm3ZLwmg1G8cjUaC0oT0x0toXuG8Bl6pgmhXfrlrE9sG0z
         u0ozBRjPrd7bF83MaU7l0DcOPNKgLpzU1w/PizmmiQ8+6uF21BEg96I+rVusWt1klboy
         MKSIVvJ994JaCOBDAVy+MGcR6LCeTj7oTuvjC76/vVDqeCbfd2tsbBE5t+KAzrYyKao0
         beq9gMaBB1N6tSGNcuX5M7uysmk0W1wVJG1g86OLS11qCcKjJGoCRpU9WYjSXH1SOls7
         mKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gqlg9mlQrzOnNuGBRs6FVMKN07w9DfmWW8w0BvZncyA=;
        b=ecWf8LbF8GmlYIDy9fEb6Uo5hcPzyDfwxgosnnOI5Qj5Is12Brp/gJ7FrKXcVfxcyt
         bMnFw2+paa6c9axJRMHXt94XP9RQKKYHb1x9RIQ9THAt/oX9mstZRLavABG2bd1ggmzf
         yv+EJ1YystGMZIAG7Mw2B7DaEq1QRH+Olu2xo9eIbNAZdtaTShecTLkLLlbJwMaWPvw5
         J5c7v9RFxkSkTA5YAW1LnNkhDWiBjGnF7EFpir/4auz/AqoeUw0mlW3CaMOXr3FDG+Gg
         sH2dG7JyIEWC+uCUJFEtMHFtsGMT6QOnO1J7WjMT5HL1ubx2bSqyJ6/rgthPz6H16bh7
         UnRw==
X-Gm-Message-State: APjAAAUoIuPbopugth2ZOB5aLG/E7ygXMhmbD8n2NtUrOvRfBcogfYHw
        VFUDyRvvtSgcEMn0ngHw2/g=
X-Google-Smtp-Source: APXvYqxmglgJRzn1GsRQX6RoSwxGtXaN/sU/gd2Qldf0Z6oLMgeyABURq9p9hQ/BaVqb5FMTq03zPg==
X-Received: by 2002:a17:90a:d151:: with SMTP id t17mr28842001pjw.60.1560290083167;
        Tue, 11 Jun 2019 14:54:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c9sm18829165pfn.3.2019.06.11.14.54.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 14:54:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] ARM: dts: bcm-mobile: Fix most DTC W=1 warnings
Date:   Tue, 11 Jun 2019 14:54:40 -0700
Message-Id: <20190611215440.10245-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528230134.27007-4-f.fainelli@gmail.com>
References: <20190528230134.27007-1-f.fainelli@gmail.com> <20190528230134.27007-4-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 16:01:30 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Fix the bulk of the unit_address_vs_reg warnings and unnecessary
> \#address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
