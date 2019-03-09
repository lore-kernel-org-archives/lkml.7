Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8ABC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7422206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVuGnJ9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCIWD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 17:03:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40618 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCIWD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 17:03:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id u9so981814pgo.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 14:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cx2d8mter60+jb2rcPSITW+svSlqh6wPI9dhc3GxDqY=;
        b=XVuGnJ9xX8gpPEC/KGEIJcNoL5T8ZP0v1hVSX55v1uvSfB6jdmu7/3gChyOnbLmXhH
         S9d4CnBCDoEbD2W0U8lhMDq00VIBWix0pjZrvKJupRgfIeHgQFgb3QAssXe0BULl0QAT
         S6naPDRto8hfk6xN6wR460Wyr0J+Papdx5iNinI3EleC9FDkTuFwGNgKohds/iM6utwh
         8pvBGjU04eLwewG+u6IOm8t92hvk3i5/8JQGMbhZjioCzZbPIQB90r3PA9fGO7QpwGGh
         v6aIoFFcJGeege5eq4IcU5B1/LaqYcRBnIc7LAnujxaqYb/bA72Yx/9LcNvmopMh+64c
         SIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cx2d8mter60+jb2rcPSITW+svSlqh6wPI9dhc3GxDqY=;
        b=cJ5N4xZeEPZzvRccIC4dP7ftWM8umCl4R3WtkN5PU6XZCLVxIyJ0hhC4Gp4GxuCCIb
         n02KW+drDwr4QIMcWkFAInEBQVnDC6YHOKN3C0lHdy0yPdYbhlg6xKPkSI/qRTzoGan0
         2oL1zRzgkNxiCw9QrdlN44Mg6kqIrQ0Qjjj8YgGTDQsFqqgZ9oRDOWtLy+1AqCviELg2
         L981qLi0BjArOuw2GXrJuUttSUu3Rcb9U1xiUKl+s865TpRUxeORMJMYjHuMmgBI/4zF
         9oyt6at2XNmRc7GG6pTJ1+lSpaq8QzlTJbRaNWYhyWN6ahUz/z44jX0uxbvNm5tKKzIE
         oZSg==
X-Gm-Message-State: APjAAAVe2GnWMnQ0KRnd1gx098vH+bFpgoPE0AZh3DcGpRRWCjNxtsGv
        BbCfCksD5f48xuKT/d+lCq4=
X-Google-Smtp-Source: APXvYqxXm/1u05lWgsnDA6MBR01qZ8dOMqr2qeC9+CMMMSJHZwEGeWyO37UR1qJFnsntqeBRmxvu8Q==
X-Received: by 2002:a63:1c02:: with SMTP id c2mr23504405pgc.351.1552169006832;
        Sat, 09 Mar 2019 14:03:26 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id p34sm3938270pgb.18.2019.03.09.14.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 14:03:26 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <code@mmayer.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] soc: brcmstb: dpfe: optimize generic_show()
Date:   Sat,  9 Mar 2019 14:03:24 -0800
Message-Id: <20190309220324.26015-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212012443.21819-3-code@mmayer.net>
References: <20190212012443.21819-1-code@mmayer.net> <20190212012443.21819-3-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 17:24:42 -0800, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> We can pass a (struct priv_data *) to generic_show() rather than a
> (struct device *). For two of the three callers of this function, the
> change means one less call to dev_get_drvdata(). For the third caller,
> it makes no difference.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/next, thanks!
--
Florian
