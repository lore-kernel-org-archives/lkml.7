Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAD9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C602082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkW4wOsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfFMPfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:35:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39245 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbfFMKbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:31:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so2917510pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=c4lD5Ja/W68zU30yx+ZIDKDyIrqaAIZ94VRiCyeCO0Y=;
        b=YkW4wOsmtRXKF39IQeQs8ZdcwD+6X2M5iCF/r6jKCp49Ml1bgkwnn9qLqERse4MXnS
         JvE/JUr1cR6fI4sYp9RHlrto71AB7k+bS6GVAtsKrhT2Wmz0R/Nn7NUSf9qGlSMRGqGX
         VFRL05138Hd3JVcXhBoLNfRo+SP5MpLwlqKq3bPblTc9ut7nk6RpFrhz/AS0kQLMdp7W
         NYPunno5BmFlawT6AG9mFdUyJvmrBka68PEWDGES8yBZtUknvd3nXlEXBJq+d80A2PuT
         pOlbAZYM12CmFbPUcdVThV/+qdhyEwwMTvqzkqBEoGhYmCw5qx4Uu3CqrowG+fxR70zk
         EXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c4lD5Ja/W68zU30yx+ZIDKDyIrqaAIZ94VRiCyeCO0Y=;
        b=G9mrUWk4xZ2jgdTDrADLLFdea2b7cDQzIN0HmlmfydFlzuxSR4N0DZdNSwwpbq3bkp
         4xY5tuxwyxMAtvlLHORSpLIq//IsjuR2XnF6A8D1u4GzB+cMMdxwbdKbRMVAX8Wg60WM
         3bAQfaROOl5ZBbisO08Sm1a9Yj5zW3Mds7Typ/PK5i9EpbOfGwJRW3gXfKdNQG3OWOu2
         cbGkByvEEkTjCUAs7Lvt8UMVWdd1ztKAvDqvYZd7EKb2vd8fSo9EOR+oGuEMaNZU7fWM
         uJs5s5K42VSfjH6jBBr3CJ8F18K/eW095naAYgbiw44Bkg/wIq38LNtJgWB5ymgQb/Ko
         /ijg==
X-Gm-Message-State: APjAAAWmDD+dRG58svYc9iOjDB/C62pguPsoDtSffEKXuxri/0cT6ojG
        KQZODprzByHstlLG2oi+9CV4UA==
X-Google-Smtp-Source: APXvYqwf629GmUVbhLZnIAU/FAePATiykUd+OC7xErJfaA+0pIRy9XJpSrc4JheBzy9dpn/uP2D0ug==
X-Received: by 2002:a17:902:106:: with SMTP id 6mr23919253plb.64.1560421882686;
        Thu, 13 Jun 2019 03:31:22 -0700 (PDT)
Received: from localhost.localdomain ([117.196.234.139])
        by smtp.gmail.com with ESMTPSA id a12sm2265078pgq.0.2019.06.13.03.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 03:31:21 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 0/7] Introduce TEE based Trusted Keys support
Date:   Thu, 13 Jun 2019 16:00:26 +0530
Message-Id: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TEE based trusted keys where TEE provides the functionality
to seal and unseal trusted keys using hardware unique key. Also, this is
an alternative in case platform doesn't possess a TPM device.

This series also adds some TEE features like:

Patch #1, #2 enables support for registered kernel shared memory with TEE.

Patch #3 enables support for private kernel login method required for
cases like trusted keys where we don't wan't user-space to directly access
TEE service to retrieve trusted key contents.

Rest of the patches from #4 to #7 adds support for TEE based trusted keys.

This patch-set has been tested with OP-TEE based pseudo TA which can be
found here [1].

Looking forward to your valuable feedback/suggestions.

[1] https://github.com/OP-TEE/optee_os/pull/3082

Sumit Garg (7):
  tee: optee: allow kernel pages to register as shm
  tee: enable support to register kernel memory
  tee: add private login method for kernel clients
  KEYS: trusted: Introduce TEE based Trusted Keys
  KEYS: encrypted: Allow TEE based trusted master keys
  doc: keys: Document usage of TEE based Trusted Keys
  MAINTAINERS: Add entry for TEE based Trusted Keys

 Documentation/security/keys/tee-trusted.rst      |  93 +++++
 MAINTAINERS                                      |   9 +
 drivers/tee/optee/call.c                         |   7 +
 drivers/tee/tee_core.c                           |   6 +
 drivers/tee/tee_shm.c                            |  16 +-
 include/keys/tee_trusted.h                       |  84 ++++
 include/keys/trusted-type.h                      |   1 +
 include/linux/tee_drv.h                          |   1 +
 include/uapi/linux/tee.h                         |   2 +
 security/keys/Kconfig                            |   3 +
 security/keys/Makefile                           |   3 +
 security/keys/encrypted-keys/masterkey_trusted.c |  10 +-
 security/keys/tee_trusted.c                      | 506 +++++++++++++++++++++++
 13 files changed, 737 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/security/keys/tee-trusted.rst
 create mode 100644 include/keys/tee_trusted.h
 create mode 100644 security/keys/tee_trusted.c

-- 
2.7.4

