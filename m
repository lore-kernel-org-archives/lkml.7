Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775E1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A7622464
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4OxiWEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfLKKq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:46:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31610 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727469AbfLKKq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576061185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jE+isrP9gJ3LfiLQuHLtxY+E9i+PYFyCHT4kzF4aVX4=;
        b=N4OxiWECjOgRgm+9AvcLghlnfxfF3Z/sg/ynI7luTTx8MRIb687BAZ9tEm42a/ixuXBcRi
        i8a9fPjjtJSuQ//O2OgOmJGSuu4LtslWFLxY34rgFVpUXMjI2CeKcQ5Pw7QCim17oHCUur
        DMz280dPmrgoHGYWFlBcznNU6vAudPk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-fhJPh-V7N4O4jVgM7Jgi2w-1; Wed, 11 Dec 2019 05:46:24 -0500
Received: by mail-wm1-f70.google.com with SMTP id t17so298186wmi.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 02:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JH1T+zEL6Fh7Z3FAc2TFJ9ucwEFM+C4d7iALZ0J6POk=;
        b=lcHNs0CKOXX1dsbY68nBpEAyYqUYxt0wwlwev0S+tfN5rMlSsgkxju8+NOPmlGYXKZ
         JJKERH+yO2Y9TXZLNpLFbM/3/a03mKOppGNm7PQKOfuMv+CzegPsZMu95In+KyGMMo5b
         dc1agQXnw5zSkpm9mB23LznA3W8SWSHTrOUJLAa2dZscRpc7QTip1ZaC2gBNCX8AKT3V
         7G5zxgeq41xlvUpNeDk1EXNWfDPjKXHfk5GvXkOhyuX/w4cnkfPsrlRKFr9UBmH6M4NN
         sxZrR7SZFT+WJgcc5LB/eSK/LJ0A7QBqb5VYKjwFUfNMIu26vUEEdiIrNZGZ+p43uthz
         1QKw==
X-Gm-Message-State: APjAAAVkRlcm5SqYZ4yQyobZHQJ/i8gAdbqAWgsj0nBr2YJ5PEUcwoB+
        A9cP0yVLNeSXksE+o7fOJIsdSVyMzIwIQkHe7HhYYv+fAEswU+pqpFktj3UtFBQvmCGYdUpChxT
        ZEXq/yZc7tcpH8qKB+skaORp2
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr2724298wmg.86.1576061183220;
        Wed, 11 Dec 2019 02:46:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqyudGse1WVPQ8R9pkCZ4v+3Kcb8LkbR1Dsw6fUKZPZekK4OR6zBQdF6aR68tkB3ry80QWGQHA==
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr2724278wmg.86.1576061183050;
        Wed, 11 Dec 2019 02:46:23 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g17sm1693366wmc.37.2019.12.11.02.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 02:46:22 -0800 (PST)
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
Subject: [PATCH 1/1] init/Kconfig: enable -O3 for all arches
Date:   Wed, 11 Dec 2019 11:46:19 +0100
Message-Id: <20191211104619.114557-2-oleksandr@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211104619.114557-1-oleksandr@redhat.com>
References: <20191211104619.114557-1-oleksandr@redhat.com>
MIME-Version: 1.0
X-MC-Unique: fhJPh-V7N4O4jVgM7Jgi2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building a kernel with -O3 may help in hunting bugs like [1] and thus
using this switch should not be restricted to one specific arch only.

With that, lets expose it for everyone.

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
2.24.1

