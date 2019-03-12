Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E0D2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfCLKmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:42:40 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:57068 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725844AbfCLKmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:42:40 -0400
Received: from mr1.cc.vt.edu (mr1.cc.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2CAgcGY032652
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:42:38 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2CAgXr3004460
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:42:38 -0400
Received: by mail-qk1-f199.google.com with SMTP id j1so1714148qkl.23
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=ERcXO2axeLwNg9dWoWi5E7axFrzxhAYjbC9wWmgct5Y=;
        b=WWYF2s20bA5jgwnxedGxgD+jesSQ9yS/58sA8Cf62Dp4EvuVBrniGqeDKLVqFmUrTz
         JEoxX22px/Z8JKEQX9nUHeRo6qL7nZ7Icuur9mOYM/Wr+Fgh28O/6ryMnUsBZdxfXns9
         3oUuv/8YP751vC2DL325xzUifG0ppfSmMmcOE58+0H3Ttch5BL1D8QrYsMavCsZIzE2A
         QliG724R73kbH6S/wYQwD0gNgGHvpQYJmAwdvNgQaqS9j46471anb7X1x+vu0BS46E0j
         dO9ljD30YLIl/AzjCmsLTz39wqYxz8kMqBDarYTDa2NHrQpGM3MYDqFrG/7cP6T9JoAK
         EuIw==
X-Gm-Message-State: APjAAAVSTKTwVspYY9i1u2MjYedmX+dpqb9n8jsaM5pFhk5ji5anAmVK
        K4/Q9w4c0WeVVnZyAxS0aHcUE/mLTr6HjDphHawHd85Jk/LyfsaCvBydpI+sV4LU6QwQSVzdpi3
        v+IlUEO0CRcD0sH7E5CSZ2wzQz0cPDzlwB60=
X-Received: by 2002:ac8:22ea:: with SMTP id g39mr18742568qta.73.1552387353700;
        Tue, 12 Mar 2019 03:42:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxrqhYIBYOBTmARS+fuP+Rb3hBAuh1oYi5C5wy5GTxSRqW5sVkGqPD/Vj5lhSazGm6lD5sBaQ==
X-Received: by 2002:ac8:22ea:: with SMTP id g39mr18742559qta.73.1552387353533;
        Tue, 12 Mar 2019 03:42:33 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id d63sm6135829qka.22.2019.03.12.03.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 03:42:32 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/extcon/devres.c - fix kerneldoc comment
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 06:42:31 -0400
Message-ID: <14349.1552387351@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with W=1 reports:

  CC      drivers/extcon/devres.o
drivers/extcon/devres.c:208: warning: bad line:                         - Resource-managed extcon_unregister_notifier()

Give the line the asterisk it wanted.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/extcon/devres.c b/drivers/extcon/devres.c
index f599aeddf8e5..f487d877ab5d 100644
--- a/drivers/extcon/devres.c
+++ b/drivers/extcon/devres.c
@@ -205,7 +205,7 @@ EXPORT_SYMBOL(devm_extcon_register_notifier);
 
 /**
  * devm_extcon_unregister_notifier()
-			- Resource-managed extcon_unregister_notifier()
+ *			- Resource-managed extcon_unregister_notifier()
  * @dev:	the device owning the extcon device being created
  * @edev:	the extcon device
  * @id:		the unique id among the extcon enumeration

