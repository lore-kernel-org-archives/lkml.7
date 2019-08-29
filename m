Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFE6C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3327E23404
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0ftpj6xZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfH2Ojt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:39:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37903 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfH2Ojr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:39:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id e16so3708361wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FShUYmpojXqD91qD2VQWKES2PpwI8gR+TS0hREDpeNg=;
        b=0ftpj6xZNoPnvIzgnjbHG/aJr3YHegwO8wl279E3BArfSZQxwDoBUu0rJrzRAXGF2A
         XVdp+sxsYp2O0Vhu4raX4uJjyJ6haP/vT2+jzSbWBwDZYOXjefzossTbVV0bQDoQmjTX
         VIUQxHlPIwUKMgZaOsyYdZri4q0lygOsthe59VXcgMEF+YWO20GLLbE33xH2H5foNxvk
         J4Ec9AyVNv6g+Wnj95cAWZ5hfD0b0PTA0CFLLTdyT1pExxeRza/o36B7slWihyWX/z8G
         Gojf9QOpJAaiuOQaUls/hMyzfBpQyCyQGxaCvC2fCt5BFnm4mO4bS6Fd/PPfECKP8lPg
         Q2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FShUYmpojXqD91qD2VQWKES2PpwI8gR+TS0hREDpeNg=;
        b=UIJcwlUB5JQd4SyaC0PtgxGlNJP/Qm/lPoDTbyOJ4pKi3SX8a2vbFrb/wZSvqRoNXY
         S+MKzePEIYY/muEDLqukoKBANJxHWHn3Fv0A248fuhcOWcVTlKqrD2QFRzozFjLxSLS/
         B3cXXL9+ciX4dQZhnrqBkRf5fHMokuIT+EOWzN1CG307w21vTRBPX0X1QHACTsQlzZ+z
         A+zL+9AkYqoEa/U7ZXyebJMuz9UIetSl1+mBkkn6OLG5cbDW1okA0UUMYZFCp+9aQoN2
         wAqQSAAltkP75fSg2TGEdNnurL+kL/OqHrMWAGBd4AJeUI+dFqgs8FMhX+5Jz08KBWps
         e7rg==
X-Gm-Message-State: APjAAAUFbtFulVY8HWASOvXp/7gReN20OoVIZjOzNDISadxDwsuWlzD1
        iYqVnYUJpEMKNrZG0FmxbMIgl7Ylnc47ng==
X-Google-Smtp-Source: APXvYqwYkf/teAXMDXjBSarnDX5tyWrHvMSPMUbg/1ctXaCS5fY7GTEvTTK7xJ01Nf92vom5WehJng==
X-Received: by 2002:adf:de8e:: with SMTP id w14mr11944917wrl.79.1567089584611;
        Thu, 29 Aug 2019 07:39:44 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o2sm3151404wmh.9.2019.08.29.07.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 07:39:44 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] arm64: meson-sm1: add support for the SM1 based
 VIM3L
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190828141816.16328-1-narmstrong@baylibre.com>
 <7hblw9rx8f.fsf@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <70d75312-68f0-351c-26b8-0f357721dd9e@baylibre.com>
Date:   Thu, 29 Aug 2019 16:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7hblw9rx8f.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2019 19:55, Kevin Hilman wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> This patchset adds support for the Amlogic SM1 based Khadas VIM3L variant.
>>
>> The S903D3 package variant of SM1 is pin-to-pin compatible with the
>> S922X and A311d, so only internal DT changes are needed :
>> - DVFS support is different
>> - Audio support not yet available for SM1
>>
>> This patchset moved all the non-g12b nodes to meson-khadas-vim3.dtsi
>> and add the sm1 specific nodes into meson-sm1-khadas-vim3l.dts.
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> 
> Basic boot test + suspend/resume test OK on my vim3L (thanks to Khadas
> for the board!)
> 
>> Display has a color conversion bug on SM1 by using a more recent vendor
>> bootloader on the SM1 based VIM3, this is out of scope of this patchset
>> and will be fixed in the drm/meson driver.
>>
>> Dependencies:
>> - patch 1,2: None
>> - patch 3: Depends on the "arm64: meson-sm1: add support for DVFS" patchset at [1]
> 
> I tested in my integ branch where this series is applied, but I'm not
> seeing any OPPs created (/sys/devices/system/cpu/cpufreq/)

These patches were sent from your integ branch, on top of :
commit 395df5af4c782ad19fb34b9a2009ca240eeb9749 (khilman-amlogic/v5.4/integ)
Merge: 2fcc5666dd45 9557737987bb
Author: Kevin Hilman <khilman@baylibre.com>
Date:   Tue Aug 27 15:39:46 2019 -0700

    Merge branch 'v5.4/testing' into tmp/aml-rebuild

Rebuilt and retested, and I get the OPPs just fine :
# cat /sys/bus/cpu/devices/cpu0/cpufreq/scaling_available_frequencies
100000 250000 500000 666666 1000000 1200000 1404000 1500000 1608000 1704000 1800000 1908000

Here is the boot log:
https://pastebin.com/LY21gU9E

and .config:
https://termbin.com/1s5g

Neil

> 
> Kevin
> 

