Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6328C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7985D207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e65zpbS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFDTfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 15:35:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34153 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDTfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 15:35:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so4505033pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=xTD3XYO7Igxo0exyVWI6cc/41JrtEN9oQdvmNtmSfwE=;
        b=e65zpbS38buPRA7hJtKymGX9tOAOvBPPnprOcQ6P31L4GDzt+jIz0g3GAnaNu6GwrK
         hXlj+/nGYhqoWPwArQB6kpxB0vnmyu9pMLgzZCwXSQeWDJ4VaDBX6ebIrbJq4LqWNsil
         nyb5IFzRCjhcgcgLI1jmjaOzRFqzAy3rG/zw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=xTD3XYO7Igxo0exyVWI6cc/41JrtEN9oQdvmNtmSfwE=;
        b=VremAChd031TWdJyfXqZcOHdpykMrJKz7hNw2V4hAts4m3QCu2ZmkZm22CCXwwd6If
         TKl7bRqh2SSMnHPKpsgPd+ZbDCrd8hqr94rIKHb7oCGHhHuVVw7+su5mBcGFjq7DyW3Y
         O3GdTMVmZwHan7zdR6hSTphcnHRSUy4QYwQ27B8YICaIL0IL/HNCPKB9tR6Tj1Sv7W8w
         PxYXifxP+XEzqOwGTXmpCv+DMrcDs6xzPMG0CRre+dyrERzrEVz3msP5VnW4rHVXkmAz
         oDbk/8qxoz/6RlZkpi0e2atiDPCwdm6njIcD62Dv4/qkry4DOG/HGBlgSkKQ2nFR36m5
         UA5g==
X-Gm-Message-State: APjAAAVwKE4npyy2ptEWQFJryOVO+0bjYAVlISuviFmQbPFBRkmb6G9q
        t3EY7TWFAA3D4zW/qH3zaL6Rzg==
X-Google-Smtp-Source: APXvYqwy/fZXLgeDSXS8MB6n4hh9Ump+ILns1RyYBF25QdlYHm22iNJCOMA32625Bb8ggKG9bpa1gA==
X-Received: by 2002:a63:70f:: with SMTP id 15mr237119pgh.432.1559676902860;
        Tue, 04 Jun 2019 12:35:02 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g17sm29008667pfb.56.2019.06.04.12.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 12:35:02 -0700 (PDT)
Message-ID: <5cf6c7e6.1c69fb81.e1551.8ac4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d6b4fb26-9a1b-0acd-ce4a-e48322a17e7d@collabora.com>
References: <20190221203334.24504-1-helen.koike@collabora.com> <5cf5a724.1c69fb81.1e8f0.08fb@mx.google.com> <d6b4fb26-9a1b-0acd-ce4a-e48322a17e7d@collabora.com>
Cc:     wad@chromium.org, keescook@chromium.org, snitzer@redhat.com,
        linux-doc@vger.kernel.org, richard.weinberger@gmail.com,
        linux-kernel@vger.kernel.org, linux-lvm@redhat.com,
        enric.balletbo@collabora.com, kernel@collabora.com, agk@redhat.com
To:     Helen Koike <helen.koike@collabora.com>, dm-devel@redhat.com
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v12] dm: add support to directly boot to a mapped device
User-Agent: alot/0.8.1
Date:   Tue, 04 Jun 2019 12:35:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Helen Koike (2019-06-04 10:38:59)
> On 6/3/19 8:02 PM, Stephen Boyd wrote:
> >=20
> > I'm trying to boot a mainline linux kernel on a chromeos device with dm
> > verity and a USB stick but it's not working for me even with this patch.
> > I've had to hack around two problems:
> >=20
> >  1) rootwait isn't considered
> >=20
> >  2) verity doesn't seem to accept UUID for <hash_dev> or <dev>
> >=20
> > For the first problem, it happens every boot for me because I'm trying
> > to boot off of a USB stick and it's behind a hub that takes a few
> > seconds to enumerate. If I hack up the code to call dm_init_init() after
> > the 'rootdelay' cmdline parameter is used then I can make this work. It
> > would be much nicer if the whole mechanism didn't use a late initcall
> > though. If it used a hook from prepare_namespace() and then looped
> > waiting for devices to create when rootwait was specified it would work.
>=20
> The patch was implemented with late initcall partially to be contained
> in drivers/md/*, but to support rootwait, adding a hook from
> prepare_namespace seems the way to go indeed.

Alright, great.

>=20
> >=20
> > The second problem is that in chromeos we have the bootloader fill out
> > the UUID of the kernel partition (%U) and then we have another parameter
> > that indicates the offset from that kernel partition to add to the
> > kernel partition (typically 1, i.e. PARTNROFF=3D1) to find the root
> > filesystem partition. The way verity seems to work here is that we need
> > to specify a path like /dev/sda3 or the major:minor number of the device
> > on the commandline to make this work. It would be better if we could add
> > in support for the PARTNROFF style that name_to_dev_t() handles so we
> > can specify the root partition like we're currently doing. I suspect we
> > should be able to add support for this into the device mapper layer so
> > that we can specify devices this way.
>=20
> hmm, I didn't test this yet but at least from what I can see in the
> code, verity_ctr() calls dm_get_device() that ends up calling
> name_to_dev_t() which should take care of PARTNROFF, this requires a bit
> more investigation.
>=20

Ok, thanks for pointing that out. Sorry I totally missed this codepath
and I should have investigated more. It works for me with the PARTNROFF
syntax that we've been using, so the problem is the rootwait stuff.

