Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5EFC76192
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5807206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKB52CWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfGOKxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:53:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45117 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbfGOKxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:53:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so16518526wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 03:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9QeR05ggwCJbQR+oKm0lK2M+jB4GX6f5Mlo/cT/UFgc=;
        b=ZKB52CWfpTKQ2s8245fa7YfZFpjWvZGUxCLmENqWhk6/dX0MN374+ru37HkmBNmq9P
         QT9q2O9dOFsem8ap6QcNS0jcENpTLsacIgNQ+Oj7VJsxn1HK+qZnXueN4XTmcx9WLQcC
         Gh0esGQ/JVdlhtdeRccvRkGT1ODYgRAmWwW3w5Rwtve14z8dRbA6ov4oK7g3UWJHa+m2
         O+fav6ug3FeVgnRmipJDqc5bxEzwqIgEWJ5VzOyi4T78AHj4K3QV6Vkgd7CF48cC/iot
         x8Wdb3iWNTk008tvFe2pUYxH+1VgxhrK94Npq1V8aHjzF+uTtCfl05/TjR83PiTBSDAS
         /0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9QeR05ggwCJbQR+oKm0lK2M+jB4GX6f5Mlo/cT/UFgc=;
        b=OyJGCz747YbpiOURTVnyW25kPEgz0rLbCSNjtEFZ2wlcNKfOhr/G483b6T1oGC1sCY
         7d1qmPFYJxUAJ5fSiThyECyMf//BTl7C1oij4uWryielqVy8ulcNxs/CuaFKT6ReuieC
         m3pJdESOh0VrDRd3159uExH0UB/dyAI9U5XL18iKXLwI3BkDa2G9hXfAXA5uOcf1lTjV
         chIkSKyjOpPe7qUyj9upLNs66m5c7rNWx6ohAuoobcIESgJK4cXM3RPOGL1P4BBnGamv
         lfOTcS/GPWf19AnmbCDrTkCn573BTAvBZ3r40GwcMUpDYx42ElRgKmOUx4cLkoeJylN6
         2jHg==
X-Gm-Message-State: APjAAAXL5+4h+5LD6+JhPGY11IvUoUqG4sqY7fUXFcrR2ApaHrBImJ2l
        eijxIk6FSYLGwrkHm2RSooNKjA==
X-Google-Smtp-Source: APXvYqxX0jr3Tfyps9J72HASrfrzfl8Z+9+nLFqpJl5898EToLTkmekHNR4zdr84b2PVw1oD3i8rOg==
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr28229277wru.125.1563188022056;
        Mon, 15 Jul 2019 03:53:42 -0700 (PDT)
Received: from [192.168.0.101] (146-241-97-230.dyn.eolo.it. [146.241.97.230])
        by smtp.gmail.com with ESMTPSA id e19sm22821146wra.71.2019.07.15.03.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 03:53:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX IMPROVEMENT 1/1] block, bfq: check also in-flight
 I/O in dispatch plugging
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <2c15c4bc-145d-fb0d-ae5a-2a8ce36f977b@applied-asynchrony.com>
Date:   Mon, 15 Jul 2019 12:53:38 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
Content-Transfer-Encoding: quoted-printable
Message-Id: <B064EF63-B7F6-4BA3-BA0A-FF9579893971@linaro.org>
References: <20190715093153.19821-1-paolo.valente@linaro.org>
 <20190715093153.19821-2-paolo.valente@linaro.org>
 <88e3c1e1-224f-a9a8-0875-848ba23b6fbf@applied-asynchrony.com>
 <B0406DB0-1003-4610-8A75-F3D7614C616E@linaro.org>
 <2c15c4bc-145d-fb0d-ae5a-2a8ce36f977b@applied-asynchrony.com>
To:     =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ops, my fault of course. I submitted the patch I made on top of the dev =
version of bfq. Preparing a V2. Sorry.

> Il giorno 15 lug 2019, alle ore 12:49, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>=20
> On 7/15/19 12:18 PM, Paolo Valente wrote:
>> Didn't I simply move it forward in that commit?
>>> Il giorno 15 lug 2019, alle ore 12:16, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>>> Paolo,
>>>=20
>>> The function idling_needed_for_service_guarantees() was just removed =
in 5.3-commit
>>> 3726112ec731 ("block, bfq: re-schedule empty queues if they deserve =
I/O plugging").
>=20
> Argh, sorry - yes you did, it failed to apply because the =
asymmetric_scenario
> variable was already gone. Fixing the patch to just return the =
expression so that
> it matches 3726112ec731 worked.
>=20
> All good!
> Holger

