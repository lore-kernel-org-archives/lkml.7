Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA976C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38C62089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="isyU6oxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfJLTQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 15:16:35 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45368 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbfJLTQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 15:16:31 -0400
Received: by mail-wr1-f53.google.com with SMTP id r5so15244708wrm.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ajiwA3G0EMDrUDqsoTSKVrrwd8tYMRJ8lH5HaDnqnrw=;
        b=isyU6oxZ4sES7mTiuXM7SJv7oloi5atWzUDpo8G1DFeAYymcHa/w+mM6eVfsfT792s
         OMoGr/38pajzD0TjpY70g/TdPGeWDY+Jzl3oRehH7rDXVfQG8JoS0UNU16O7WwvGN2qd
         LQog1nRtJLpUZTVcKCov7gI1NeTexkDppFf+EJKq4prr+OXp/aMW8ZefFxWxW9yk8wKN
         gphXK7hK7zvjqMAUDM6Wt8xMarYQGcUCmfZPz/ZkmqJaJbSOKMfI8Ky1ikJH8Q3T27f/
         e6glsIXrTiRFNjKFLR42pnhHWjsHuXod6d7OqyzRCNCLxz4B2cOL1ReZPByRotnV6v7M
         oouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ajiwA3G0EMDrUDqsoTSKVrrwd8tYMRJ8lH5HaDnqnrw=;
        b=HIRFUzx8GKjxRDbRDyijhwkkR8ouZaJ2iw4jR2FScdooPpGxrFpCDu2CVqS7xMkpnp
         itMOFin7HoG7W25/+9z8ezlD57foa5J1chp6jnRUAvvFCM1mZg3Qf/KviwaJhCcKX/W+
         G4/vJglFjclS+ywyCGu0PbpU0TXGvR/BtgiRwF8cwGXwhm927lvYsh0sQlB683AhmN6U
         Q/RsvgjVrGRnVf55+/Xhak9a361YaQbGMm4TsgtFZa4f7oTBrMG1ql2vXxEyBJllb9b9
         awonibdIdZiy/xCz0ySqcJI8ViDD3PPIUQxDNJJmg2XaZRr0Ux0yyY9TPxNmS71ztIbX
         oA2g==
X-Gm-Message-State: APjAAAXoJCyG/ycNVOVOka4qk7jHQ2wxuiDm/DqOtvsWsrhYINXpNl2K
        etfQKgpZjW3gq/KhUvi6OmUW+Cap
X-Google-Smtp-Source: APXvYqwYMaj464uxEW9Z3LUYJBjyh25EWMmfA51bk8zoTszrkl1QQGtETY0PWPCVHOgWx46l4PmSTg==
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr5665325wro.256.1570907790030;
        Sat, 12 Oct 2019 12:16:30 -0700 (PDT)
Received: from [192.168.1.20] (host86-143-38-66.range86-143.btcentralplus.com. [86.143.38.66])
        by smtp.googlemail.com with ESMTPSA id n18sm10472615wmi.20.2019.10.12.12.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2019 12:16:29 -0700 (PDT)
Subject: Re: Linux 5.3.6
To:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191012075902.GA2038794 () kroah ! com>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <48afc878-5424-7554-cd02-4175ec12eaea@googlemail.com>
Date:   Sat, 12 Oct 2019 20:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191012075902.GA2038794 () kroah ! com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm announcing the release of the 5.3.6 kernel.


5.3.6 build fails here with:

arch/x86/entry/vdso/vdso64.so.dbg: undefined symbols found
  CC      arch/x86/kernel/cpu/mce/threshold.o
make[3]: *** [arch/x86/entry/vdso/Makefile:59: arch/x86/entry/vdso/vdso64.so.dbg] Error 1
make[3]: *** Deleting file 'arch/x86/entry/vdso/vdso64.so.dbg'
make[2]: *** [scripts/Makefile.build:497: arch/x86/entry/vdso] Error 2
make[1]: *** [scripts/Makefile.build:497: arch/x86/entry] Error 2
make[1]: *** Waiting for unfinished jobs....

Chris Clayton
