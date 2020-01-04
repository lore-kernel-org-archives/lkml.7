Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADD1C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 02:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F31D222C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 02:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENw57qnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgADCEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 21:04:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43093 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgADCEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 21:04:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so32996281lfq.10;
        Fri, 03 Jan 2020 18:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DP1fYoznEacFSbgWsSDZL+rwUQxQG8vzPv53EveY774=;
        b=ENw57qnUM0Ch8wLUwrLe0Lhf0ax96F+wK9PrLkOSXC9hQkS9xluescyFCdr7bG4Twq
         U7KgCZ/+R28tGTo/Pe09DwKX9piauepr8pDeEdYeOhpt7AluAGpAhD8BWac9nCJDqvzp
         +BW9G4twPl5CUD8+4LsHs5sI3waUDns3Kygx9LqNlTvIAbDSmzjSjYjH1C1wos8F6fl6
         cBxfcD6bZTdztSDMu9vKRvbnNJELYatMk/3t9JDKYPZogages1aI6PxkbLLNyrI9xWe8
         4rqeRsZ/6fuuQZp+PtAeMPBTyLDIDoRq6h1HFD5e+j9THOyK3BH4ZJq6lSHn0cosnPSX
         3ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DP1fYoznEacFSbgWsSDZL+rwUQxQG8vzPv53EveY774=;
        b=FcD5inX0Asg+UMn+GQV+e2bAbOiQVBA9F0IW/Ss+bqUfT+X0n1pSs+s2MCeU2TO1jH
         Yho+EN8jotbLtDfWa5U9WIUI3TZmrftO/Zo+baVtThoYyS5AMmmgPHPbWyYkfuABjGcJ
         qgMVYQ7S4WMRk+OwGjb3FqohuPvcwYduTIQqYYVC3LaKlH3FueH6SU1YERYnaOJorn+3
         uyLDyPZsn2Bwadd8+9wVSyRELMn4ITUzicHMiGpRiN/+mw/CB+1cMWQwrR8++YkGL9AF
         JXiQJvwTmIEsG+NPQ0c56EVq7Wn6+cMp5zIi7sz4tHh1DKfrGa/puMBJujh/+QPngeHN
         80Hw==
X-Gm-Message-State: APjAAAV3A0q/UC6l1EtZhV8F5pYJXv+QKxvEDywDCzTsV6iRsY9u8Jq0
        SFnMOQTRNb16NoCMZo9MYUUZTRG9
X-Google-Smtp-Source: APXvYqz/P3UeuIynbTD2ACZJlI96d20BxjSLSMXbG6FDOyMTE8bhGAkaJyn6xBZGCOqVbhw89Cl+EQ==
X-Received: by 2002:ac2:46dc:: with SMTP id p28mr51678437lfo.23.1578103480073;
        Fri, 03 Jan 2020 18:04:40 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e8sm30021439ljb.45.2020.01.03.18.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 18:04:39 -0800 (PST)
Subject: Re: [PATCH v3 01/16] dt-binding: usb: ci-hdrc-usb2: Document NVIDIA
 Tegra support
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191228203358.23490-1-digetx@gmail.com>
 <20191228203358.23490-2-digetx@gmail.com> <20200104003341.GA5889@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b24a37f2-1515-9586-ae87-864272b87410@gmail.com>
Date:   Sat, 4 Jan 2020 05:04:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200104003341.GA5889@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.01.2020 03:33, Rob Herring пишет:
> On Sat, 28 Dec 2019 23:33:43 +0300, Dmitry Osipenko wrote:
>> NVIDIA Tegra SoCs use ChipIdea silicon IP for the USB controllers.
>>
>> Acked-by: Peter Chen <peter.chen@nxp.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Thanks!
