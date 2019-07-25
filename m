Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72A2C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD7122BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igwlp1jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390759AbfGYNtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:49:15 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36561 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390515AbfGYNtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:49:15 -0400
Received: by mail-yb1-f194.google.com with SMTP id d9so12088338ybf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+94dksNMcufTeD/gyuUattLxpQAoVrZBBEnx6NzwFI8=;
        b=igwlp1jjMjzAEk8NRn0H5RDYphkcWR6yJ2kmjtXjspl/BBg41z7oa2nDhRSfy9sosJ
         TpW/84vSFYnbJbxDU5/bVkAoqDFU2nES1vtt1Wm8iH4WEzQuFgawY6ddeO7JZEI5P3j0
         1EV4KfGrwCfJjlke104b3pme0tBDfKJgovzggLxwjSN1mk3CPDWpgUKlNycor5Juxii7
         b7LZ3RVbvvdV5pg80c0Ia75qccs+K/9YEoPwVTQO0tpstlttM6wo4dCZLxJsubbsiztv
         o3jc1JRLjkl+Y+x4zBBuEXGcKReNCQQUaFUYk659QHdnLHv3n3eUfOQeK82Yw7VBK3E/
         OYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+94dksNMcufTeD/gyuUattLxpQAoVrZBBEnx6NzwFI8=;
        b=BT2XECr8CqTuhUv4eXq7s9v2nVF28Aq8oYjhxofpkqzgXsysVB6JhOl410zoUCC0JL
         smzVNr/NP15tBtx17LvRmjbh8ggRRvrDLCz10E93FEIHE1Iozp29v5KYK1cnppvHybJQ
         FiLYQ/G8+1BENk3ssKOisbJWRzz3xqkG7SmV4i4XM8+Wz6l3Z3/Pv62tntK/UXLC0UCy
         vD+wHf29xUMLCVaFSBgJC3uTtb0TTHF+jK66NmmSm0skIMq/5yrLDuhBdi3rUMYpU4WJ
         dTrOlPSYgj08vDyJaDf1RV9cheRg+jHn5AgXhrskegjukUdbl/p0GaK9tWm6EB0JXV27
         dWFg==
X-Gm-Message-State: APjAAAXkVhJV1Bf2r9PoVNB7/EaR60CkDYGX8xEMWkr2QONWVU55I7R1
        9KSH8Eq68ngMmUxkUEIU7c49y8oX
X-Google-Smtp-Source: APXvYqyguZ45AzSFpcwWFhs3OcwoWTG8JmIslBN5LYLTa+WpeZ4q/grsKE8Sx3XG2k/2XTgX47wL/A==
X-Received: by 2002:a25:397:: with SMTP id 145mr54540161ybd.469.1564062553865;
        Thu, 25 Jul 2019 06:49:13 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id l4sm9960651ywa.58.2019.07.25.06.49.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 06:49:13 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id s41so15796235ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:49:12 -0700 (PDT)
X-Received: by 2002:a25:2516:: with SMTP id l22mr21764852ybl.441.1564062552540;
 Thu, 25 Jul 2019 06:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <1564024076-13764-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
 <1564024076-13764-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <1564024076-13764-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 25 Jul 2019 09:48:32 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfqMRtbJFPiAGyPKpoKjxcVQp_YYXD5Xtj0bHmSQBMpkQ@mail.gmail.com>
Message-ID: <CA+FuTSfqMRtbJFPiAGyPKpoKjxcVQp_YYXD5Xtj0bHmSQBMpkQ@mail.gmail.com>
Subject: Re: [PATCH] ipip: validate header length in ipip_tunnel_xmit
To:     Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:09 PM Haishuang Yan
<yanhaishuang@cmss.chinamobile.com> wrote:
>
> We need the same checks introduced by commit cb9f1b783850
> ("ip: validate header length on virtual device xmit") for
> ipip tunnel.

Fixes: cb9f1b783850b ("ip: validate header length on virtual device xmit")

> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Good catch. reg_vif_xmit in net/ipv4/ipmr.c probably also needs it.
All other ndo_start_xmit under net/ipv4 and net/ipv6 have this check
as of the above commit.
