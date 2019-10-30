Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75713CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467FC20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6VZ7BA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfJ3W6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:58:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46426 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726837AbfJ3W6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572476330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nzz7sPab5APnqYMyjw2jhY5UVs1dF5WZgMMoICv2W90=;
        b=L6VZ7BA2qzRnyujtxGjQFhum+++tXW5zakMxS1S6wl0IkIlcvUNrzPl2Kz+B8xdu6f3zFB
        6MoreKcLdNm6RsniFGK104hoPCZunukcgy32IxKFepnO7ekCpoAkQgDM+m+5bNCYCnMZJN
        Zbm0kzF5ZzpKkArKsri7yjtNa3kD6s8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-yma7WaZvPoWPAOsDcfcQ0A-1; Wed, 30 Oct 2019 18:58:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 007471005500;
        Wed, 30 Oct 2019 22:58:45 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-32.phx2.redhat.com [10.3.116.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9791C5D6D6;
        Wed, 30 Oct 2019 22:58:44 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: [PATCH v4] tpm: Add tpm_version_major sysfs file
Date:   Wed, 30 Oct 2019 15:58:43 -0700
Message-Id: <20191030225843.23366-1-jsnitsel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: yma7WaZvPoWPAOsDcfcQ0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Easily determining what TCG version a tpm device implements
has been a pain point for userspace for a long time, so
add a sysfs file to report the TCG major version of a tpm device.

Also add an entry to Documentation/ABI/stable/sysfs-class-tpm
describing the new file.

Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
v4: - Change file name to tpm_version_major
    - Actually display just the major version.
    - change structs to tpm1_* & tpm2_*
      instead of tpm12_* tpm20_*.
v3: - Change file name to version_major.
v2: - Fix TCG usage in commit message.
    - Add entry to sysfs-class-tpm in Documentation/ABI/stable

 Documentation/ABI/stable/sysfs-class-tpm | 11 ++++++++
 drivers/char/tpm/tpm-sysfs.c             | 34 +++++++++++++++++++-----
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI/s=
table/sysfs-class-tpm
index c0e23830f56a..5468fedc493c 100644
--- a/Documentation/ABI/stable/sysfs-class-tpm
+++ b/Documentation/ABI/stable/sysfs-class-tpm
@@ -183,3 +183,14 @@ Description:=09The "timeouts" property shows the 4 ven=
dor-specific values
 =09=09The four timeout values are shown in usecs, with a trailing
 =09=09"[original]" or "[adjusted]" depending on whether the values
 =09=09were scaled by the driver to be reported in usec from msecs.
+
+What:=09=09/sys/class/tpm/tpmX/tpm_version_major
+Date:=09=09October 2019
+KernelVersion:=095.5
+Contact:=09linux-integrity@vger.kernel.org
+Description:=09The "tpm_version_major" property shows the TCG spec major v=
ersion
+=09=09implemented by the TPM device.
+
+=09=09Example output:
+
+=09=092
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index edfa89160010..12da71e72488 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,7 +309,17 @@ static ssize_t timeouts_show(struct device *dev, struc=
t device_attribute *attr,
 }
 static DEVICE_ATTR_RO(timeouts);
=20
-static struct attribute *tpm_dev_attrs[] =3D {
+static ssize_t tpm_version_major_show(struct device *dev,
+=09=09=09=09  struct device_attribute *attr, char *buf)
+{
+=09struct tpm_chip *chip =3D to_tpm_chip(dev);
+
+=09return sprintf(buf, "%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
+=09=09       ? "2" : "1");
+}
+static DEVICE_ATTR_RO(tpm_version_major);
+
+static struct attribute *tpm1_dev_attrs[] =3D {
 =09&dev_attr_pubek.attr,
 =09&dev_attr_pcrs.attr,
 =09&dev_attr_enabled.attr,
@@ -320,18 +330,28 @@ static struct attribute *tpm_dev_attrs[] =3D {
 =09&dev_attr_cancel.attr,
 =09&dev_attr_durations.attr,
 =09&dev_attr_timeouts.attr,
+=09&dev_attr_tpm_version_major.attr,
 =09NULL,
 };
=20
-static const struct attribute_group tpm_dev_group =3D {
-=09.attrs =3D tpm_dev_attrs,
+static struct attribute *tpm2_dev_attrs[] =3D {
+=09&dev_attr_tpm_version_major.attr,
+=09NULL
+};
+
+static const struct attribute_group tpm1_dev_group =3D {
+=09.attrs =3D tpm1_dev_attrs,
+};
+
+static const struct attribute_group tpm2_dev_group =3D {
+=09.attrs =3D tpm2_dev_attrs,
 };
=20
 void tpm_sysfs_add_device(struct tpm_chip *chip)
 {
-=09if (chip->flags & TPM_CHIP_FLAG_TPM2)
-=09=09return;
-
 =09WARN_ON(chip->groups_cnt !=3D 0);
-=09chip->groups[chip->groups_cnt++] =3D &tpm_dev_group;
+=09if (chip->flags & TPM_CHIP_FLAG_TPM2)
+=09=09chip->groups[chip->groups_cnt++] =3D &tpm2_dev_group;
+=09else
+=09=09chip->groups[chip->groups_cnt++] =3D &tpm1_dev_group;
 }
--=20
2.23.0

