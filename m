Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8356BC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526C9208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bRrTSGWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfGADZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 23:25:02 -0400
Received: from ozlabs.org ([203.11.71.1]:38307 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfGADZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 23:25:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45cXmp4vsZz9s3Z;
        Mon,  1 Jul 2019 13:24:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561951498;
        bh=/kMAiQZs0gnpj1DnNcPae61KsnoPRPeOYgjHpvjXupM=;
        h=Date:From:To:Cc:Subject:From;
        b=bRrTSGWonN3kpdBRBwBqqCDX4Ll8+WM2X34cjYtePXfAIZBmnyU/Jn2m/IIYJg1s5
         VbZNzKgCZZ1afVqTJKJWmxRLfyxDqB4+Apj6WHkBzA8xrx8W+bFVMBlPfDPPnKXusg
         VJbDThxV7DK/qIf3sNtq6wKHYKsLp8WtnAHmOdmp7lKlU9gFOPXLaeLtgqz6gtgZw5
         ecrrNkFh7aqEszsVszhqMzw+g/fjQalu1GPOqxoHXjit51aHFV6dXIpQnb83KLkqZu
         Ltko10V7EHFLFhlghIykSxxbLRRVZu8INeGkeIus95gI6EBVsnGXE7QMGL1ebc5vhL
         lK4+Es+NY3d9w==
Date:   Mon, 1 Jul 2019 13:24:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: linux-next: manual merge of the pm tree with the pci tree
Message-ID: <20190701132457.3512acdd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jw.saVJMwjH/513wz=4yNAZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jw.saVJMwjH/513wz=4yNAZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pm tree got a conflict in:

  Documentation/power/pm_qos_interface.rst

between commits:

  151f4e2bdc7a ("docs: power: convert docs to ReST and rename to *.rst")
  562fe2ef1a21 ("PM / QOS: Pass request type to dev_pm_qos_read_value()")

from the pci tree and commit:

  0c4899702720 ("PM / QOS: Pass request type to dev_pm_qos_{add|remove}_not=
ifier()")

from the pm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/power/pm_qos_interface.rst
index 945fc6d760c9,cfcb1df39799..000000000000
--- a/Documentation/power/pm_qos_interface.rst
+++ b/Documentation/power/pm_qos_interface.rst
@@@ -113,76 -107,72 +113,78 @@@ the aggregated value does not require a
  From kernel mode the use of this interface is the following:
 =20
  int dev_pm_qos_add_request(device, handle, type, value):
 -Will insert an element into the list for that identified device with the
 -target value.  Upon change to this list the new target is recomputed and =
any
 -registered notifiers are called only if the target value is now different.
 -Clients of dev_pm_qos need to save the handle for future use in other
 -dev_pm_qos API functions.
 +  Will insert an element into the list for that identified device with the
 +  target value.  Upon change to this list the new target is recomputed an=
d any
 +  registered notifiers are called only if the target value is now differe=
nt.
 +  Clients of dev_pm_qos need to save the handle for future use in other
 +  dev_pm_qos API functions.
 =20
  int dev_pm_qos_update_request(handle, new_value):
 -Will update the list element pointed to by the handle with the new target=
 value
 -and recompute the new aggregated target, calling the notification trees i=
f the
 -target is changed.
 +  Will update the list element pointed to by the handle with the new targ=
et
 +  value and recompute the new aggregated target, calling the notification
 +  trees if the target is changed.
 =20
  int dev_pm_qos_remove_request(handle):
 -Will remove the element.  After removal it will update the aggregate targ=
et and
 -call the notification trees if the target was changed as a result of remo=
ving
 -the request.
 +  Will remove the element.  After removal it will update the aggregate ta=
rget
 +  and call the notification trees if the target was changed as a result of
 +  removing the request.
 =20
- s32 dev_pm_qos_read_value(device):
+ s32 dev_pm_qos_read_value(device, type):
 -Returns the aggregated value for a given device's constraints list.
 +  Returns the aggregated value for a given device's constraints list.
 =20
  enum pm_qos_flags_status dev_pm_qos_flags(device, mask)
 -Check PM QoS flags of the given device against the given mask of flags.
 -The meaning of the return values is as follows:
 -	PM_QOS_FLAGS_ALL: All flags from the mask are set
 -	PM_QOS_FLAGS_SOME: Some flags from the mask are set
 -	PM_QOS_FLAGS_NONE: No flags from the mask are set
 -	PM_QOS_FLAGS_UNDEFINED: The device's PM QoS structure has not been
 -			initialized or the list of requests is empty.
 +  Check PM QoS flags of the given device against the given mask of flags.
 +  The meaning of the return values is as follows:
 +
 +	PM_QOS_FLAGS_ALL:
 +		All flags from the mask are set
 +	PM_QOS_FLAGS_SOME:
 +		Some flags from the mask are set
 +	PM_QOS_FLAGS_NONE:
 +		No flags from the mask are set
 +	PM_QOS_FLAGS_UNDEFINED:
 +		The device's PM QoS structure has not been initialized
 +		or the list of requests is empty.
 =20
  int dev_pm_qos_add_ancestor_request(dev, handle, type, value)
 -Add a PM QoS request for the first direct ancestor of the given device wh=
ose
 -power.ignore_children flag is unset (for DEV_PM_QOS_RESUME_LATENCY reques=
ts)
 -or whose power.set_latency_tolerance callback pointer is not NULL (for
 -DEV_PM_QOS_LATENCY_TOLERANCE requests).
 +  Add a PM QoS request for the first direct ancestor of the given device =
whose
 +  power.ignore_children flag is unset (for DEV_PM_QOS_RESUME_LATENCY requ=
ests)
 +  or whose power.set_latency_tolerance callback pointer is not NULL (for
 +  DEV_PM_QOS_LATENCY_TOLERANCE requests).
 =20
  int dev_pm_qos_expose_latency_limit(device, value)
 -Add a request to the device's PM QoS list of resume latency constraints a=
nd
 -create a sysfs attribute pm_qos_resume_latency_us under the device's power
 -directory allowing user space to manipulate that request.
 +  Add a request to the device's PM QoS list of resume latency constraints=
 and
 +  create a sysfs attribute pm_qos_resume_latency_us under the device's po=
wer
 +  directory allowing user space to manipulate that request.
 =20
  void dev_pm_qos_hide_latency_limit(device)
 -Drop the request added by dev_pm_qos_expose_latency_limit() from the devi=
ce's
 -PM QoS list of resume latency constraints and remove sysfs attribute
 -pm_qos_resume_latency_us from the device's power directory.
 +  Drop the request added by dev_pm_qos_expose_latency_limit() from the de=
vice's
 +  PM QoS list of resume latency constraints and remove sysfs attribute
 +  pm_qos_resume_latency_us from the device's power directory.
 =20
  int dev_pm_qos_expose_flags(device, value)
 -Add a request to the device's PM QoS list of flags and create sysfs attri=
bute
 -pm_qos_no_power_off under the device's power directory allowing user spac=
e to
 -change the value of the PM_QOS_FLAG_NO_POWER_OFF flag.
 +  Add a request to the device's PM QoS list of flags and create sysfs att=
ribute
 +  pm_qos_no_power_off under the device's power directory allowing user sp=
ace to
 +  change the value of the PM_QOS_FLAG_NO_POWER_OFF flag.
 =20
  void dev_pm_qos_hide_flags(device)
 -Drop the request added by dev_pm_qos_expose_flags() from the device's PM =
QoS list
 -of flags and remove sysfs attribute pm_qos_no_power_off from the device's=
 power
 -directory.
 +  Drop the request added by dev_pm_qos_expose_flags() from the device's P=
M QoS list
 +  of flags and remove sysfs attribute pm_qos_no_power_off from the device=
's power
 +  directory.
 =20
  Notification mechanisms:
 +
  The per-device PM QoS framework has a per-device notification tree.
 =20
- int dev_pm_qos_add_notifier(device, notifier):
-   Adds a notification callback function for the device.
+ int dev_pm_qos_add_notifier(device, notifier, type):
 -Adds a notification callback function for the device for a particular req=
uest
 -type.
++  Adds a notification callback function for the device for a particular r=
equest
++  type.
+=20
 -The callback is called when the aggregated value of the device constraint=
s list
 -is changed.
 +  The callback is called when the aggregated value of the device constrai=
nts list
-   is changed (for resume latency device PM QoS only).
++  is changed.
 =20
- int dev_pm_qos_remove_notifier(device, notifier):
+ int dev_pm_qos_remove_notifier(device, notifier, type):
 -Removes the notification callback function for the device.
 +  Removes the notification callback function for the device.
 =20
 =20
  Active state latency tolerance

--Sig_/jw.saVJMwjH/513wz=4yNAZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ZfQkACgkQAVBC80lX
0GzHXgf/eRMvJHVTZPoMOzBllCm88iSJnQM1H/KWd9T2DeUiNAdCWz76lAve7QnL
uzhb2WddUKTT92hGsnnhTf8iFf1UToLmu6jWm4T4BUJ42By5RgurUqOTD9x2ZHHM
52mQv47tj7ibCCIlC9KrPMmWrGUOSD9O4HmUrjxDpZzLVzpOgh1saTUsLQLOfici
p5zyfY6cmSG5ZEXu99INV7Py5UOXKDL5WGOs8r4h+rWyIQhV+G6rVRkHVynKfdjW
sdP90hvlI8saJOrPRHBJKNWwV8lKxqu6OO2Yi4xh7RpexMBHCCIgXsDTyTaVpygp
EyvT1d2qQAUZMl8ZkerHKosDpDwVJw==
=MWSx
-----END PGP SIGNATURE-----

--Sig_/jw.saVJMwjH/513wz=4yNAZ--
