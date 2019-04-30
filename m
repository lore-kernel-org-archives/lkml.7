Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DB2C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3432216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="F2K/xby4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfD3Ak2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:40:28 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44224 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3Ak2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:40:28 -0400
Received: by mail-yw1-f67.google.com with SMTP id j4so4663718ywk.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=LgDHqiBMkIEP2Gjv1b/BPNB6tTx6cNIX8WGn2OufiRQ=;
        b=F2K/xby4cmu6d2bZoZHJLR5Z4UZj5CGWYwSUm3LxusNt5Jmmm9YeWtE5K9sqrAdZuk
         gwz6epfbgd98xGZRRXx2zBxmy2oDyAdASJQHHpO8rY3PjpCAFbhU+2RcJuuqUE4ZqfaW
         /leG3SS/9/y27TwwrXCfbtJGcjzg3UZBYRPMitXPLwSbOuAM8QaXoh6yQaQfT/IcPXeW
         vuVLqIIdHj1Ou0IAaxfLoslywy/E4eDi9gpDAv1OG1wWf0w2PeT6Qri71vyTbJcrqbUX
         KEuZ4nD3RjUSl0spMlo3D/3HRKtuTLpV0xrX3NhRVCe+vuVhpPIJcyxcKf7zQhI8Kwau
         YXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=LgDHqiBMkIEP2Gjv1b/BPNB6tTx6cNIX8WGn2OufiRQ=;
        b=OaTx/QksC5ewpu+lf/z5EFPZcbZrbdRpPgvydz/+ixsUdbtWTSDJG2JhIDuwjUFX5s
         2fsTHyEWIFCXNypNTSuSz4h43C2dLpPHXTGic6FYqLKIkod440d6PlSYciiH/Ha86EPB
         3f6xfJ9HXj9C/NuTat832UZKp2x1b1imtozeTEulZiK6aJRVPODe7XGllDLuIBSy1LPi
         8K/DNys5zvgYbxL/EwdIWZoOejfor0X9MTVO5bKWnMDpQRlhQalWaLfV9xrHVZSIEb9z
         KFMhbh4nRp1a7mR4/Kp0WLX+WXJrlhITgMz+MZjFKKcVVqQ4VnHByIQ7ojpSCLKo3mT7
         N3+w==
X-Gm-Message-State: APjAAAW607krTwkcaTYgxm/9h+uupAhp0ffqOIRAqzvhNXIx7JnXU6Cj
        uCyTY1mtVnXQ8COKLicS9ELfjNsLNRLQ0w==
X-Google-Smtp-Source: APXvYqwRUNNglVfbfdo5R7L0BKzVxB+n+Hc3Y+ZAEsg00ux13E71kxX4gWJaZPEGNX5YB88pffHYaA==
X-Received: by 2002:a81:3b13:: with SMTP id i19mr18065733ywa.100.1556584827229;
        Mon, 29 Apr 2019 17:40:27 -0700 (PDT)
Received: from cakuba (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id x189sm7834917ywb.41.2019.04.29.17.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 17:40:27 -0700 (PDT)
Date:   Mon, 29 Apr 2019 20:40:23 -0400
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] netdevsim: fix fall-through annotation
Message-ID: <20190429204023.259fe70a@cakuba>
In-Reply-To: <20190429173807.GA18088@embeddedor>
References: <20190429173807.GA18088@embeddedor>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 12:38:07 -0500, Gustavo A. R. Silva wrote:
> Replace "pass through" with a proper "fall through" annotation
> in order to fix the following warning:
>=20
> drivers/net/netdevsim/bus.c: In function =E2=80=98new_device_store=E2=80=
=99:
> drivers/net/netdevsim/bus.c:170:14: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>    port_count =3D 1;
>    ~~~~~~~~~~~^~~
> drivers/net/netdevsim/bus.c:172:2: note: here
>   case 2:
>   ^~~~
>=20
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>=20
> This fix is part of the ongoing efforts to enable
> -Wimplicit-fallthrough
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
