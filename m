Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC31C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FD620868
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="SQ92VKPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404218AbfEXVKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:10:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45133 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391771AbfEXVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:10:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id j1so9504844qkk.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqwnG1uIANfo29FPPFO9XzdxaIL8u/YShBseQ7nZRAg=;
        b=SQ92VKPGzUpQMVWPmzyFFvqntCrKJfUDQ81Kl1fc2lDQ4knAU0wvsoetXOYHQzC5mC
         aM/JAZnnPh/EYJMQRWlUfVk2UwIhyXH1lNN0LU3qXnZjLBul+NnypLeh7o5b4HJkgfj9
         NaJWpGlQqNt5X397cFWigSHMLSIrVHSV+E3/q42XVK+D+pdJQMDMHAYBU1EayTMIgYdv
         QkfDq8h7q+9cj5n2X9diEXG5BmSEJMeZiLoCbo5jdwXGnvE+ooU3nujenKRix/cVslAG
         5GbBpmWX66iMdRFHApqRCoJTb4konvSDaXKPupYgO7jRIVi1WOXtaKuxqduRfE4R9pfr
         DdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqwnG1uIANfo29FPPFO9XzdxaIL8u/YShBseQ7nZRAg=;
        b=F4W7DRcb/TeM1jeVZiuL11/ueDxa9hP770owOQAMFlV8ZDfuEcbrvoo7iJECVPNYL/
         buvI+UWg47AT7bnFOu8fuyrp+4DpyPMw0X1DB5azHuvVv4XorD4bWnfFsldxtVSa3bQ4
         jPBCaqRYzBBXA0ZfmnNpNDIwbJb8142seg9w7S2LRB6FFEENHhHg6Eeynb8dJvx4JOKh
         xctmap/I3NftB6bsJL2tGb/p821VOnO5WqjrksBZmv/vOOMZQ9mqUZhbI8TRBdCUE5nQ
         e/8pYpGo5nDDy/lwcV2osfmdru8GsLnsPQs85kryhkxq2HkOvZ6DhXmEuxH3qBN7aKt4
         Qamg==
X-Gm-Message-State: APjAAAXT9f4bSdoDRzddFm0kBgxzP55gU74JJxtISUhVgiLTwof42sbT
        AQ4bwaK6UHsVjlWWemRwOPsIiOJdim8oDUMn4lLKqQ==
X-Google-Smtp-Source: APXvYqw53TxiSztmeS5aG/lRAscCWEBCg60ghArjRRHg8ms6Qa8DVfD44TDY+uL/Ii2z9W8E3g1ie46yeMnAfbL/JOU=
X-Received: by 2002:a0c:b04f:: with SMTP id l15mr70291951qvc.191.1558732245610;
 Fri, 24 May 2019 14:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com> <35811fe2-7aac-aa3c-46dc-2bef515b0f47@gmail.com>
In-Reply-To: <35811fe2-7aac-aa3c-46dc-2bef515b0f47@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 24 May 2019 15:10:34 -0600
Message-ID: <CAD8Lp45kFO47N9KpgF4SACLUZmjOEG49_=ZLgP8fZyOYh_qYJg@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] platform/x86: wmi: Add function to get _UID of
 WMI device
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 12:59 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> Add a new function to acpi.h / wmi.c that returns _UID of the ACPI WMI
> device. For example, it returns "ATK" for the following declaration in
> DSDT:
> Device (ATKD)
> {
>     Name (_HID, "PNP0C14" /* Windows Management Instrumentation Device */)
>       // _HID: Hardware ID
>     Name (_UID, "ATK")  // _UID: Unique ID
>     ..
>
> Generally, it is possible that multiple PNP0C14 ACPI devices are present in
> the system as mentioned in the commit message of commit bff431e49ff5
> ("ACPI: WMI: Add ACPI-WMI mapping driver").
>
> Therefore the _UID is returned for a specific ACPI device that declares the
> given GUID, to which it is also mapped by other methods of wmi module.
>
> Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>

Some extra background may be useful when reviewing this.

As researched in
https://marc.info/?l=linux-kernel&m=155498017207933&w=2, we are
dealing with a tricky situation.

asus-wmi currently serves two different classes of device: eeepci-wmi
and asus-nb-wmi.

The eeepci devices have:
  _WDG : includes a METHOD block with GUID ASUS_WMI_MGMT_GUID, and an
EVENT block with GUID EEEPC_WMI_EVENT_GUID
 _UID : ASUSWMI

The asus-nb-wmi devices have:
 _ WDG : includes a METHOD block with GUID ASUS_WMI_MGMT_GUID (same as
eeepc), and an EVENT block with GUID ASUS_NB_WMI_EVENT_GUID
 _UID : ATK

To support new devices we now need to start concretely identifying
which of these we are working with. But complications include:
 - The main MGMT_GUID used for matching at the moment is shared over
both device types
 - Some Asus products have both of these (via two separate two
separate PNP0C14 WMI devices).

Currently eeepci-wmi and asus-nb-wmi register themselves with
asus-wmi, which registers a platform device for each one. The platform
dev probe then succeeds the platform device probe when it finds any
_WDG entry for the main MGMT_GUID and the _WDG entry for the
corresponding event GUID (not necessarily as part of the same
underlying ACPI Device). In the case of both devices being present
with duplicate MGMT, the first one that is parsed wins, and the other
is ignored (see guid_already_parsed()).

Sticking with the current approach, which is imperfect for devices
that have both devices, adding a method to detect the _UID seems
reasonable. Although actually I just realised you could probably also
detect the difference by using wmi_has_guid() on the EVENT UUID
without having to add a new function.

I'll keep thinking about how to improve the situation around two
devices present (but don't want to needlessly conflate this patch
series with that).

Daniel
