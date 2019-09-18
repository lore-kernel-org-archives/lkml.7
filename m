Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932EEC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6561D218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6+DvTK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfIRJyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:54:02 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44757 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfIRJyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:54:02 -0400
Received: by mail-ua1-f67.google.com with SMTP id n2so2117067ual.11;
        Wed, 18 Sep 2019 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5gtS+yM+B/W3F1yUw9GbHkkklL2emSJNV+P8Wl6WJU=;
        b=V6+DvTK45f5Kewrd4hdXFL5+ryuu3iOKTRRkfjh2KPewA4I2VFLHE+feohZPjEcW9y
         u1juoerG4EcqlvtvhnETEF9CCXZyYASGPg3+80ZdLp6/E9HF1LoT7CHW5HT6QbdOJA4p
         CDFnD/tAymuqmIj2OrEdAudt5hEsqHSsmyNXU0BEutQ2JFLl+YCRRiR3VFT4BEMgl+3A
         paKDPu0JFoJ/PmXqUR1X11YHPHsCML80vhV1rBMuepJwQ9BbWoquSowHyoVHUrRCO5U3
         epo5YLdh+aUfWW3U1aiPcuHxKtCM3ylCqRHxSJfByjWWwZKI/3fxmKTgqyi6B5UsmYDi
         qwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5gtS+yM+B/W3F1yUw9GbHkkklL2emSJNV+P8Wl6WJU=;
        b=o/ONygw2NM7Tgo3u0VB1cXNgwEUPCh/oy/DPpOi4fK0AOs7J9Ykr8K5Lnv0iqaqz2K
         lBK0KVRX19LZRfqHIimHNa54oQMCbUl81WEiWGfZ7oY28T70dnCaur5PNs/Y5WjV8GsT
         mqqOjrBDvqE9viERQBlv+i73l+IJKJj+baMp2hejh7j94uQpB92RppTxZrM6FutncJ6s
         2Qx5qC4iqciIBu839m/IMZcW4dXM079JosVMsWRe0j4Qa7D6+iONzjSLhEhNarAzI6ig
         EmFIc72cAL1jfIuDStUHXVgZh1arw+mSqVEsev1BtT4Qz/p3198iL/8s/nN9+1QId8YI
         3/uQ==
X-Gm-Message-State: APjAAAUNFYEdg3Pz+J/rwiixOD3pIPwYmITw7m+CLfWfsYiQd/BF4uaH
        XQBCPfvGPWFmkeALcphSZQmacqAYyNY3qSqHtaQ=
X-Google-Smtp-Source: APXvYqwSJ1sw3p/xqW7OOsBpOGLPiZgvrA7SWgx1VSzZdmWueOjQ7vBQb45IVAndJBb7SSBkfyYFPLeGq2BVCFaxsGA=
X-Received: by 2002:ab0:2808:: with SMTP id w8mr1687646uap.75.1568800440960;
 Wed, 18 Sep 2019 02:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <8998.1568693976@turing-police> <20190917053134.27926-1-qkrwngud825@gmail.com>
 <20190917054726.GA2058532@kroah.com> <CGME20190917060433epcas2p4b12d7581d0ac5477d8f26ec74e634f0a@epcas2p4.samsung.com>
 <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
 <004401d56dc9$b00fd7a0$102f86e0$@samsung.com> <20190918061605.GA1832786@kroah.com>
 <20190918063304.GA8354@jagdpanzerIV> <20190918082658.GA1861850@kroah.com>
 <CAD14+f24gujg3S41ARYn3CvfCq9_v+M2kot=RR3u7sNsBGte0Q@mail.gmail.com> <20190918092405.GC2959@kadam>
In-Reply-To: <20190918092405.GC2959@kadam>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Wed, 18 Sep 2019 18:53:49 +0900
Message-ID: <CAD14+f1yQWoZH4onJwbt1kezxyoHW147HA-1p+U0dVo3r=mqBw@mail.gmail.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linkinjeon@gmail.com, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Wed, Sep 18, 2019 at 6:27 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Put it in drivers/staging/sdfat/.

It'll conflict with the current exfat staging drivers.
And moreover, I don't think it makes sense to use sdfat naming in mainline.

Samsung uses it since it handles all fat filesystems.
From what I can tell, that's not in mainline's interests:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-next&id=58985a9d2d03e977db93bf574a16162766a318fe

What I'm proposing is to remove the current exfat drivers and add
sdfat-based one(that I removed fat16/32 handlings and renamed to
exfat).

> But really we want someone from Samsung to say that they will treat
> the staging version as upstream.

Agreed.
Perhaps Namjae didn't pick up our questions with all those mails we
sent during last few days.

Maybe ping him again?

Thanks.
