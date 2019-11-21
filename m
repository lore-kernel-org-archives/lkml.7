Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97170C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B184206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8TfQYQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKUOK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:10:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35042 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUOK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:10:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id r7so3405038ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJr5TKLYdPNJRAX3qEH8F1mSjnVBObJYF2mexkZ2Mb8=;
        b=M8TfQYQ2YFoW+pdD8qPKkhHHUpuWhPe6ZwEnqP3WiHjuFn5kXFqYfVgKgT00GsOvb6
         jGptIRLTk3JKSjHb1gFz0Iy2j7MOo4d/D0M1zkuLE65adLb4zq16pyw4XXBIf7C+L4Jm
         PN30Fv4Q6uhjCv3NHMS6he2yrBHX61nWbqL7SJl0Z293eX9QX36ZnyX4Fz32MhBSXUIs
         lbhJEmWVtXPqQjoWBwVuRaVY19iWxywrSzeN9qMaxT1MdqfBJ5kg3YW9PxPuBUSwQ/Pl
         Xwo4d/DziLKOCz+Z2hBE+KtxEIfPhHkXndybGj95JT9BQrnT4MA93QV+ENOjq+blTR5h
         0LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJr5TKLYdPNJRAX3qEH8F1mSjnVBObJYF2mexkZ2Mb8=;
        b=h79nS4nac1btpvfGqU13IxhFZF9vQ4LWCl2LXm6lLgbxZn3jMtBCVlLvLbNrwUObMP
         RlkrMQxuXJTbteLBHgYQfqoDdlofQo+p43sONTTU1SF5xNZgG+k+CrpEYDbuSE+UW+4q
         B8DhjukoBBFlwtchUwXeBZbzXJL766kEqqpD9DEI/MBOjTzHQMT9v+mplphet+sV50eo
         OHwcCtuW8T/yTnBhGW1gg8MnJr825cAtHb1hcc2+5uLDjW31Tt/ZR6GLJllW/6lpF+9C
         TdlvLi24chwMD8WyJ5O4QnpRPOxTemTVojscKEfHHDABPAzNULQocN+VxxNeSg8ThXpn
         CmyA==
X-Gm-Message-State: APjAAAUT5kXA6iqvXV3vkGCvgmBtvJ3vMn20oO91AhTpq/TaGGDLf7Lu
        G6CRfN3HMZ1lt/9Yo0PPWJWV8lHhSmWfbw2MBrXiUw==
X-Google-Smtp-Source: APXvYqyTp9UobATgipJw5x8QE/Nw9xZJKmgCtO03/0B62/xoVW/SnHidSqxIs9zNdLsdbeLiKfW89R4BjjPS9qHAAs8=
X-Received: by 2002:a2e:9a12:: with SMTP id o18mr7645392lji.191.1574345424517;
 Thu, 21 Nov 2019 06:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20191119155211.102527-1-paul@crapouillou.net>
In-Reply-To: <20191119155211.102527-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Nov 2019 15:10:12 +0100
Message-ID: <CACRpkdY_C1LKS6a2AqwEmR5fbj3r6djzQqy4-D5RU+WNDuG4fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: ingenic: Handle PIN_CONFIG_OUTPUT config
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 4:52 PM Paul Cercueil <paul@crapouillou.net> wrote:

> This makes the driver support the 'output-low' and 'output-high'
> devicetree properties in gpio-hog sub-nodes.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Patch applied!

Yours,
Linus Walleij
