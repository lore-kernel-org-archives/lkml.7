Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FDFC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B1920645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GMPzdLkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfDWOHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:07:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37616 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfDWOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:07:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so243254wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bYQuDANAvEzcNoTTvVTiwiok37mqdJnLTf/0CFWlbFk=;
        b=GMPzdLkOHLLG8OA3685mgyADgQhw07ltg5ENwoBtTLUBBndpVELtetgzJFyieS1T8E
         3ujUfE2J/jkfBigobfI5Er3uI3aCIsf7gHPEk5rJFh47FUAFhI/uPYy5+wc9I90fdfaw
         qt0OPmOOh3PKaWkeZcge0rRbn2lR+Iqf2yjVgCUnx6uwOfwm/0mVpwI9XEciJl1FlZaI
         B3BW5cbfpmIbJaZ5TO3nyxVT1cMhdZIerBfnt2Kdd047QJe92v1TdbYsyGqDEIlHHGCc
         cREMUBHE2DrWWtV+D1LcG2C9OlEuhL+bb3JDSJ5P2T3vDREmyn7vR1uqagR7nIo4trYQ
         4icQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bYQuDANAvEzcNoTTvVTiwiok37mqdJnLTf/0CFWlbFk=;
        b=dqO1Y14REKgWKADzWdHM04kRAmPdbQGEHbyY3ir+Spq0kNAhj+fDBKyJBe6SjvLI4R
         WQEIkOEFYXj8WfRzbPdweEoh0mTS9lt1p6GEg3VQ5kESOjjFlaTQTiQZsKm3QwJRWpRu
         ELyXoMwjRTSoZue+4OYcXQkmT8f19ZcBeH4UHgl1r1uKZXLEJwh5GdWO28uGGtyneUJ+
         i9UABsWdtOiC861IWwEfu+3LAx6vy6gee56cVbP0FNptuy+lFq2Yts1tOSWG7CtPR22W
         40G8fj0ZbyoqreQTbdeuT5FI27X5nhn6QSbJQgzSo66zrOXTI4ElIxxrYivu2HbttEjU
         O00A==
X-Gm-Message-State: APjAAAUC9AkplQHcyI6ChsXsZZ5BnpzBkeVQ4uOXt3Of+79PMjyketkF
        KGesTLBVfgK40oLoPp8qVjuc3CZh6y6omA==
X-Google-Smtp-Source: APXvYqwIjgoBh+8YV5fGvqNC6X2l/S4NuKOWocLDdN5gmFEEU+rotMOTZVeAJlC1miwWYSd5W2S9IQ==
X-Received: by 2002:a7b:c115:: with SMTP id w21mr2484662wmi.55.1556028419084;
        Tue, 23 Apr 2019 07:06:59 -0700 (PDT)
Received: from [10.1.3.153] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h8sm15562642wrx.45.2019.04.23.07.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:06:57 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] iio: Add PAT9125 optical tracker sensor
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io
References: <1556016046-31231-1-git-send-email-amergnat@baylibre.com>
 <1556016046-31231-4-git-send-email-amergnat@baylibre.com>
 <alpine.DEB.2.21.1904231302210.24175@vps.pmeerw.net>
From:   Alexandre <amergnat@baylibre.com>
Message-ID: <8abd482d-ae1e-ba86-c050-317fc0208fe6@baylibre.com>
Date:   Tue, 23 Apr 2019 16:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904231302210.24175@vps.pmeerw.net>
Content-Type: text/plain; charset=iso-8859-7; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 4/23/19 13:33, Peter Meerwald-Stadler wrote:
>
> how is this thing different from a mouse device?

I developed this driver to detect the board movement which can't be 
detected by accelerometer (very slow motion). I admit this use case can 
be handled by an input, and I'm agree with you, PAT9125 driver could be 
an input. But this chip is able to track different kind of motion (flat 
and rotation), and additionally have an interrupt GPIO, so using it like 
input limit the driver potential. This chip is designed to work in 
industrial measurement or embedded systems, and the IIO API match with 
these environments, so IIO is the best way to exploit the entire 
potential of this chip.

As I understand (from 
https://www.kernel.org/doc/html/v4.12/input/event-codes.html#mice ), 
mouse driver must report values when the device move. This feature 
souldn't be mandatory for an optical tracker driver, specially for cases 
where user prefers to use buffer or poll only when he need data.

All other comments will be fixed in V3.

Regards,

Alexandre

