Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12AFC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07CE20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uG079AaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDHLTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:19:19 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:38204 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHLTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:19:19 -0400
Received: by mail-wm1-f42.google.com with SMTP id w15so14261528wmc.3;
        Mon, 08 Apr 2019 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=picsGpjcrUCwT8YUKL80MWGiGtJMGcjFvUvK1NQ15h4=;
        b=uG079AaRDji3vn+300Q/1JHyh0SvrOT0J6XHh4SrN90FL+n7e3WsmkVJnzfbgritGY
         66ZcU9owVY5ayphdobkcHjtwtFbPcVKH9ou5/1sJN0LWoOA3GGhdSQk5pT3dBwmEPcHW
         d7XOL2XnaYPzFdyqKrnFc6BjDJSov7gdAH0aKQttqfyoWcMPOfP3hZZK3lTUcJOi/cw2
         sBKgTIwVkoiYUHVOPleL6e35p5dZoMusvCQXSkytx+4qq3U8dAK/8nrnfr7T6tnT88+x
         b+TY1gXQvY5dCI3g36OZzlEtuOcqnkIwgFeGYxs+WhQkmAxRA1JRmfsfQURiRwfaumG5
         Nrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=picsGpjcrUCwT8YUKL80MWGiGtJMGcjFvUvK1NQ15h4=;
        b=aTiIzXBACToUEE3vaa+Yd3AKFuGtYlxHI1gMRmBJKEe6rPj/WlpVQuK26LNUVoVr3h
         Lf9FTU4Njdfl1b2GrGrCcl02c9BD4wFT1JlUIzuFZVq1ztr73GCwkv5yHsi2AAQgLRtm
         Q8MdPpb+dhypgiW0PtXhlbmzBmZeFUTMFCsh4wnhdHrcKwIx+3IloemqQZyWrIGrfo1S
         3t18GAOmdSVgsVdC/BWhlirmMcrxJWXJyHgMfCP5pTqTR+o3xRvQsk+UAf3RZFGEpizz
         Lpe8Yn/XKYYs377Fu7pFZVGoUkcSRHdcJ3VoKIitBWpHmhB/n7895Av7tIoJqU+a6LZP
         lZpw==
X-Gm-Message-State: APjAAAW632pWg5/R71DmFWPE3XtjIQBMk3Ur6WVO/l16O+gcEdUSo8Rh
        UXgZt/Khr3bKKobPusP7eb4=
X-Google-Smtp-Source: APXvYqxkFYFvW2mSHyXx7WUx0ZBa3N0Z1e4sFlIfHCpESRvQI7YSZ4lNMzbzS7gW91TLhzlsJ3KDXg==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr138948wme.4.1554722357501;
        Mon, 08 Apr 2019 04:19:17 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id 11sm10161234wmk.17.2019.04.08.04.19.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 04:19:16 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Emil Renner Berthing <emil.renner.berthing@gmail.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BUG] Rockchip SPI: long burst writes produce unexpected result
Date:   Mon, 08 Apr 2019 13:19:14 +0200
MIME-Version: 1.0
Message-ID: <1fcd4954-e0e8-4f93-80d3-8cbd169d0af9@gmail.com>
In-Reply-To: <CANBLGcyeroURDCHrBPRQ8bbhNsy9u0LkCq0MQmWUyvPR=p4b8w@mail.gmail.com>
References: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
 <CANBLGcyeroURDCHrBPRQ8bbhNsy9u0LkCq0MQmWUyvPR=p4b8w@mail.gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, April 7, 2019 9:55:10 PM CEST, Emil Renner Berthing wrote:
> Hi Vicente,
>
> On Sat, 6 Apr 2019 at 19:35, Vicente Bergas <vicencb@gmail.com> wrote:
>> Hi,
>> i have been experiencing issues writing to NOR-Flash SPI Memories
>> from two RK3399-based platforms: gru-kevin and sapphire board.
>> For kevin, this resulted in a bricked device because that memory
>> is the only boot device. ...
>
> Since you say reverting the "set min/max speed" patch fixes your issues
> could you try raising the spi clock like this and see if it works for you?
>
> +       assigned-clocks =3D <&cru SCLK_SPI1>;
> +       assigned-clock-rates =3D <400000000>;
>
> Of course the driver shouldn't let you configure the spi-controller in a wa=
y
> that makes it skip bytes, but if this works for you then I still think
> you're better off explicitly setting the spi clock speed rather than having=

> the driver raise it for you. At least while it does it without
> checking for errors
> or having a way to lower it again as outlined in the commit message.
>
>>     status =3D "okay";
>>     spidev@0 {
>>       compatible =3D "spidev";
>>       reg =3D <0>;
>>       spi-max-frequency =3D <50000000>;
>>     };
>>   };
>> ...
>
> /Emil
>

Hi Emil,
I've added both assigned-clocks properties to the spi1 node and tested
again. Unfortunately it still fails in a similar way:
Before the maximum write burst without errors was 47, now it is 33.
I've also tested it with an SPI bus speed of 100KHz to make sure the
external hardware is not overrun:
  ioctl SPI_IOC_WR_MAX_SPEED_HZ 100000

Regards,
  Vicen=C3=A7.

