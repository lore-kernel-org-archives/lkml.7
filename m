Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE77ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D44206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568208121;
	bh=GyluRdeFq0VX5d12+b7WYBAp+JEZ8grGntsHDSjqYoE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Tu007oL9kPG92EdKjcO5Ew3Ig0wx61KboeYPPfaXYVez+6aZ3Vv9vQInc/0Ql88iT
	 JNPgOav2bCjltWrcgsXnYVnlOIvXaDsMBJHS9Y08g88ZloBz4h87EhkVtQoeSAp58b
	 wNQQz6GBBGioX/xEQ8IDVZJGC0PdCkwLVrEJVqdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfIKNWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:22:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35877 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfIKNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:22:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id l20so19995380ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCyL2xtvyQdLdW6FJFwSDs6+Mxk/HA5bYPmnFS87ufs=;
        b=LzrvAgM9OQYbI9TUU3c/HZDniGCL2JHzdTV2dek9I5BeMfC8fagkSditS2/3sSLF15
         gapZp7Kvj5gPYxhHqMfEeUugXZBIcmPhU8ZG6uq7NMNhdKrtFoebT8k6wftDA+V6Myqy
         31HyzHH8rPW0ntcQNOG6w8RJaSfugWER2fT5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCyL2xtvyQdLdW6FJFwSDs6+Mxk/HA5bYPmnFS87ufs=;
        b=rybBI2eU4BX/NL2cgO0ZFan9xF1csful7oOmbUs1/L1139BRF2aLfIxEFEm+EWeiB8
         9mqV3ViJojzp0N2NcqF4kNTEFzdAacR9IPq8Eqd5xbhGQEGzPo36/rRJXD1qqY+kQ0Z7
         7Awm90GkP8TxK7QMInbKAEf+WLMtItnDY4rSElaDlwyOzyPKquBcwtQOcaGdIIFkcUuO
         2ahGTyKzTjFLwikGpFhZNR+UVQCH9My2nIT+cKJzAm/Un5EJBhHDrigKAFnsjmPRW8So
         A2orRunHxiClCSxyjJ+38q9TMj/RhOvYeyQDEVzJT36NIpSHRRM4l2yyv0ZiSof7WCRD
         2e1g==
X-Gm-Message-State: APjAAAVWOUT6iDwayQLwz1c9L0RBZjuQoKJBsd29GiAIHGsbjhnOmj03
        bKaLC3VfqJLe3cjFuoY/9ofecg4eLhmSCw==
X-Google-Smtp-Source: APXvYqzvGLclAV7G60bT0FJEBrR0gGgLVdT/TulZLKyiQZ4FGBcvYv0UrU5YMkBDaFdRHfOCQkT7cw==
X-Received: by 2002:a2e:8694:: with SMTP id l20mr2763831lji.68.1568208117597;
        Wed, 11 Sep 2019 06:21:57 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id i65sm4699028lji.16.2019.09.11.06.21.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 06:21:56 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id j4so16422754lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:21:56 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr24534839lfp.61.1568208115902;
 Wed, 11 Sep 2019 06:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgBuu8PiYpD7uWgxTSY8aUOJj6NJ=ivNQPYjAKO=cRinA@mail.gmail.com>
 <feecebfcceba521703f13c8ee7f5bb9016924cb6.camel@sipsolutions.net>
 <CAHk-=wj_jneK+UYzHhjwsH0XxP0knM+2o2OeFVEz-FjuQ77-ow@mail.gmail.com>
 <30679d3f86731475943856196478677e70a349a9.camel@sipsolutions.net> <2d673d55-eb27-8573-b8ae-a493335723cf@candelatech.com>
In-Reply-To: <2d673d55-eb27-8573-b8ae-a493335723cf@candelatech.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Sep 2019 14:21:39 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgAXAw=U_kthB9mG+MBocpawxCzo=6WDrbGgOUr+ac3CA@mail.gmail.com>
Message-ID: <CAHk-=wgAXAw=U_kthB9mG+MBocpawxCzo=6WDrbGgOUr+ac3CA@mail.gmail.com>
Subject: Re: WARNING at net/mac80211/sta_info.c:1057 (__sta_info_destroy_part2())
To:     Ben Greear <greearb@candelatech.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 2:03 PM Ben Greear <greearb@candelatech.com> wrote:
>
> Out of curiosity, I'm interested to know what ath10k NIC chipset this is from.

It's a Dell XPS 13 9380, with

  02:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac
Wireless Network Adapter (rev 32)
        Subsystem: Bigfoot Networks, Inc. Killer 1435 Wireless-AC

(numeric PCI ID 168c:003e, subsystem 1a56:143a).

The ath10k driver says

    qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:143a
    firmware ver WLAN.RM.4.4.1-00140-QCARMSWPZ-1 api 6 features
wowlan,ignore-otp,mfp crc32 29eb8ca1
    board_file api 2 bmi_id N/A crc32 4ed3569e

if that tells you anything more.

              Linus
