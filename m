Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A894C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D710F20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558019295;
	bh=4jRPBn+wlg+A+RUcELib0vPkUOpkI/dyLxYWcSZiMOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oMJKTf2+w1AtYTAG2wmaQqHPzz2h8G0Hda2NQFIeZa0otzh8vGMn6NF+s8P6bhy+H
	 jU8jGwRbrJEbMJam7ehV0m2yxiue4syMVIfliE1p7OkHnT0mP7rofpbBhj+VqPoojI
	 RbrTe0r5Fr9V/47yV+nTm93Bs6EBKesf/XN19Jv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfEPPIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:08:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47003 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEPPIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:08:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id l26so2882798lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGHxW899Amf7ZgHaxb24JsnGeNM4NZvWTEPA1jMV4y8=;
        b=AtS0tP7u7iyJ1QEm//4O5HaN3+5kkE2tr9Yqtj73YWBv2pnZkSMIsKWKaScHGyv6fO
         H8ljLoZWHA0lu28jqNo2CZO4sASGLxZBPHEQMwNQVDmIJ70k63fFucdxmDo8LHK54i46
         +sia9Wr5owuEX/MqfRs/YVPWurP/Jf7wXvQDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGHxW899Amf7ZgHaxb24JsnGeNM4NZvWTEPA1jMV4y8=;
        b=mkPc/bBU8QNDpmBEKUmqVgq4XAIH1rOtp3ivyg4K+VbyYecF6VAeummaz14AiZpd27
         L5wHODQtBRMxIAlmgUe4ns0iWKW4S2PdOGgIkESkv6ihOMSMz/oxnwzIB1qW3BqgBago
         tiGWbEueOPCrDR7RSoDJra933VA0C4H7aCA2Y6yXWJigczmVsten05RXev7Ylesjplf2
         2QZ/GqM+4GIKQw7wFqkk9sOfzozo43fIEdiw1bKsKfqzleXWqbWaoGDMzozqCxjtxzYi
         Ca71BfiBhbfxrbHDSoHLUYZ2rXK0NCEv5GMT7DkjCLn1/fLtyVOpwQfBgy5Mupt4cNcm
         sR2A==
X-Gm-Message-State: APjAAAUc92xVbYy1hbgxjizhEbUgzfAjn+nwXN0yaLXY3VmZMPE+CZcS
        9qACjFk1qw6XgBzqixrHFhqzF2PRYwE=
X-Google-Smtp-Source: APXvYqzD6Trb13AqmS3WUI1w4TFD8ov+MqtdjMGMgwAswrlNeeFUGfZe1GVMhqeZGs5lXezNx5VYJQ==
X-Received: by 2002:ac2:4893:: with SMTP id x19mr23814849lfc.109.1558019292252;
        Thu, 16 May 2019 08:08:12 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y24sm1008221lfg.33.2019.05.16.08.08.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 08:08:11 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x132so2948673lfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:08:11 -0700 (PDT)
X-Received: by 2002:ac2:510b:: with SMTP id q11mr22478766lfb.11.1558019290857;
 Thu, 16 May 2019 08:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190516044313.GA17751@localhost.localdomain>
In-Reply-To: <20190516044313.GA17751@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 08:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
Message-ID: <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
To:     Eduardo Valentin <edubezval@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 9:43 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> - thermal core has a new devm_* API for registering cooling devices, thanks to Guenter R.
>   I took the entire series, that is why you see changes on drivers/hwmon in this pull.

This clashed badly with commit 6b1ec4789fb1 ("hwmon: (pwm-fan) Add RPM
support via external interrupt"), which added a timer to the pwm-fan
handling.

In particular, that timer now needed the same kind of cleanup changes,
and I'd like you guys (particularly Guenther, who was involved on both
sides) to double-check my merge.

The way I solved it was to just make the pwm_fan_pwm_disable()
callback do both the pwm_diable() _and_ the del_timer_sync() on the
new timer. That seemed to be the simplest solution that meshed with
the new devm cleanup model, but while I build-tested the result, I
obviously did no actual use testing. And maybe there's some reason why
that approach is flawed.

Guenther?

                    Linus
