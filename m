Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD62C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B59E20850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ps/ltZex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfCYLyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:54:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42049 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbfCYLyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:54:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so6282619wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 04:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=AdpgoZOF5+08hWqxT68WkSHPgRmLJx4JnkStnFQFVnc=;
        b=Ps/ltZexMWx9W4Vzm5hUCDd/3qbZzxJlDNgbh/X/Z56M9IAmpuwFDQWjO1sdOefkg7
         gJJvmA0iOY2UfR5NjW6tVOimw2SNO3/qsNJcI3oeTChndsqhfgJZUWZaaoofJkO19ZfE
         ImMlwlsQ/8+dwzUmOG3dSsIblhKsSgE6QUm5+VhfKc57z5uHOrvTdNq8plpmos9nRNNy
         K4f3Aom19+6cw9U09u9HQilqZ+eruFfN7nZHOu/1yBP0kSsBukpkKZK+/mtOBYjTXxnL
         pz+ZwZ8eVNTNgwnmKvu8noPoRXELGGEB9qs268ZgEnJQ+hvVbLcVOBOi6JlOG+/OtfV0
         SRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AdpgoZOF5+08hWqxT68WkSHPgRmLJx4JnkStnFQFVnc=;
        b=OInqu9nYJB+bI5CEKKjNTv/GYEQA6jirLBW8ckoDOlplUVnsusKo7mT2DiVZm+IaA8
         xptSiq0HrLu10v8pwFZdHl9e2P94Y5n+A/zl4imA4Ytyw4hk7q/gBUHx1demUHFgFT49
         0OcfzosAUOv8onRn7BOyRGeRr3v8TWpg7o6d1jIhNKkonidUGr742ZML9aMFKMBRlALS
         I72FolDq3n8QxA2zvQJuNjeiOQiKgc+SdA+by1K1eOStIB/gPCkE2rglPZqqBlqkFit6
         t1SuqBRRjdf0qlUDqDjid5/xrWCxe35Kyj+L8C4BMM9HQua3MDEljNV8nvrARZIeUcMy
         4Ahw==
X-Gm-Message-State: APjAAAXHhLAFi2biHv1Vz/TVL6CQRsrQXLyRIdFFJCYKrqugH+ouBHyS
        aS9K1YabgMAfnuPluwk0IB4WQA==
X-Google-Smtp-Source: APXvYqwkQLM4luYP8mb97pmXDQuShw3lZulQjA7xZHp1aET6ogZ9y9ujmPpKRPfKcum91FMJ7EQhoA==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr16563721wro.2.1553514893493;
        Mon, 25 Mar 2019 04:54:53 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id b3sm19513901wmj.15.2019.03.25.04.54.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 04:54:52 -0700 (PDT)
Message-ID: <e3d9d95fd07502cccf8ef97ba7b2e2adb4eefbb3.camel@baylibre.com>
Subject: Re: WARNING: bad unlock balance detected! (3)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     syzbot <syzbot+f3e3434787332dfc1c47@syzkaller.appspotmail.com>,
        davem@davemloft.net, devicetree@vger.kernel.org,
        khilman@baylibre.com, kuznet@ms2.inr.ac.ru,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, netdev@vger.kernel.org, robh+dt@kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Date:   Mon, 25 Mar 2019 12:54:49 +0100
In-Reply-To: <0000000000003749360584c395ba@google.com>
References: <0000000000003749360584c395ba@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-23 at 07:14 -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit ec01fb69ac8034ad6e839b31f9df167a110f868b
> Author: Jerome Brunet <jbrunet@baylibre.com>
> Date:   Wed Jan 16 17:59:47 2019 +0000
> 
>      arm64: dts: meson: s400: fix emmc maximum rate
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10afb7cf200000
> start commit:   065b6c4c Merge tag 'devicetree-for-5.1' of git://git.kerne..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=12afb7cf200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14afb7cf200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ea4067c9a08ae046
> dashboard link: https://syzkaller.appspot.com/bug?extid=f3e3434787332dfc1c47
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a10577200000
> 
> Reported-by: syzbot+f3e3434787332dfc1c47@syzkaller.appspotmail.com
> Fixes: ec01fb69ac80 ("arm64: dts: meson: s400: fix emmc maximum rate")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Hi David,

I'm not sure I understand what the problem reported is but I don't think a DT
patch could be the cause of a locking issue on x86.

If I missed something, feel free to let me know.

Cheers
Jerome

