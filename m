Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F5FC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EA5205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7WYzZyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407783AbfFKV6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:58:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32775 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404770AbfFKV6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:58:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id k187so7210429pga.0;
        Tue, 11 Jun 2019 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gJy35TgHH/v0hDshZHQdSlMIZMSrmjDdOipXSskBwzU=;
        b=i7WYzZyuIyUtNcO9F5iEujjMLDNtr/r8dUs6BFd2R/eAaJOxtr/0O1Wi+23stB3f56
         5BlZDrkhgGdUKU0HJejPus03Nojdf+dbNqTsbR8fO6QjeWKmPOoGB3Brdz0a3DbPv3CN
         XysKmCFYO8rJSumUiZm3FhZw6MHwhPn5x3djN339fZL873VWsqI1Yc9tOGRpd/tnS2k9
         +/cRJUy8TTDoSA0znxrQaJtQl7xjDy2qrq4tcz2bqSNo/wY9zRal5+csvEvHTot8yADw
         BiqTQ+cO45jW+MHRsxvA+SzR+x5EV1peCXQ1SeMsHJA2nqzlezWLavFN+PZYbFc59Hz6
         ut9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gJy35TgHH/v0hDshZHQdSlMIZMSrmjDdOipXSskBwzU=;
        b=TG0m0pdVvlrqAaVh3jv0wp5qBmVMUJq5RhNHg37ilXZFX7Ya/lTG+Rb4YBZRCkiVTs
         Q0XSrXD7By7RMhT+e1FqSZTdvpCALM9yxTKGpvFHyX8P9ND6hPZcw3N6XCw+9jj82lQ9
         A9T3lk6VQfHKZau9sUBeoLy4FJzgTeyeECImtHE6tdtXPTt1rnXv3iwxJG3+zwMlYCzC
         mPMSmXqRh9aZvS1Lu+gbEkGnIxNr2SFgnOKBw4kXpmxXq0TwIHGB3huNWjrqlIG1ScVW
         Dj3n4FLfEOwamr5UkDW74NzAk7y5o/nD0Olx85N5g6hOD8zlusuFW4Dgah5Kvz+sGh2I
         ul4Q==
X-Gm-Message-State: APjAAAWu7O9DykLukCB/K8RBIreygiSDte3zAobjYPXTswVVpDrpo3r3
        FnRZX757+p84ElZ10mZJ2ww=
X-Google-Smtp-Source: APXvYqzkJHyddK7zVr84/ggWzaAIw8IL0RXuzddrzRjQxYgcia42pynxjQJg16MqYp7/tM48McjzmQ==
X-Received: by 2002:a63:2bd1:: with SMTP id r200mr22130911pgr.202.1560290321397;
        Tue, 11 Jun 2019 14:58:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z126sm16434754pfb.100.2019.06.11.14.58.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 14:58:40 -0700 (PDT)
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
Subject: Re: [PATCH 7/7] ARM: dts: NSP: Fix the bulk of W=1 DTC warnings
Date:   Tue, 11 Jun 2019 14:58:38 -0700
Message-Id: <20190611215838.10758-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528230134.27007-8-f.fainelli@gmail.com>
References: <20190528230134.27007-1-f.fainelli@gmail.com> <20190528230134.27007-8-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 16:01:34 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Fix the bulk of the unit_address_vs_reg warnings and unnecessary
> \#address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
