Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3455C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7823C20715
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CA/aumke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfKSJSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:18:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38179 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725784AbfKSJSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574155121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F5gVroGd0jCB/6b+aqlr6VxWgFq7818TIln7vtMs1d8=;
        b=CA/aumkeCKDWztvYu5FiQ8xWaZaflcFqDG4ddWvVS2zeoWCi8Wl/nN3OmKQ7u917M20bf6
        BBA6NsgTKFFLIHgiFF24++WXKHOl5QFOjp98LMBPEW3dJzHhbmWB8s85yUAhag+87vZP8P
        nQK7znq1342tz4bNBmdvKiRmg0TFl7I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-C2SRRnKSOvi0w8dCfL_9cw-1; Tue, 19 Nov 2019 04:18:40 -0500
Received: by mail-wr1-f71.google.com with SMTP id z10so890913wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 01:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I0ochwV95DWb+Vb/kQFhi7I2FhfRb9PfG9M5Z+gcjYQ=;
        b=W+iqxis/5QJDEviEXOC0i74j5bpNBSmOyEoogheMPITSj6z+LUcO5r32R7RaltpRSg
         6c5H1jlf/rsmGamcPEkTXb1mNxlVya5O6oFw4YVdHB3+XYrcOS8RTyenfTnVSzHZaGcW
         Tb9MpeMdNKlpzgOmfjg4XEV/ApJcCJdshllFhpei4XoA5iWfv9JwFmz2AdZNPzI+8q5d
         9Rsf9XXHg6mmV3OlvyyNvZiDfhqUw08nR/mQMpJRJ+jQNsboMbuTDeVUIcaGvtQEr3g5
         Fezl3EhncBzn7xO/BzV/Ff0eHN8VdbduJ4kK5vmh+jY0gkGqu+E6Yc9H/yTIx944F+W3
         /+mg==
X-Gm-Message-State: APjAAAWjh9r3aN5auDVxzg8EVP7XChUf3WMp3tAPdXQQVAPsKZwWrvhJ
        jfuXpb+JJLe+DdLe/5E5x/1vctjwj/J+XZU+QbZaEQC9iqlRPVDz3qCqlDqb/Y+Ns7cdXQkh/fy
        RrxiORRuQWds6uyrqCDBYyiPx
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr4388635wmc.143.1574155118747;
        Tue, 19 Nov 2019 01:18:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/3ENyoIZuytZnCqKEgxHHFsE1tK9q5FPF1B1/0eBPoNkV5H1Fk3MNUOM61TMOl+cJiT5QLg==
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr4388590wmc.143.1574155118380;
        Tue, 19 Nov 2019 01:18:38 -0800 (PST)
Received: from minerva.redhat.com ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id f140sm2427588wme.21.2019.11.19.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 01:18:37 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH] efi: Only print errors about failing to get certs if EFI vars are found
Date:   Tue, 19 Nov 2019 10:18:21 +0100
Message-Id: <20191119091822.276265-1-javierm@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: C2SRRnKSOvi0w8dCfL_9cw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_LOAD_UEFI_KEYS is enabled, the kernel attempts to load the certs
from the db, dbx and MokListRT EFI variables into the appropriate keyrings.

But it just assumes that the variables will be present and prints an error
if the certs can't be loaded, even when is possible that the variables may
not exist. For example the MokListRT variable will only be present if shim
is used.

So only print an error message about failing to get the certs list from an
EFI variable if this is found. Otherwise these printed errors just pollute
the kernel ring buffer with confusing messages like the following:

[    5.427251] Couldn't get size: 0x800000000000000e
[    5.427261] MODSIGN: Couldn't get UEFI db list
[    5.428012] Couldn't get size: 0x800000000000000e
[    5.428023] Couldn't get UEFI MokListRT

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

 security/integrity/platform_certs/load_uefi.c | 31 ++++++++++---------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integ=
rity/platform_certs/load_uefi.c
index 81b19c52832..336fa528359 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -39,16 +39,18 @@ static __init bool uefi_check_ignore_db(void)
  * Get a certificate list blob from the named EFI variable.
  */
 static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
-=09=09=09=09  unsigned long *size)
+=09=09=09=09  unsigned long *size, efi_status_t *status)
 {
-=09efi_status_t status;
 =09unsigned long lsize =3D 4;
 =09unsigned long tmpdb[4];
 =09void *db;
=20
-=09status =3D efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
-=09if (status !=3D EFI_BUFFER_TOO_SMALL) {
-=09=09pr_err("Couldn't get size: 0x%lx\n", status);
+=09*status =3D efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
+=09if (*status =3D=3D EFI_NOT_FOUND)
+=09=09return NULL;
+
+=09if (*status !=3D EFI_BUFFER_TOO_SMALL) {
+=09=09pr_err("Couldn't get size: 0x%lx\n", *status);
 =09=09return NULL;
 =09}
=20
@@ -56,10 +58,10 @@ static __init void *get_cert_list(efi_char16_t *name, e=
fi_guid_t *guid,
 =09if (!db)
 =09=09return NULL;
=20
-=09status =3D efi.get_variable(name, guid, NULL, &lsize, db);
-=09if (status !=3D EFI_SUCCESS) {
+=09*status =3D efi.get_variable(name, guid, NULL, &lsize, db);
+=09if (*status !=3D EFI_SUCCESS) {
 =09=09kfree(db);
-=09=09pr_err("Error reading db var: 0x%lx\n", status);
+=09=09pr_err("Error reading db var: 0x%lx\n", *status);
 =09=09return NULL;
 =09}
=20
@@ -144,6 +146,7 @@ static int __init load_uefi_certs(void)
 =09efi_guid_t mok_var =3D EFI_SHIM_LOCK_GUID;
 =09void *db =3D NULL, *dbx =3D NULL, *mok =3D NULL;
 =09unsigned long dbsize =3D 0, dbxsize =3D 0, moksize =3D 0;
+=09efi_status_t status;
 =09int rc =3D 0;
=20
 =09if (!efi.get_variable)
@@ -153,8 +156,8 @@ static int __init load_uefi_certs(void)
 =09 * an error if we can't get them.
 =09 */
 =09if (!uefi_check_ignore_db()) {
-=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize);
-=09=09if (!db) {
+=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize, &status);
+=09=09if (!db && status !=3D EFI_NOT_FOUND) {
 =09=09=09pr_err("MODSIGN: Couldn't get UEFI db list\n");
 =09=09} else {
 =09=09=09rc =3D parse_efi_signature_list("UEFI:db",
@@ -166,8 +169,8 @@ static int __init load_uefi_certs(void)
 =09=09}
 =09}
=20
-=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize);
-=09if (!mok) {
+=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
+=09if (!mok && status !=3D EFI_NOT_FOUND) {
 =09=09pr_info("Couldn't get UEFI MokListRT\n");
 =09} else {
 =09=09rc =3D parse_efi_signature_list("UEFI:MokListRT",
@@ -177,8 +180,8 @@ static int __init load_uefi_certs(void)
 =09=09kfree(mok);
 =09}
=20
-=09dbx =3D get_cert_list(L"dbx", &secure_var, &dbxsize);
-=09if (!dbx) {
+=09dbx =3D get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
+=09if (!dbx && status !=3D EFI_NOT_FOUND) {
 =09=09pr_info("Couldn't get UEFI dbx list\n");
 =09} else {
 =09=09rc =3D parse_efi_signature_list("UEFI:dbx",
--=20
2.23.0

