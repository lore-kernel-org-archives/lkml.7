Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8F3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B675520828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kdspBq6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfCRTii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:38:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39199 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRTih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:38:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id f10so8095790otb.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpPMovfbLs9/tBz0zB96XqyHPfbK74z+0dXPs8hdsmI=;
        b=kdspBq6L2UtgufwmsQbYUokgX25Rr/pC55XqnBbc1LxBNyKZ1AVdQmzvNkVOSP5D6v
         E6iVofIlgSrRCKH51DioH6Ssb4/0woqAok7RqQkZkneeD2GDGJP9vFwVjOq5vtK/gnkS
         9V+ppR5XagtoOZQ2DnnpX+IndCnrC8uptTyIfzUaqeHHiGFC60hmu1MKJ5FJkUkIGLsJ
         OIsLGKHyTsxidmEgBd06YNn2/9WXE8rDfHV/9m2EkFeKPXSdIerCFZcrnNbHfsL35gpD
         tIOzcCS2VoBymMnbTkl4c5g/trzh3yGO3HsC4t2EBupTKr6bd89vu/EO+2yAQDvaSM+8
         kg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpPMovfbLs9/tBz0zB96XqyHPfbK74z+0dXPs8hdsmI=;
        b=gPNLKpQBLPoZt3K+K0rlzQa9eGPirNKfaQj4UKPVHG3H3ktEXqN7A+UUAEOXimkprX
         b+uD/fDZzpobGnP583OeT0QPBj5qd8moyEtjrzt8j/0nPEjImpn+OKS7Sog8jrSVQpDa
         HK+gpIlO4Pkr5xKksKkFbYk9UxYILh42yUB6AS0KN8WIiIlpcmqj4jt3fOtnZF+CefWT
         tUbwu3XG3e25m5VRxUsCFZTEy/d/BPGQEmgblBBKEXi2JEEn2wJL0Zy6ZE7zfNdbBkDX
         W9KPJbaR7no1nH6NMX4sBoK+qpT6x1FjZW7lKPVDChcZJsK+vgeWnEq1wDz8yaPqcyE0
         cD+g==
X-Gm-Message-State: APjAAAWLMKCMnAmqVbXUZapxnQffg8RNFOka84ChnD0AASlS57Rz5mrZ
        7vlaJoOO6gS0/FSA7ZfmyDz1wlPlITi6Y7lM13A=
X-Google-Smtp-Source: APXvYqw/5WJXX8RisMxRxRIC5eSSJ9m3tBc6GyhLi26aoXIhtKiu024QjOSIqkGcrswZErmlFCTfMgyqUgJjar+ELAE=
X-Received: by 2002:a9d:6306:: with SMTP id q6mr11239674otk.86.1552937916954;
 Mon, 18 Mar 2019 12:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190318095851.4062-1-narmstrong@baylibre.com> <20190318095851.4062-4-narmstrong@baylibre.com>
In-Reply-To: <20190318095851.4062-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Mar 2019 20:38:26 +0100
Message-ID: <CAFBinCCjfGJzkLd3C-R4VM9fwKfrA6gT511CFkERcAyyvApXzA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] arm64: dts: meson: g12a: add uart_ao_a pinctrl
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:59 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Jerome Brunet <jbrunet@baylibre.com>
>
> Add the always on UART pinctrl setting to the g12a soc DT.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
