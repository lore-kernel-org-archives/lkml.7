Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC525C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9992E2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="mJ6GN3nX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbfJJBBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 21:01:23 -0400
Received: from mx3.ucr.edu ([138.23.248.64]:50292 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731155AbfJJBBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 21:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570669283; x=1602205283;
  h=from:to:cc:subject:date:message-id;
  bh=FbXEHMrqooWbgZHGXSG3NF7G7Mhn0laqydiduZiAtMk=;
  b=mJ6GN3nX+weJ5ALpfmUuRnfJsZK3vdeAo2irMy6VCXnrzOU6aoHXJFeN
   zV82tYOcdkU8fKArsqdr/mfdeZ//cwZbBPOdXKAykeoJxEPPceY7uZiQs
   IA4HwSp6qN28O4tHsX+3xkvR3vsJ0gKCFWxxcjp4GANXLcblP4JnsOt2g
   fERvwz7+VWlZJ5J43QW8B5wAUJCPck82Uk84VqpPSJH7TS3K3GMHwDHe3
   RHwb7q6ckrBNBN2J2zZPAfI8Mxe82n9b11wXQtRCMjavPbmRlRgeHYBBy
   tA/olcCf4WHb25KxrUHjuNTlF79Q5x+PDZqQwH0CeAsgD5Nk8PJCgBpYO
   Q==;
IronPort-SDR: BuLT6TjtOFJB6fhLEvzeSLNc8eHCSL8OhbHApIJWVh/qf2WUKsTEhTh+hvIh7Ms7OgWsZWGK+M
 WjyMfagUmW+97AlxKBySVrOHDX7KVZ42x/rDwOSca8sM0tsWCmHXo/bE4sRoS0dOB7j/RnhyB3
 l5PzGF4zx81gXks/qGy2FI7faGT2Pg2LGZt+VzpexBxPX+y6Z4Ngdlt4ttGJNlx2TQLkslKAJE
 qI4pgBQswTUdV2C1oVBYYawPBMALhoL0QzMC/xxrL2nAIQv4NOdQ54x88mvyQkPjD7LPuClTtq
 1p8=
IronPort-PHdr: =?us-ascii?q?9a23=3Adx5aphH86XANj2HX7Cn6uZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zpsWwAkXT6L1XgUPTWs2DsrQY0rGQ7fqrBTZIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+3oAnPucUbjpVuIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1kyoMKSI3/3/LhcxxlKJboQyupxpjw47PfYqZMONycr7Bcd8GQG?=
 =?us-ascii?q?ZMWMNRVy1aAoOnbosPCeUBNvtGoYfkulAOoxq+CheoBOzy1zREgnH70bE/3+?=
 =?us-ascii?q?knFg7LwAItE84TvHjNsNn5KboZXeSowKTIyDnOae5d1zXg54jSah0voe+CU6?=
 =?us-ascii?q?9+f8TSzkciDB/JgkmKpID5JT6ZyvgBvm6G5ORgT+KvjGsnphlzrTiux8Ysip?=
 =?us-ascii?q?TJhoUIwV3D9SR4wYY1Kse5SEJnfdKpHoBdtzyGOItsWM8tXXxnuDsjx7AApJ?=
 =?us-ascii?q?W1fzAKxYw5yxLDb/GLaYuF7xL5WOqPPDt1i2hpdK+7ihux6USs1+zxW82u3F?=
 =?us-ascii?q?pUoCdIksPAum4M2hDJ6MWKRf1w9Vq71zmVzQDc8ORELFgxlarcNpEu3KY9lo?=
 =?us-ascii?q?EWsUTfBi/2n1j2jLOOekUk5Oeo7+Pnb63jppCGNo90jhjyMrwqmsCiGOg4PB?=
 =?us-ascii?q?UCUmyY9Oim273j+kr5QLpOjvIoiKXWrJfaJcEDqq64BQ9azJoj5g6hAzu61N?=
 =?us-ascii?q?kUh3oKIVJfdB6ZkoTkNEvCLO38APq8m1islS1kx/HCPr3vGJXNKX3Dna/hfL?=
 =?us-ascii?q?d8605T0gszwcxD659aEbwBPe78WlXruNPGExA5LhS4w/z7B9VlyoMeRWWPD7?=
 =?us-ascii?q?edMKPTt1+I++0uL/CPZIALojb9LeYq5/r1gH8nll8SY7Op0YEUaH+mBPRmJV?=
 =?us-ascii?q?uWYX72jtcGC2cKsVl2YvbtjQizUCxTenH6C7Mu5jg6UNr9JZrIXMagjKHXj3?=
 =?us-ascii?q?TzJYFfem0TUgPEKnzvbYjRHqpRZQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HtEwCzgZ5dhsbWVdFmHgELHIVaTBC?=
 =?us-ascii?q?NJYVaUQEBBospGHGFeoowAQgBAQEMAQEtAgEBhECCUiM4EwIDCQEBBQEBAQE?=
 =?us-ascii?q?BBQQBAQIQAQEBCAsLCCmFQII6KYM1CxYVUoEVAQUBNSI5gkcBglIlpGqBAzy?=
 =?us-ascii?q?MJTOIZAEJDYFICQEIgSKHNYRZgRCBB4ERg1CEDYNZgkoEgTkBAQGNeIc3llc?=
 =?us-ascii?q?BBgKCEBSBeJMVJ4Q8iT+LRAGnYwIKBwYPI4FGgXtNJYFsCoFEUBAUgVsOCY5?=
 =?us-ascii?q?DITOBCI0/glQB?=
X-IPAS-Result: =?us-ascii?q?A2HtEwCzgZ5dhsbWVdFmHgELHIVaTBCNJYVaUQEBBospG?=
 =?us-ascii?q?HGFeoowAQgBAQEMAQEtAgEBhECCUiM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBC?=
 =?us-ascii?q?AsLCCmFQII6KYM1CxYVUoEVAQUBNSI5gkcBglIlpGqBAzyMJTOIZAEJDYFIC?=
 =?us-ascii?q?QEIgSKHNYRZgRCBB4ERg1CEDYNZgkoEgTkBAQGNeIc3llcBBgKCEBSBeJMVJ?=
 =?us-ascii?q?4Q8iT+LRAGnYwIKBwYPI4FGgXtNJYFsCoFEUBAUgVsOCY5DITOBCI0/glQB?=
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="86422987"
Received: from mail-pl1-f198.google.com ([209.85.214.198])
  by smtp3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 18:01:22 -0700
Received: by mail-pl1-f198.google.com with SMTP id g11so2708543plm.22
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 18:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MvM2jwgUKO6uz4LfxBqoaB6VDvyVvKuoyUYs0jsyz0k=;
        b=ct6/jNuJfQ5mgQz6UuMsZK9rt+AFEAYOaaiLMcfkWO6zbxaTFU/Pi/cwCs+aWyzIEq
         cYyujv2zGmPTgmzc0kN6iXn5B4FyjzGjtuoHAucRCJNXmfBjp1vIdCXV2X1yFsxuCl/+
         2zltk8zKmJ+kJUF8LWOTzL3vCgJPbuPi7KMQoj2WjUNLRgXw7MXhyP641A7Udwx5jFv0
         MClc4VD90GzGtunKk3FtxOnR8eRDYyrbwJ1ZEqFvjvVZ5aBXQV6PG3mbBE3XV8I87XwF
         yJ3dY3IhHUAKgaxoFlBfoizu+ofi+UXy5+Tz74CRs2mwcvUG2DkW4d4qw/nnKWQ6x9WR
         DHfg==
X-Gm-Message-State: APjAAAX6DiRZQwdhwIf9p308lAAcLpJk/LzD+Pt+PsulAcpgaI6H3c2Z
        SfryiNNyngILpOtTfQQ1IK2zcYZ0hvFytOXIur9LZbkOuPNml1IBXyvBRvqEFQEH6IpZirtIAmu
        FjYu2jHgT73DVySLTpVftu84PjA==
X-Received: by 2002:a17:902:2e:: with SMTP id 43mr6021042pla.270.1570669281481;
        Wed, 09 Oct 2019 18:01:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxOXnmntkThXGYy+i9dPCuMRJzaVdG4Osex5SflPK5bvsD16OY0wpQwitsRLeTtpk5YTdBCpQ==
X-Received: by 2002:a17:902:2e:: with SMTP id 43mr6021006pla.270.1570669281167;
        Wed, 09 Oct 2019 18:01:21 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id f65sm3388103pgc.90.2019.10.09.18.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 18:01:20 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jan-Marek Glogowski <glogow@fbihome.de>,
        Mathieu Malaterre <malat@debian.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: core: Fix potental Null Pointer dereference
Date:   Wed,  9 Oct 2019 18:02:02 -0700
Message-Id: <20191010010205.25739-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function usb_device_is_owned(), usb_hub_to_struct_hub()
could return NULL but there's no check before its dereference,
which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/usb/core/hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 236313f41f4a..8d628c8e0c1b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1977,7 +1977,7 @@ bool usb_device_is_owned(struct usb_device *udev)
 	if (udev->state == USB_STATE_NOTATTACHED || !udev->parent)
 		return false;
 	hub = usb_hub_to_struct_hub(udev->parent);
-	return !!hub->ports[udev->portnum - 1]->port_owner;
+	return hub && !!hub->ports[udev->portnum - 1]->port_owner;
 }
 
 static void recursively_mark_NOTATTACHED(struct usb_device *udev)
-- 
2.17.1

