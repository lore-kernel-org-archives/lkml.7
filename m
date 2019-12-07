Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E86C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE56217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="LG7Q8Mzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfLGSV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 13:21:59 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:44738 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfLGSV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 13:21:58 -0500
Received: by mail-pl1-f178.google.com with SMTP id bh2so2941917plb.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 10:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rYZBBRiANlnOnFi8ovHE2DcSrsXS2fMjDZoBxr32+zA=;
        b=LG7Q8Mzt++H1r7POjXW1vG6DbiR9S7FNET3iDS1KAXERZ+8citglJyzcXQkNyLneWv
         5kTpn2FaJjjGICZ9n9Gc8K1c7xp+fSYlzglaXGvzNIwjg/LubEtKo1MUD7Id6GqkT3WV
         5ElLslm4TU5iijSUOEhoO0aLC+ZXIg6ej7C4t+v8t7sq0ovx1zMuOOZVGjze/wbGc0Bo
         61WjoZQrVMRt5O5ecSNcsvqnmUQ2ZgxwhnFWwFYVqBg/UbA4oaScGj2UUCn9+hsIhjbs
         rnbsjCxgqZRkhCcz2OU77jC+dFO3Dp8t9Hv7N11D2B2+4mfu99RO2n9f9qpe3yfEeY8g
         7ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rYZBBRiANlnOnFi8ovHE2DcSrsXS2fMjDZoBxr32+zA=;
        b=DuE//lhY+9W1i9Ef4IEmXnrpa/gNTuaU6tHeT3G4/Hi8BFyALGG2EKuH3Ne7jPjQ6A
         sz8VsuyCtx+Rnok1ZzBqCt3RHGFp7qbUAV6umGZcNLjIXWKbolD79xKKfVVhvCS6qqWA
         qjs4QKtM2lS36ddszhi7cswMTzn0gTeuk9pTg6rboks5tjHeYvUHqhH0Jl8Ouc1/A/Xp
         Z8xU+wddPv+qAya/WTRFONNLPdoARqcrp2vFKUtjscH78cmwg0ImuY+tHEy8fahjC0yJ
         9DwtsJq1iCpWoG0fczcXOO6Oy2jXEUAk1f0b2tUqBuATxbhbOvnKsX4JZK9WfDEyRLWz
         b/ig==
X-Gm-Message-State: APjAAAU8k0fhDdwODnFQW1uBohjTLTFyYQD0W5JVx08NaSsD9cCUYVQk
        o3jKNjLwLM7oi/AxUjYGGz7tTQ==
X-Google-Smtp-Source: APXvYqzlnpKdCEFNMwYy41hXu1QvTa2f2xrCR5pEJOV/WkRY/DzdFlPH7zeB1jU7XQ1eH3uElyOmjA==
X-Received: by 2002:a17:90a:7bc3:: with SMTP id d3mr23367973pjl.86.1575742918122;
        Sat, 07 Dec 2019 10:21:58 -0800 (PST)
Received: from debian ([122.164.203.149])
        by smtp.gmail.com with ESMTPSA id r4sm6993968pji.11.2019.12.07.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 10:21:57 -0800 (PST)
Date:   Sat, 7 Dec 2019 23:51:52 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PROBLEM] uvcvideo: Failed to query (GET_INFO) UVC control
Message-ID: <20191207182152.GB5280@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i get this  output piece from "dmesg -l err" of kernel 5.4.2


-------------------x---------------------------x------------------
uvcvideo: Failed to query (GET_INFO) UVC control 6 on unit 1: -32 (exp. 1).
uvcvideo: Failed to query (GET_INFO) UVC control 7 on unit 1: -32 (exp. 1).
-------------------x----------------------------x-----------------

Additional information:
Linux debian 5.4.2 #17 SMP Sat Dec 7 01:39:12 IST 2019 x86_64 GNU/Linux

Relevant file:
drivers/media/usb/uvc/uvc_video.c


--
software engineer
rajagiri school of engineering and technology
