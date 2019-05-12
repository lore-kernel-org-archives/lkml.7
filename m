Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2E3C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F79721019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjM1S5rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfELRnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:43:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39365 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfELRnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:43:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so5884673pfg.6;
        Sun, 12 May 2019 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RpfQWsV4Cbteqis6flWSQny0WpQ+Omw4oCErU7z7boU=;
        b=fjM1S5rHQqQcQd4WKjcxpSpf/RFROidSPqgD621jf1QPwRyL0r+h5EwLAMqv1Obsbq
         CGGMdJweC0t63KEYmq6MWkdav2WloDvQoZN/SJxecAMgoOkQ/K7fAxBZ1pC9l/dPGndk
         C4L/Jc9sIsCmgfqorFyGMPsz3wN+i/jthDI6dq0zfn61d4iJhN15CAPJD2vDiJht2+/1
         JEcSDTmE/mtYq0qyn3NONfVE4e1IyE1/Azv6YEtO68QeCVlgg4DNNKKEILhpGrobLQD7
         T2BgJHi0qQmeBhVNWv0iF5qX7FUdEBYgHpH56YzJ1+Xn4a3IBzxGpkzmh2Y4vA1pBH9v
         29iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RpfQWsV4Cbteqis6flWSQny0WpQ+Omw4oCErU7z7boU=;
        b=XknaEIH+x8U1+WW+XSVW4p52KoWDePrxymTLGOLg6XBU1fm9hIna3mNjkL54wpPRec
         U3Ei6IjdHpgEk/WJtXhQ+9BL13kFJqNdlU6XewgNHLfaLbD9VrvgQ3piaAiQip4xV6sP
         OiI+ZS1sjAno+sng7zBug5bVT0AYzcF8LBgIcJOJOATc7bazxOCrUcfTgQm+E6rUdXpw
         4mMMABy7/1fnEQqVbiGtUXjEJlH+jyoQPU8JEFgrnPfAMd9NEfkPl1210k6kpHQwkmQI
         xNcImoRy1hIUM+v68sBXqu5+NUw0eETvrg/1Cacgchzit8sxPpTt3jTCtJMh3oY2FzPG
         zFzw==
X-Gm-Message-State: APjAAAVwclL4qchHd62LMxWal3mJKqq5W14IucumH7BsEHI9ND53lBha
        zTbk3JkoSjA5DatHa+artSRCoga5
X-Google-Smtp-Source: APXvYqwA2JLRsVBcHD5XrPTOoDV9t5KwrAn9xuuMjj9Ou0loLok0YzAVyBhvlltiUo/rZLTLoCgOBA==
X-Received: by 2002:a63:170a:: with SMTP id x10mr25927719pgl.355.1557683003371;
        Sun, 12 May 2019 10:43:23 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id m6sm1125842pgr.18.2019.05.12.10.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:43:22 -0700 (PDT)
Subject: Re: [RFC PATCH v1 5/6] soc/tegra: regulators: Add regulators coupler
 for Tegra20
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-6-digetx@gmail.com>
 <20190508075706.GW14916@sirena.org.uk>
 <9756d8ca-0778-5185-5b6b-3168d63819ec@gmail.com>
 <20190512090627.GO21483@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <586b4f29-1937-2d7b-3944-c29311502878@gmail.com>
Date:   Sun, 12 May 2019 20:42:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190512090627.GO21483@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.05.2019 12:06, Mark Brown пишет:
> On Wed, May 08, 2019 at 04:10:58PM +0300, Dmitry Osipenko wrote:
> 
>> 1) CORE and RTC have max-spread voltage of 170mV.
>> 2) CORE and RTC voltages must be higher than the CPU voltage by at least
>> 120mV.
> 
> This seems like it should be easy enough to describe - we just need
> minimum and maximum spreads between pairs of rails.
> 

Yes, but the proper CORE/RTC minimum voltages shall be maintained until
all drivers will get support for the voltage management, which likely to
take a lot of time to get upstreamed. So I'd want to get at least some
basics working for the start, later on it should be possible to consider
generalization of the regulators coupling. Mark, are you okay with
having the custom regulators coupler as an interim solution?
