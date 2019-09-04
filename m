Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8E5C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2912E2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="MVk9Ap6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbfIDSRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:17:10 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:52809 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390016AbfIDSRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1567621027;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=6sKFQsgK3hmnQqRn7QbS0Q0onQxt/wsvfBLo+ew2VPs=;
  b=MVk9Ap6OuSERi/77uUYiStbwQojfGqlS2O6PFD0U5T9kUmgUwmbsCbvQ
   8kIc94cE66/1DRZMtBIly9JyVQ2KX4Ro6P/wb8nA+Ybir7c/cskSmDA/l
   iz+98Y5XrD0M+aI9tISvXQuSJZ+0u1HCwZc4jG+RXw0++CCxmANyXOSEQ
   o=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: asFe9edQEmHVY/aROrCRTcmcYIq+1J/+sWfY+RCj0l/CO4uUHkEG1jxAebSGWUZ/18SxWqwcxF
 Xn25wGDLhpWgGVJKKjA4fimC/hT+5bWo0Ny9I9b2Smp4dkzWRyyqmEsE9zx/CYPGFdiv2hltxT
 W8slK2rY7rXJqVC5ZPDbwDTa2nVkWpuqhCiHL9GtaOu4lUSMUkXzjPPNIpSadaZEYB+gxNYpct
 6yzhkAQqhd60FTTCgzI9eqSD2TEKqcCSQM5Ka/+88HHDGxf1db25eaLi2EtXAZ7Y1K26BYVtdb
 +YE=
X-SBRS: 2.7
X-MesageID: 5411413
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,467,1559534400"; 
   d="scan'208";a="5411413"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Tyler Hicks <tyhicks@canonical.com>,
        "Ben Hutchings" <ben@decadent.org.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Documentation/process: Volunteer as the ambassador for Xen
Date:   Wed, 4 Sep 2019 19:17:02 +0100
Message-ID: <20190904181702.19788-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
---
Volunteer as tribute, perhaps.  Lets hope this isn't needed as frequenly as
the past two years have gone.
---
 Documentation/process/embargoed-hardware-issues.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index d37cbc502936..f9e8c0b23c52 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -221,7 +221,7 @@ an involved disclosed party. The current ambassadors list:
 
   Microsoft
   VMware
-  XEN
+  Xen		Andrew Cooper <andrew.cooper3@citrix.com>
 
   Canonical	Tyler Hicks <tyhicks@canonical.com>
   Debian	Ben Hutchings <ben@decadent.org.uk>
-- 
2.11.0

