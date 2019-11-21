Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C738CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979932070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PROaNuWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKUN4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:56:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45611 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfKUN4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:56:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id n21so3274594ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 05:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwVumWvJHo4zvWxGZJD9YSWEBNd/DEDoZWc1zGQkww4=;
        b=PROaNuWrUKfIWxlt+j8KnAB87S9sEPRRC6XBWLZRSlLDbSCwpFFGXYtL+n3UhxkSnb
         zltboWUsjHwVXDG8sa1sM8NgJaHgZF4KeCpIkdAaZyRqZqCaHl+rYRUm3D8RS5A/EnCl
         Q75Zxx34KXOEIEj224cI+oGu1NFCGs7vdCaqpWbgqyBMpoIU0Aj/VrIffmL6710odHKO
         gULu3ssd8wX29tDvOdwwoYjcU1hc1jN7CkusvCk3jWPw22fId0+TqKLIYq975QXn+C2a
         qYZgtmLDvAJ/JMwbYbfP/gEoCc7fbYXQ3sWQZXg3offSocrRzpuPbKzNbGwTNdfiIcNQ
         +jFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwVumWvJHo4zvWxGZJD9YSWEBNd/DEDoZWc1zGQkww4=;
        b=XTvbO1Vty2wDWQYgGfhjptQkT4Yjdn0q258P1BkXjIA9t7q5iyT4MpIee4SkEDASl7
         KBlYE3MYI7CTM680O7zq7g79HAwKrI32j5/9cvavrGbCE3sbwh6bzi3GOzrnvZsupAQI
         X+cn+932Tkl4NT5ZILnJ7nHNYBurZM4KajPLPIgdivJ15qc0w9HkLxh/iB31UnWrS5Sy
         sEqISQWfQUdNiqNfdpCmr/5TnRwR6Va+rv60olhUWjgseJNZzopkmLNB2C6Kd1tqPfV/
         PVwNXNCoo8mHwBShi1PH8W+fmoOuejM9tFjuscFY0LCttef1ncop4dIhDEvjm4SEUYc8
         WThw==
X-Gm-Message-State: APjAAAVcOf5WlkoX7PMZ3Ou4YiGm7UtL06zWzj8xGNew4V1XVcaLz2Pk
        D8sI3nJpQRoLQ0QObWelEp1kKDWjEQL3rB4PnkQ5tw==
X-Google-Smtp-Source: APXvYqxK0E9D55XX4sJlFFn/xkAOM+O9uzYS51IiYbmsrxiwLu/M4n5FQGZais+eCToXwuxAaBgFfC8+x3EE7MMm9YU=
X-Received: by 2002:a2e:9784:: with SMTP id y4mr7671826lji.77.1574344562426;
 Thu, 21 Nov 2019 05:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20191115155752.2562-1-gregory.clement@bootlin.com>
In-Reply-To: <20191115155752.2562-1-gregory.clement@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Nov 2019 14:55:51 +0100
Message-ID: <CACRpkda5m-h_v_aNGb5gAOH7-HSd5c+Oxdij=H3UwQG9-FusaQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: armada-37xx: Fix irq mask access in armada_37xx_irq_set_type()
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        stable <stable@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 4:58 PM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

> As explained in the following commit a9a1a4833613 ("pinctrl:
> armada-37xx: Fix gpio interrupt setup") the armada_37xx_irq_set_type()
> function can be called before the initialization of the mask field.
>
> That means that we can't use this field in this function and need to
> workaround it using hwirq.
>
> Fixes: 30ac0d3b0702 ("pinctrl: armada-37xx: Add edge both type gpio irq support")
> Cc: stable@vger.kernel.org
> Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Patch applied.

I do not have time to send any more fixes pull requests at this
point, so this will go into v5.5 in the merge window with everything
else, and then to stable from there.

Yours,
Linus Walleij
