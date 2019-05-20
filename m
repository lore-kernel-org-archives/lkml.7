Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CC9C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2529A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DBxlmCZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfETSef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:34:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43043 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfETSef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:34:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so15695488wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=wCpNgUaSRqQ+NRb8eHf40n9iQjypeZPQ4KDEREuAn30=;
        b=DBxlmCZEUqtTCDkrut51v8cijQmVeobqeWrZn7uMddx1ZvlZOOYvagsiLBgOp3+rus
         S4i1vhieKERLcAviEsFOI0OkAbSMYlVEv+z1Jj7GV1PBG9L6XjQV44pdVhnMkkF2HpH5
         8oWLWsXKoOxuLD+POD8brFU5TbH3/c65p7V3DtnIQp2vE/obNG1rj9z5+9Nm6kOy6sSJ
         7H+ibnJql0Ywk/3jjSmrobfZ6TMD6sf0yposEXQfjZpzEU66Ufx+QaQYp9enLyLADJ5S
         g5NEjtzbkYkoQDr3T8t6+yHo183LNES/9DeeGmRGuU1lBSmsv+g9xgEcz3qovO1QaLQv
         XRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=wCpNgUaSRqQ+NRb8eHf40n9iQjypeZPQ4KDEREuAn30=;
        b=mpngrEAeISi2JM9pLAYIXilIA8ZT/rh02F5agHgIJIhP4EQgmFrOZkAbjLQq8vrf1V
         0j3oTf2QMszNH0igwW4fqq8r9l7fQQqhCau0miJRdXxyLtbDNMCwm4mMnagAoGcqiccd
         NhkQM3QFoN+lD0hmCQpOz9X/CYmD9ahB5BKAKLwWR8A4QTL0h+HtPfK1LcPNqsmD6A94
         22yYHYLSBaZT+ZTpxBUuPVOwoURG5ejocBT1BURXpp/xyPl262cHrWAhBohnhXUISgjH
         InUtNxmwS1nas0wWvcGiHzmzv2g0/IeKdPdneAUXjzwgna6qJAvjERDL3ttnPJNAdS8V
         /tlA==
X-Gm-Message-State: APjAAAUvRfaXApw0AwWS2Q+vEL0LsjEmVr1SD0q6oJoSRm/yv/t2zhtb
        TGX4zKEilHZVFgz0XXYsR4YDiA==
X-Google-Smtp-Source: APXvYqyVIBqjTKvFY23aNyMKIltNloLDsuWfNj5r52gjwtDfVYWPC7Y4McdoKdcDIaa8uMytlfuXAA==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr24241576wrw.23.1558377272966;
        Mon, 20 May 2019 11:34:32 -0700 (PDT)
Received: from [192.168.1.77] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id v5sm37487367wra.83.2019.05.20.11.34.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 11:34:32 -0700 (PDT)
Message-ID: <5CE2F337.9060207@baylibre.com>
Date:   Mon, 20 May 2019 20:34:31 +0200
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/10] ARM: meson: update with SPDX Licence identifier
References: <20190520143812.2801-1-narmstrong@baylibre.com> <CAFBinCCEi8OjeDaWxfhyfoQOu3GVsw=U9jBLQ2LEkPn7Ataf7w@mail.gmail.com>
In-Reply-To: <CAFBinCCEi8OjeDaWxfhyfoQOu3GVsw=U9jBLQ2LEkPn7Ataf7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/05/2019 20:06, Martin Blumenstingl a écrit :
> Hi Neil,
> 
> On Mon, May 20, 2019 at 4:38 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Update the SPDX Licence identifier for the Amlogic DT and mach-meson
>> files.
>>
>> Neil Armstrong (10):
>>   ARM: dts: meson: update with SPDX Licence identifier
>>   ARM: dts: meson6-atv1200: update with SPDX Licence identifier
>>   ARM: dts: meson6: update with SPDX Licence identifier
>>   ARM: dts: meson8-minix-neo-x8: update with SPDX Licence identifier
>>   ARM: dts: meson8: update with SPDX Licence identifier
>>   ARM: dts: meson8b-mxq: update with SPDX Licence identifier
>>   ARM: dts: meson8b-odroidc1: update with SPDX Licence identifier
>>   ARM: dts: meson8b: update with SPDX Licence identifier
> please check the .dts updates with my comment on the meson8b patch
> because I believe there are two typos (which managed to sneak into the
> rest of the patches)

You are right, thanks for pointing me to the licenses texts subtleties, I was misled by
the "of the GPL or the X11 license"... but looking closely clearly shows
a MIT license.

Will re-spin.

Neil

> 
> 
> Martin
> 
