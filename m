Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA3CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B64206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="hNzZp1V2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfCKKn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:43:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46738 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCKKn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:43:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id v16so3547338ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c87jzWIZtvLDTsWdnzo/HYHSGIho26mPgXOUYgHAzRE=;
        b=hNzZp1V2F9T986baoYsBdF+/RWPQUElueA47CpSTyNtyhyAtGEDXNN0lou9OCm2Ivv
         lDzShv0+yUbipnxIX+H3CN7IeWcRKeqBUgzBEM0yhbJxXUT4EM6f5XFDXizCQqNGiVeU
         rr1ByKAO1k3fI9g54QTGiB6K6jPBR+I/EbaAyw5Wt8AWTd+n7IA+YQD3v63xKsQL0IiG
         Fqi1eHEeZPJFCFMMn5wnhagZM8m9v7MuORRwuHDQjgPoQdZyN8Lb9IJxGHDYJ3dgHV9T
         +EhWaGmTcANa5+Y/z1EeNldEKhUzOd7ypZjh/LzFeF/e3hG2/HgtmQCaGuwg76XfKxRZ
         tqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=c87jzWIZtvLDTsWdnzo/HYHSGIho26mPgXOUYgHAzRE=;
        b=uYxKOQdFeNhKo0YVJW1AkAbPY4Ms9C4VN0u7Pgw0DAZKDjPJFKdOPv6Vg6APYUvCpL
         +bfx5EFh/Zi/wgiJql940yeidho0KPhJOQKhpC3N98oYPnRzmdRJ//Jg7Z1VzZVjmS7c
         pIcZdidhvS21EhCPJULSoXyJqgSvi/PKWfdNHMqu15LnDp1cM4SjR/NfhYAoBT7wMatH
         NYPn+PWOsnt0anERiB11vsnLhHoTCvJJnGVf1PsmW7nUEXu8BQmlgZNNDQ1zJwXD64gL
         4NrOACkhDtCwKpok42f/nz4usEDn4zjTl5FWUIMGL+oC/dZhOUgeINnpBVL324XI2Pm/
         TTsw==
X-Gm-Message-State: APjAAAXLiFnX5tjorgEnalFjmNBsPLm4cN2YaROjnj3MIMoH7FbBMWZ+
        ZiKl+uMzBTESkBvsWJS1wlbJPEa+zJA=
X-Google-Smtp-Source: APXvYqx4n6QFeBGEX7jnjyS9xY79Xp5DXhb2UtHTpHtXqJbc89CAqvcUMViRK0v63VlR9HTdmSqXPw==
X-Received: by 2002:a2e:5518:: with SMTP id j24mr16516405ljb.80.1552301005376;
        Mon, 11 Mar 2019 03:43:25 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.87.180])
        by smtp.gmail.com with ESMTPSA id 8sm898789ljs.42.2019.03.11.03.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 03:43:24 -0700 (PDT)
Subject: Re: [PATCH] net: renesas: fix a potential NULL pointer dereference
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        netdev <netdev@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190311070138.24084-1-kjlu@umn.edu>
 <CAMuHMdUcc2MXwX1sP4QEiWskoDofR8HQv-e2f9nWXhaMPeeZYA@mail.gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <73506a39-1c8c-b5dc-d5df-6f9dc51c09aa@cogentembedded.com>
Date:   Mon, 11 Mar 2019 13:43:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUcc2MXwX1sP4QEiWskoDofR8HQv-e2f9nWXhaMPeeZYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03/11/2019 10:43 AM, Geert Uytterhoeven wrote:

>> In case of_get_phy_mode fails, the fix returns NULL to avoid
>> the NULL pointer dereference.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> 
> Thanks for your patch!
> 
>> --- a/drivers/net/ethernet/renesas/sh_eth.c
>> +++ b/drivers/net/ethernet/renesas/sh_eth.c
>> @@ -3187,6 +3187,8 @@ static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
>>                 return NULL;
>>
>>         pdata->phy_interface = of_get_phy_mode(np);
>> +       if (unlikely(!pdata->phy_interface))
>> +               return NULL;
> 
> of_get_phy_mode() does not return a pointer, but a phy mode index.
> Hence zero is a valid value.
> 
> So I'm wondering where is the potential NULL pointer dereference?

   Hm, not seeing NULL deref as well...

> Perhaps we do need to check for negative error codes?
> Or is this already handled later, by {of_,}phy_connect()?

   Not seeing such handling too...
   The v2 patch seems good though, as the "phy-mode" prop is mandatory anyway.

> Gr{oetje,eeting}s,
> 
>                         Geert

MBR, Sergei
