Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3207C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC83520675
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Skm0pkRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfCHApb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:45:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37770 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfCHApa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:45:30 -0500
Received: by mail-ed1-f68.google.com with SMTP id m12so15046869edv.4;
        Thu, 07 Mar 2019 16:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VMLhAY8wK4w6r18X3jvuwsh+ayxD4nX3lDwgwhyfbI8=;
        b=Skm0pkRKbbpsM3vXLXw5vDD7DYuq18a4Ud/aGDPHtSt80GhcJa7v6V/UICic9xUscj
         SsPWNGOCl43ruhH5g3MZ23fM7/i/mZFXIUi5FSxv6FUs135EwlAkAjlNodeVWmPwfyxf
         7DG19jkwrC0TvjOAlrNmrYlybqbo86+ZfOKlsXZoKxOWJlQvUbNUY8FTJf0rPnvl/TbS
         dYoGX/szk1awlURLL+OOXPKr619CkyKSs9zqU30vyBj6VfcR3qFdgH9yezYipXuY+xPH
         OQsdje1/rRbQXmOWHX1phUsig9VoPaAE5wWqs4KSiX1dtpE40YKk7FrJxtZhW8lwEhaL
         EueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VMLhAY8wK4w6r18X3jvuwsh+ayxD4nX3lDwgwhyfbI8=;
        b=CALw7TVzyv/y0lzUBLvZ03QfX2MMeprvCZ+bIz0PBvqzwNGQGm0FOWWM2J+G4XqShD
         bfiiJyEkCtN9QrOUipDykFsAogAXkEwwxx3JLlZm+Ta6WaH+4fG3uqKcfF3iMzX6AHcO
         JKo7GIqWBe3tihQwMlK5ejIUkT2Ijf+GaP4KiWTf2S7wAB7FVlY+VwDYljDgr5CfuleR
         TWIMciLl22WBDYXivfgcg+jMcN7Pre1EujWbhMRe/2UJTOBwuWWf+TBjUOKdyl+jPPPJ
         Fp4P3VNPWhPPDm+vK/4UA3RMP/6/G0jBM49NNTAIrmp41zl1gEb4y8E9qQ92zKBe2P26
         JzdQ==
X-Gm-Message-State: APjAAAXwjuBholS667ZwwrWostFvG9V8GivPfeG0aQKtoM3WKrcaHvHa
        6SFhh1qNNLmrboa511JS7yM=
X-Google-Smtp-Source: APXvYqw+Bjp4okBvWYUXlM5z0RJvyprggwXnv81W3/0acEHSrexNbsqJo3rk6omQxy4P4YAK5I3VSw==
X-Received: by 2002:a17:906:c355:: with SMTP id ci21mr9727802ejb.246.1552005928617;
        Thu, 07 Mar 2019 16:45:28 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id p4sm1149012eja.40.2019.03.07.16.45.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 16:45:28 -0800 (PST)
Date:   Thu, 7 Mar 2019 17:45:26 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: -Wsometimes-uninitialized Clang warning in
 drivers/tty/serial/qcom_geni_serial.c
Message-ID: <20190308004526.GA11580@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are trying to get Clang's -Wsometimes-uninitialized turned on for the
kernel as it can catch some bugs that GCC can't. This warning came up:

drivers/tty/serial/qcom_geni_serial.c:1079:6: warning: variable 'baud' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
        if (options)
            ^~~~~~~
drivers/tty/serial/qcom_geni_serial.c:1082:37: note: uninitialized use occurs here
        return uart_set_options(uport, co, baud, parity, bits, flow);
                                           ^~~~
drivers/tty/serial/qcom_geni_serial.c:1079:2: note: remove the 'if' if its condition is always true
        if (options)
        ^~~~~~~~~~~~
drivers/tty/serial/qcom_geni_serial.c:1053:10: note: initialize the variable 'baud' to silence this warning
        int baud;
                ^
                 = 0
1 warning generated.

While this is probably not an issue in practice (I assume baud is always
supplied as an option), we should clean up this warning. I would fix it
myself but I have no idea what baud's initial value should be as it
seems it is dependent on the driver. Your input would be much
appreciated.

Cheers,
Nathan
