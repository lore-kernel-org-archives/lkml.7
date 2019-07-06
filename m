Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5688C5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 03:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9B921670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 03:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfGFDo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 23:44:28 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54442 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbfGFDo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 23:44:28 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x663iQXd024331
        for <linux-kernel@vger.kernel.org>; Fri, 5 Jul 2019 23:44:26 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x663iLI2005371
        for <linux-kernel@vger.kernel.org>; Fri, 5 Jul 2019 23:44:26 -0400
Received: by mail-qt1-f199.google.com with SMTP id k31so10969814qte.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 20:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=8fXsS/qCFMlK3IfJe0o+L9zW5hwu1Njz/pHhxSynS10=;
        b=MY21nqgn0vlsWC8hxTJLX9FdqB/oT6ISboip0BZHLWc6bKZTxdJ8np9O9fRclxkEF5
         OaKe8YRlFNPNUxVmaeN5g+v05PaOtnp+tUmmQW5Tf4xi8I5ERASH3Zshk/rFnWC1Lu0+
         xc8TpTNVM+LrSAAV3aoYMmijVnTxYug9P1D9HZQ2WzZ7ai5KLUa9ZYF/PrkPlplm9a+I
         u+gpY77dq+MN3QeVKl50X+Wz4J2EsraIyIqrfP2QpA22gI2t+EgEXTivNMH2OyhMtBJ3
         /mJzTbHOXMuneJIVy8T3B2zgN88PMfJaIPuyDcmGvUEBm1AGge3O4Gx9f/pdgE/q7Wcc
         OP6Q==
X-Gm-Message-State: APjAAAX25dt/WWSngbBQbosqLE/0KefCILOfAw3X6rSJYu2Dey3LL4eo
        NNcrkjq2X6ZbJS8vpkxyYrDHd46J7UjE1A9UOHEbjFX5hXZrXTfNaERwD2NX9DR3PZwrgKrtcVD
        4wunPpmDJfPdinosCTQ6O4RLHmC/a6bWr4BU=
X-Received: by 2002:a37:47d1:: with SMTP id u200mr5455030qka.21.1562384661387;
        Fri, 05 Jul 2019 20:44:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx77CAOwb57kHTbH+rwRZca8Ng8B9IqTqMLwAaJTBXpsHS9IRbrpNxlEUt0uLu50+3hRR3OtQ==
X-Received: by 2002:a37:47d1:: with SMTP id u200mr5455020qka.21.1562384661140;
        Fri, 05 Jul 2019 20:44:21 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::7ca])
        by smtp.gmail.com with ESMTPSA id w9sm2251091qts.25.2019.07.05.20.44.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 20:44:19 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: next-20190705 - problems generating certs/x509_certificate_list
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1562384658_2389P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Jul 2019 23:44:18 -0400
Message-ID: <27671.1562384658@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1562384658_2389P
Content-Type: text/plain; charset=us-ascii

This worked fine in next-20190618, but in next-20190701 I'm seeing dmesg
entries at boot:

dmesg | grep -i x.509
[    8.345699] Loading compiled-in X.509 certificates
[    8.366137] Problem loading in-kernel X.509 certificate (-13)
[    8.507348] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    8.526556] cfg80211: Problem loading in-kernel X.509 certificate (-13)

I start debugging, and discover that certs/x509_certificate_list is a zero-length file.
I rm it, and 'make V=1 certs/system_certificates.o', which tells me:

(....)
make -f ./scripts/Makefile.headersinst obj=include/uapi
make -f ./scripts/Makefile.headersinst obj=arch/x86/include/uapi
make -f ./scripts/Makefile.build obj=certs certs/system_certificates.o
---- smoking gun alert
  scripts/extract-cert "" certs/x509_certificate_list
----
  gcc -Wp,-MD,certs/.system_certificates.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/9/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -D__KERNEL__ -D__ASSEMBLY__ -fno-PIE -m64 -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -Wa,-gdwarf-2 -DCC_USING_FENTRY -I.   -c -o certs/system_certificates.o certs/system_certificates.S

I go look at extract-cert.c, and sure enough, if the first parameter is a null string
it just goes and creates an empty file.

The Makefile says:

quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
      cmd_extract_certs  = scripts/extract-cert $(2) $@

and damned if I know why $(2) is "". Diffed the config files from -0618 and -0705,
not seeing anything relevant difference.

Any ideas?


--==_Exmh_1562384658_2389P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXSAZEgdmEQWDXROgAQJdfBAAh0OK5AXK+UV3PLU7Zf5MEVbiRWdArkQl
/Mq2xWj7D7T/cNw5C6rkF+15mZr/Jrn7hQS2pdAXf2bBJ1yt+09dDr5+fCMkIzCv
+XKxE876Cd6CnrmyKHprKeitoRxs2Lgre1WPamzWwDKcq3HYgEl1mKrNEnk+bYhp
h/U7qQgpxxRKx+rZU0ZwejwpJw4wgtiYELHUP5ibaGjLwzqZhzQ6prfIW/ow9zRi
m08yxe1THhXs/3ZBAZsXx/LeoUZQhhb7H6WfKYMMU+mwnUSw0rw6fUI0VkOVHV6P
VRcaDpWOV8gAgO6rZffunApCZrRPlTMa+wZwh1vCXApEn1vCtgul6jLKBh9H0XSR
+TS5z90I2BBx9TpmjR2aP04DqATir2CBeXRm1KubQUKPeXJUnjxJF2y/uURUsK52
Uvb5lYRcdPWoYwDsi9eikPKPda8y7H+TQGuygzV9VQAbYyffHfXR3cQMnAVltxko
ZZqtxIBG+/7WtfmTUqN8hzKThHieF92yF1bGgJk8mIjppvUAsoReZgSKqGKePvHX
F3NZoKtMW4A78Yc6PYl9rVADMj0wtapdo8Y7hAjogaf27M/Qu7g94nITro2p8lVx
rJLj61K7Q644ChMjWodkFxNnI4UiiBR5ut+bwVb5IQE/8TSU/eRC1wuuEJk76gQD
MCKeD0Nx+bI=
=etAO
-----END PGP SIGNATURE-----

--==_Exmh_1562384658_2389P--
