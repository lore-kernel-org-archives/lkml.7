Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B739C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436E720863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hPUG79Hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfETR4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:56:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46721 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfETR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:56:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id 203so10653056oid.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnU52g/boLPrvaC7Lk7YTaYbB64jJRa17WqE6kdu0io=;
        b=hPUG79HfZRgIOAcjnjkcHWHEsotbZEp7IYdTnhO3sxpo39xGOJj26gWT+GrrmRR6D7
         NV5kY7MYANLoAYuiwh5Zlx6io39iLmeKXbsySsSgj4W3ws68vbPTf65+9uQykZKNhsNh
         hJVpZzdcFRxsPr2vO64EcyPRrqsljP/wdtgLtkbdeQVUNFglfotDJ1sx7eL7eKDSGwb+
         ADLqWW4FBTC3k4XdjDndzP1QhoDJU67f1ev04AOsg/xGHeefce7mRTj3RL/81+Shj9pb
         6rlOFr5eaNXHV5+LY5j2NKHNp9yShShMqaFRuiDnid91kvd5Hkvcaq/EchqMJOoWr1UT
         NgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnU52g/boLPrvaC7Lk7YTaYbB64jJRa17WqE6kdu0io=;
        b=MkjUfGzjzrFfbnGZPEoLvcjbAiU0BXeGSsUcF9rnvbdzVDcDTfjB1dhd9ptpvIvmHj
         pT63LKJMhcaTYBFeS9fLQSBhk+HY5HdE0RidcEalwfcbmxlEWvpHYkz+BtitIE16eaZI
         PEL12+gwlCdllMvysEjUUjv6ucEtwd9XAR9rXiUhVW3Hw3h943M7jgTRt8pFbdKliEQ7
         99Vu20CxPBDhakmoxsmPR2VL47vDrIYvlNMLOJQfZZm1wUvPxSAYp01LWET+t3IRAcln
         tgN0NIZf7+AguRLa8bkQRD4NYkuAjpAA+CAFFSwBtYLLd1uHwyx2u0geszoVjMqFJJHI
         L8gQ==
X-Gm-Message-State: APjAAAWQuXM1+tixo9jbB3ABjwLY4Ex1wKbeOUfID8kTROMmiw1YaVYa
        A2NdTZKDsRu6yZ45KjsxkXWjcbtERZSgoz6kAJ4=
X-Google-Smtp-Source: APXvYqypP7Pacvyt44dFZalPqQM1rwMz7wLXcmXZyakgBMi7D5OnzzpRmOas/Vj22KygufhL8H7XqICxyFGZBT7JDWg=
X-Received: by 2002:aca:f144:: with SMTP id p65mr278504oih.47.1558374968921;
 Mon, 20 May 2019 10:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190520143551.2330-1-narmstrong@baylibre.com> <20190520143551.2330-2-narmstrong@baylibre.com>
In-Reply-To: <20190520143551.2330-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:55:58 +0200
Message-ID: <CAFBinCDcs0YNpbe2ezn0bzE7n0PYj1u+Wx8abiBZRMBTAGye=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] phy: amlogic: phy-meson-gxl-usb2: update with SPDX
 Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:36 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
