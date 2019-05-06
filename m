Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EE2C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248DC20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFRf8U7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEFMkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:40:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44443 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfEFMkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:40:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so2305036plj.11;
        Mon, 06 May 2019 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oy4Ruent20mS+vP/+538UQ8wRUJfmtdHDo5O6cPrgi4=;
        b=WFRf8U7lETJO5PXZBsqw6MHcWsnZyyqjvWrBH8wntrYVE+COQLqSvmwNgjAyRf2rUK
         mjFP8jQcFjthk/AjNCt5kkYv2jn+zItPxdGUmZg+br59QJLsz/malW2eQbcppTVIB6M3
         zgVAZ8EEsoWtmn2Jw+I+tmpjEdYh7r73AiHKGhacZgsHH1O7qVJWs/CwVHDOQfoSlWtw
         UdWW5mwBKyBstnAu4vMNA/c2HQqoNHOEN8DPJp+6Y6BorflxfTexcxdACTzFZCM2afde
         Tmv1Z8eC7ji9ljjgI2sOIe2qPEtyam7vJkN+vqX/bO6hh4hh31YQppTDsupjc1XMCTXD
         z7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oy4Ruent20mS+vP/+538UQ8wRUJfmtdHDo5O6cPrgi4=;
        b=KpH3bLxSy7MTYV9dJdNQEVRubX+sxArHlvaNjsodx+fiLzz9AGqh11DwkwSazxXwhr
         T/eAoetwZrOKKALzwu7kqNf1Uax61Y9ceu6SsxWVdCy0fHev6EwGcb+PFqo+k1dbHrCE
         mqnEk9rhtf0m+F6/CYaOYY3BhOLsJwlD5yPD+h6qxENKcre2pXZCn61N6V6+AIr7N33V
         4j2QaN5LKJq9vjQDD5GIW05yp21f3S3/u29V1QdNsr8p1Wkl1PSEuyn9MAE3CJSau70A
         4aVQ6HXnbTdEGOc2HHLc56r80leXym4Rp7HaHxBwVLoX4BIhZ1mSbvVct4erOaVchALl
         3tCw==
X-Gm-Message-State: APjAAAUWHTGB8Gdsi+tVviAsGxahxs2Z6qjJrG/acU9QA3l2/MQNo2Xq
        +dfArDvcVNgNvDmpL85YpCyysHKwgoJQakwbOXk=
X-Google-Smtp-Source: APXvYqyeQd/K/YBN5Hod+tC22DfpiN3sS4Qv0z1TQntwH0Ll1/epHnjDeRJuP6aZp85N3kApHK6p0DP9J/t5uPenmnc=
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr31893319pll.12.1557146413415;
 Mon, 06 May 2019 05:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190502130351.5341-1-linux-kernel-dev@beckhoff.com>
In-Reply-To: <20190502130351.5341-1-linux-kernel-dev@beckhoff.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 May 2019 15:40:02 +0300
Message-ID: <CAHp75Vc4xWbnGoaS8tRDV4_F-Qifh7K1hoFn0V-OObun2Sd0DA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Add several Beckhoff Automation boards to
 critclk_systems DMI table
To:     linux-kernel-dev@beckhoff.com, Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 4:04 PM <linux-kernel-dev@beckhoff.com> wrote:
>
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>
> There are several Beckhoff Automation industrial PC boards which use
> pmc_plt_clk* clocks for ethernet controllers. The patch adds affected boards
> to critclk_systems DMI table so the clocks are marked as CLK_CRITICAL and
> not turned off.
> This should be applied on top of another patch as both change
> the same table:
> [PATCH] platform/x86: pmc_atom: Add Lex 3I380D industrial PC to critclk_systems DMI table

Yes, that's why it either should go via CLK tree, or I need an
immutable tag or branch from them.
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Steffen Dirkwinkel (1):
>   platform/x86: pmc_atom: Add several Beckhoff Automation boards to
>     critclk_systems DMI table
>
>  drivers/platform/x86/pmc_atom.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> --
> 2.21.0



-- 
With Best Regards,
Andy Shevchenko
