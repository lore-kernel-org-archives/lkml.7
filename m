Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDAAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3A120854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ktgJc5kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfDOWWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:22:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40489 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfDOWWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:22:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so9265650plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=lptdN09AWw8dqNZlD1qBwSSlbgj7fwHxdKofOcd3HoA=;
        b=ktgJc5ktdUWFh+RXzUm3uAD2p0pZ7YvBmn8+INN0V/yPjPTLgukY0JCxi0O2IHt9aE
         xygetAonU1mVcAYctyiGDPNY1U/NutMYzxap7XXc3WCK+W/lAgBL50Qj4ZiIQpgkh60f
         /Q/Bi0E7bHQQ5MTMrryk9X2JxI0W6WAKoiflMA6JSQ2KXROZU68RffwtQiFphPscPGtP
         MA5UXX49z8+CUwkRhlUF+txMUN0zIfN8D7RumqEZm326KZRt6HIQ0N4T53trNaVY6hFM
         ItcFLJy2iAtD2q+r5QjszjVttq+ZjOUqD/xAkjoA75K+6nuNRIq8b9DvmPcKC8V+2YAi
         6DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lptdN09AWw8dqNZlD1qBwSSlbgj7fwHxdKofOcd3HoA=;
        b=uIxn9KCOpvSdSrHoGTCnqelgYyP7QB9Inl4S14e6QDvkYSwA89BnkAfevE0pjSBqKO
         6A1xaLWdMWtO0PlB+EsVyceonDzPdMYuHwUJxUsfLS7S1zQZyPw1W9LU7EtGhKiok+8e
         i4qbcVBu6qJx7k++bhilKvdDzQ2Lg01/71fbhRYFeDXNM9gROXJgOIG0g5wvcZht5fjJ
         ImZlRN79a7q4z1tkJe7+bSU2wQjBs6A19mg2XyNTXG2n5/++PtBu87mblDs0e3SB8qA5
         acCWeM9Rg4vyZ2ROL2bRGOJlV12sg0TxYiTSs87dM0VJJTf6ApFLx71BD4vcT33D2Gi4
         cn1Q==
X-Gm-Message-State: APjAAAX16iph/y5QRG6ViARtSeXl5MFsIv8qutdKVIaRpeBs+Zwn3D3N
        pifxi97TSHkbGlXlke0WXOp+yw==
X-Google-Smtp-Source: APXvYqwfyYWiUTTXxdFaINioxbue02XqHvTyGmZQgmfWUuefcgJfNNTp5gxkt4ieJZ3H12wkQMDn5w==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr76226418pla.306.1555366928363;
        Mon, 15 Apr 2019 15:22:08 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:c45e:7ed8:c242:3563])
        by smtp.googlemail.com with ESMTPSA id 128sm38039859pgb.47.2019.04.15.15.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 15:22:07 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: meson: Add G12A display bindings
In-Reply-To: <5c7c873c-0535-0342-26b5-6cb29df9859b@baylibre.com>
References: <20190313141030.5958-1-narmstrong@baylibre.com> <5c7c873c-0535-0342-26b5-6cb29df9859b@baylibre.com>
Date:   Mon, 15 Apr 2019 15:22:06 -0700
Message-ID: <7hmukqrjsh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 13/03/2019 15:10, Neil Armstrong wrote:
>> This patchset adds the G12A specific bindings for the Display VPU
>> and VPU Power Control.
>> 
>> The Amlogic Meson G12A Display module is based on the Meson GXM SoC
>> with an updated Plane Blender, thus VPU architecture and interconnect
>> is the same.
>> 
>> Implementation then DT nodes will come in a further patchsets.
>> 
>> Neil Armstrong (3):
>>   dt-bindings: display: amlogic,meson-vpu: Add G12A compatible and ports
>>   dt-bindings: display: amlogic,meson-dw-hdmi: Add G12A compatible and
>>     ports
>>   dt-bindings: power: amlogic,meson-gx-pwrc: Add G12A compatible
>> 
>>  .../devicetree/bindings/display/amlogic,meson-dw-hdmi.txt     | 4 ++++
>>  .../devicetree/bindings/display/amlogic,meson-vpu.txt         | 4 ++++
>>  .../devicetree/bindings/power/amlogic,meson-gx-pwrc.txt       | 4 +++-
>>  3 files changed, 11 insertions(+), 1 deletion(-)
>> 
>
> Kevin,
>
> I applied Patches 1 & 2 to drm-misc-next, can you take Patch 3 along :

Queued for v5.2,

Thanks,

Kevin
