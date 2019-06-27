Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB0BC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD34720B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfF0Pmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:42:37 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:26690 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF0Pmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:42:37 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2019 11:42:36 EDT
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=ross.lagerwall@citrix.com; spf=Pass smtp.mailfrom=ross.lagerwall@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  ross.lagerwall@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="ross.lagerwall@citrix.com";
  x-sender="ross.lagerwall@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  ross.lagerwall@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="ross.lagerwall@citrix.com";
  x-sender="ross.lagerwall@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="ross.lagerwall@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 52+Xcdg6sTgsb8rJ7oQOG/BqE2PUQuUlf+sUGPHsEfMzM8mAfVaO7o5+uCsyeYJz5VeVW8MqoF
 mBdZVPhiyipu+MxAEghzOMR8fP5MKKTQHSTipNXBn4daTCmPGBKKtBEe5OuLl6kWFIfMZaPBfP
 o1/LHvL1JXj8xV8BrsM6FlTFddZfEws3QCuc9MvcHYPqPMYMl1sLk0Rh4OEimk9vYTuVVaCH9O
 Izmgjntf5kY3TsMPNY+PoV4YA6TCcJVVAZxD5lJ2UCcROgeDavFprY6HeYm1jDpKNRv2BIXLsv
 J18=
X-SBRS: 2.7
X-MesageID: 2324821
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,424,1557201600"; 
   d="scan'208";a="2324821"
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] iscsi_ibft: Use a field width for target lun sysfs entry
Date:   Thu, 27 Jun 2019 16:34:58 +0100
Message-ID: <20190627153458.22520-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target lun sysfs entry contains the contents of an 8 byte LUN id
formatted as hex. Because a field width is not specified for each byte,
the resulting string is variable length and impossible for userspace to
unambiguously parse. Fix this by using a field width of 2 for each byte
so that the string can be parsed correctly.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 drivers/firmware/iscsi_ibft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index ab3aa3983833..5900edcb6334 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -371,7 +371,7 @@ static ssize_t ibft_attr_show_target(void *data, int type, char *buf)
 		break;
 	case ISCSI_BOOT_TGT_LUN:
 		for (i = 0; i < 8; i++)
-			str += sprintf(str, "%x", (u8)tgt->lun[i]);
+			str += sprintf(str, "%02x", (u8)tgt->lun[i]);
 		str += sprintf(str, "\n");
 		break;
 	case ISCSI_BOOT_TGT_NIC_ASSOC:
-- 
2.17.2

