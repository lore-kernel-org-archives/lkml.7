Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D8FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B40D20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439036AbfFLMdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:33:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41735 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438948AbfFLMdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:33:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so25465915eds.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 05:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/9+BscyBSG8LtxRtL3bsLVsuCvjxfppgNJUSn3pi0BA=;
        b=dHKW1qzNZwyMVOn+qHOePUQ35FtWe1LEhdHRgQQ6XejmTk73mI96UnD0DRfyc0b82b
         agVXEKrYAal+c4XlyDbWwTf42Q3Ek06h2zAPI4lfi4MufDeQIoiMMYsZ78cKTlDn25vx
         /NtTc8w2oP3ThoCqlSXI8e6PAElGTvic+3CGAfLQGo3+O1T/xMBMe19YMs2pWVCFCmIt
         4O3enn5J6iE4EIDsNs/O29VE2WDl9eM1SRh2B6HIpLEvCg7rKP1PiozuBdiYrLqIUKd5
         O6crjGl9NUWFT9SfqIOIfXZQ8vFyZEwdTn7weXz5S1RB7HxPgVb64VKDJic3uUqeJWkj
         DGAA==
X-Gm-Message-State: APjAAAWSKiNBdcDJHUkvSpnaIofCdlav+q0oEIWgOiHO88uqxrzBwqcg
        ++j8xz9GWXHNZxAVMwC5rmeQEQ==
X-Google-Smtp-Source: APXvYqwH+EIsTHqwWN3f9HxFMK99PgTbuqj4T1Pw/EUS2brCmPFSeeUdToS6/AutI5NLtTDk9/MaKw==
X-Received: by 2002:a50:b561:: with SMTP id z30mr32633599edd.87.1560342787019;
        Wed, 12 Jun 2019 05:33:07 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c21sm2784931ejk.79.2019.06.12.05.33.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 05:33:06 -0700 (PDT)
Subject: Re: [PATCH 4/5] drm/connector: Split out orientation quirk detection
To:     "dbasehore ." <dbasehore@chromium.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-5-dbasehore@chromium.org> <87zhmoy270.fsf@intel.com>
 <01636500-0be5-acf8-5f93-a57383bf4b20@redhat.com>
 <CAGAzgsoxpsft-vmVOuKSAbLJqR-EZvcceLpMeWkz6ikJEKGJHg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fe774952-6fd5-b4ec-56c9-32fd30546313@redhat.com>
Date:   Wed, 12 Jun 2019 14:33:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGAzgsoxpsft-vmVOuKSAbLJqR-EZvcceLpMeWkz6ikJEKGJHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-06-19 02:16, dbasehore . wrote:
> On Tue, Jun 11, 2019 at 1:54 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 11-06-19 10:08, Jani Nikula wrote:
>>> On Mon, 10 Jun 2019, Derek Basehore <dbasehore@chromium.org> wrote:
>>>> This removes the orientation quirk detection from the code to add
>>>> an orientation property to a panel. This is used only for legacy x86
>>>> systems, yet we'd like to start using this on devicetree systems where
>>>> quirk detection like this is not needed.
>>>
>>> Not needed, but no harm done either, right?
>>>
>>> I guess I'll defer judgement on this to Hans and Ville (Cc'd).
>>
>> Hmm, I'm not big fan of this change. It adds code duplication and as
>> other models with the same issue using a different driver or panel-type
>> show up we will get more code duplication.
>>
>> Also I'm not convinced that devicetree based platforms will not need
>> this. The whole devicetree as an ABI thing, which means that all
>> devicetree bindings need to be set in stone before things are merged
>> into the mainline, is done solely so that we can get vendors to ship
>> hardware with the dtb files included in the firmware.
> 
> We've posted fixes to the devicetree well after the initial merge into
> mainline before, so I don't see what you mean about the bindings being
> set in stone.

That was just me repeating the official party line about devicetree.

> I also don't really see the point. The devicetree is in
> the kernel. If there's some setting in the devicetree that we want to
> change, it's effectively the same to make the change in the devicetree
> versus some quirk setting. The only difference seems to be that making
> the change in the devicetree is cleaner.

I agree with you that devicetree in practice is easy to update after
shipping. But at least whenever I tried to get new bindings reviewed
I was always told that I was not allowed to count on that.

>> I'm 100% sure that there is e.g. ARM hardware out there which uses
>> non upright mounted LCD panels (I used to have a few Allwinner
>> tablets which did this). And given my experience with the quality
>> of firmware bundled tables like ACPI tables I'm quite sure that
>> if we ever move to firmware included dtb files that we will need
>> quirks for those too.
> 
> Is there a timeline to start using firmware bundled tables?

Nope, as I said "if we ever move to ...".

> Since the
> quirk code only uses DMI, it will need to be changed anyways for
> firmware bundled devicetree files anyways.
> 
> We could consolidate the duplicated code into another function that
> calls drm_get_panel_orientation_quirks too. The only reason it's like
> it is is because I initially only had the call to
> drm_get_panel_orientation_quirk once in the code.

Yes if you can add a new helper for the current callers, then
I'm fine with dropping the quirk handling from
drm_connector_init_panel_orientation_property()

Regards,

Hans
