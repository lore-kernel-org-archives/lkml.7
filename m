Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50CCCA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9185E21929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJ432iGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfJXVig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:38:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37463 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbfJXVig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571953115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+W4d4OgMW+B0KDlXk+E0iYX+C7rcV2ERm9vzGNurd3E=;
        b=bJ432iGa/UZJBzKC1TGMZvz31+9wWGI5Almaz4VUf+4Xd5YIydPSndkanoDYYeYzJGkM2P
        5l/GIxUq/3rcQpTlkWmfCdf+SsblaRlUY9qiKBOI5H2DNdPFAysce0NptGf7vZgrJhMKfR
        f7Q+la2DHe0tvdh/rwBFk/JAWo47DU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-i0NYPJfCOpWgLiHcLKfycQ-1; Thu, 24 Oct 2019 17:38:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 594711800E04;
        Thu, 24 Oct 2019 21:38:30 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C45A85C1B5;
        Thu, 24 Oct 2019 21:38:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ACPI / PMIC: Add partial support for Cherry Trail Crystal Cove PMIC
Date:   Thu, 24 Oct 2019 23:38:23 +0200
Message-Id: <20191024213827.144974-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: i0NYPJfCOpWgLiHcLKfycQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Our current Crystal Cove OpRegion driver is only valid for the
Crystal Cove PMIC variant found on Bay Trail (BYT) boards,
Cherry Trail (CHT) based boards use another variant.

At least the regulator registers are different on CHT and these registers
are one of the things controlled by the custom PMIC OpRegion.

This series renames the existing Crystal Cove driver to make clear that it
is for the BYT variant only and then adds a new (very minimal) Cherry
Trail Crystal Cove driver.

Lee, the changes to the mfd code here are very minimal / trivial, I believe
that it is best if this series is merged in its entirety through Rafael's
tree, can we have your Acked-by for this?

Regards,

Hans

