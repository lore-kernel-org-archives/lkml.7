Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B80C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C979421721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/iO2g/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391793AbfFMQZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:25:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38720 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbfFMQY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:24:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so8382128plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hDoQf8XVMWB4WIjEfgbzeZ3Sc8iH6yn9VUuCEmnDaKw=;
        b=q/iO2g/3m+0dJFISoxCPlF7W5Fu4zwu37pr6P69r1zZkoab7K9d7LcVmNE+c356Ylh
         jQ/X2I6FlbFLefEO7W2cB0Uc5m+csgWwoZuLgvUnImrKA1cXtztX1m4ENH/e7iHKygXv
         pOZ+YEPAlchXUS7dW8E2lytG1MYHLHToL4avmP/yHbRRpPjhLvNubF7x5MTLYtldc80U
         s4+E1JgsGsjTuzr4FRoaFinD6oKCINDkJTtcEcYXyh3HfAEIpbgVF0X1fN6vXO8THeWk
         oQzgrjtFGbdCJw5Qc5vpannCM+5VPabA5X7BDUKksY8INYMsJxOD+acwjLlk4yGQYmK4
         hM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hDoQf8XVMWB4WIjEfgbzeZ3Sc8iH6yn9VUuCEmnDaKw=;
        b=cpPdLlemUauGxDrMfFCr1soxZpNqvNIj5ssPebbNBBa+i6RALQO+cgZ+6gMIYdPevf
         S7CO4CN+7w23rjmd9ehApXHy9edJceVeI+tbBqLLK81LaUQiU8KIiryptu9b7ZxgGon0
         vj4tkOTJ+orChhzx4TMtoGY0BNbH4ZT0LHyvfE6HIjEbDxpIFUn+NbHSk7vs177NHdOQ
         iAPrM5gCeS+GM6vxpemx1xZs7O71TIcz1T+kIJ2MTyA3qYjl+qXA+7N14oPiNOM5C3EQ
         zeO5+Osd/FTKoV+oLvb9G9OU2heJBtqyUBnPW/JRoAESrLNL/RJyUyuv9+GzjgyN2hNW
         1/kA==
X-Gm-Message-State: APjAAAVi9+8VYCiqIC57nkz03XDdnbUK/fJ3Sijqb/mj3rtL9e0W+N9c
        6cZN4wz4hg+BuvZ2u8UYax3C3wR0dlg3Lovsien3WLlx728=
X-Google-Smtp-Source: APXvYqz2N6YseMc2JaVVByd10s1wHIsddE686w1OjgTzOcY7ejuEdMag4oB/EBVylQXKWw3u8PJ6+J5CVfKXwKUfxDE=
X-Received: by 2002:a17:902:44f:: with SMTP id 73mr30807143ple.192.1560443098024;
 Thu, 13 Jun 2019 09:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190612095828.17936-1-gregkh@linuxfoundation.org>
In-Reply-To: <20190612095828.17936-1-gregkh@linuxfoundation.org>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Fri, 14 Jun 2019 01:24:46 +0900
Message-ID: <CAC5umyhSiOo6aN=cy09MdH3R3qpWiaqk+b-1Onrc_Byqc19dAQ@mail.gmail.com>
Subject: Re: [PATCH] fault-inject: clean up debugfs file creation logic
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B46=E6=9C=8812=E6=97=A5(=E6=B0=B4) 18:58 Greg Kroah-Hartman <gre=
gkh@linuxfoundation.org>:
>
> There is no need to check the return value of a debugfs_create_file
> call, a caller should never change what they do depending on if debugfs
> is working properly or not, so remove the checks, simplifying the logic
> in the file a lot.
>
> Also fix up the error check for debugfs_create_dir() which was not
> returning NULL for an error, but rather a error pointer.
>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Looks good.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
