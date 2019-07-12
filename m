Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED9AC742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D02221019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch9r0eIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfGLDIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 23:08:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37143 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbfGLDID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:08:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id y26so6706513qto.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 20:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Latw1SK0aQwgj00tIR9D8mWYTOvWXFhHHTA1m5yyi+Y=;
        b=ch9r0eIFufmMvOXPyCFHTrI9h2Mt4m0F8V/fORZzm0JmIZ4mZrg2EBs7BrB8a5Bg8q
         QScH7El7cPGYSNSkn7d/LUaw50K8lor9HzfCYuNM1A3mfzQ7bbLjoRRIwvPWlMcRsFnD
         Sp/fbUUnbHv4UkVDo/kyteGlH5Lvu3QRxzjawzYeAa011OEX7rS6rSzxLsi/0y5WxP+s
         3umqE8pQlIr3BDZlY3u+XMT1TkWHvNt+dS2DSX7gZ92AkezVJQEYwLinpjaSXGLY56s2
         5OUA0AjcWPj8PfZPvAcS/nB2NEa9jAFfxWB9YDAV9mK6Reff9gmLfLExREzBPiiqfdYf
         VnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Latw1SK0aQwgj00tIR9D8mWYTOvWXFhHHTA1m5yyi+Y=;
        b=HCYbjl6KWydwNmgRWBUtiDdEy5GRTd81X/FBkfKl6vIHugBQvokSKZROpwEmYbW9d5
         E8mwlBzE2bubajIU/dx6mkMHCROoLuHWTDOB22hvLw0fDNx1ZOueHdfcAAzbuwKmSwx2
         Zt0IPGdQ/3ejn25IqI4QPf5UbJRaovH/QcmD/QZZ0g9jUCdVfkrybO+SMCe7GnUnIUAI
         dQ7C45ESbMYClKfoXV1kJNjmYj3nMVuRiYiYAE/tBqzPswlMAgVEAYyWKkhCmur6YLdd
         V842pztOPlQ6p63dljT+TEQqVDyMoYxMmSXOdXZi6Q2JWmWWnGALnOsZd+QKlBsSsjjR
         1S9Q==
X-Gm-Message-State: APjAAAVJxkzjJCQKUFs9Nseue6/Io8D+SKsgaT00g+zfojAPCbrReXYt
        H5+Jtvyq0g3yHSDNlyna4HMLvm75zwE=
X-Google-Smtp-Source: APXvYqxdOaFc56W5RbJfPPO5WTFhBYCrW9FBbZmsudJRW8P2+NBdgGeIJLoA0g+AytXDnXVfl9CeEw==
X-Received: by 2002:a0c:ea34:: with SMTP id t20mr4573647qvp.11.1562900882596;
        Thu, 11 Jul 2019 20:08:02 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.22])
        by smtp.gmail.com with ESMTPSA id h18sm2216868qkk.93.2019.07.11.20.07.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 20:08:01 -0700 (PDT)
Date:   Fri, 12 Jul 2019 00:07:57 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/vkms: Introduce basic support for configfs
Message-ID: <20190712030757.a7sp5xmyzyt24i4e@smtp.gmail.com>
References: <cover.1561950553.git.rodrigosiqueiramelo@gmail.com>
 <20190710170116.GB15868@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zvxlkk76lzcxofrn"
Content-Disposition: inline
In-Reply-To: <20190710170116.GB15868@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zvxlkk76lzcxofrn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07/10, Daniel Vetter wrote:
> On Mon, Jul 01, 2019 at 12:23:39AM -0300, Rodrigo Siqueira wrote:
> > This patchset introduces the support for configfs in vkms by adding a
> > primary structure for handling the vkms subsystem and exposing
> > connectors as a use case.  This series allows enabling/disabling virtual
> > and writeback connectors on the fly. The first patch of this series
> > reworks the initialization and cleanup code of each type of connector,
> > with this change, the second patch adds the configfs support for vkms.
> > It is important to highlight that this patchset depends on
> > https://patchwork.freedesktop.org/series/61738/.
> >=20
> > After applying this series, the user can utilize these features with the
> > following steps:
> >=20
> > 1. Load vkms without parameter
> >=20
> >   modprobe vkms
> >=20
> > 2. Mount a configfs filesystem
> >=20
> >   mount -t configfs none /mnt/
> >=20
> > After that, the vkms subsystem will look like this:
> >=20
> > vkms/
> >  |__connectors
> >     |__Virtual
> >         |__ enable
> >=20
> > The connectors directories have information related to connectors, and
> > as can be seen, the virtual connector is enabled by default. Inside a
> > connector directory (e.g., Virtual) has an attribute named =E2=80=98ena=
ble=E2=80=99
> > which is used to enable and disable the target connector. For example,
> > the Virtual connector has the enable attribute set to 1. If the user
> > wants to enable the writeback connector it is required to use the mkdir
> > command, as follows:
> >=20
> >   cd /mnt/vkms/connectors
> >   mkdir Writeback
> >=20
> > After the above command, the writeback connector will be enabled, and
> > the user could see the following tree:
> >=20
> > vkms/
> >  |__connectors
> >     |__Virtual
> >     |   |__ enable
> >     |__Writeback
> >         |__ enable
> >=20
> > If the user wants to remove the writeback connector, it is required to
> > use the command rmdir, for example
> >=20
> >   rmdir Writeback
> >=20
> > Another way to enable and disable a connector it is by using the enable
> > attribute, for example, we can disable the Virtual connector with:
> >=20
> >   echo 0 > /mnt/vkms/connectors/Virtual/enable
> >=20
> > And enable it again with:
> >=20
> >   echo 1 > /mnt/vkms/connectors/Virtual/enable
> >=20
> > It is important to highlight that configfs 'obey' the parameters used
> > during the vkms load and does not allow users to remove a connector
> > directory if it was load via module parameter. For example:
> >=20
> >   modprobe vkms enable_writeback=3D1
> >=20
> > vkms/
> >  |__connectors
> >     |__Virtual
> >     |   |__ enable
> >     |__Writeback
> >         |__ enable
> >=20
> > If the user tries to remove the Writeback connector with =E2=80=9Crmdir
> > Writeback=E2=80=9D, the operation will be not permitted because the Wri=
teback
> > connector was loaded with the modules. However, the user may disable the
> > writeback connector with:
> >=20
> >   echo 0 > /mnt/vkms/connectors/Writeback/enable

Thanks for detail this issue, I just have some few questions inline.
=20
> I guess I should have put a warning into that task that step one is
> designing the interface. Here's the fundamental thoughts:
>=20
> - The _only_ thing we can hotplug after drm_dev_register() is a
>   drm_connector. That's an interesting use-case, but atm not really
>   supported by the vkms codebase. So we can't just enable/disable
>   writeback like this. We also can't change _anything_ else in the drm
>   driver like this.

In the first patch of this series, I tried to decouple enable/disable
for virtual and writeback connectors; I tried to take advantage of
drm_connector_[register/unregister] in each connector. Can we use the
first patch or it doesn't make sense?

I did not understand why writeback connectors should not be registered
and unregister by calling drm_connector_[register/unregister], is it a
writeback or vkms limitation? Could you detail why we cannot change
connectors as I did?

Additionally, below you said "enable going from 1 -> 0, needs to be
treated like a physical hotunplug", do you mean that we first have to
add support for drm_dev_plug and drm_dev_unplug in vkms?
=20
> - The other bit we want is support multiple vkms instances, to simulate
>   multi-gpus and fun stuff like that.

Do you mean something like this:

configfs/vkms/instance1
|_enable_device=20
|_more_stuff
configfs/vkms/instance2
|_enable_device
|_more_stuff
configfs/vkms/instanceN
|_enable_device
|_more_stuff

Will each instance work like a totally independent device? What is the
main benefit of this? I can think about some use case for testing
prime, but I cannot see other things.
=20
> - Therefore vkms configs should be at the drm_device level, so a
>   directory under configfs/vkms/ represents an entire device.
>=20
> - We need a special config item to control
>   drm_dev_register/drm_dev_unregister. While a drm_device is registers,
>   all other config items need to fail if userspace tries to change them.
>   Maybe this should be a top-level "enable" property.
>=20
> - Every time enable goes from 0 -> 1 we need to create a completely new
>   vkms instance. The old one might still be around, waiting for the last
>   few references to disappear.
>=20
> - enable going from 1 -> 0 needs to be treated like a physical hotunplug,
>   i.e. not drm_dev_unregister but drm_dev_unplug. We also need to annotate
>   all the vkms code with drm_dev_enter/exit() as the kerneldoc of
>   drm_dev_unplug explains.
>=20
> - rmdir should be treated like enable going from 1 -> 0. Or maybe we
>   should disable enable every going from 1 -> 0, would propably simplify
>   everything.
>=20
> - The initial instance created at module load also neeeds to be removable
>   like this.
>=20
> Once we have all this, then can we start to convert driver module options
> over to configs and add cool features. But lots of infrastructure needed
> first.
>=20
> Also, we probably want some nasty testcases which races an rmdir in
> configfs against userspace still doing ioctl calls against vkms. This is
> ideal for validation the hotunplug infrastructure we have in drm.
>=20
> An alternative is adding connector hotplugging. But I think before we do
> that we need to have support for more crtc and more connectors as static
> module options. So maybe not a good starting point for configfs.

So, probably the first set of tasks should be:

1. Enable multiple CRTC via module parameters. For example:
  modprobe vkms crtcs=3D13
2. Enable multiple connectors via module parameters. For example:
  modprobe vkms crtcs=3D3 connector=3D3 // 3 virtual connectors per crtc

Thanks again,
=20
> The above text should probably be added to the vkms.rst todo item ...
> -Daniel
>=20
> >=20
> >=20
> > Rodrigo Siqueira (2):
> >   drm/vkms: Add enable/disable functions per connector
> >   drm/vkms: Introduce configfs for enabling/disabling connectors
> >=20
> >  drivers/gpu/drm/vkms/Makefile         |   3 +-
> >  drivers/gpu/drm/vkms/vkms_configfs.c  | 229 ++++++++++++++++++++++++++
> >  drivers/gpu/drm/vkms/vkms_drv.c       |   6 +
> >  drivers/gpu/drm/vkms/vkms_drv.h       |  17 ++
> >  drivers/gpu/drm/vkms/vkms_output.c    |  84 ++++++----
> >  drivers/gpu/drm/vkms/vkms_writeback.c |  31 +++-
> >  6 files changed, 332 insertions(+), 38 deletions(-)
> >  create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c
> >=20
> > --=20
> > 2.21.0
> >=20
> >=20
> > --=20
> > Rodrigo Siqueira
> > https://siqueira.tech
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

--=20
Rodrigo Siqueira
https://siqueira.tech

--zvxlkk76lzcxofrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl0n+YwACgkQWJzP/com
vP9CZg/9E53QHUFTioD/13tV2Bp4Z05UX3ac9n1vbymmM81xJvRQCd6D45IkNUfL
RiFYInMHCeRMWaXAIJyukjpDueUjtnlYgenlMmbyWZmYmbSN79O+e1nRWvg5h0cf
RL1+1FVlxtdpO58z87QBvEvwQyefPHY92HesOhnb7wEIrW47NaUP9oWs1psFFh1P
NZFXRf2S4eQYwsdIzMI37HZKzdbi0qd91GfsLyfkdJm1osUvhSKvpY06zXbgDfyZ
x89mDv6VdSdC+E3l8AUdAlL3G/NNxG0lQDxvuxozH4DL/QaVkxKyWYTJGFf5Kxo7
47uvsKMcFnjohLdq9x4poRIbJWDwwh5rXA82As38Wuh3kTk622FtZ/LZGzj009ly
OT64x7T0pxL9w+6G0/yS3aNOE+DkeBfXnwltBVsdiNpFWLFvrwxdpnNkOsUnaukw
m/I/Gu8w5Xn8wXyOVaok1K0NGjPXy+nwUIfVOz2s9PrcW48vjfp2HQ2Zio/ntpk1
3dOZc+YZvVy9tPH1bzfbH81wkn/7hCLiuhDVERymz3+bx+Q1UNf51mqXZBCsYWI0
4CEnzxIGZ1qKl0rHnIPz8JCP2KPqiMc8EjmZ+pg/DYsSX8tvpZkjcKd08yEyKVjz
Ivi8de+38jRgTBP4JkB07BMS4pSDLJC+OGqNPni1ZW+b5alDQa8=
=SVj8
-----END PGP SIGNATURE-----

--zvxlkk76lzcxofrn--
