Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFA3C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B22F20659
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ir3wSEP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfJJSac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:30:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43480 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJSac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:30:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so4423203pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=ORiOn2ijg214/FB0BTVae4aav3Hv7+fGWBkzNRGr70c=;
        b=ir3wSEP1pelrXWLac9D+DzZayrfPLrb8c1CMg6RIukhApw0o7JAtf0Br+2iuN2IkwF
         CsKFz3HnUdx+BUYkHUzMl3CGqBSvUI4MJYF1kzTXWBdzAJQVKDb2RptEcVDIWj/FW4Wj
         yXmOXv23FsXmfc12xavUzSiL6WctEb9Iyo27E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=ORiOn2ijg214/FB0BTVae4aav3Hv7+fGWBkzNRGr70c=;
        b=sSFyeHaW1+F3oijUsBpN+7FbTI9qq3BwIF4a1v/znsNg0bGtVF72Ki8QvqgU4PVkJR
         +y/H4ONJR01hzlqMSTsLDM44mxgGE/uEjXnqoScrkqAnuxaGTE309pNWlzAmiwXMMYEx
         Unx6HFv2KYDKi8amlRro0aFrSWyGMjTvPsSa11kNoQ2KDoJPAUI6edY2I4sdnrz+t+Ts
         XhQkG6FCaPuv3+xGyG/il6wCRGHBKfGhnQbR45RUMcHhRsvw9cY6T62S2Q/vsA9DCWvA
         tqbMAVP+ZGWuxCIxqqamEwTrQ6Z4e3f92jXApGUfM8IzubrIUlFR0m2z1BPnB9Mbwkvg
         RFIQ==
X-Gm-Message-State: APjAAAWFCw6KAFUXybarPU3GJ7PqZwkGxyRB9h9ocLExJElgM3tr2tAK
        JgQKqwll1QXDEHyQuVvuEkM27g==
X-Google-Smtp-Source: APXvYqwq/5gCZohNEE4qPNVBMfmMnDuLbHKuu0mov6MOWy4yAGKsDYjltE6oLtKz8XFFiN4Nbye22Q==
X-Received: by 2002:a63:d452:: with SMTP id i18mr12718002pgj.76.1570732230838;
        Thu, 10 Oct 2019 11:30:30 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j17sm6238178pfr.70.2019.10.10.11.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 11:30:30 -0700 (PDT)
Message-ID: <5d9f78c6.1c69fb81.e8d13.6c8b@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1570616148-11571-1-git-send-email-Anson.Huang@nxp.com>
References: <1570616148-11571-1-git-send-email-Anson.Huang@nxp.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Anson Huang <Anson.Huang@nxp.com>, andy.shevchenko@gmail.com,
        davem@davemloft.net, fugang.duan@nxp.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] net: fec_main: Use platform_get_irq_byname_optional() to avoid error message
User-Agent: alot/0.8.1
Date:   Thu, 10 Oct 2019 11:30:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-10-09 03:15:47)
> Failed to get irq using name is NOT fatal as driver will use index
> to get irq instead, use platform_get_irq_byname_optional() instead
> of platform_get_irq_byname() to avoid below error message during
> probe:
>=20
> [    0.819312] fec 30be0000.ethernet: IRQ int0 not found
> [    0.824433] fec 30be0000.ethernet: IRQ int1 not found
> [    0.829539] fec 30be0000.ethernet: IRQ int2 not found
>=20
> Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to plat=
form_get_irq*()")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

