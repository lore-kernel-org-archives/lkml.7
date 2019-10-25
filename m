Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C69CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9919206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCGwtzIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfJYTbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:31:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41744 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727143AbfJYTbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572031871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=S/xdyRsNHfBtMV1DseEdmIGdbbGR2o5yNrdis2nPB90=;
        b=GCGwtzIoxjzM6lnkp+VC4SKvWbmXBIPc1e5SvJMM48oaWR1LZmyitjZ2RItJ/2i7A/B/RR
        +6/Q1DTR7dt43inkEnyfigvp5o/dqfq9dxGKyhD4OHccq438O5kPRyZgE7EUSd8AXwlmFI
        0EljLm+kuKZINroHIVjnSYYsGgHaBwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-u90dXLTROhOmVtUgkgnK3A-1; Fri, 25 Oct 2019 15:31:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C715E6;
        Fri, 25 Oct 2019 19:31:05 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-117-192.phx2.redhat.com [10.3.117.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0E2160852;
        Fri, 25 Oct 2019 19:31:04 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: [PATCH v2] tpm: Add major_version sysfs file
Date:   Fri, 25 Oct 2019 12:31:03 -0700
Message-Id: <20191025193103.30226-1-jsnitsel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: u90dXLTROhOmVtUgkgnK3A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Easily determining what TCG version a tpm device implements
has been a pain point for userspace for a long time, so
add a sysfs file to report the TCG version of a tpm device.

Also add an entry to Documentation/ABI/stable/sysfs-class-tpm
describing the new file.

Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
v2: - Fix TCG usage in commit message.
    - Add entry to sysfs-class-tpm in Documentation/ABI/stable

 Documentation/ABI/stable/sysfs-class-tpm | 11 ++++++++
 drivers/char/tpm/tpm-sysfs.c             | 34 +++++++++++++++++++-----
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI/s=
table/sysfs-class-tpm
index c0e23830f56a..c6bd02bafafd 100644
--- a/Documentation/ABI/stable/sysfs-class-tpm
+++ b/Documentation/ABI/stable/sysfs-class-tpm
@@ -183,3 +183,14 @@ Description:=09The "timeouts" property shows the 4 ven=
dor-specific values
 =09=09The four timeout values are shown in usecs, with a trailing
 =09=09"[original]" or "[adjusted]" depending on whether the values
 =09=09were scaled by the driver to be reported in usec from msecs.
+
+What:=09=09/sys/class/tpm/tpmX/major_version
+Date:=09=09October 2019
+KernelVersion:=095.5
+Contact:=09linux-integrity@vger.kernel.org
+Description:=09The "major_version" property shows the TCG spec version
+=09=09implemented by the TPM device.
+
+=09=09Example output:
+
+=09=092.0
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index edfa89160010..9372c2d6f0b3 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,7 +309,17 @@ static ssize_t timeouts_show(struct device *dev, struc=
t device_attribute *attr,
 }
 static DEVICE_ATTR_RO(timeouts);
=20
-static struct attribute *tpm_dev_attrs[] =3D {
+static ssize_t major_version_show(struct device *dev,
+=09=09=09=09  struct device_attribute *attr, char *buf)
+{
+=09struct tpm_chip *chip =3D to_tpm_chip(dev);
+
+=09return sprintf(buf, "%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
+=09=09       ? "2.0" : "1.2");
+}
+static DEVICE_ATTR_RO(major_version);
+
+static struct attribute *tpm12_dev_attrs[] =3D {
 =09&dev_attr_pubek.attr,
 =09&dev_attr_pcrs.attr,
 =09&dev_attr_enabled.attr,
@@ -320,18 +330,28 @@ static struct attribute *tpm_dev_attrs[] =3D {
 =09&dev_attr_cancel.attr,
 =09&dev_attr_durations.attr,
 =09&dev_attr_timeouts.attr,
+=09&dev_attr_major_version.attr,
 =09NULL,
 };
=20
-static const struct attribute_group tpm_dev_group =3D {
-=09.attrs =3D tpm_dev_attrs,
+static struct attribute *tpm20_dev_attrs[] =3D {
+=09&dev_attr_major_version.attr,
+=09NULL
+};
+
+static const struct attribute_group tpm12_dev_group =3D {
+=09.attrs =3D tpm12_dev_attrs,
+};
+
+static const struct attribute_group tpm20_dev_group =3D {
+=09.attrs =3D tpm20_dev_attrs,
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
+=09=09chip->groups[chip->groups_cnt++] =3D &tpm20_dev_group;
+=09else
+=09=09chip->groups[chip->groups_cnt++] =3D &tpm12_dev_group;
 }
--=20
2.23.0

