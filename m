Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81025C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3992238B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="enwqPukv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfGWCQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:16:36 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41235 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfGWCQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:16:36 -0400
Received: by mail-qk1-f193.google.com with SMTP id v22so30011192qkj.8;
        Mon, 22 Jul 2019 19:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7GgnchVxa85kofAIjboqJCKA6VShjGUyfwivNl63GJ8=;
        b=enwqPukvvi2Os0t54GJuz6TCm4CbxxKrSuAL/QdPmtJdzjuFCj+I3xLRmS9ubxIVnU
         BmX3XK1IKQ5Bp0Kt/rsUlcMLdEBkkWjkLRdZWwI1i4MFfM4/gIPrgaFA4uZFUnjSXwTo
         BJKEsm19zmW8OfM4acCvQ/4de/DyLISE1/szE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7GgnchVxa85kofAIjboqJCKA6VShjGUyfwivNl63GJ8=;
        b=aWP401S5NUvUAJWQoVWOXvRIGPvrERGQVvQrWxKAy2SQzliBOJblbrEfgGyLXpWOIh
         L5iHptgwC2Ldi9TGRtubb0GAQJ/94hSs9rRGp6vUYDiUa1/QKPKjMDgDbCjPYTbgOYLZ
         /MFp6seg7sZ//zhlVDahoFqZ+lEmTGrVZQAOaO/ZbW1od1H/UTa6ITMxYs2ftG9TswQH
         d6JLYWFyvyOBk/ECkhfcMQPC1AjHvof+sGZRuZHNAR0J3JuEISkjjQXUom0uQn+mlYYt
         eF88QenYofTZGHWyQ9yZrG298inGschoYWA0mjUW0GR1Ca8+8dIt6skWaZgu0qliTq7+
         ToOA==
X-Gm-Message-State: APjAAAU2ftNR4ta/H/m6Qcko+UwMb310vHVFXUQOidtCfG0/j/VxFDDS
        w9ckG2mAQLMoSBKyPwaQWeeSq67/p4iVRTsmqUU=
X-Google-Smtp-Source: APXvYqxU3suR2c+fS3yT0aq2lqnTUt++7MYnhK9oL6tGmvBmBmm6edtD6GqRPtAqNuBdgfYwI2gPuRDH4KkZOah0kFs=
X-Received: by 2002:a05:620a:16d6:: with SMTP id a22mr49006146qkn.414.1563848195224;
 Mon, 22 Jul 2019 19:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190723003216.2910042-1-vijaykhemka@fb.com> <a0a8162e-c21b-4b3d-b096-1676c5cc9758@www.fastmail.com>
In-Reply-To: <a0a8162e-c21b-4b3d-b096-1676c5cc9758@www.fastmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 23 Jul 2019 02:16:23 +0000
Message-ID: <CACPK8XddLM934ArbA13GEN6m9KpgOkQattE5p8qBpv-yL4mJ9Q@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: tiogapass: Add VR devices
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Vijay Khemka <vijaykhemka@fb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 at 00:40, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Tue, 23 Jul 2019, at 10:04, Vijay Khemka wrote:
> > Adds voltage regulators Infineon pxe1610 devices to Facebook
> > tiogapass platform.
> >
> > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

Thanks, applied to aspeed's dt-for-5.4.

Cheers,

Joel
