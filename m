Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6872C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C46D217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fqRhCbgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfHGAaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:30:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39377 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbfHGAaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:30:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id x3so8861160lfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 17:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=04KeAaCHcaHA13etq10kb5eqtxQxSQGGJ3drhfuep0U=;
        b=fqRhCbgmWE11EYy3WIsEPjq48dq2jzTQOhZT7z7UW8KW//nC8dYqObDWTiTfCLO1kp
         kxxcmjUAd/qgJ4YzxnhotT/4QmTXeMCRqlRUH6vvg2rdYn3xcQosK24cTLIVKz6qhULf
         VJVsUbuWu0FTrMtZ86g1CyNgtVWby+VNSNh5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=04KeAaCHcaHA13etq10kb5eqtxQxSQGGJ3drhfuep0U=;
        b=pHGcB4GKJJ7jSZx1iwbeSN7dqliJ+00mIMevPojhq9p3Jpirb2tG4wNNRzxoB//xEN
         FApTIZZPAukMN9uzgEMQ/RLUiYwoMGuK8Ty0dDtIdWUxrWPIavr6ZdYXFGlO52+IIA9e
         ko/hYmGmkPirrsUdOcVoGIlZODllOKaIHJafZiGxd+yqAlZ7UvH98GChiWf0LhJd6p+v
         1wfk8V27enygz3JFzK1ZveUub3S74e7ZShsvO8W45QyFAX7jr2XBbi7ymX9qmtWOmCAs
         H1MWcabnFJEMGejD2LJG0QD87b35OUqELuWvctsfgFfZ3Svk9+g0YpdWT1e2x+7DOseR
         oJYw==
X-Gm-Message-State: APjAAAXv2PIeZUAGzYIPzJThg5NK4rnzbVRx7czW+aCJskngH3vAYbPE
        f+wRIMg9qUd/XdMWY5lpS1gZCaLXIFM=
X-Google-Smtp-Source: APXvYqxddrywG6Y9pPCABUIv7/PzG8bi/6HgUqUlqK4xjEXuMWya+B+d0Swzv96kbGFlYH71fB9/gA==
X-Received: by 2002:a19:ca4b:: with SMTP id h11mr3997174lfj.162.1565137819145;
        Tue, 06 Aug 2019 17:30:19 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id q22sm18376953lje.75.2019.08.06.17.30.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 17:30:18 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id z15so58362743lfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 17:30:17 -0700 (PDT)
X-Received: by 2002:a19:ed11:: with SMTP id y17mr4205590lfy.141.1565137817348;
 Tue, 06 Aug 2019 17:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAH040W7fdd-ND4-QG3DwGpFAPTMGB4zzuXYohMdfoSejV6XE_Q@mail.gmail.com>
In-Reply-To: <CAH040W7fdd-ND4-QG3DwGpFAPTMGB4zzuXYohMdfoSejV6XE_Q@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 6 Aug 2019 17:30:06 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM6Jz7YY9XUj6QKv5VJCED-BnQ5K1UZHNApB9p6qTWtgg@mail.gmail.com>
Message-ID: <CA+ASDXM6Jz7YY9XUj6QKv5VJCED-BnQ5K1UZHNApB9p6qTWtgg@mail.gmail.com>
Subject: Re: Realtek r8822be wireless card fails to work with new rtw88 kernel module
To:     =?UTF-8?B?6rOg7KSA?= <gojun077@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Tony Chuang <yhchuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ yhchuang

On Tue, Aug 6, 2019 at 7:32 AM =EA=B3=A0=EC=A4=80 <gojun077@gmail.com> wrot=
e:
>
> Hello,
>
> I recently reported a bug to Ubuntu regarding a regression in wireless
> driver support for the Realtek r8822be wireless chipset. The issue
> link on launchpad is:
>
> https://bugs.launchpad.net/bugs/1838133
>
> After Canonical developers triaged the bug they determined that the
> problem lies upstream, and instructed me to send mails to the relevant
> kernel module maintainers at Realtek and to the general kernel.org
> mailing list.
>
> I built kernel 5.3.0-rc1+ with the latest realtek drivers from
> wireless-drivers-next but my Realtek r8822be doesn't work with
> rtw88/rtwpci kernel modules.
>
> Please let me know if there is any additional information I can
> provide that would help in debugging this issue.

Any chance this would help you?

https://patchwork.kernel.org/patch/11065631/

Somebody else was complaining about 8822be regressions that were fixed
with that.

Brian
