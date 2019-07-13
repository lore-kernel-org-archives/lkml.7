Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3584C31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 18:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F37C2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 18:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7ZiMI/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfGMS5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 14:57:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44847 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfGMS5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 14:57:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so12383993ljc.11;
        Sat, 13 Jul 2019 11:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1DMwibKvZCBQwsKwsGLbs45A3tB2NhY6KAKu789sECM=;
        b=Z7ZiMI/B+AwP5+Nu0a832zRw3pILi8bsCjFiZhmXOQARtYiTVtULJtVw6q7ipCIMq6
         XtxCiPVtXBIs8T+FJCxJTCSdA6V/SfcDCeNOYS0ykYfMvxDFjOI8l47xMeEmrvdPcSIg
         rGfMQ6488rOfJlGGM4a3qXGg/PVQjyLjsYg9m2G9Cwf12Ja1KoZmZEYDG9cqqjTfwOh0
         HD6dptz1al1/mm3MpL8ftA/zDzCw5OMxCr8SqNi8yNHpUqnemwx6ZxsFeeWpdnA1w+8Q
         xhJgFGHhaZ5fMF9szwe/sPYi55lOMi+t3pJ/yAIIuiRAH2wFkLRxBKHNq9XuFqv4q4ZK
         4j2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1DMwibKvZCBQwsKwsGLbs45A3tB2NhY6KAKu789sECM=;
        b=nj4Z2ghVYNh3ywqZMUekgeKn0hsz+aUbmF7bjTkwk/fUQL4WiHh+pvVkGhpczk2BeG
         AI/h5Uw03gERF7Q/IFlzxyQh1+fc/Pm238TZVkeQIcKmj/oynNPs46YtEsZiNDPS5eqI
         XsDo+24zRX4IDkMdxrc0rZDRM/cJc1oqaa5qTwjUkT+SptnT5ogrdr2+9uUn8W3G8wmL
         +1YimY10QPD1z28OZiYZVtGGGZj4zcqdSl4iCAf8/uI5EZ3afEcjIN2hE1MqJ7/BOjTy
         VXlDuaFmbN+214wCdNZDAMw0QY/ptcZPm1Mr8jB/GGdzibcwxoQizzCI2VfvlYq770Tb
         xM/w==
X-Gm-Message-State: APjAAAUN3+XQ5Tz9i1f+Rnr2cP761nAQTlhHmSuTXjuxpuqyPg4If7Pg
        wbx30Z9ut965JO20qS9emVK5GRXS
X-Google-Smtp-Source: APXvYqxNyzCSv/eKGElqM9iJwmHCu1kHSKZrRaq3BPn3cU5K7rbOFEc1UQgFYqjoELx45FF79WpqhA==
X-Received: by 2002:a2e:25a:: with SMTP id 87mr9505577ljc.183.1563044254326;
        Sat, 13 Jul 2019 11:57:34 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id u13sm1584252lfi.4.2019.07.13.11.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 11:57:33 -0700 (PDT)
Subject: Re: [PATCH v1] drm/modes: Don't apply cmdline's rotation if it wasn't
 specified
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190711021313.29445-1-digetx@gmail.com>
 <20190712195429.dlz5ofwoafciedcq@flea>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <11723cfd-12d2-5810-70df-0e053352d648@gmail.com>
Date:   Sat, 13 Jul 2019 21:57:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712195429.dlz5ofwoafciedcq@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.07.2019 22:54, Maxime Ripard пишет:
> On Thu, Jul 11, 2019 at 05:13:13AM +0300, Dmitry Osipenko wrote:
>> The rotation mode from cmdline shouldn't be taken into account if it
>> wasn't specified in the cmdline. This fixes ignored default display
>> orientation when display mode is given using cmdline without the
>> rotation being specified.
>>
>> Fixes: 1bf4e09227c3 ("drm/modes: Allow to specify rotation and reflection on the commandline")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Thanks!
> Maxime

Thank you. Please note that I'm not a DRM maintainer, hence either you
should pick up and apply the patch by yourself or somebody else who has
the commit rights will have do that. I guess Thierry could also pick up
the patch into the Tegra's tree, but this patch is more DRM-generic.
