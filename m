Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE42CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD0520862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAinKUkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbfJ2Nrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:47:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45755 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726858AbfJ2Nrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572356858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AOZDZYv9EYsWU3DDUZnJ3QM3j0uLD33yFtGOQVV5kdk=;
        b=GAinKUkOE5JZP9veCL/BCGeWB53XTsKV/lQYe3clYC03l5hy0hUU3CMLY4Ii7k3M3ANaIl
        5szMmbc1N3BRwUg5iZFmnVvc/DaW6rZDX8IaJWCIhgQ9S+Ual/S2fJsIyaws8drpKXyHqu
        +Y4MealaFE6RqGTki9+ar3GhRR/v5UI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-qSagFc73OrWovHU1oZha7w-1; Tue, 29 Oct 2019 09:47:37 -0400
Received: by mail-wm1-f70.google.com with SMTP id t203so878605wmt.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jQTwbHy83mtQr77G3uSvn8MlfrVM//HDdD91jEPvl6g=;
        b=Y4IIHG0HUYZxPlOhEwQYRUMZjF1QjHmSm29kJ8kt8QShosZ3snn8ADiuE6InO8sHrW
         ibk5pATe3lckyHFKBBdbouuCPhcvXRzFwF4iAtii3r6fQ0y3T/b28gPwmQRAnsHXqMV1
         NRt8se1jPctPY5YZCSBGos6k0KftmGnB745gkUHExha0pkQ7V7cJK2crNl9p6ZRxz2xQ
         nLy+tdJVDD10zESl1JxxarZnOfjsguxKfCsOTHdm01m5bCZELSXUTTZM6QcOLqOcZj+K
         Ti5W08s47K6OoKoeNeErXO/4RfAnkxkwf/9Lv1TvVoO++WkgZWy7VqOd4kZ7XdOLLVWD
         3I9Q==
X-Gm-Message-State: APjAAAU0VyzbkXtlvU5aBZjtanNj9GBwOwYqqgwhnm1ghMVXnxAVbTz9
        5W4emxO+YpuiLPbOwN97oyMoiPxexosWkD4Zgd6BPaCE0mPLXUHeM2lc+FfEjWGiZszh7T/MBPx
        bmwsi9/MS1sJWgkW3jZQ7tdhH
X-Received: by 2002:a05:6000:118f:: with SMTP id g15mr5234390wrx.242.1572356854902;
        Tue, 29 Oct 2019 06:47:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzliW861h/AGu6aqVzf4hjYXVlZi0TA4h1trMKB9KcWAVofSDtLty/EGGh6dyERP6OOYq3JRQ==
X-Received: by 2002:a05:6000:118f:: with SMTP id g15mr5234373wrx.242.1572356854705;
        Tue, 29 Oct 2019 06:47:34 -0700 (PDT)
Received: from turbo.teknoraver.net (net-109-115-41-234.cust.vodafonedsl.it. [109.115.41.234])
        by smtp.gmail.com with ESMTPSA id f204sm2895789wmf.32.2019.10.29.06.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:47:34 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller " <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Blakey <paulb@mellanox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH DRAFT 0/3] mvpp2: page_pool and XDP support
Date:   Tue, 29 Oct 2019 14:47:29 +0100
Message-Id: <20191029134732.67664-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: qSagFc73OrWovHU1oZha7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Last patch series for mvpp2. First patch is just a param to disable percpu =
allocation,
second one is the page_pool port, and the last one XDP support.

As usual, reviews are welcome.

TODO: disable XDP when the shared buffers are in use.

Matteo Croce (3):
  mvpp2: module param to force shared buffers
  mvpp2: use page_pool allocator
  mvpp2: add XDP support

 drivers/net/ethernet/marvell/Kconfig          |   1 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  11 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 232 ++++++++++++++++--
 3 files changed, 220 insertions(+), 24 deletions(-)

--=20
2.21.0

