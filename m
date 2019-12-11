Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C2AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84126206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyOt2yK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfLKKq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:46:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27790 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727493AbfLKKq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576061184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=K4H0zSCO2QSm/eggmwjamKsM01zRajc55w+V6waEM80=;
        b=eyOt2yK79JnvKsNX2iLZ1E0ZUJbhFx9hQPjFvTMS0FQLS5IoYmtNNp7gfO0Ewvk9YiRnk9
        3OSJBmRA0daQJyz2VwwjepccGP9OdyhUHAvGQudPg046sCvwx4JjORJx0u1e2+Ea2ko3Rw
        PYPs4FPhwcMq6XQ9nERArupGf9K9kcs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-sjk1RgsmMvWGMb_yPgPYKw-1; Wed, 11 Dec 2019 05:46:23 -0500
Received: by mail-wm1-f72.google.com with SMTP id o205so2231360wmo.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 02:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rAWXwRmtKcTKVeo5rctfBGlbD9osl7KY6CkodtUNWGo=;
        b=cSyXVkT/ioc10tf07J7rqpDZbeyk5/hxUUnRvA1v64hs3Pk5OrS1kiwZv2VSnlub8o
         eKfcEnop6sfZeEFt9fPZ1DjzV8bQ+Wpt0JMrQXqP1GD17UchL0uRpcm9e459R20jLJ68
         UrYv3xSKMNAtJ2leUSE32PJUmu6IIO04B1I/bcz3vo488antmSTdst6hokORSwejOoWb
         ebSESjE90vLH3crEANXWqhuwNmwj6WWOgX+CpOoVeh5a/GfDrl1qS4g8DI5sRZsEiyw+
         9qYB/8/cTZiI1HxNbrzSiojhWqk/M0+oFGRkA48YJChg3iGyKEdc4M/4xZR4zm66aJ8I
         ZusA==
X-Gm-Message-State: APjAAAUWlgq3NTzlW2o5EJuKya1gM3AjEEuioST/YnxEzGt+dUUkALd2
        AYBrRMDDPNqpXYz+wADgbyO5arF2sDVLsxZWsCmuoVsxObOCURQJ4vtQyfT2trnLaXxrIhUxKIT
        xnjW2JEQZCympfPygw+kpsl3r
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr3136318wrs.106.1576061181678;
        Wed, 11 Dec 2019 02:46:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxkgJU2agR+Z5q42YP9ARXBeSx7dL46TxPCzZ6G8qxxaMgrd/eV07ev8lxG62+yxAB0cKD0Lg==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr3136284wrs.106.1576061181391;
        Wed, 11 Dec 2019 02:46:21 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s15sm1818465wrp.4.2019.12.11.02.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 02:46:20 -0800 (PST)
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
Subject: [PATCH 0/1] init/Kconfig: enable -O3 for all arches
Date:   Wed, 11 Dec 2019 11:46:18 +0100
Message-Id: <20191211104619.114557-1-oleksandr@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-MC-Unique: sjk1RgsmMvWGMb_yPgPYKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this submission is to expose -O3 for all the
architectures, not only ARC, since it helps in hunting some bugs (see
the commit message for specific example).

Previously this was posted as RFC here: [1]. With this submission I'm
addressing Krzysztof's concern regarding commit message. No other
changes are made.

The RFC was accepted into -mm tree here: [2]. If needed, please replace
that one with this one since this one has a nicer commit message.

The patch is made against next-20191210 tag.

Thanks.

[1] https://lore.kernel.org/lkml/20191210145657.105808-1-oleksandr@redhat.c=
om/
[2] https://marc.info/?l=3Dlinux-mm-commits&m=3D157602335225239&w=3D2

Oleksandr Natalenko (1):
  init/Kconfig: enable -O3 for all arches

 init/Kconfig | 1 -
 1 file changed, 1 deletion(-)

--=20
2.24.1

