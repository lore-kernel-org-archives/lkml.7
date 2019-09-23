Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8E8C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA6C20673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv9NQOxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502344AbfIWTpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:45:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37471 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfIWTpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:45:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id l21so14956125lje.4;
        Mon, 23 Sep 2019 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gwDAel33WMQqtovNB1KbiGxft8Ut6izN7ToSNAkleME=;
        b=Yv9NQOxaxsUpVkjVju0Ku2Piny6tZMnztrF0hoU78XQcFyipSlHK8OH+0XJdhcAXXu
         DfMhxaRn6eLyjdFsoSziIun7hNzxTHR3/mHoixq/4VpavE5b2zTfoFNU1tnIKJgAwYh3
         xEGJsPqt+axA3Sh4bjN4hdpum0ewZvMQG1QsnfgVBUh0p/yROmS5Ns1eXU7w2LjZK3S/
         jHI2od9mVIZ9YrFnTfFJ3vl4tu1IORYOIxG/KMuoOIf2CeRwXGr5hLRFdIen/Ym6+QHf
         rkcZJ4Z4FK/dLijXrNTqxF+mb+WS5El4TTVogxz2GE8/byULkaXc6FP7msE+3IwcwAiA
         hR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gwDAel33WMQqtovNB1KbiGxft8Ut6izN7ToSNAkleME=;
        b=RVAT7lfQSVpNrvYBl0/zbWcjB+NmZR4GZGTFUV+ifWfunCFF/ii8DYwDY3/K3QVwym
         YW1jkaQon/uT9KlZ/mx/aSNvQ0X6xJF77pAVS19wTMbTsVNzB1Ayai06VXhcwhhxZTbL
         i9D4VlFfEr9xBFpZ2xFYVYgRpUbcms/w8OleiYGdFWSzuUP/Ta8JRPvy+EIC1gabAtg/
         TtgTYxLHqTmft7Un4DuAoEr03fi7hx36w19S3NofFI2rDwHvmNfFjuyGWjLzT8Z5oTy7
         +ljQuJhIRNXv1KQGBF9f5G8g4HhpOP9SLAN3Vp67DbJl1jeRCm6RIvjRmqSfFOBdkZ8e
         sxIQ==
X-Gm-Message-State: APjAAAXPhf2zJc3khXRPWyOmMvWLmdQ+4v6GpT40laJAzS0Kn3D9mD65
        NcJA0UNcydEUoLkd7Lcn+NN4bFuW2CK8w8GURh85VgBCfg==
X-Google-Smtp-Source: APXvYqyBNqDyQfdRnIKbGnBdPmHVX8SqkL5m0iS64hTwCXwrlnJPlNCSfEkI2e3BSMtAGtK3Y3JP69fPk69uPR+MvwY=
X-Received: by 2002:a05:651c:20a:: with SMTP id y10mr586999ljn.163.1569267935769;
 Mon, 23 Sep 2019 12:45:35 -0700 (PDT)
MIME-Version: 1.0
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Mon, 23 Sep 2019 21:45:05 +0200
Message-ID: <CAEJqkgjSes-4bSKbyfbNhXfcQwdEMzp8X4f72_SS=NpBoBtWmQ@mail.gmail.com>
Subject: acer_wmi: Unknown function(s) on Acer Nitro 5 (AN515-43-R8BF)
To:     platform-driver-x86@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I noticed some warning in dmesg on this Laptop.

Fn+right, Fn+left is BrightnessDown/Up and produce the following warning:

acer_wmi: Unknown function number - 4 - 0

The brightness has some other issue on this Laptop but not sure
who to blame on this. Probably amdgpu.?

/sys/class/backlight/amdgpu_bl1/brightness <-> actual_brightness
seems to mismatch.  EG: when brightness is 0 actual_brightness is still 5140.

Unplugging the AC gives the following warning:

acer_wmi: Unknown function number - 8 - 0

When plugging the AC back I see;

acer_wmi: Unknown function number - 8 - 1.

I uploaded a dump of the acpi tables and dmidecode of the box.

https://www.frugalware.org/~crazy/nitro5/ACPI
https://www.frugalware.org/~crazy/nitro5/DMI

Please let me know if you need any other informations.

Best Regards,

Gabriel C
