Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DAEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB072085A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="geIRKggf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfCOVuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:50:55 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40055 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfCOVuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:50:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id k11so8555737oic.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fAnAF6HI3aUDD5hCiUpTX0j0x3eGnc7Pur10ZCisk20=;
        b=geIRKggfZzDk1gKV1yiRf9uxdpZfiq+NAgioXghsD/rMm1SN5ZciBAA+2n7eZg+UlG
         tSlc7eFxqn2H/6FQ601kEgo9o4UcWSL9CUHOHVB1j0Nax33joXTkTh4JI5xO8pdQw1WH
         212w+2r5PcP+e+5Pmey+XnjpPtME9ah9tEV6grfVPPC1C9CHGtGEKsdFklOSW5znxQHI
         vVQB1HyW/qPI+TLIpEIddeFfvfDukVQeL3kDEi4eYr7DRPtbF9n3VIRYP1wg2xSCZ+xX
         bl0eigm4ZS8AAKlXUl1w9/xq4bj0/qUDb/C6vmuLmZwJb3h37imGSe+4AInSpEz4PE/m
         2kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fAnAF6HI3aUDD5hCiUpTX0j0x3eGnc7Pur10ZCisk20=;
        b=U37pSKYJlRttSW51vz/C7HrgggXUN28supzbPYvTdD8KLBAqSHF7H51EWVdiyprSyI
         PXCfiTeKA4Eia6nastS6Uh83w7CBCz/oZCnLbY/1xpfhsJonZdr/ko9j6vFqzcWsc0Uv
         CPUtSJU5MVlipK8zgAkGyTN6TWxI7iej0dACg2uSRsVZ5j4iia+llukqnUHXvLyu1rTz
         xt6/Kvtez4CjIcFe4Lk6MIu9ZefuKVgvhx3DQeapff620feImQXjBBIO0JDV5y7wiwj0
         3hMU37oUzUfY94eOcXkWsHRFigH+aUEvKu6q5+QkITF0Rr2VKTTCUp8xgl2b2vgYHOYz
         s4Zw==
X-Gm-Message-State: APjAAAW6cQoroZFHmU2oAr5GsLWyn4psnHO07H5uAsnDdmsqliT81I4l
        q8wVOS7VQU2UUoDUonwiAdwR5zL7HXseg5+Jf7l+fA==
X-Google-Smtp-Source: APXvYqyK1bhGjvLCx7Kz+icQDppn/ZFSuYO3hrEsaGl494Kl4LmJW4cJFPmz62Oxy+/z506cTjz0/QZ66lavb9dCU+4=
X-Received: by 2002:a54:4e02:: with SMTP id a2mr3085565oiy.140.1552686653469;
 Fri, 15 Mar 2019 14:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190311095613.11371-1-narmstrong@baylibre.com> <20190311095613.11371-12-narmstrong@baylibre.com>
In-Reply-To: <20190311095613.11371-12-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 22:50:42 +0100
Message-ID: <CAFBinCDU_6JEJJS8yZkq0rjbqKcy2eBKFaYqgX3txGMiO5U9Fg@mail.gmail.com>
Subject: Re: [PATCH 11/11] arm64: dts: meson-g12a-x96-max: Enable USB
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Mar 11, 2019 at 10:58 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +&dwc2 {
> +       status = "okay";
> +};
your patch description states that this enables the "USB host ports"
but dwc2 is only used for peripheral mode (meaning: dr_mode =
"peripheral" or dr_mode = "otg").
do we still need to enable dwc2 in a host-only configuration?


Regards
Martin
