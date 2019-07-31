Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F24C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C286206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wt3Tf57W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbfGaOHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:07:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46563 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfGaOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:07:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id c3so8798352pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=HnxpbXM5FXYu5TGRW7msWD3j45cMinExmwyTlbdvq+4=;
        b=Wt3Tf57WCZo+rUEDJ3jbZm7OQkvi7Dtk7RSMqczyM0hXLVxoOk8PoSsovHOnYzhWKt
         tXnGleVn3bCBrk22K8az/gtarGktHc+5Rec6cdOHtQjEEYdna1TSxVzVqIkAmnBZ5dgA
         xKT27UQ2ZHcR0F6jt6HpVSpb3e7tHD2O6tzAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=HnxpbXM5FXYu5TGRW7msWD3j45cMinExmwyTlbdvq+4=;
        b=MWyLz2cB0n6B9JlwwN2HqC0SYpMRkrCb4Y71mXhWfVgCQoVpJu1FCwZZBp0TCj9KYE
         PJ2J4dTp76ZiFS0QltAC+yU2u4SlmRrhvnCVaTB5SyNU+z1sWCDMISbVBkNpoL1Qj/Dw
         b0YESkacaTMdfyMpEAMJdHwfsexJSNnJwG+iKuKYQTM9vjW3n6gyNWGKn3aW3BqUA+zB
         8fPZC+omsVT/ieTHDltMFbfLqSHHL75DmxIlorKyAQvHH3jEywRcwWHi9sW4MjHPQvA0
         D+xL5HW6BpSQ2qT2ioN+0beYS+sWn4tUYjOIUL6kMbaBoL8ByOprXYttcQZdDkI/nCyj
         oTIw==
X-Gm-Message-State: APjAAAVk9Fs7W4qu6+LhGSpS/GVgJzOsENjtWvbPdg1dWl5y7qAppR+3
        +7HKbiggqVmRNBYgESDvs6MaKZwV3TqFEA==
X-Google-Smtp-Source: APXvYqxsFQ252Xkfi9cEcbNTq50MLLf0fS9QQFo3WFhjQHY7txjaCoXt/b2BFl2SUn4vSdmAr9ZTiQ==
X-Received: by 2002:a17:90a:f98a:: with SMTP id cq10mr3205995pjb.43.1564582071848;
        Wed, 31 Jul 2019 07:07:51 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w14sm76786272pfn.47.2019.07.31.07.07.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 07:07:51 -0700 (PDT)
Message-ID: <5d41a0b7.1c69fb81.fdf43.82e9@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731084056.jd7p5lrvyun6ynlf@willie-the-truck>
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-33-swboyd@chromium.org> <20190731084056.jd7p5lrvyun6ynlf@willie-the-truck>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Will Deacon <will@kernel.org>
Subject: Re: [PATCH v6 32/57] perf: Remove dev_err() usage after platform_get_irq()
User-Agent: alot/0.8.1
Date:   Wed, 31 Jul 2019 07:07:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Will Deacon (2019-07-31 01:40:57)
> On Tue, Jul 30, 2019 at 11:15:32AM -0700, Stephen Boyd wrote:
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>=20
> Acked-by: Will Deacon <will@kernel.org>
>=20
> Please let me know if you'd rather I route this via the arm-perf tree.
>=20

Yes, please route it through the arm-perf tree as v5.4 material.

