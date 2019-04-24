Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4D7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D9520685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556090443;
	bh=rni+V//AQhwJI60hOiEBtbHqeDGaouyP06UShjZshgs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ISMab77qs6mhAQ5yvfvJ+txAmBhYXNXV3Js+WzchCr6M9Gd9PFpZh6p16JhPs93NF
	 5XFa2T8dMBY3fRJGI8YT/HTwGFaNqzKZgDeR6DS4uIXwRXNqpfYx9GwkrFxciKqufs
	 +uN+BiaINl6beBcFhSsHio54pJwm/LQLOCy9oWQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfDXHUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:20:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45440 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbfDXHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:20:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id y84so13416959oia.12;
        Wed, 24 Apr 2019 00:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlz/jTFbB35TazHt6RURpEdEs+qLpXbIqgsneSLwibs=;
        b=VwO+toLqNpbRqXu3VtCvM+P3dwS4HB0jO3h69CZ2Ij5tQ15A+i4mBHewjSaxLPuP2S
         if3wJr5tj/7mPt3GujufjYZBB1u7g/DSn5Q/FP97AXFrpPDsOyY3W4PTzeNLvHUCjNMo
         aBh1Q3vFrUZJgJ6C0DZh1OXL1emw4sGx3Zmh1TpDZg2NRv0xkNGRmMwAse0mqVkCFwsj
         13LYJJ65sG5S+I0P0Gj/y2nGKLG/NvyE37BnvBs49vIIB9+sgVn0+J9IoNBRI5camlU+
         xuN8AE4NaGZU5eQCKKk9gCfhArE5UojfOCyT+IT3WXUupFsmoIUQePu76IAjNVOoZiEX
         J47Q==
X-Gm-Message-State: APjAAAVU5tJpM7k1x56R4zFtib354605cppO7ZqznYaBfPeTyCA/nwhi
        qjghOR0IziE5+AyO0935ES9AFm0d8IYCeClFUfI=
X-Google-Smtp-Source: APXvYqybS7c6y+CMjsK6KfZdX0AjHN7GPWCDQkmNbWb7gjc0hpRXuytL6tBsi4NHFhKo0TFX9ZfnC1xrT+GGi+7cdZE=
X-Received: by 2002:aca:6c47:: with SMTP id h68mr4966666oic.57.1556090441401;
 Wed, 24 Apr 2019 00:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com> <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
 <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com> <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
 <f6db39bc-b8d1-fda8-ad37-a8b050ef0027@redhat.com> <37aee883-1253-adad-82b4-4a578cc72825@uwyo.edu>
 <CAJZ5v0j9U20cFbRx6QKeQv6wyDg6nL71L0U_Rec5+W1JoD8-=w@mail.gmail.com> <144b56d4-54e6-bccd-4652-22303bcd9168@uwyo.edu>
In-Reply-To: <144b56d4-54e6-bccd-4652-22303bcd9168@uwyo.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Apr 2019 09:20:28 +0200
Message-ID: <CAJZ5v0jJEovXXiqs-tzPC7FsGjGL+qxfXCxbTrQZqAxSCv1oyQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
To:     "Robert R. Howell" <RHowell@uwyo.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:03 PM Robert R. Howell <RHowell@uwyo.edu> wrote:
>
> On 4/23/19 2:07 AM, Rafael J. Wysocki wrote:
> >
> > On Sat, Apr 20, 2019 at 12:44 AM Robert R. Howell <RHowell@uwyo.edu> wrote:
> >>
> >> On 4/18/19 5:42 AM, Hans de Goede wrote:
> >>
> >>>> On 4/8/19 2:16 AM, Hans de Goede wrote:>
> >>>>>
> >>>>> Hmm, interesting so you have hibernation working on a T100TA
> >>>>> (with 5.0 + 02e45646d53b reverted), right ?
> >>>>>
> >>
> >>
> >> I've managed to find a way around the i2c_designware timeout issues
> >> on the T100TA's.  The key is to NOT set DPM_FLAG_SMART_SUSPEND,
> >> which was added in the 02e45646d53b commit.
> >>
> >> To test that I've started with a 5.1-rc5 kernel, applied your recent patch
> >> to acpi_lpss.c, then apply the following patch of mine, removing
> >> DPM_FLAG_SMART_SUSPEND.  (For the T100 hardware I need to apply some
> >> other patches as well but those are not related to the i2c-designware or
> >> acpi issues addressed here.)
> >>
> >> On a resume from hibernation I still see one error:
> >>   "i2c_designware 80860F41:00: Error i2c_dw_xfer called while suspended"
> >> but I no longer get the i2c_designware timeouts, and audio does now work
> >> after the resume.
> >>
> >> Removing DPM_FLAG_SMART_SUSPEND may not be what you want for other
> >> hardware, but perhaps this will give you a clue as to what is going
> >> wrong with hibernate/resume on the T100TA's.
> >
> > What if you drop DPM_FLAG_LEAVE_SUSPENDED alone instead?
> >
>
> I did try dropping just DPM_FLAG_LEAVE_SUSPENDED, dropping just
> DPM_FLAG_SMART_SUSPEND, and dropping both flags.  When I just drop
> DPM_FLAG_LEAVE_SUSPENDED I still get the i2c_designware timeouts
> after the resume.  If I drop just DPM_FLAG_SMART_SUSPEND or drop both,
> then the timeouts go away.

OK, thanks!

Is non-hibernation system suspend affected too?
