Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B93C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182D620823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FNYUqEFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfCDJeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:34:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44826 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDJeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:34:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so4687273wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 01:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IW/8YsNJV2jsAkJliYBu42s7jgtHk3nBWT8Ex5IVnbQ=;
        b=FNYUqEFSgiLV79smnxx2LL29UmM7A2XHzLxuoAFEJzWRq6VVOlFFa2Db42NjiciP/j
         rLUvOi2CqjhvMmPpK1MGB16piD/O4LyR1wTpvzYKDHvMBbndXOqH7xZW9Rlvu0YEHyK/
         qF/ppSSOdOgZ1cR77D6fDEy6Lbzwx9CUqTbp1mhnUZBTjN3o2u5O/PHSf3bUkwPfwHzB
         uOrJEqzE2/NTzqB4dNoQHo19PY8rL2rO78bbDXqyxRU48qq0BK/z6lBh7lOVYsKoxKA4
         uOkowtohEAj1fdibI+lMH+1KHpEJDJm/NpF//r91vipjIYtNjKb8PBug20r0hEObkJ4B
         avFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IW/8YsNJV2jsAkJliYBu42s7jgtHk3nBWT8Ex5IVnbQ=;
        b=qKoLzVr50MGW56kWKLRomW1FgFqsSkm+Vcm+pXpTGmNb2ToNlTzP+KwpD/YEzMBQRb
         JJyAdSAD/8WGX/ZzibuwG9TVzrwnDsksSyILS5J3hGFXv8bBpWMP7xQ7U+yPilVXWYeF
         AmqnEPtM5fznq51PYX/Wx0UcuymfVkOUCIQ6UxuH50wlgrs3KO/MkT5gAwSMgmImFaJC
         aLvzya9lxklUfgl5KbHAumeftwh7UeDhAjobBQA9+pdgXR+NMt2nRx1B0n8jOaRrASoC
         GZ2kT0xLkK9po6A/fTXShIfv8GEwvln9LcrOxDcSoCGpH/vi1MIdgL/WqYtovrAd49OT
         JnzA==
X-Gm-Message-State: APjAAAWZ7BlaiL+rzgEhO9JEFRodftZPrbML/WnfQVltG9UpLqQyksMc
        N7OJPbMeUhgBlQnSMKAkHC7/8Q==
X-Google-Smtp-Source: APXvYqwO/FJNIjx5ByFaIIH+0ARbfxNe+re5z2LmJGb0J1DrXdIyImpK21a6wZ7VxaPjQ7HXlXR5ig==
X-Received: by 2002:a5d:4605:: with SMTP id t5mr11728402wrq.311.1551692037968;
        Mon, 04 Mar 2019 01:33:57 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e193sm12832325wmg.18.2019.03.04.01.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 01:33:57 -0800 (PST)
Subject: Re: [PATCH 8/8] usb: dwc3: Add Amlogic G12A DWC3 glue
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-9-narmstrong@baylibre.com>
 <CAFBinCBoahGTbnii0Dhfj75YC8u2HjodAqFWwtD=K3xOZ-wGPw@mail.gmail.com>
 <CAFBinCDjFJS58+6yqxrsyHvhycsg2sC4tTtRj8O=GkcPJpR5Tg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <2a6e3d5d-fb32-455c-ae86-16bc6ba024dd@baylibre.com>
Date:   Mon, 4 Mar 2019 10:33:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDjFJS58+6yqxrsyHvhycsg2sC4tTtRj8O=GkcPJpR5Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/03/2019 11:29, Martin Blumenstingl wrote:
> Hi Neil,
> 
>>> +static int dwc3_meson_g12a_debugfs_init(struct dwc3_meson_g12a *priv)
>>> +{
>>> +       priv->root = debugfs_create_dir("dwc3-meson-g12a", NULL);
>>> +       if (IS_ERR(priv->root))
>>> +               return PTR_ERR(priv->root);
>>> +
>>> +       debugfs_create_file("mode_force", 0600, priv->root, priv,
>>> +                           &dwc3_meson_g12a_mode_force_fops);
>>> +
>>> +       debugfs_create_file("otg_id", 0400, priv->root, priv,
>>> +                           &dwc3_meson_g12a_otg_id_fops);
>>> +
>>> +       return 0;
>>> +}
> I just stumbled across the "USB role switch framework", see [0]
> it seems to provide a userspace API as well and two in-kernel drivers
> are using this framework already
> (drivers/usb/gadget/udc/renesas_usb3.c,
> drivers/usb/roles/intel-xhci-usb-role-switch.c)

Just added support for it, works perfectly :-)

Neil

> 
> 
> [0] https://elixir.bootlin.com/linux/v5.0-rc8/source/drivers/usb/roles/class.c#L246
> 

