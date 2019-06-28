Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E3FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61412086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VF6Qdhuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfF1W7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:59:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37965 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfF1W7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:59:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id b11so4981422lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 15:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hxr737kZawIDdGnBRfezwRYZfPo+N/0q3w7Fxi9l4A=;
        b=VF6Qdhuv7A1bSXPlb3IW1+FrjzPu/5kLqJR8Bz3t4QYSsRmFGPpUKtjDK+76denozn
         16FGNec6EkruICXjbpFZ9+3J36uau6xjWzLCfmQ1pkX2GY6gfKFgHUUoAsIpsrM4gUfb
         2J1/qNcGNldERB23rgLKXTx1gg+Ws1OyBf04k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hxr737kZawIDdGnBRfezwRYZfPo+N/0q3w7Fxi9l4A=;
        b=ejEZLcDCQG3+pxmPS2q5eAoEBpQ6LwEu7fdbbhPGElW0ZeKggclWhiscUEXKoZWGDy
         lERLP33dev5rynidCGEVhwqfMHkmhBitvz6N05MYVYDH/du2g7Umz9kjFibvtMaxgYFG
         z10XPQD7hfQctZr9KL3Vs6R/GDmfDpaxNUxs+ojWbXzPorJU8Vt6Z6uH1kK7lcBG4RiU
         sHKNQoONMxmBDaU79Zh6uDdtsWvUKdsgmVF8a76qsM3lJefTXzdZNy8eQ6+2mSCLaTgt
         QM3xVKt2axCPTLShH6Wx2fGY8BxGEbS85VwhfXB9ZXrkDIkcw3YNqLCy+SL1NfymxJ61
         /vZg==
X-Gm-Message-State: APjAAAUWPCIvpZRCspYbY37GGG1GRK2TxnKvwfT15lZwvaEOroBcVWVl
        tDTtzhWVclfiSIW79VQWFJ9Ct3Biibs=
X-Google-Smtp-Source: APXvYqxrYs0aqqtV5K0SyVy6l6Ew3l34pxbsI7+M1Zs8MjKyEE3eojvs6PLJB9eepC371yWhg9eICg==
X-Received: by 2002:ac2:495e:: with SMTP id o30mr6144562lfi.140.1561762742024;
        Fri, 28 Jun 2019 15:59:02 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id p5sm1137963ljb.91.2019.06.28.15.59.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 15:59:01 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id a21so7490619ljh.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 15:59:00 -0700 (PDT)
X-Received: by 2002:a2e:9758:: with SMTP id f24mr7644626ljj.58.1561762740673;
 Fri, 28 Jun 2019 15:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190627003616.20767-1-sashal@kernel.org> <20190627003616.20767-14-sashal@kernel.org>
In-Reply-To: <20190627003616.20767-14-sashal@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 28 Jun 2019 15:58:49 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPyGECiq9gZmFj8TU6Gmt2epQtuBqnGqRWad79DJT589w@mail.gmail.com>
Message-ID: <CA+ASDXPyGECiq9gZmFj8TU6Gmt2epQtuBqnGqRWad79DJT589w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 14/60] mwifiex: Abort at too short BSS
 descriptor element
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 5:49 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Takashi Iwai <tiwai@suse.de>
>
> [ Upstream commit 685c9b7750bfacd6fc1db50d86579980593b7869 ]
>
> Currently mwifiex_update_bss_desc_with_ie() implicitly assumes that
> the source descriptor entries contain the enough size for each type
> and performs copying without checking the source size.  This may lead
> to read over boundary.
>
> Fix this by putting the source size check in appropriate places.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

For the record, this fixup is still aiming for 5.2, correcting some
potential mistakes in this patch:

63d7ef36103d mwifiex: Don't abort on small, spec-compliant vendor IEs

So you might want to hold off a bit, and grab them both.

Brian
