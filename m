Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE2CCA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F53F208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ph1p1ZV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfKBASY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 20:18:24 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:34565 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKBASY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:18:24 -0400
Received: by mail-vs1-f45.google.com with SMTP id y23so965228vso.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 17:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GaHIwx+KL1U/Q4t4mS0pbZ4hDEkbGYDHs74jtDZxIQA=;
        b=ph1p1ZV3OU0ycJqNT5h4wC9WwDd5cM+miljA5PE34BLJJwjRP/cvjlZzKJbNRuK8aM
         oSlPpF6c8mcWVjF2GgINHnG/z3Uh71b+kyWHCchSC0kvPqVt6o6ilBuxwrhUjCXa/DQZ
         J8WIcdvE8lFhZDtcAkupgHqY6JzLCj+DQcHUTfdNICM9eTKkRkeWFDqo6Rj0A7x+Loo4
         hxnazVmGZdtujrCo8ZmlQNKLMoAr46XouijZ3Ta4HHj8IvzNyPRqcn+JKnHTMylUdXSI
         33LAVZuy0T79EaQ35k3Rp0vbzCU6Eu3L+GW73c8fkuqKeCHFmrz6FOEigcvzXbAVHPVX
         IVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GaHIwx+KL1U/Q4t4mS0pbZ4hDEkbGYDHs74jtDZxIQA=;
        b=RGiKTXmYHH2lyuI9q5ET7Z+TzoHa91AnfDal3dth3EHZtWKvVWPIoxXFDuJY4XG/x6
         SvEqopkyX0/AqEZj2nKVjN9pfEct1Q5WrP1iOwKHyQyrqM8ns6+p/xKGTRX1EX17jVW/
         cI9VtHBi7piPxgAiMtAdrc4/JQ1LrcD969+J72+8zrxCWjO4ZJEZYU4m0LjyVynQRjNL
         PA+9BH9Q+j+JOPolffjxDQaxoJxnqMJ9HskwFxdVOkagUAFBOgFaQ9kPO4ZSe/r6zfXX
         f3b5gMSqlbhjMVFm/gdPmPpBJBmHihlgUANIasbfxZ56U+il4yGBQ+o0c9V3ToroYETI
         dRYQ==
X-Gm-Message-State: APjAAAXKgZ/r2HSnDizPb5lN6dTLAzobJTgS/wqo4NSYu6a7PFZ4VKQg
        PLV1duv8Kyo+X6RhHOnvl6WI8XHyOlu1YDmO99g//jYJ
X-Google-Smtp-Source: APXvYqxys/tPqomZ9/hmLirA9W2SzyjJ9y4DXP4QmNF7HllBdvirauwjiaRyBeIDrKv8uwsbvZGbVAb545upgK4EYmI=
X-Received: by 2002:a67:dd88:: with SMTP id i8mr6947667vsk.150.1572653902969;
 Fri, 01 Nov 2019 17:18:22 -0700 (PDT)
MIME-Version: 1.0
From:   Yy Bb <by312139@gmail.com>
Date:   Fri, 1 Nov 2019 17:18:12 -0700
Message-ID: <CAKJfos-Hxcf3TC03H7-m0DskYPDTOVBx=X9OXCi8h+9=y8+z4g@mail.gmail.com>
Subject: How to implement BLE security?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We implemented the communication between a Linux device and mobile app
via BLE. We are able to read and write data by using a free app "nRF
Connect".
Now we need to support the BLE security. Basically our data is
sensitive. We want to protect our data from MITM. So we need to
support a reasonable high standard of security. It seems "Security
Mode 1, Level 3: Authenticated pairing with encryption" is what we
need. Our device doesn't support visually input. We use BlueZ, D-Bus
and Python3 on the Linux side.
But I have some practical questions:
1. For pairing, how do we support password protection? Is this
something only for the mobile app developer?
2. How do we know when pairing happens on the Linux side? Is there a
callback or notification we can use from BlueZ Python API?
3. How does data encryption work? Some mentioned AES-CMAC, some
mentioned AES-CCM? Which one should we use? So we'll just need to
encrypt the data on the Linux Python and send the data?

Thanks in advance!
