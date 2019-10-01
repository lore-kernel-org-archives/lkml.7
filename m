Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61ACC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A4D215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TpvppLf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfJAJk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:40:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40856 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbfJAJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:40:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so14607499wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 02:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=UzvLIkrTSi/epemgPJ8AXmPaJAGF16PPZin3f/2spag=;
        b=TpvppLf8WLWVp9DomSHJfRS+c1F4tZNVBDGJDc6uMvD3qLIjsRJ9isqzG7ARg31F7H
         WuCIZ0QihSFQA7WGB0e6Hmwy/vxTte+2fmlwPIpi/Bt7RBmN47RkGoUX/cEiNqE+BgzH
         trM9KE0xmDwnDrzjlxZ6MELCU1aDjLYWc2puO1IeukTMI1wmD1xAnADamSFNmx1qILUB
         O+zCVNDAARLMyP20ieMb5WFhecLROs+VxAlOMyrjgw43gct9EExlSRU5M2Ie9Z6IT0Ec
         aaV6huX2lmCtKVDrBHY+oB6eMt4ustgfcvLM2QRfRdTTkgjpTAglRn6/tdTB6S2mkg88
         +QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=UzvLIkrTSi/epemgPJ8AXmPaJAGF16PPZin3f/2spag=;
        b=L7Z+CICAv8fOuZOjP9Pr+wja/FEdYl9DtB8KO1SnrmPoWmzIO+BryYTEp9dZ2ufzx3
         Z6M205XHQX4k7+kMhsarqMCGGrNMrZty6AjSAgNSs+oWNOdWOEZWCmwAQojlGWtfQEay
         BoHEPTx+BeqYKHH1VdFwl116PayNXpq9Lj5wBk4iQgrCX+8dxMofXiezam3ASodWDSft
         DYTkks8EB6Gw3173v5SUUkZPAB9II0s4gteP27iIqnXYffn2dzctQrXEpQWqPrbyNIsJ
         3s1zmjxB9Wca2qLbNEtPj6F+r2SVYwAFnKAw6IhI+fF6zb38MKouq9qV8AgZYjzwAbHU
         VIDw==
X-Gm-Message-State: APjAAAUxPvMV774aDN4qWj3Ol2WmrGvRyrs3V2vIj8imvTXbOP1HvKHk
        LtadrLlz7R84BvIUxlkvXT0hRA==
X-Google-Smtp-Source: APXvYqwyIWVUUG6BoVZAuEAlFBkPxd97wknxy9fL/CaSJF8Tr2znTOAsBGffEVJ4FW38j9dZAwkJfA==
X-Received: by 2002:adf:e64e:: with SMTP id b14mr18036441wrn.16.1569922822301;
        Tue, 01 Oct 2019 02:40:22 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b5sm1925895wmj.18.2019.10.01.02.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 02:40:21 -0700 (PDT)
References: <20190905135040.6635-1-jbrunet@baylibre.com> <1567693618.3958.4.camel@pengutronix.de>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] reset: meson-audio-arb: add sm1 support
In-reply-to: <1567693618.3958.4.camel@pengutronix.de>
Date:   Tue, 01 Oct 2019 11:40:20 +0200
Message-ID: <1jk19oregr.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 05 Sep 2019 at 16:26, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Hi Jerome,
>
> On Thu, 2019-09-05 at 15:50 +0200, Jerome Brunet wrote:
>> This patchset adds the new arb reset lines for the sm1 SoC family
>> It has been tested on the sei610 platform.
>> 
>> Changes since v1 [0]:
>> * Fix the mistake on the number of reset as reported by Phililpp (thx)
>> 
>> [0]:  https://lkml.kernel.org/r/20190820094625.13455-1-jbrunet@baylibre.com
>> 
>> Jerome Brunet (2):
>>   reset: dt-bindings: meson: update arb bindings for sm1
>>   reset: meson-audio-arb: add sm1 support
>> 
>>  .../reset/amlogic,meson-axg-audio-arb.txt     |  3 +-
>>  drivers/reset/reset-meson-audio-arb.c         | 43 +++++++++++++++++--
>>  .../reset/amlogic,meson-axg-audio-arb.h       |  2 +
>>  3 files changed, 44 insertions(+), 4 deletions(-)
>
> Thank you, both applied to reset/next.

Hi Philipp,

Looks like this patchset missed v5.4-rc1.
Could you provide a tag with the bindings to Kevin so we can use the IDs
in DT until the next merge window ?

Thx
Regards

Jerome

>
> regards
> Philipp

