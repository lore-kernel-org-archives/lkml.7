Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B74C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4A020811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qgAr+je4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCSSBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:01:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46245 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfCSSBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:01:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id s23so14223319pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xryz42gpFBJM0pSgAQ2oWQ1B7xBH+bmM8IVBAsOzdAk=;
        b=qgAr+je4uw6We7pH2yD7vCQD8BV/5EZYMSdYtjVrlgKKZYBpSVN9O7B40R5e4DTj/2
         XblgI68XFBghVBfKxglCCsdbGaMI5MCFin6q0SnTzFoPFqkh0ezvIqN0Jjb+8QmE+4Pf
         uolj9+zyyxJTlnHPxynz0CfIn+llatsm1/MxTnwDHaEAZtYltwHP2sIkJuwGRbEQXUkQ
         2/UsNSry6AvzIjsjuwr19IT3cNVpq3sLDSyg78V5pieaH23XqaDSvK8YJIAVJcxxk7Y+
         7CZqoAkhmQWfj/E0auEkwBBOwM/8C/Jl+QjeIFC7v9XG8MprTi0sbgqCDYaq4nCIcb2t
         0y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xryz42gpFBJM0pSgAQ2oWQ1B7xBH+bmM8IVBAsOzdAk=;
        b=s7hnYLMPjPQrrTNtJt2B2quL+9Uk+gFJUhCTedXnZnNXjBPA2DPe/jCqGgQuIyjM2O
         fNf5E83QWNGpV9ehwQXLHjz/ANgBFZNkYPigqxZW06hBs19ZjfDoOTZvWXDtHHIEX5hf
         Do/7LrVzY22UWuZaUBRUyH8Cgg+QWxWttnacC4NUAab6iMnQpdDNhtCIFzqyernicy0E
         HCmhO6gX+Ir97Ak+ROVUPvujyewxTImI5YclCvaPYBTP2YQzFC4YMnqSAy8E1a8QalTF
         pxFn7FJ4R7E92u8to+HTya+IeIIPnEiQFmSCbSq40naTms5UMBs3rFU7+mc6s2YcqFja
         vfyA==
X-Gm-Message-State: APjAAAXLsriLxOB4w658cz3yIrnWapAsRohHnNH4zc5U9ztwBXfZYotX
        Uc9JhcVSj/Z7Gng3OzucdkeHDuKsGOs=
X-Google-Smtp-Source: APXvYqztmWj6EywjWiKk3+i/UVGy9fHlJUc8t9h1L4t2HtOmfQLe5jJh59t6buxkJ/y/ossEGDNrzg==
X-Received: by 2002:a62:ea08:: with SMTP id t8mr3163875pfh.60.1553018482333;
        Tue, 19 Mar 2019 11:01:22 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id s6sm17569770pfm.94.2019.03.19.11.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 11:01:21 -0700 (PDT)
Date:   Tue, 19 Mar 2019 11:01:16 -0700
From:   Benson Leung <bleung@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, Urja Rannikko <urjaman@gmail.com>,
        bleung@google.com
Subject: Re: [PATCH] platform/chrome: cros_ec_debugfs: cancel/schedule
 logging work only if supported
Message-ID: <20190319180116.GA39795@google.com>
References: <1553013156-2808-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <1553013156-2808-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Tue, Mar 19, 2019 at 09:32:36AM -0700, Guenter Roeck wrote:
> The following traceback was reported on ASUS C201, which does not support
> console logging.
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 361 at kernel/workqueue.c:3030 __flush_work+0x38/0x1=
54
> Modules linked in: snd_soc_hdmi_codec cros_ec_debugfs cros_ec_sysfs uvcvi=
deo dw_hdmi_cec dw_hdmi_i2s_audio videobuf2_vmalloc cfg80211 gpio_charger r=
k_crypto rfkill videobuf2_memops videobuf2_v4l2 des_generic videobuf2_commo=
n ofpart m25p80 spi_nor tpm_i2c_infineon sbs_battery mtd tpm joydev cros_ec=
_dev coreboot_table evdev mousedev ip_tables x_tables [last unloaded: brcmu=
til]
> CPU: 2 PID: 361 Comm: systemd-sleep Not tainted 5.1.0-rc1-1-ARCH+ #1
> Hardware name: Rockchip (Device Tree)
> [<c020e4b0>] (unwind_backtrace) from [<c020ac18>] (show_stack+0x10/0x14)
> [<c020ac18>] (show_stack) from [<c07a3e04>] (dump_stack+0x7c/0x9c)
> [<c07a3e04>] (dump_stack) from [<c0222748>] (__warn+0xd0/0xec)
> [<c0222748>] (__warn) from [<c022279c>] (warn_slowpath_null+0x38/0x44)
> [<c022279c>] (warn_slowpath_null) from [<c02365d0>] (__flush_work+0x38/0x=
154)
> [<c02365d0>] (__flush_work) from [<c023786c>] (__cancel_work_timer+0x114/=
0x1a4)
> [<c023786c>] (__cancel_work_timer) from [<bf33233c>] (cros_ec_debugfs_sus=
pend+0x14/0x1c [cros_ec_debugfs])
> [<bf33233c>] (cros_ec_debugfs_suspend [cros_ec_debugfs]) from [<c056a888>=
] (dpm_run_callback+0x64/0xcc)
> [<c056a888>] (dpm_run_callback) from [<c056ad2c>] (__device_suspend+0x174=
/0x3a8)
> [<c056ad2c>] (__device_suspend) from [<c056b9e0>] (dpm_suspend+0x174/0x1e=
0)
> [<c056b9e0>] (dpm_suspend) from [<c026b3e0>] (suspend_devices_and_enter+0=
x6c/0x50c)
> [<c026b3e0>] (suspend_devices_and_enter) from [<c026ba8c>] (pm_suspend+0x=
20c/0x274)
> [<c026ba8c>] (pm_suspend) from [<c026a628>] (state_store+0x54/0x88)
> [<c026a628>] (state_store) from [<c03cd2d0>] (kernfs_fop_write+0x114/0x18=
0)
> [<c03cd2d0>] (kernfs_fop_write) from [<c035d48c>] (__vfs_write+0x1c/0x154)
> [<c035d48c>] (__vfs_write) from [<c035f9e8>] (vfs_write+0xb8/0x198)
> [<c035f9e8>] (vfs_write) from [<c035fbc0>] (ksys_write+0x3c/0x74)
> [<c035fbc0>] (ksys_write) from [<c0201000>] (ret_fast_syscall+0x0/0x4c)
> Exception stack(0xe9365fa8 to 0xe9365ff0)
> 5fa0: 00000004 beef8b28 00000004 beef8b28 00000004 00000000
> 5fc0: 00000004 beef8b28 02319170 00000004 beef8b28 00000004 b6f3d900 beef=
8b74
> 5fe0: 0000006c beef8a98 b6c0adac b6c66534
> ---[ end trace f4ee5df14e8ea0ec ]---
>=20
> If console logging is not supported, the work structure is never
> initialized, resulting in the traceback. Calling cancel/schedule functions
> conditionally fixes the problem.
>=20
> While at it, also fix error handling in the probe function.
>=20
> Reported-by: Urja Rannikko <urjaman@gmail.com>
> Cc: Urja Rannikko <urjaman@gmail.com>
> Fixes: 6fce0a2cf5a05 ("mfd / platform: cros_ec: Move debugfs attributes t=
o its own driver")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>


Looks good. Applied to 5.1-fixes.=20

Thanks for the quick fix.
Benson


--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlyRLmwACgkQHwn1ewov
5liwQA/+O9tGU3IlmSrgD/0unyxBHeE8qvsFh0unuroAY72eKz23fSABIT3pd+u7
mE89PayJR4O8wF8GJTaB+oX3dcWueblUmjbihncv7AkP17aVchv6YfgfI71NE9ax
468+kVDYdBRKYLOAsFSODIPI7Rvrfj1uw5unaJF7wWEpJtqNCce7+h8iOSExTEcn
9ofHfBPsqSk+uvu6Bv7bYfYWQp8sYFGxYfFP/krGDIeATf9+9Pa7LmAOny391RjR
0bCvZLipNAQLExzNW1PJ6/yUoO8QFJ8Gyb0ICCGi7rxDmM+qYw7HY6a0nytFKk6S
5qk/ht+7h2M1T4MNH3ZXd3Z5eAtk5Tcw/T0/0M6R7gzcBwFSAdYfr1QZIT9UKhW0
tWX8+p2Qwfj4n6xo93IKPyoP/e+wKPG8Q9Qv7XoaQeHGmkMcqLOnEkKVURJoaMcT
Q6Jllklj2eOAw9LVV06CcGl5D43mDUh01tfMNhgtvUaFplq79lLwuX+CY9NZSRez
AtI6i/Ice1CJOmUTWNsLIr16sv0IPQqZMW+uXLxgEit8VOiarAet47njIzZ/ilbV
gfAcuxz5fwgiuhxLg9BQI1XuGIRS4xk5ayGbNJREsNyqOYv6w9WzwR/XVj+mHF7J
yRgku+1imFjymEJ99syqK5ApwIPWXzoYLN6AYqRpwEqkbsafp/c=
=plrn
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
