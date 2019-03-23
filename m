Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36183C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 09:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F350A218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 09:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eaoi+4VT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCWJzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 05:55:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46083 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfCWJzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 05:55:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id o1so4818864wrs.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=JM4qLmyqXI9ppIvoMALQtWz9jrINBuzbmUFLvlyIlXs=;
        b=eaoi+4VTSHow1StChlzuH4TDeb1l87i+7cx17QpCWK+H9iRABRmR7RX7CaWzKMGAfl
         h5Q1/5afp5+KBCpwSSHHoyhbBjt+PC/72c1vyXSwkmsrVjaSrDkaxX0INBKJFtLXmern
         1Gvyy+9UB+7xadd2yxAph/IGHy519R2pahiSwcp19waMuEunpC5zApbaX8zM8xbo2Llz
         L+hLZonXU7QGz1wcgb9Rp2lMYHNdAGlQOHw72VvWOhZMNZNE49bOVVzl0ofSCCucRgG7
         eL6tyC09I/izyKHICkva7q2/mwrcEJVrV+v4OlE1z28z4AzJNDSMe67mV/o5YKosmdC9
         DQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=JM4qLmyqXI9ppIvoMALQtWz9jrINBuzbmUFLvlyIlXs=;
        b=QqnA6QZQO8bKDoXhRdrBR/Z70HLIijgc/jlyJMoudSmu5VAIPGI+VpAgs6QYWVHFL4
         /QHuyiueo7JxY+M8ZPcd6b39yg5CNp+5z6nPALHpBB52Pk7HiUk0H73yGq1Nj+v8xdxL
         e1KdFRrlZtPhDGw7ghKjn7HFG/XAgAv5sAOYPWOYVO+nvlhAukMqwEO/Nw4j1L/J6TTI
         TFlJnUqwo9+CfRCGf+CY/agDRlMBOlNCFCR0XVTPV9Z1Y9gKIDk+MECGeH+80GZW0N5e
         CB+8SHMLNjtO19r7SHnvZNt7yvUVz6qU4UAFvHB7BB+nOU03G0y4SUZEuvM6sNs2uHMG
         K7+Q==
X-Gm-Message-State: APjAAAU1EBBbrGXKsRRmtrEqFx69hVTzAbBQAOsVI05kz3E+EDlxirE/
        rgY6ZJKyysLzQihMAQDlFFRpOg==
X-Google-Smtp-Source: APXvYqwR4HgC8huANOv4HaD9eDdX2uaAhRZOcO1xRJ1RTHkFpIBNJO6xSZLdcygL1iL5Ty8GUEou5w==
X-Received: by 2002:adf:9103:: with SMTP id j3mr9236460wrj.236.1553334948844;
        Sat, 23 Mar 2019 02:55:48 -0700 (PDT)
Received: from [192.168.1.77] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d6sm10817120wrx.62.2019.03.23.02.55.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Mar 2019 02:55:48 -0700 (PDT)
Message-ID: <5C9602A3.6010607@baylibre.com>
Date:   Sat, 23 Mar 2019 10:55:47 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Kevin Hilman <khilman@baylibre.com>
CC:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] arm64: dts: g12a: Add peripherals
References: <20190318095851.4062-1-narmstrong@baylibre.com> <7h5zsa33yu.fsf@baylibre.com>
In-Reply-To: <7h5zsa33yu.fsf@baylibre.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 23/03/2019 00:05, Kevin Hilman a écrit :
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> Add following peripherals :
>> - AO Clock + Reset Controller
>> - Pinctrl
>> - UARTs
>> - SAR-ADC
>> - USB
>> - Mali GPU
>>
>> USB depends on the PCIE clock and missing Reset bindings.
> 
> I left this one out for now.
> 
>> SARADC bindings is merged.
> 
> And this one, as it depends on new clock IDs.  I need a stable tag for
> those.
> 
>> USB bindings has been reviewed, but not merged yet.
> 
> Also depends on a reset patch for the IDs used.  This was just merged by
> Phillip, but I need a stable tag before I can merg this.
> 
>> Mali GPU bindings are still in review.
> 
> I've left the Mali nodes out for now also.
> 
> IOW, I queued patches 1-5/8 (branch: v5.2/dt64), and will wait on the
> others until their dependencies are cleared up and/or I have stable tags
> to use.

Ok, Thanks

> 
> In the future, please note all the out-of-tree dependencies for the
> series.

Sure, I'll add more dependencies details on the v3 cover letter.

Neil

> 
> Thanks,
> 
> Kevin
> 
