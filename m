Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917182082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="lGgnHNhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDKIVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:21:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37596 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfDKIVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:21:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so6109876qtn.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=US8I1OrPDCYIIBsY9+LutTDKh9eROciFyoQZAfhWaW8=;
        b=lGgnHNhfpbOlzoZUS88tfFhqWFs8tF4lBxH9t1htisNLx0WNkL+INakw/nd2Jl85wQ
         m5PFBkbF7+hluvCc5nz9epQEimQ5QfIfAPpY3+Tuui2dRxwFmh3I+DZ+EDrtWYhK7PEQ
         o7HXePYQvfolzIvzcziXKGOapXeRuGKLIoNoTsbEQupxplpm8ovd8FaXQhGeMMVncDQi
         8zveEaFyj2z/60qKEcrxJ7bgf6PUsdjc//+wC1keQt8rbYomQA9HprG7S9ozTEDh1s5x
         FOnXF1dWugRJE8LnVGp3Xt9s7n4J+6LxRXkSF/zkxP3s/753yCDneP6jeUBZvY6vEN8n
         9gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=US8I1OrPDCYIIBsY9+LutTDKh9eROciFyoQZAfhWaW8=;
        b=cYh3VAsDF3+9QBknDijxES07UXWcIT9EqsB3YGiH+xLV1Yr9Lj5/tCgPezoc8SRQAS
         AFXIdqDweL6U2bjITehnNR3vRxct4TX1CZwGi2BbOdFqHO5lFMN1uBY4jOm869NyWMTZ
         n1BWFqqvsyPg726iQehOkIIXciF/gsohpF8Achy0mzlmsnLLaOMS80lAHV058oyWhwGI
         hRXOesz2xMxG+vchEx6u/Ezaig8bdmordI2eajIcaxQDNuNBFYhdRuYR7OdDnHp/5Nyv
         NzXU4Fy3jiNW7u9wcoaFVid+OIHCS23K01lNqlTeXCDvgudtNTu29uzgrBtTm2sUWBol
         MolQ==
X-Gm-Message-State: APjAAAVs05faTGZPJGTaTgH13tWls60NKfh6uQTrehk7ev07wd3KrDsR
        rWmJw4NFUXUyr9kOfGWNBEuW20ZGClg1zzh/rekmEg==
X-Google-Smtp-Source: APXvYqw19H0k9NILD5NGBxCKMyEPdcMRXWQDIUzzyYGidvShSuJ7Vf0HmYdHZ1ZWsAl69udZmIEwwoXo7NXsNMBQaFc=
X-Received: by 2002:a0c:d155:: with SMTP id c21mr39447605qvh.64.1554970899893;
 Thu, 11 Apr 2019 01:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com> <f2822519-c137-560e-fe78-172202e52bfa@gmail.com>
In-Reply-To: <f2822519-c137-560e-fe78-172202e52bfa@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 11 Apr 2019 16:21:28 +0800
Message-ID: <CAD8Lp465z=HB5kKZEk7eHd9NVdhSLYhzgiH6Yg45v=j0TCU+SQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] platform/x86: asus-wmi: Fix hwmon device cleanup
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 4:21 AM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> The asus-wmi driver does not clean up the hwmon device on exit or error.
> To reproduce the bug, repeat rmmod, insmod to verify that device number
> /sys/devices/platform/asus-nb-wmi/hwmon/hwmon?? grows every time. Add
> pointer to the device in module state and call cleanup on error.

I wonder if this can be fixed more cleanly by using
devm_hwmon_device_register_with_groups() ?

Thanks
Daniel
