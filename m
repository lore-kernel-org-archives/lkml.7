Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8C2C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A372B216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoM4LpRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfGII5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 04:57:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54394 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGII5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 04:57:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so2194674wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=R9Adg2z/CO5uWVdUrvi5/6JydCFg7NDTy9df8tmiuA4=;
        b=HoM4LpRMArbdezWEQuoWXWiRF+rGFOo7OglDjcNiJ5s+rtkBNMXJgV5UPy8ZhA4H79
         vkGbQ3QdumkiCaF7OXCCUsIoaL4G40EYhIlSuzLevF+HRtcpCx1erI8pX4Ct7/RiqRBm
         gzncDaAMJiXxZZXYNgaPpVcyPwYg3P03ZF0CT60R9e3qBk7D9xuwevJpH5+EwWDgrIRS
         5ewCFU8RWxS3aN29zsJKnkhfrmx5FjILnrDlr+02koqcxFPqZd/+TxpXPaDx0WX0pnza
         OIStXehzctzJ4OUgGAnPBcFy6y8MwGUeJ/vj1TObr5LV6/Jy75CaqoqQzYcyNjVjca6B
         J77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=R9Adg2z/CO5uWVdUrvi5/6JydCFg7NDTy9df8tmiuA4=;
        b=iCgx/wYsempNh5XCtS+v9NKcEUOxqMiaTG/VL+ZGtdHBerrIlcdxX/lrN9aqLx41IR
         xtLmzdE0UQYbE/6ie4wzcphLmZcc/M1eZdW/byKnwJdsaebLli/DZeMn32BC680Zf90O
         y6lDX+Q8pntuYe0sjkWiP1/HcgSPWssfwujhKbEyP9uc6xddSGeoT312zPwj0NMXhX/R
         IvS2NZE5hERVj0476qvmSgM3oO7QNZD0EH8aazRLDgV0qkNLsqfrB5LDOg/eSSIc0WyL
         27ZVyMCZRGP13o8ycPOv+ULhac0dZFSi90yxVAljhxeEJpwUt4QX73Wgt12sy9HeohYa
         xuxg==
X-Gm-Message-State: APjAAAUBAP3q26pJt8J8wbLjFcsTJUOZAxdv/b0LgOsgkbaQvNIgFoh/
        22cHd9dB7zMpbiKk3+CDIMJ8ijgaEQfpKGsV/8vIoZQrhX/z1g==
X-Google-Smtp-Source: APXvYqyM28qEvJEQicZU4knWB2nvnjndzNF5cejWfrCoHiWpKNT+gZRDoYcodaDxkZss48zhWr910taiMhBwDqPJoag=
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr20667896wmj.167.1562662648019;
 Tue, 09 Jul 2019 01:57:28 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date:   Tue, 9 Jul 2019 10:57:17 +0200
Message-ID: <CAEXMXLRu2HU5AmDJbVn8BZkDfgyvK2rH7egBniumEY49J87sTg@mail.gmail.com>
Subject: make *_defconfig does not handle modified *_defconfig files
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Considering i have arch/arm/configs/abc_defconfig, I can run "make
abc_defconfig" repeatedly, and always get output

# configuration written to .config

or

# No change to .config

But if I now change arch/arm/configs/abc_defconfig, even just the
modification date, then "make abc_defconfig" no longer works. I need
to make clean or delete a file to trigger it (eg
scripts/kconfig/symbol.o).

Thanks,
Nuno
