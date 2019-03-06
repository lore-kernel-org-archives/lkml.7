Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B2CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0DB20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/MjTXb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfCGAAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:07 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:44158 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfCGAAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:03 -0500
Received: by mail-qt1-f202.google.com with SMTP id c9so13386596qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RLZYCznt91X7Gql2FLJuA+D6Xq8z59q436/ddkparrE=;
        b=i/MjTXb7CbOG6UdkkS0vRNZvfV6iqT+SJUy26kVbxvGCwjfn8jRCtI1zQO9vj5H2ak
         apfgI4/baSkKebqMBSvCMvYYCd4lYbo5ztim2Tyika6/fTfhgxfiyzwCe6U8SXuxUH/A
         QMXQD8oXCYd6+d5dhpHO9MT8ekx8Nhcac8L3GeVKmleZ3xJNOFmMJqTs6o1aMOa/SvMi
         gfGhsbLGZLzEnc36jFQIkNfeaKcX77AgJBYVu2/DvzZJ1oXI4NCpFzcTHoMVU38SfSl7
         DH+AH9U/Yw0/Mu1nSxhw0CQM0XKEcmhK6zNTjbEdD41qts+TJNBsuwJNo9oPQByKvGkt
         DkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RLZYCznt91X7Gql2FLJuA+D6Xq8z59q436/ddkparrE=;
        b=e/fTOXdpDxzbG+171Z6UL2Y2q76b5+7Dk4jU5PRbzCH5qJ9BgCgHcChGvotQtwhREi
         s4YMsaSMgy6TUzgjKrrGiRsu3PYAc+SyEP2K84VGWCYbopr2Ve+CO6EjYQr0JAWWSpGa
         XYUoLNTBXKpUb0mUmg7WlxWYtUG79HfdCEAhPhTSx5/fcGJ6a3FrHDHqrR1rXCERYDqq
         Sf84UnJEFicGLOfSxAhkfGaI/d9yiaeSm9pT/QbCHsGHmChcO/15QpIaeXK2azfpRZpJ
         3V/q/Cxf6JVHc0UCfQy8WxF9X0QpsJHeXR+4FGUGcD0Yn9i8PZWl5yE49jydU3Ws28CK
         VgIA==
X-Gm-Message-State: APjAAAXOl7I2aG2ESOjUr7iDYR1ko1NhmPJkKfHixJ7rBq2Ze6TraKlW
        KNZ1nQY6BBNVMYybZk4rmz/HVWdJwPkUS70Vc0pdWQ==
X-Google-Smtp-Source: APXvYqyg65IJHTLLH/dejwTsjoNanUPirYo+pqDWCoJN7KCkY2ggEVBCzFT/3DLvioXGAP9kW6hrdz8OII58UGrorWamGQ==
X-Received: by 2002:a0c:b91c:: with SMTP id u28mr5950718qvf.45.1551916802349;
 Wed, 06 Mar 2019 16:00:02 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:00 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 14/27] ACPI: Limit access to custom_method when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

custom_method effectively allows arbitrary access to system memory, making
it possible for an attacker to circumvent restrictions on module loading.
Disable it if the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-acpi@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/acpi/custom_method.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 4451877f83b6..ac8a90dc7096 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -29,6 +29,9 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	struct acpi_table_header table;
 	acpi_status status;
 
+	if (kernel_is_locked_down("ACPI custom methods"))
+		return -EPERM;
+
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
 		if (count <= sizeof(struct acpi_table_header))
-- 
2.21.0.352.gf09ad66450-goog

