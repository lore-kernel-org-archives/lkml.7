Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E81C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9273A20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWfRUNyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbfCaMUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:20:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38324 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfCaMUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:20:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so8259188wro.5;
        Sun, 31 Mar 2019 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+8VxQduP/q9+qhh0yVY3mIfWHz4bBHqJjeLsbZA7tcI=;
        b=oWfRUNyQQhW15Ai6SM5Fm/M5kPfs8qbNvP/NWmgCyic3XJTpUAIvl9FWNmw4H7zdwD
         rjXnoMTlE4m7/EJYFgzsnS5+g0nxqwsvkRBUJ2PmHPc0KOZi/X6NoChdqA0ZqvPawUhB
         pbOGgtK67/GmzdL+ZOhFmzd/XMoRNj9Ct0i/Z10Q7GWq0fpM0+AlBWNQR/GdbxyCF5FN
         swXIJrD0Pxbc7+wj7AeSp+1gAxO6qOUc8lBvRVB4fFatZP8VPV7hHJHTdlY+Zhl++yDU
         pErtRet/a2l7NuM/nSZac3bLcyb1u6s/efeBxnysis3cj/2DwZd2uLmhFA3KoMA5OxNE
         BknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+8VxQduP/q9+qhh0yVY3mIfWHz4bBHqJjeLsbZA7tcI=;
        b=DnSCxkUTIR2QbPOxZ6EK2//sD+mh4Wa/hCA2fc6jt3jCOgqDquiRCM2CFi8RlCuPfp
         D+07P586qICnVLrzeXxG3N0G5BRGTg93x9ViFhtHTV8GMv2FIgNZn5Zn9iXz1XQ8I3Q+
         2HQ/biJ2II7KNPZxmG9hDoYI5vx5oGeyfgUsA8/7NlRHqXybhjlGNCP2EsZNyb3UkfMK
         JUA+hYNaQOjEo5ZyFD0kEYq3tgBUb9C/QGKZO9KQ/DCtg1thPsupiN4xncMrKLcRePM0
         YzWcMiWVGIiyF0fcG6kY8HwKo1kaEn2JnS1Qr7WKzWI3DHYnGgkbbo2xeAXlRsEYLrKn
         APJg==
X-Gm-Message-State: APjAAAUYKefYJaPphE3tNWSZAzPQUNjSRzERRQzfq8U/In+nannYVnZU
        x/NunRbYO9Yafo2iVTglLVk=
X-Google-Smtp-Source: APXvYqzjX06MGJ/ZP+Hk0aR78hucBqps9oArSDMypwyN89aJj/wsX1Wxbazp4yMM7a2/esaQUUUR0A==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr38374542wrt.253.1554034811187;
        Sun, 31 Mar 2019 05:20:11 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id t15sm11122677wmt.2.2019.03.31.05.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 05:20:10 -0700 (PDT)
Date:   Sun, 31 Mar 2019 13:20:08 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5/8] fbdev: sm712fb: fix crashes during framebuffer
 writes by correctly mapping VRAM.
Message-ID: <20190331122008.3ohmdjp54nts42kh@debian>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-6-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316222504.27170-6-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 06:25:01AM +0800, Yifeng Li wrote:
> On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), running fbtest or X
> will crash the machine instantly, because the VRAM/framebuffer is not
> mapped correctly.
> 
> On SM712, the framebuffer starts at the beginning of address space, but
> SM720's framebuffer starts at the 1 MiB offset from the beginning. However,
> sm712fb fails to take this into account, as a result, writing to the
> framebuffer will destroy all the registers and kill the system immediately.
> Another problem is the driver assumes 8 MiB of VRAM for SM720, but some
> SM720 system, such as this IBM Thinkpad, only has 4 MiB of VRAM.
> 
> Fix this problem by removing the hardcoded VRAM size, adding a function to
> query the amount of VRAM from register MCR76 on SM720, and adding proper
> framebuffer offset.
> 
> Please note that the memory map may have additional problems on Big-Endian
> system, which is not available for testing by myself. But I highly suspect
> that the original code is also broken on Big-Endian machines for SM720, so
> at least we are not making the problem worse. More, the driver also assumed
> SM710/SM712 has 4 MiB of VRAM, but it has a 2 MiB version as well, and used
> in earlier laptops, such as IBM Thinkpad 240X, the driver would probably
> crash on them. I've never seen one of those machines and cannot fix it, but
> I have documented these problems in the comments.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
