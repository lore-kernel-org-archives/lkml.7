Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8EFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1F62075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555411537;
	bh=NFUYIbsWU5tCd9V22ixH/6+tfugKzThpAUcLcWXBaVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IzFbXK/zodJlYUgsD9o2pIIocE8HW0dnX9KLfQHCIEjufMlZLcPzK26Pzf3XS4WQF
	 3Vs/Cr+nQh8gBjD3kzp5kdrqSQg/FoWFDQqcz/Z0lLlZGXRVKg8L2GcnKtggomr1bm
	 kfEMDmqeWEmZtPIBxe71cvzUViHsGgWwmsS5vV9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfDPKpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:45:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45368 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfDPKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:45:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id e5so2752299otk.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 03:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvSWWHmQxiqG9m8wD5qBRV3YAhnz1X1L4u/Xdk+E8Lw=;
        b=HF6vai4cEOR/JG43SvtPXsWVz9dwlxmVdaRFOhNP1VqUGAA9vffWkT/6KL7A+s4l/l
         pP50x6oXKymxqTZKZ3a0wJdKL+QE9FThrOJeS3r+p0x/IMU1YTXUsR6MNyBs3pTDtWCK
         EIiEz3A5WFqqa//RNUbPUsMpKpFXe/tBw3T35rA+JSPcGO2sGs4WKanUr/3VLneeFL2h
         23MMgXW+/kmhnUK4k1e5QKPKRPURInfnP97+b8ATE6XOoHttispxuC0FTUALDseCq6/8
         6vATQ8dXp1jr5yvKEeoVQuOaaUubmEXrESHmWunh/8Ke0QgAtBRAn3MPyy/e/Z9eRaLC
         lTmA==
X-Gm-Message-State: APjAAAU/zycs8uXuRmH4UJ1HJIrYkiWvoVkekVXzRoT78rNsaoUF7Zn0
        cF1nYy3uS7qQB5I7Spz6RvwEx9orh6NPxPdrtqZyMuQI
X-Google-Smtp-Source: APXvYqwt6hYDtopD64pLBRWb7M1oTCvCYD25ksuYR3GvChGA/wPYerr87Kgm3XqccmfDZYr+eDK8McjBnX+/mRp8898=
X-Received: by 2002:a05:6830:11d0:: with SMTP id v16mr16822277otq.159.1555411534250;
 Tue, 16 Apr 2019 03:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0jZCwPm-mg5L43RbqLKq1vB9zno85G+LPUVb+73KLimVA@mail.gmail.com> <0e152d7f-4b5f-0b0e-ac25-94b6cefa6901@arm.com>
In-Reply-To: <0e152d7f-4b5f-0b0e-ac25-94b6cefa6901@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Apr 2019 12:45:23 +0200
Message-ID: <CAJZ5v0jrBi3oWAVsgk5hMPAudWEBshkqM8Epg0a-7zbnAMOvDg@mail.gmail.com>
Subject: Re: [PATCH v2 27/36] drivers: Add a generic helper to match device by
 fwnode handle
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        mike.leach@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        robert.walker@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:31 PM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> Hi Rafael
>
> On 04/16/2019 11:20 AM, Rafael J. Wysocki wrote:
> > On Mon, Apr 15, 2019 at 6:06 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> Make the device_fwnode_match() a generic helper to match device
> >> by fwnode handle for use with bus_find_device(). This will be
> >> also used by coresight.
> >>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >
> > Can you resend this with a CC to linux-acpi@vger.kernel.org, please?
> >
> > There's some device properties material for 5.2 collected already and
> > it would be good to keep all that together.
> >
>
> Sure, will do. Btw, I have a question w.r.t the match function.
>
> We have :
>
>
> class_find_device(struct class *class, struct device *start,
>                    const void *data,
>                    int (*match)(struct device *, const void *))
> and
>
> bus_find_device(struct bus_type *bus,
>                  struct device *start, void *data,
>                  int (*match)(struct device *dev, void *data))
>
> Just because the "match" has slightly different constraint for the
> data (i.e, const void * vs void *), we can't reuse the same match
> function for class_find_device. Do you think we should converge the
> types to reuse the same match every where (Of course in a separate
> patch series) ?

AFAICS, (void *) pointers can be passed to functions taking (const
void *) arguments, so yes, it looks like that could be consolidated
and it also would be a valuable cleanup IMO.
