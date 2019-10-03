Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B43C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B625020830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlUxtkoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbfJCRdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:33:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56582 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730823AbfJCRcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570123973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tyc8Mk8DJcaipG9TZO3g0pE+sD22mtd1Wvj7+XFS8Vs=;
        b=FlUxtkozk3qE3W5q3py1FalZj1ZbbYvZguu6n0GvwV/RnYXRP5/GospIXMgZwslApnzkeR
        Ar2ZoLPwOA+YSOYK7t/88TSR4f9emWGmqLlzOFThhSE3InYcvFjHY3TuZdJGyVvA1QtHfo
        eSW2ejI2qgt/EgDWzSBERNyvrvm4AB4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-68CYGk9-OmG4rKzj9u8jpg-1; Thu, 03 Oct 2019 13:32:50 -0400
Received: by mail-wm1-f71.google.com with SMTP id o8so1416288wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ef7N0ePuxn3Ta7g1ODhoz4GZ5kwOIoAGHMitlSYrcw=;
        b=BhBQ7L4HtoBaDbGyd/3Mdk+2qKzSVrFSP1EMSb8qF6GsK7498Z4iAVR6J0GB1EG3c3
         b3V85lt2fgNNupIWZpTnJpRTVb2Ck3jXl+fZxzJWS4qL35qz6mxcUvNX8431wjrB54OF
         g7vop/yVCtY4nbpTndWcPac7hySbnCfqbY76XzqMUmgo9KB4yGGm0cG7n8gwgURfTc3J
         Yt93jEkRQmvbJL2LsuAU2ljUkBibkHO3jAy9RftzNkZBIRIYmONppc69cVxKA9hgYreu
         qqv/HWzE4bZWSTo1hTVO1yv1YwHeluZJcfEo1U6TDuM2w9BGXj2eRqG1jzGRo8sxO6yW
         QxVQ==
X-Gm-Message-State: APjAAAW633+w54eQqS7W3dPEKK9/YgByOS8JdVsNg/sA+JycpxCMVTCK
        QDDYP3Ik8184vxo/ncT0tm2Z9hTzTDHf0r03qDEupakIAA13UXOQW6qyFY7Z7VTpvLcRDLYGqmX
        8LtWE6vafLj2sHsgBjreX6X5k
X-Received: by 2002:a7b:c156:: with SMTP id z22mr8133040wmi.142.1570123969574;
        Thu, 03 Oct 2019 10:32:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+93T7QZmfuz6juSrvUo+0tO+JKd49hF/xJ8735MhhS21vMaPI2qHMRdInVKHuyZof2sGApg==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr8133017wmi.142.1570123969238;
        Thu, 03 Oct 2019 10:32:49 -0700 (PDT)
Received: from localhost (pD95EF0F7.dip0.t-ipconnect.de. [217.94.240.247])
        by smtp.gmail.com with ESMTPSA id 90sm4908448wrr.1.2019.10.03.10.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 10:32:48 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Christian Kellner <christian@kellner.me>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH] thunderbolt: Add 'generation' attribute for devices
Date:   Thu,  3 Oct 2019 19:32:40 +0200
Message-Id: <20191003173242.80938-1-ckellner@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: 68CYGk9-OmG4rKzj9u8jpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Kellner <christian@kellner.me>

The Thunderbolt standard went through several major iterations, here
called generation. USB4, which will be based on Thunderbolt, will be
generation 4. Let userspace know the generation of the controller in
the devices in order to distinguish between Thunderbolt and USB4, so
it can be shown in various user interfaces.

Signed-off-by: Christian Kellner <christian@kellner.me>
---
 Documentation/ABI/testing/sysfs-bus-thunderbolt |  8 ++++++++
 drivers/thunderbolt/switch.c                    | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentatio=
n/ABI/testing/sysfs-bus-thunderbolt
index b21fba14689b..630e51344f1c 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -80,6 +80,14 @@ Contact:=09thunderbolt-software@lists.01.org
 Description:=09This attribute contains 1 if Thunderbolt device was already
 =09=09authorized on boot and 0 otherwise.
=20
+What: /sys/bus/thunderbolt/devices/.../generation
+Date:=09=09Aug 2019
+KernelVersion:=095.5
+Contact:=09Christian Kellner <christian@kellner.me>
+Description:=09This attribute contains the generation of the Thunderbolt
+=09=09controller associated with the device. It will contain 4
+=09=09for USB4.
+
 What: /sys/bus/thunderbolt/devices/.../key
 Date:=09=09Sep 2017
 KernelVersion:=094.13
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 410bf1bceeee..ac9fa2740800 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1120,6 +1120,15 @@ device_name_show(struct device *dev, struct device_a=
ttribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(device_name);
=20
+static ssize_t
+generation_show(struct device *dev, struct device_attribute *attr, char *b=
uf)
+{
+=09struct tb_switch *sw =3D tb_to_switch(dev);
+
+=09return sprintf(buf, "%u\n", sw->generation);
+}
+static DEVICE_ATTR_RO(generation);
+
 static ssize_t key_show(struct device *dev, struct device_attribute *attr,
 =09=09=09char *buf)
 {
@@ -1325,6 +1334,7 @@ static struct attribute *switch_attrs[] =3D {
 =09&dev_attr_boot.attr,
 =09&dev_attr_device.attr,
 =09&dev_attr_device_name.attr,
+=09&dev_attr_generation.attr,
 =09&dev_attr_key.attr,
 =09&dev_attr_nvm_authenticate.attr,
 =09&dev_attr_nvm_version.attr,
--=20
2.23.0

