Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12458CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0380218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVlKxtj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfJTQsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 12:48:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33600 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfJTQsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 12:48:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so12886771wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 09:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qyqrGDk+Zt7s4YN81M0MZ1PXTfBkta2lCsaTtYvGgsQ=;
        b=hVlKxtj2l5SzVIshPHfbMa9B9OZEfFThkomEQuIeI3wkVgXnsTbx7bd0w6Il4Rma0i
         TX+HsdsFLZ1bsa8ALlF56yC8hWHvmwlOOu7FfdR4VfkVvpsbg0Tk5/zC3PmNCia33S62
         30D0xQf3Jr8La8eDpEGa4Mo08I0YqdGGuPjUJCzucF8oJVlbDHhyzjnNdzyG0YtD1cRd
         qnv/RDNz/11O7Lmkp65+PUOQiZZQxhHt8VLtW2WZCHCjhAOyQl1TD+fdWAPPXdKFagP7
         mhNclpkmoRJ8vNkKXKUaLHjkwbj4rBeYy0pZcRptrc7WrfEMFMmAcnES0U+fN0OxhddF
         SNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qyqrGDk+Zt7s4YN81M0MZ1PXTfBkta2lCsaTtYvGgsQ=;
        b=gSCk+ZMfnf+xPFeQTaOQcP4Wel5BaYEpXXifnb+B3WtpBBp2GUtQgfODDVMdUhj+2e
         5iqrlkObN3bmK1cQ3Hrrb2ch1augTw6IT+xk5zeE2jTn36ab9a2CxVYOdu7k8IwoQrEo
         zzFw7GhL6PDYeBv2tgyh5abIPXjLROORA001GFPP/YRGs+y0eHnQT6By5IVM5HvDsiiW
         2V0XsVPHt4DhCMjhywkgVHIIKHX22NNNT/OBfMru5Cmt9m5VBxVM8ZGp6FJcfjvOEH8a
         xxIBJmgbssdFmBegx5MiyShqTddienQ4IBw9ZZ6Q2eJFdEm247KoGH0NIQvuBP/vBuPV
         BPYA==
X-Gm-Message-State: APjAAAVuGpdBVLBHg+lDcXNywGUmBb+NPyIUj3zymc0Qv9AfxHc4coVg
        MiYObFoYvbrVDxKiCr+qwNV4OwY=
X-Google-Smtp-Source: APXvYqzkyottTlYPcq8B9UBosQLqqn9grYkB2pdHcYffC6vrK6OwYmYFU4/GBSmtVb5wIRSiH7XuxA==
X-Received: by 2002:a1c:1bcd:: with SMTP id b196mr15622835wmb.12.1571590131262;
        Sun, 20 Oct 2019 09:48:51 -0700 (PDT)
Received: from avx2 ([46.53.254.76])
        by smtp.gmail.com with ESMTPSA id c6sm5819129wmc.9.2019.10.20.09.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 09:48:50 -0700 (PDT)
Date:   Sun, 20 Oct 2019 19:48:48 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     yamada.masahiro@socionext.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tags: fix "config ..." false positives
Message-ID: <20191020164848.GA13623@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"config" regex is too loose, giving a few false positives

	CONFIG_and     drivers/pci/controller/Kconfig  /^        config and MMIO accesses.$/;" r
	CONFIG_option  arch/x86/Kconfig        /^        config option.$/;"    r
	CONFIG_option  init/Kconfig    /^        config option determines the parameter's default value.$/;"   r
	and    drivers/pci/controller/Kconfig  /^        config and MMIO accesses.$/;" r
	option arch/x86/Kconfig        /^        config option.$/;"    r
	option init/Kconfig    /^        config option determines the parameter's default value.$/;"   r

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/tags.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -213,8 +213,8 @@ regex_c=(
 	'/\<\(DEFINE\|DECLARE\)_STATIC_KEY_\(TRUE\|FALSE\)\(\|_RO\)(\([[:alnum:]_]\+\)/\4/'
 )
 regex_kconfig=(
-	'/^[[:blank:]]*\(menu\|\)config[[:blank:]]\+\([[:alnum:]_]\+\)/\2/'
-	'/^[[:blank:]]*\(menu\|\)config[[:blank:]]\+\([[:alnum:]_]\+\)/CONFIG_\2/'
+	'/^[[:blank:]]*\(menu\|\)config[[:blank:]]\+\([[:alnum:]_]\+\)$/\2/'
+	'/^[[:blank:]]*\(menu\|\)config[[:blank:]]\+\([[:alnum:]_]\+\)$/CONFIG_\2/'
 )
 setup_regex()
 {
