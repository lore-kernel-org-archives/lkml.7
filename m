Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DF9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B4E20828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF+XatHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfLJO5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:57:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41447 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727426AbfLJO5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575989825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pizj88R2AL6EW2h5n6WxVnUb6CuY670RUYlkHQGcOE8=;
        b=dF+XatHhWsaENo5ceC1YMhgjcW3tiVW9p3S1ZOX97i9e9eV4feolIEkOds9W6t/Xm8B10o
        HRGLBodvdlyTxu8rOwaObeNPh4Jt1EJMX+8IO6sxv0e6dduIZ6WL87fzTarf8d9pwR0Tfy
        jJ8VisT3VCht1ZgNNEPZPDerLk5Ui4I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100--axuD1D9PzaF6WCKv3iftA-1; Tue, 10 Dec 2019 09:57:04 -0500
Received: by mail-wr1-f72.google.com with SMTP id 90so9000029wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 06:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KhgmoMXvASqQe9/KIjSmxvUQfCfCVmkr95iRvUliS04=;
        b=WJvbV0HcP4XOz0LGnUFuSL8Ri22bOSIR6NC+4w5jTdU9wdRuG+bVcCl7yiSFZs5+V/
         M4sTftiosbaKSk9bWde9nSOq7reFplM+Q2hJ6lWlUBMSWklABn7i6XAIcVEYa34lNw3+
         afjJ7VfNYWieLI5XX4Jo3FaWwfqqYsYi4AaqP0WrVh5scmx80UI/aWA0csxG0JlaGbR/
         lTy2mc1whCFbed9A6s6tXy0TKvWrfkfOIAIkjoth45EY06f9jZxnRmbey45e3T198TzP
         S115iXIlm5/4c08HWqcOfWOJphI1eGGWM8Tl3HUuATtEvP0axQ4lBdudxdegQIgvNWAb
         dpbg==
X-Gm-Message-State: APjAAAXQYxNrPxOGXh5wNi/glzNfmSJIq/uZP+Tla4cqLMRKPzlSesS/
        whBCm4pSYYTuSS05/rgItFjE6yJE1fcMaHFjH2HsLxnYqK6GA26nGv8T2nGhih9PYawTsff2mIY
        RTkWu1SzMSwlYUgQxccR/UHoy
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr3694881wrs.11.1575989819329;
        Tue, 10 Dec 2019 06:56:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqx6hFrH03lwVLmtWW0DWqoOkoHzF32eiPuhRamLitPZ9i/I7oZ3qKTUxtMydFXkTy9B0AOQ==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr3694865wrs.11.1575989819138;
        Tue, 10 Dec 2019 06:56:59 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v22sm3347493wml.11.2019.12.10.06.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:56:57 -0800 (PST)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>, Tejun Heo <tj@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        David Howells <dhowells@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH RFC] init/Kconfig: enable -O3 for all arches
Date:   Tue, 10 Dec 2019 15:56:57 +0100
Message-Id: <20191210145657.105808-1-oleksandr@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-MC-Unique: -axuD1D9PzaF6WCKv3iftA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building a kernel with -O3 may help in hunting bugs like [1] and thus
using this switch should not be restricted to one specific arch only.

Thus lets expose it. If for some reasone we have to hide it, lets hide
it under EXPERT.

The commit is made against next-20191210 tag.

[1] https://lore.kernel.org/lkml/673b885183fb64f1cbb3ed2387524077@natalenko=
.name/

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 init/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index a34064a031a5..b41b18edb10e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1228,7 +1228,6 @@ config CC_OPTIMIZE_FOR_PERFORMANCE
=20
 config CC_OPTIMIZE_FOR_PERFORMANCE_O3
 =09bool "Optimize more for performance (-O3)"
-=09depends on ARC
 =09imply CC_DISABLE_WARN_MAYBE_UNINITIALIZED  # avoid false positives
 =09help
 =09  Choosing this option will pass "-O3" to your compiler to optimize
--=20
2.24.0

