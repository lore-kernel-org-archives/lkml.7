Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B088C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9F92186D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP68Jacn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKRR4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:56:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42897 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRR4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:56:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so20608303wrf.9;
        Mon, 18 Nov 2019 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cwfQ3N/cTzoCvXg6T+Zsye4Ejmfzx1Xt1yFenYDRQwA=;
        b=dP68JacnksDrI5NZU3/iOHC/3Dbava94bYvIr/jSx3mOvcE8tqYzEragcpuW63bO0h
         MzHLelLDcRkcZMaOEw22VAHme9ssSoOrpGk5PHsAOl6JxUgIYtXxFVY5nkVaD6iaH/04
         mfyD+MM9V92p8d22bpWhOZG1sHD5S4NwwYaTtrYJQ0Qp6aBJJwP1mnaRzPegSmuBnMYz
         X1PVlduC6Ee+Uuw54O8bp/gksHIQjb79Z/ZQZV6Z07nqGJukkd1+3OI6fZvZMk9bp0b/
         +2SiAH4kwQ9ueqB8prSzFWEBgGRxNTxqDLb6Q9V5IHlRo9Mgd4h14zp9hsUeQcaXtisr
         X5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cwfQ3N/cTzoCvXg6T+Zsye4Ejmfzx1Xt1yFenYDRQwA=;
        b=TPyWBCdmzh2K624Moyc/wwXeWqIB22yeDDTUnj4gRRGDsBkG+rDXcIXXe7/NTaonuf
         Zc09odt6iSSIxUtxjpgkR/JAdcrDzx5c7PG6XKcvRJS3++mJBws7/1tlqwFsqbr36p9G
         8pn/N7fqKocNbVXDRTPmqO5kEp0WpfnNcBN8lDAZnq8FtILdOoli1XYfe+Y3djyCttJQ
         3XfVa2CK7rNoFdmDEW1csN0S3tp86ywtlLp6ATDBy5VJe3SmimtS4wCb2lO/Cg3CttHy
         SfxZjbvN0FDWwxMU3EA0PWHzCPCSCSrrhg/Fywv9anCbsqkIkzbKJmjD2Mii/tqnu0g6
         tUQQ==
X-Gm-Message-State: APjAAAW/RDlwkmmgRkTbR2mm7dOxFB18LE+PDbiNSQMDq2WqNXtUUlnv
        BxFa3u84BAhq5dqDAWKnzHM=
X-Google-Smtp-Source: APXvYqw4H7afnAy3HoRtSRqDF8AFVCwF8p68zMWjYBncl/heJ1FdJBieRGNws3CXw9kkIWiaf4nexw==
X-Received: by 2002:adf:da52:: with SMTP id r18mr31880697wrl.167.1574099778047;
        Mon, 18 Nov 2019 09:56:18 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a15sm14979977wrx.81.2019.11.18.09.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Nov 2019 09:56:16 -0800 (PST)
Date:   Mon, 18 Nov 2019 18:56:15 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Giovanni Mascellani <gio@debian.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dell-smm-hwmon: Add documentation
Message-ID: <20191118175615.ilqmlkcksd2f3yy5@pali>
References: <20191118171148.76373-1-gio@debian.org>
 <20191118171148.76373-2-gio@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yyevasuc2teap2t2"
Content-Disposition: inline
In-Reply-To: <20191118171148.76373-2-gio@debian.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yyevasuc2teap2t2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi! It is great that kernel would have up-to-date documentation.

On Monday 18 November 2019 18:11:48 Giovanni Mascellani wrote:
> Part of the documentation is taken from the README of the userspace
> utils (https://github.com/vitorafsr/i8kutils). The license is GPL-2+
> and the author Massimo Dal Zotto is already credited as author of
> the module. Therefore there should be no copyright problem.
>=20
> I also added a paragraph with specific information on the experimental
> support for automatic BIOS fan control.
>=20
> Signed-off-by: Giovanni Mascellani <gio@debian.org>
> ---
>  Documentation/hwmon/dell-smm-hwmon.rst | 112 +++++++++++++++++++++++++
>  Documentation/hwmon/index.rst          |   1 +
>  2 files changed, 113 insertions(+)
>  create mode 100644 Documentation/hwmon/dell-smm-hwmon.rst
>=20
> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon=
/dell-smm-hwmon.rst
> new file mode 100644
> index 000000000000..f80d30d8a02a
> --- /dev/null
> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> @@ -0,0 +1,112 @@
> +Kernel driver dell-smm-hwmon
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +Description
> +-----------
> +
> +On many Dell laptops the System Management Mode (SMM) BIOS can be
> +queried for the status of fans and temperature sensors. The userspace
> +suite `i8kutils`__ can be used to read the sensors and automatically
> +adjust fan speed.
> +
> + __ https://github.com/vitorafsr/i8kutils
> +
> +``/proc`` interface
> +-------------------

/proc/i8k is legacy interface and ioctl is already obsoleted/deprecated.
New applications should not use this interface. It is replaced by acpi,
input layer and hwmon interface. /proc/i8k is needed for old Dell
laptops (like Dell Inspiron 8000) which do not support acpi or does not
provide input events. Please express this in documentation, so people
would not try to use this old interface in new applications. Also this
legacy interface is available only when kernel is compile with
CONFIG_I8K option.=20

> +The information provided by the kernel driver can be accessed by
> +simply reading the ``/proc/i8k`` file. For example::
> +
> +    $ cat /proc/i8k
> +    1.0 A17 2J59L02 52 2 1 8040 6420 1 2
> +
> +The fields read from ``/proc/i8k`` are::
> +
> +    1.0 A17 2J59L02 52 2 1 8040 6420 1 2
> +    |   |   |       |  | | |    |    | |
> +    |   |   |       |  | | |    |    | +------- 10. buttons status
> +    |   |   |       |  | | |    |    +--------- 9.  AC status
> +    |   |   |       |  | | |    +-------------- 8.  right fan rpm
> +    |   |   |       |  | | +------------------- 7.  left fan rpm

It is not right or left fan, but rather fan0 and fan1 (right =3D 0). On
some laptops is really fan with index 0 on right side, but on some not.

> +    |   |   |       |  | +--------------------- 6.  right fan status
> +    |   |   |       |  +----------------------- 5.  left fan status

Ditto.

> +    |   |   |       +-------------------------- 4.  CPU temperature (Cel=
sius)

This is not CPU temperature, but rather temperature sensor with index 0.
Probably in most cases it CPU temperature. See i8k_hwmon_temp_label_show
for mapping index to sensor name.

> +    |   |   +---------------------------------- 3.  Dell service tag (la=
ter known as 'serial number')
> +    |   +-------------------------------------- 2.  BIOS version
> +    +------------------------------------------ 1.  /proc/i8k format ver=
sion
> +
> +A negative value, for example -22, indicates that the BIOS doesn't
> +return the corresponding information. This is normal on some
> +models/BIOSes.
> +
> +For performance reasons the ``/proc/i8k`` doesn't report by default
> +the AC status since this SMM call takes a long time to execute and is
> +not really needed.  If you want to see the ac status in ``/proc/i8k``
> +you must explictitly enable this option by passing the
> +``power_status=3D1`` parameter to insmod. If AC status is not
> +available -1 is printed instead.
> +
> +The driver provides also an ioctl interface which can be used to
> +obtain the same information and to control the fan status. The ioctl
> +interface can be accessed from C programs or from shell using the
> +i8kctl utility. See the source file of ``i8kutils`` for more
> +information on how to use the ioctl interface.
> +
> +``sysfs`` interface
> +-------------------

Please move sysfs hwmon section before legacy /proc/i8k. So users first
read information about new interface and then (who is interested) can
read details about legacy interface. Personally I would move proc
interface even after module parameters, to be at the bottom of document.

> +
> +Temperature sensors and fans can also be queried and set via the
> +standard ``hwmon`` interface on ``sysfs``.

Maybe add comment that this interface is available in /sys/class/hwmon/
path. And that there is "sensors" command line tool as alternative to
calling legacy "cat /proc/i8k".

> +
> +Disabling automatic BIOS fan control
> +------------------------------------
> +
> +On some laptops, the BIOS automatically sets fan speed every few
> +seconds. Therefore the fan speed set via ``/proc/i8k`` or via the
> +``sysfs`` interface is quickly overwritten.
> +
> +There is experimental support for disabling automatic BIOS fan
> +control, at least on laptops where the corresponding SMM command is
> +known, by writing the value ``1`` in the attribute ``pwm1_enable``
> +(writing ``2`` enables automatic BIOS control again). Even if you have
> +more than one fan, all of them are set to either enabled or disabled
> +automatic fan control at the same time and, notwithstanding the name,
> +``pwm1_enable`` sets automatic control for all fans.
> +
> +If ``pwm1_enable`` is not available, then it means that SMM codes for
> +enabling and disabling automatic BIOS fan control are not known for
> +your laptop. You can experiment with the code in `this repository`__
> +to probe the BIOS on your machine and discover the appropriate codes.
> +
> + __ https://github.com/clopez/dellfan/
> +

Ideally add some comments what could users do when they find correct SMM
commands for enabling/disabling BIOS mode. How and where to add these
SMM commands and where to send patch (to ML linux-hwmon@vger.kernel.org)

> +Module parameters
> +-----------------
> +
> +* force:bool
> +                   Force loading without checking for supported
> +                   models. (default: 0)
> +
> +* ignore_dmi:bool
> +                   Continue probing hardware even if DMI data does not
> +                   match. (default: 0)
> +
> +* restricted:bool
> +                   Allow fan control only to processes with the
> +                   ``CAP_SYS_ADMIN`` capability set or processes run
> +                   as root. In this case normal users will be able to
> +                   read temperature and fan status but not to control
> +                   the fan.  If your notebook is shared with other
> +                   users and you don't trust them you may want to use
> +                   this option. (default: 1)

Add a note that option is only for /proc/i8k and so it is available only
when kernel is compiled with CONFIG_I8K.

> +
> +* power_status:bool
> +                   Report AC status in ``/proc/i8k``. (default: 0)

Again, this is available only when kernel is compiled with CONFIG_I8K.

> +
> +* fan_mult:uint
> +                   Factor to multiply fan speed with. (default:
> +                   autodetect)
> +
> +* fan_max:uint
> +                   Maximum configurable fan speed. (default:
> +                   autodetect)
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 230ad59b462b..092435ad6bb8 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -44,6 +44,7 @@ Hardware Monitoring Kernel Drivers
>     coretemp
>     da9052
>     da9055
> +   dell-smm-hwmon
>     dme1737
>     ds1621
>     ds620

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--yyevasuc2teap2t2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdLbPQAKCRCL8Mk9A+RD
UsgAAJsHx55mf+O6btohz703ULTVeA1POgCgu4LtwcGVBjTQkgYro1jS9Vuxuz0=
=wWlI
-----END PGP SIGNATURE-----

--yyevasuc2teap2t2--
