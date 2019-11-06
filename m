Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F291CC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FB32075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k7NGxK51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfKFTIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:08:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37404 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfKFTIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:08:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so13139016pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=BaqbKobe0jxjSSf8ASCculhZ9lF+9i0oqNNSuq7LJSc=;
        b=k7NGxK51P0gq6/cVH8RnI35juHOis4+iMWtlorN4LInlpsFGO/3NaqjXNq9VUeTCH8
         ZEhmUoKVLpz0jUlnjNh+/TZ6r7XrEViRFU+ZCtB8F7lhS8OKBOU/RfYJPa1fnOsAkV5S
         lq5RqIinLZVDUI1ct+5W1pbtzutHgvpoQIJcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=BaqbKobe0jxjSSf8ASCculhZ9lF+9i0oqNNSuq7LJSc=;
        b=oujFQnnTP7KfTLAsJiV/ObXDtGLEoIVd3uaouZNQwDTxq3oBc9nSrCGw/xoaaPeRaY
         Cpknh52DCwPHKY+05fo4YlxsRhSyVvCdNIP+DEiUBvq4zyvm7IFfisWyaEbySRfYuMxV
         IY33vcvrMG54lURlM2xq6xaCu6F2DlIgs5xKMKyk0W6It0cXNzSdl5N9ZXSQZPUN1f+T
         2bp/TUW11FgASCMpZkSqWCdEfmgEMRwJxfscT6KgldVa05ow7mZr405+kV/C2pSj9HzG
         MTULqw2sRrJ46xXFnebac1lHAZDJAmPY9cYuEvf0qfOpSQJA7lCC/DmZ/CQ63b5tRweN
         DJmw==
X-Gm-Message-State: APjAAAXjYeBZrwS/0KYtFXZlanDeFVRsIHy2Ted0e8QwqjdHgePlG8lX
        GHcR1SAxPplrV4e6UZ+XjZjX9w==
X-Google-Smtp-Source: APXvYqySn9ZQK5mxiOTmHd4DqsJ+as1T8d47lJL0ESCaVp9l09y2Av93H7o78ZtWWtMB21Ub5sHMRg==
X-Received: by 2002:a17:90a:2065:: with SMTP id n92mr6061627pjc.20.1573067316837;
        Wed, 06 Nov 2019 11:08:36 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c21sm23764032pgh.25.2019.11.06.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:08:35 -0800 (PST)
Message-ID: <5dc31a33.1c69fb81.c563.2043@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <507d1769-41ba-749a-cafa-d178128bbb8b@codeaurora.org>
References: <20190905091707.14420-1-mkshah@codeaurora.org> <5d7155f2.1c69fb81.61bf.f862@mx.google.com> <507d1769-41ba-749a-cafa-d178128bbb8b@codeaurora.org>
Subject: Re: [PATCH v2] soc: qcom: Introduce subsystem sleep stats driver
From:   Stephen Boyd <swboyd@chromium.org>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org
User-Agent: alot/0.8.1
Date:   Wed, 06 Nov 2019 11:08:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2019-11-06 01:22:14)
>=20
> On 9/6/2019 12:07 AM, Stephen Boyd wrote:
> > Quoting Maulik Shah (2019-09-05 02:17:07)
> >> +
> >> +static inline ssize_t subsystem_stats_print(char *prvbuf, ssize_t len=
gth,
> >> +                                           struct subsystem_stats *re=
cord,
> >> +                                           const char *name)
> >> +{
> >> +       return scnprintf(prvbuf, length, "%s\n\tVersion:0x%x\n"
> >> +                       "\tSleep Count:0x%x\n"
> >> +                       "\tSleep Last Entered At:0x%llx\n"
> >> +                       "\tSleep Last Exited At:0x%llx\n"
> >> +                       "\tSleep Accumulated Duration:0x%llx\n\n",
> >> +                       name, record->version_id, record->count,
> >> +                       record->last_entered, record->last_exited,
> >> +                       record->accumulated_duration);
> > Information in sysfs is supposed to be one value per file. This is a
> > bunch of different values and it includes a version field. Looks almost
> > like something we would put into /proc, but of course that doesn't make
> > any sense to put in /proc either.
> >
> > Please rethink the whole approach here. Can this be placed under the
> > remoteproc nodes for each remote processor that's in the system? That
> > would make it more discoverable by userspace looking at the remoteproc
> > devices. I suppose GPU and DISPLAY aren't "remoteproc"s though so maybe
> > this should be a new 'class' for devices that have an RPMh RSC? Maybe
> > make a qcom_rpmh_rsc class and then have these be stats in there.
>=20
> since stats can be used by userspace for the purpose of computing=20
> battery utilization /sys/power seems to be good place to keep it to me.
>=20
> Adding it under class may require it=C2=A0 to be device. we are using it =
only=20
> as module.
>=20

I believe /sys/power is for the power management subsystem, not
specifically battery utilization or remote processor power states.
Wouldn't battery be /sys/class/power_supply? Why not put this underneath
some /sys/class/remoteproc or so?

> >> +               kobject_put(prvdata->kobj);
> >> +               kfree(prvdata);
> >> +               return ret;
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static void __exit subsystem_sleep_stats_exit(void)
> >> +{
> >> +       sysfs_remove_file(prvdata->kobj, &prvdata->ka.attr);
> >> +       kobject_put(prvdata->kobj);
> >> +       kfree(prvdata);
> >> +}
> >> +
> >> +module_init(subsystem_sleep_stats_init);
> > So if this is compiled into an arm/arm64 image that doesn't include qcom
> > platform support it will create this directory? That's just nonsensical.
>=20
> Kconfig depends on QCOM_SMEM which inturn depends on ARCH_QCOM to get=20
> compiled into.
>=20
> It won't get compiled for other than qcom platforms.

Sure it won't get compiled for anything that doesn't have ARCH_QCOM
enabled, but it can run on a board or SoC that isn't qcom. That's the
concern.

