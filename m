Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28800C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3FA20656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="YBlYZSo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfFYFKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:10:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43477 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfFYFKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:10:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so11579859qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 22:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSDH/ok8CW9SbNnaNAwXiWQPIve7Xz+jyrpbhWFgBPA=;
        b=YBlYZSo1HY9rwh3BdkYDs6loVnStHN+AIrnN5txkbW6DbN9BFvQ9wLuioABD+5nV4k
         KC7/bV3XzLmGsf1F8WEB5wE/s4JaWaMh5Bf3V3+NroQDxQ4vh2We5Fg2IPeYoda75X+G
         bjmNh73KbfMKWmpyAuluII0wE890z1hR+vLzEv1Fof7gQG5xmbIq2M7XxPTd9PQpL1c3
         1jpFIdogLdZpByN3baZJDwfUMcw0aTo/yIDAQA2OQDq3ckJ38Ep2iIogT/yLPvHTfcTo
         tmPdVoeb01m/BaBhXheeTpBF5nHfvx01c4+ygLKiHxCn0WjmPrTprNSkxO+zQf2WEX8J
         OfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSDH/ok8CW9SbNnaNAwXiWQPIve7Xz+jyrpbhWFgBPA=;
        b=eJYq93o431PEROp30BoM52mqxvj0VAGKEXy2aYKDRjibON4THo4Ewyg9hY2gAeCjJ1
         mf8etcA+53wQN/71842aL+JnZ3gtHGC/xE3Yp0UVCDH45BnTAiMjNEhwaWE7KoGGas5G
         jSeHm2NYUk6tAZyfZX2KOC3OsCawrPeLI2ykD+g7+bICBsc9q4pfLHkooUYTsloakbdg
         8X5fhhNXOQKKDAqD3PeI4DdHgdv8pgR1NwkYBhcyxXuLDE7N2mKxbQNMIewGjNWOnrfr
         u3nEn59/6Ysf/BKnxNOW8ZlOWyfjahxuK/28tcut2ykkh+UZ8cWIac3u6hcJu1TQfgdU
         czpA==
X-Gm-Message-State: APjAAAVVsCTWA35VGIbhJDEyJdhFe/8SVMygOqkrVpyvf2Hb8DCoaupF
        sWDyMkIuLYFcLftsetoPz5JI1i3ebnmnyI3qqQcPtg==
X-Google-Smtp-Source: APXvYqx+ncJYbN67EJYk55a4Ko3NQDKlI0E3Z08XuUn0tEfoofHUFiBOKv9mtIb3S/CENjgpj+4YiwLNSNHpehxF1lc=
X-Received: by 2002:a05:620a:10b2:: with SMTP id h18mr59138841qkk.14.1561439431566;
 Mon, 24 Jun 2019 22:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp44RP+ugBcDYkap3tUL1NSq+knGJbO9A6UAmCtcjPgxTQQ@mail.gmail.com>
 <20190624062114.20303-1-jian-hong@endlessm.com>
In-Reply-To: <20190624062114.20303-1-jian-hong@endlessm.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 25 Jun 2019 13:10:20 +0800
Message-ID: <CAD8Lp47G-+VRFGgakYyVFT8CLSgspvn_E-rMq6AMjiUrdF022A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btrtl: HCI reset on close for Realtek BT chip
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 2:24 PM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
> Realtek RTL8822BE BT chip on ASUS X420FA cannot be turned on correctly
> after on-off several times. Bluetooth daemon sets BT mode failed when
> this issue happens.

You could also mention that scanning must be active while turning off
for this bug to be hit.

> bluetoothd[1576]: Failed to set mode: Failed (0x03)
>
> If BT is tunred off, then turned on again, it works correctly again.

Typo: turned

> According to the vendor driver, the HCI_QUIRK_RESET_ON_CLOSE flag is set
> during probing. So, this patch makes Realtek's BT reset on close to fix
> this issue.

Checked the vendor driver - I see what you are referring to, so the
change seems correct.

#if HCI_VERSION_CODE >= KERNEL_VERSION(3, 7, 1)
    if (!reset)
        set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
    RTKBT_DBG("set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);");
#endif

However I'm pretty sure this is not saying that kernel 3.7.0 did not
need the reset. I think it just means that the flag did not exist
before Linux-3.7.1, so they added the ifdef to add some level of
compatibility with older kernel versions. I think you can remove
"since kernel v3.7.1." from the comment.

After those changes you can add:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203429
Reviewed-by: Daniel Drake <drake@endlessm.com>


> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
> v2:
>  - According to the vendor driver, it makes "all" Realtek's BT reset on
>    close. So, this version makes it the same.
>  - Change to the new subject for all Realtek BT chips.
>
>  drivers/bluetooth/btrtl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 208feef63de4..be6d5f7e1e44 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -630,6 +630,10 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
>                 return PTR_ERR(btrtl_dev);
>
>         ret = btrtl_download_firmware(hdev, btrtl_dev);
> +       /* According to the vendor driver, BT must be reset on close to avoid
> +        * firmware crash since kernel v3.7.1.
> +        */
> +       set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
>
>         btrtl_free(btrtl_dev);
>
> --
> 2.22.0
>
