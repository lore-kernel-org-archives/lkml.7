Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A74C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2857217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555598405;
	bh=tekO43nJXxpaaeevEmdoVFA6o1lSPhmSz0QpgCW8LDc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dJ6sMhnWNUuYP0SyAUuNY3X64rn4nw3IFkabNv230Sp3ZBfwiV/lXLDLobvs6Lg85
	 nzuIiPnnJblIxjc2UFFUjup5Z9A+DXKKlaTHqP5N7Jmkjrc37hR3J/OdPyd81ySRb5
	 dS0vbPtBxHmyu2MmuztLCanbEi6etsnrDVPVkP0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbfDROkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:40:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33338 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388277AbfDROkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:40:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id e5so1808363oii.0;
        Thu, 18 Apr 2019 07:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwMyiCrXg7F4EhT0zxsPBDwK6KZEo1cltBW0EokSJ4o=;
        b=qCb5xupsBvym06K1m0cG3VYd7rsQ0OBpY18rdj9iYKYbU4PsE6MUC+t4HZxBWX1bq1
         Oz512pMCrIKHzhHbJAGwwpXoDnvelAod78RSTzJB9hXTEBVwjXfp/0j/qrBjuWvGtugv
         lKD1JtVw/OvieApObOgK+YJdWq+Y4Q18moRU5pvIRTpa1WKUs/yRGWVoWQr7iE8msr7N
         rZEEEX9ObLUibCSceowEwZy1Jr8/FTyATmRdROuM76953Q2E52iDj4nBtq6mNQVakMsc
         MBHltiKDYVlnzXheZZaJwj45PXLQX4dRiXXHkg2kIvji/Tgt1DhyeuumaFkenDy1GqbT
         LyMg==
X-Gm-Message-State: APjAAAXJbqxosTVHtechah+EOPrLTFtUwLsc1egJlSgPz0cYC1CeAcft
        YKy+MMkTdE61YTRMGxCnPzFdUa1upP2Okv+jM08=
X-Google-Smtp-Source: APXvYqxQJ/eZGM8YukG2KhMNqstirXgSqSvnFEPXxKBHamuwMHGBG+l9h7Dzxjo3nnwli0OutOYXLps3SHxCfZOsprI=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr2368438oif.110.1555598402635;
 Thu, 18 Apr 2019 07:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com>
 <1555411164-26399-1-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0i2-11rgH5Y+83U041Eyp=SA56oPqDmS2g24SyYYJH3jg@mail.gmail.com> <ebb13205-2548-1c30-fd65-bdfe4c7d9c08@arm.com>
In-Reply-To: <ebb13205-2548-1c30-fd65-bdfe4c7d9c08@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Apr 2019 16:39:51 +0200
Message-ID: <CAJZ5v0jXioEAELmHqMhR0wJQkzLQpp1WA-zuWHdFkSWjiX0kVw@mail.gmail.com>
Subject: Re: [RESEND][PATCH v2 27/36] drivers: Add a generic helper to match
 device by fwnode handle
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:53 PM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> On 04/16/2019 11:48 AM, Rafael J. Wysocki wrote:
> > On Tue, Apr 16, 2019 at 12:39 PM Suzuki K Poulose
> > <suzuki.poulose@arm.com> wrote:
> >>
> >> Make the device_fwnode_match() a generic helper to match device
> >> by fwnode handle for use with bus_find_device(). This will be
> >> also used by coresight.
> >>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Cc: linux-acpi@vger.kernel.org
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>
> >> Resending with linux-acpi in Cc, as requested by Rafael.
> >
> > Do any other patches in your series depend on this one?
>
> Yes, I do. But they are in the middle of a big series of changes and
> I don't expect this series to go into 5.2. So, if you plan to pull this
> please go ahead.

I would prefer the new exported function to return bool.  With that
changed, I can apply the patch I think.
