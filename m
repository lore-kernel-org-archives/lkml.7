Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54ABC04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889CD217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfE1Rp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:45:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36571 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfE1Rp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:45:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so2021363qkl.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 10:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAYtqa2DAr5N77/OMPYjghZagaZbPGB+Zztk+7V5jgU=;
        b=pBGxVv5URZQMuCOReMNbscBbHwsvp+4KbjtQJRdduQNg6PMzHC1r4HbL5BB3wcP0zn
         5h2fsmGzBrprmBt0Bp8OUnyAaPqSHkTRQuVN8zU+8VCHaa15yiV9TJLQX3tN/fupDaU5
         P1CfgwJw98TdnFRZhWRVoBJQ9wxnxczHatu0LOumEK+jt9JmLhA3wY0TV3PZcClMGM4J
         aqERBdzrzVHunvj0x/0em2HVGdPEfSWZ/FZafcdNacTUBOJuSHYpUFjYG2NZMpo2KbHk
         Uym19q8hqnx2Fs/4zD9YhilOQ5dc/2RYxU12Oqn8fQCDF7M7dlhVE+A/acbmXDhMECix
         Vryg==
X-Gm-Message-State: APjAAAW89RGhKOa/ZJeMRMpxEyHJTqcAE9usTOMsuxFDS6rZYXoBd9eT
        LWE4L9k1TQneipXw+60FAaT6gAdSyps0YjUL9R1tIg==
X-Google-Smtp-Source: APXvYqz1xnUIVAN8WZEme5sRuWkK0m2Sb1s8935RgGJHI43BAZQampPfuKMjgr/Icm7bFwaGd4NsYX+joPPkLxIDo7g=
X-Received: by 2002:ac8:303c:: with SMTP id f57mr13204817qte.294.1559065526243;
 Tue, 28 May 2019 10:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com> <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 28 May 2019 19:45:15 +0200
Message-ID: <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
Subject: Re: hid-related 5.2-rc1 boot hang
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 7:15 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 28 May 2019, Dave Hansen wrote:
>
> > I have a system that works fine on 5.1.  When updating to 5.2-rc1, it
> > hangs at boot waiting on an instance of systemd-udevd.  The kernel
> > backtrace (https://photos.app.goo.gl/EV8rf7FofWouvdeE8) looks like it's
> > doing an finit_module() that dives into the hid code and is waiting on a
> > request_module().
>
> Dave,
>
> thanks for the report.
>
> Just to confirm -- I guess reverting 4ceabaf79 and a025a18fe would work
> this around, right?
>

It would be also interesting to know which distribution and which
systemd version you are running (if you are on systemd).

This rings a bell as I recall  playing with
request_module/request_firmware a while ago, but Hans convinced me
that no such delay would be induced.

Cheers,
Benjamin
