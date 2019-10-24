Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A51CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C89205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5BWLeVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503735AbfJXRZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:25:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44663 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503725AbfJXRZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571937906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IWzAZ9HNPk3l1a/8iI2n7kSXyM4kxMXTHno5ToPU7ww=;
        b=U5BWLeViFlU813TBvjAev3MCuQqfCMuPJjOkhXTjh70uJiwynQSDsp3GZJYAZJfv8UEQ4V
        4GROTZn5jIhw9qFeGkdl79C/E15YCFaQAwfCOZQuC/xZVE0o28GkCMYrxOgz7SH3e+DF46
        Xaytc3pwkVI6Egm9nfJKsTCVzGDAENI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-c4bcAWLNMDiryZBbchh6WQ-1; Thu, 24 Oct 2019 13:25:03 -0400
Received: by mail-wr1-f69.google.com with SMTP id i10so5105155wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 10:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QceqmF4YKwwH8fTUkw/b9vvDDjaKb935kcJgs7A+w8g=;
        b=GNXTMKJW/XLCgXP9WT4Jc4/W4Q53byE+1CAa5fM65ET51x3JCfoTzTbaRRDlFTk7dX
         fRfltOwKc1dqqlDpm/0/vUNCuGuC6irk0n/EtLXzBvCneb4Y2ZcnMtXjFUEwgR73ZFxo
         2Ccm24NtuQnqalkKegf2Oqti9MF+aWNqUP553cKG6/rwL1vmntfNOPzPXNDCL7gxtFdi
         Nn/Boelkd3EzGefJAkAhFUhQo09PpBWBXyAiu4exD5oljzIXb2FQ1Lu4yWYK7seT7nxx
         kLSJatkIZWFpg32uY/Giw26rMqT5BVLl9AvOYMlivwxqOjg23pFN97nzAmf0I3ER2R5h
         CQSw==
X-Gm-Message-State: APjAAAVF7zQ56ql2lP4PxkbvF1kqmPlpMxESDsQmJML6j7LoungHTJLT
        bt4w4LwGjgPWwaZD9U+qQXLrd+7ff7cnAbpLS4j9u/hBJPSetNBTGZEsTGCiX4Ve0C3nfkRZ4Dd
        rOwgEvzFvaH+Z6M2VsYPjKMeI
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr4952667wrw.176.1571937901784;
        Thu, 24 Oct 2019 10:25:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz5Rez1khw9qnCHtTQbdfVkKcfFrfFNym8v2VuQ29stcdXlnuRhZ4LzEGVIEADkmeLYi+UUsA==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr4952649wrw.176.1571937901592;
        Thu, 24 Oct 2019 10:25:01 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 200sm4253443wme.32.2019.10.24.10.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 10:25:01 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] mvpp2 improvements in rx path
Date:   Thu, 24 Oct 2019 19:24:55 +0200
Message-Id: <20191024172458.7956-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: c4bcAWLNMDiryZBbchh6WQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor some code in the RX path to allow prefetching some data from the
packet header. The first patch is only a refactor, the second one
reduces the data synced, while the third one adds the prefetch.

The packet rate improvement with the second patch is very small (1606 =3D> =
1620 kpps),
while the prefetch bumps it up by 14%: 1620 =3D> 1853 kpps.

Matteo Croce (3):
  mvpp2: refactor frame drop routine
  mvpp2: sync only by the frame size
  mvpp2: prefetch frame header

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

--=20
2.21.0

