Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45A8CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C81B20684
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nt7t9+IE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437722AbfJYO24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:28:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47393 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409359AbfJYO2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572013734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zyapHGu7/Oo0qkTwxuNUgfmvbp8XI8/6ksqWtHCwxRA=;
        b=Nt7t9+IEakoCiIqlAPm0fhLzSVlF8tBA8qkW/cPqDgjyJ+sL8XHnba3qyQIOEmLyCu3sk0
        Ym7EXIKPVxuYBtuz2qB0iDBH4q2tExewHKURVbQj/TkHj4m3DCy3AwINBSjipgD4Z6x4GY
        eH3wA1dH4ryHDSame2iQXrmzftiHTEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-trDOS9OGPUCDUZ3yGX7yiw-1; Fri, 25 Oct 2019 10:28:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B27621800E01;
        Fri, 25 Oct 2019 14:28:49 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-117-192.phx2.redhat.com [10.3.117.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6409B5D9CA;
        Fri, 25 Oct 2019 14:28:49 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: Add major_version sysfs file
Date:   Fri, 25 Oct 2019 07:28:47 -0700
Message-Id: <20191025142847.14931-1-jsnitsel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: trDOS9OGPUCDUZ3yGX7yiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Easily determining what TCG version a tpm device implements
has been a pain point for userspace for a long time, so
add a sysfs file to report the tcg version of a tpm device.

Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/char/tpm/tpm-sysfs.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

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

