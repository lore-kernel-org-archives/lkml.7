Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222C3C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1452173B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs6KMGLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407028AbfFKTPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:15:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46056 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388777AbfFKTPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:15:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so5125837plb.12;
        Tue, 11 Jun 2019 12:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FbS5gmW4sJyWE7auBrgSPXqrri3yNCCY5hQxQmnq6k=;
        b=Hs6KMGLtZO47eDQNot9zxlDHcKAAOl29gI57yQS301qXDHXAr3zj57bjv+WVSqJxTs
         GDP6eZtSXWdPPUHMifCIRUUym6SQYY2xVkceJNFJ1C8eHpu362YQCy0tA4mp7HBMH4qh
         OxML16/6Dyfrh2i7+/znD3r8eJPt7Thk8s6atvWvKSRp6F7TKWhMja6YqlYGh1rogFzb
         ljm1teDN/vRQWY4Jydmu5sFLlpXeZLNnYDXZGrUnP++lix9HqdkwURWLtL77iHhsAEZ9
         HD3VOJoliK5HaHnbixnCFwk+px84+Vdcilxf/ja+WE/UuqRmpn0GGujz/3BSkT0jWJXj
         Tn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FbS5gmW4sJyWE7auBrgSPXqrri3yNCCY5hQxQmnq6k=;
        b=ZFxCU9L7ZGQ+E0LrJmKDWNsXOiNNNedRk6DRle528js6QxYa2SDrvGH5tOs43zhIR4
         tdaMZ2AGnG/klGO/thFjrggusCjKkALyME5eKZjXNYeUDoGNHQom0dFSnv717e5Vk7cT
         PILHXOGcT/UHww1HPnbsfsrBfmfIq3s/bj4srO2zIvoPvmqh1TF+7mS1+x2kkTY0kBPU
         bRM8Sc+uaIJMqpcNmO7A5vKm86z7x5WoOCQ3tqBCRPa7xabcqtdEujcz6bPf0XD2aPso
         qVPdD83Mle6TaCPbnYWRABx7jxY/wK7HQ9qZT+VaryugTaQmej0amHdTr979U7UENz2l
         wyHw==
X-Gm-Message-State: APjAAAXUGveqjyBbp0+ouNIVNTeN5Ff+O1rU1hAXR6MyScjhUkuvPWwh
        0qRoTXEQ3R8ze5xn98Emw2ijY8Wk7GkDm6tpb94=
X-Google-Smtp-Source: APXvYqxzgNRzOrFhLfj/IIDljHbkD2oMXAJsYsEhL6lTPng9W+ZNM/k+dqr6H263Dvj/Qh9swhmK6XsSb4M1NeK9Z18=
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr4036693plt.255.1560280550936;
 Tue, 11 Jun 2019 12:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190521062837.3887-1-hdegoede@redhat.com> <CAHp75Vf6qzq3O1qz481FRuT1MN2EZOV43FpoSCC-vqATzyRF8w@mail.gmail.com>
 <0018e660-c1d4-2c42-837f-ceb13d575b86@redhat.com> <41f5c7ff-20a3-ba6a-7ee3-2d3956d8b5a8@redhat.com>
In-Reply-To: <41f5c7ff-20a3-ba6a-7ee3-2d3956d8b5a8@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jun 2019 22:15:40 +0300
Message-ID: <CAHp75Ve8No6pKr0NiNxiQhLRSnJ=w6VW2zsLA2FV9VjqsvvMQA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Only Tell EC the OS will handle
 display hotkeys from asus_nb_wmi
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 9:15 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 28-05-19 15:37, Hans de Goede wrote:
> > Hi,
> >
> > On 24-05-19 18:43, Andy Shevchenko wrote:
> >> On Tue, May 21, 2019 at 9:28 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>
> >>> Commit 78f3ac76d9e5 ("platform/x86: asus-wmi: Tell the EC the OS will
> >>> handle the display off hotkey") causes the backlight to be permanently off
> >>> on various EeePC laptop models using the eeepc-wmi driver (Asus EeePC
> >>> 1015BX, Asus EeePC 1025C).
> >>>
> >>> The asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL) call added
> >>> by that commit is made conditional in this commit and only enabled in
> >>> the quirk_entry structs in the asus-nb-wmi driver fixing the broken
> >>> display / backlight on various EeePC laptop models.
> >>>
> >>
> >> Hmm... doesn't apply.
> >
> > That is likely because your review-andy branch contain a whole-bunch
> > of asus-wmi patches.
> >
> > Since this is a patch fixing a regression this should go to the fixes
> > branch. As the other patches so far are only in your review-andy branch
> > it is probably best to merge this patch to for-next + fixes first and
> > then rebase the set you have in review-andy on top, so that this can go
> > to fixes without getting a merge conflict when the rest of the patches
> > show up...
>
> Ping? This is a 5.x regression fix, as such it would be really good to
> get this into 5.2 and then cherry-picked into 5.y.z.
>

It doesn't apply to our fixes branch.

-- 
With Best Regards,
Andy Shevchenko
