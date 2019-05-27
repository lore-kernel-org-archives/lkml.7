Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B63C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 01:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0AD20815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 01:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7B66fV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfE0B4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 21:56:08 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40111 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfE0B4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 21:56:07 -0400
Received: by mail-it1-f195.google.com with SMTP id h11so21980742itf.5;
        Sun, 26 May 2019 18:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4riq5WOrC6jxJv+1e3ONXH5F0cl4unP+M0sgitUBG8A=;
        b=F7B66fV4prSwIRfZawcHCapEbxTOWBuNBaZCIQ6EKpn3pkjpnaU2czUylmkzXzlmxZ
         HmxRo+aD2j2gvXclYMexnD6hwOLonFPwXDUH+/IixOYGch84mgAAXREsk4msNRwi/h9I
         HCo090HtDhVHdNDV5Qn6jyyoBpUpTpA49nns51My6WExajf8nG2B+OXvnDSHQTIeyYHS
         kMpRa18MeLr/EZzs67xhiPD7irU1MA6t6Ulk+YtnhVTm273ovhoACo8b/JD4VfFbxmRH
         qML6YVc+FTxO2IyD1fWKmkOYXNA3ce5AlwQwyvAnX6ebUtz9iwyHKBLp8bkaC0/wVE0r
         jygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4riq5WOrC6jxJv+1e3ONXH5F0cl4unP+M0sgitUBG8A=;
        b=d/pCWuSETcpk3Y23+IwUemF+niJ7AXy9wKN5xH/Y+lrb6NQQbPQKHmz8ZcT7N0PdIg
         LG6EYuaBB/rm3whwpyELuzW/mW0PTtHUDk8AzTGmGFpr6HKMTC3Nb7q4Ij7B9CJnTnnC
         CRBLXS1HCQvuuUaTUzAAhcslgnOIWXvFQ+hdawAoUpbQWN9w3Al1zZ5OiWcSgkKiUcNe
         +UlZH7+JP2SL01O1jdFd5AFEuZwfpawYp52TlODoYZNbsc97x4bHVhY1fhJZfc8te79o
         IaDYrmS2ASX7V+9P1vLbV/AdrUnMzycFnDJsuiH6uybKyx33KPs6v06e0IyA/oVdMHHO
         Tj7w==
X-Gm-Message-State: APjAAAUYUNdrnAsAfjIO//iVVM5mqaH/6EUUNcjWcefDaEsIUCrYZcmV
        DahLfy0pCJWgxPPqdapZl8jOPd2c0SUGRo+JMlA=
X-Google-Smtp-Source: APXvYqywHGWRgscHD3wttrQTCBgSjiAHfAChFkGelESVt8gY5T7nllpYfOpg60tGtOEJ4v9Y/l/47i8eo83/eIeSbt8=
X-Received: by 2002:a02:7420:: with SMTP id o32mr7347087jac.117.1558922166931;
 Sun, 26 May 2019 18:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190523060437.11059-1-peng.fan@nxp.com>
In-Reply-To: <20190523060437.11059-1-peng.fan@nxp.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 26 May 2019 20:55:55 -0500
Message-ID: <CABb+yY0r-njq2OGVP9xAh=-wgib5zk8XbS-vdY1jtz2R=rT4Nw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 12:50 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> This is a modified version from Andre Przywara's patch series
> https://lore.kernel.org/patchwork/cover/812997/.
>
Can you please specify exact modifications on top of Andre's last
submission? As in "Changes since v1: ...."

Thanks.
