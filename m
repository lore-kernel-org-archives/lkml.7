Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A93FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C22924B4E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bEsPvPk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfFDHyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:54:05 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:46253 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfFDHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:54:02 -0400
Received: by mail-ot1-f53.google.com with SMTP id z23so3705428ote.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdoY+3UrNN3k7BHN8aNWywmO5ugEgyn9Qd2QfjzsAuo=;
        b=bEsPvPk0DVDweIcQ4mfy5vBH6qJf5qU8QfBnJjTHYsRGh9+dEiARILOFl/ydAmbbV7
         MgZzKM9EXIWmaiTm3Bhfvk8PrJER6JFWGcS8ncDEY3Vbl/WCN1KsxqNnLq/yGVX+f5sD
         6MngoQU1emapXEOiIllMyTsgK1dJed0uWr9mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdoY+3UrNN3k7BHN8aNWywmO5ugEgyn9Qd2QfjzsAuo=;
        b=M4ghjl8yXUuTiUJGnQ01zmhBr0bGdIWOOd6Ceht3yIZCi8BF9xNXMOWnmB6PRKsnGV
         Ke7MVNlBI5cGOsOpuwk2xvFX0NE+5kiTgv8tcvwIBxIYZgYX76jFpUrASjYXbwyhmnIv
         UQOLlTSr4OycqlKjk3TsBIHJEcJtEv1qIO9RCkmLLOKtqGtFRmGy6zpmwd9UuyLKPSIp
         M92YJjQSBX18Bz7q6QRhSjN6V5S1KwOaJuLRjB6BGuQvtxN2Gy6D0LTp6uFvlt3qPU9z
         x8NBYv/8foPuGD72Ajdjsyby04+BSzFcgTXm+JWn7kKds+E+KJWbLnPIwC72Djah8Adv
         bIAg==
X-Gm-Message-State: APjAAAWGdelvo1lYy/yNJ4ZXGUKNwtWM2ZuC0fhV5o/BEuRUIXDRn5Eb
        TrUUH68i64apzZJ95tKBOEl84ibHHxw=
X-Google-Smtp-Source: APXvYqy0SOTJOHQlZTC04d7efKuFy1Wwq6h1Yd6KsKzwbIaToatzmoo8Cy/y2RKZ9i6FeYtfcWZyDg==
X-Received: by 2002:a05:6830:20c6:: with SMTP id z6mr4396968otq.58.1559634841096;
        Tue, 04 Jun 2019 00:54:01 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id h60sm1502259otb.22.2019.06.04.00.53.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 00:54:00 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id r21so6189083otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:53:59 -0700 (PDT)
X-Received: by 2002:a9d:1b4b:: with SMTP id l69mr4047896otl.141.1559634839440;
 Tue, 04 Jun 2019 00:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190528055635.12109-1-acourbot@chromium.org> <20190528055635.12109-8-acourbot@chromium.org>
 <b4320740-a016-4a0e-b9ae-e042fd305b12@xs4all.nl>
In-Reply-To: <b4320740-a016-4a0e-b9ae-e042fd305b12@xs4all.nl>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 4 Jun 2019 16:53:47 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUTG3Pe6pU=gD0m0N3mOOHGyEp5Je58s3ahH_83a4i1rg@mail.gmail.com>
Message-ID: <CAPBb6MUTG3Pe6pU=gD0m0N3mOOHGyEp5Je58s3ahH_83a4i1rg@mail.gmail.com>
Subject: Re: [RFCv1 07/12] media: mtk-vcodec: abstract firmware interface
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 6:16 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 5/28/19 7:56 AM, Alexandre Courbot wrote:
> > From: Yunfei Dong <yunfei.dong@mediatek.com>
> >
> > MT8183's codec firwmare is run by a different remote processor from
> > MT8173. While the firmware interface is basically the same, the way to
> > invoke it differs. Abstract all firmware calls under a layer that will
> > allow us to handle both firmware types transparently.
> >
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > [acourbot: refactor, cleanup and split]
>
> High-level question: is the mt8183 firmware different from the MT8173?
> And if so, is or will that firmware be part of linux-firmware?

Yes, the firmware is different, and AFAICT it will be posted to linux-firmware.
