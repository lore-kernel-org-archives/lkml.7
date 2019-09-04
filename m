Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C7DC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5CF22CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620469;
	bh=HVPsM3txQgcnk/3lR3lRftJNUg0OBCD3o9erAomK1l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nyo0WevGJk2flRZphD8ZiHv+0j4n0K07ZF/+z2GeqquiV2QZdyHVIaZW/njqmWUXz
	 4ZdHK8SBCR9ZbbKEyypaLjhAMEy30tTQOFVwxEe+lKC+FgdNrih0uyK0Rle204eLIk
	 szYgYP68nGmt8uShwlVQYg9mrkHUoT7Qw4HPI+Nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbfIDSHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389274AbfIDSHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:07:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37962206B8;
        Wed,  4 Sep 2019 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620464;
        bh=HVPsM3txQgcnk/3lR3lRftJNUg0OBCD3o9erAomK1l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGIHI+g2AkWeoOFk837deCsV6uhIZapzC202jYaK8MqU9fOWI+DF76lXBwDuODiNM
         Pwyq3o6QlsLtj9jxkCxwwFSqAbjP0l4x0+1LEQpg9kxoU2ZwtdEC6zKqsddTEBs3mM
         fZCdtYqarsx4huAYU16LMFllMdETZv0xAiAc5miA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.19 68/93] typec: tcpm: fix a typo in the comparison of pdo_max_voltage
Date:   Wed,  4 Sep 2019 19:54:10 +0200
Message-Id: <20190904175308.907305241@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit a684d8fd87182090ee96e34519ecdf009cef093a upstream.

There appears to be a typo in the comparison of pdo_max_voltage[i]
with the previous value, currently it is checking against the
array pdo_min_voltage rather than pdo_max_voltage. I believe this
is a typo. Fix this.

Addresses-Coverity: ("Copy-paste error")
Fixes: 5007e1b5db73 ("typec: tcpm: Validate source and sink caps")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20190822135212.10195-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/tcpm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -1445,7 +1445,7 @@ static enum pdo_err tcpm_caps_err(struct
 				else if ((pdo_min_voltage(pdo[i]) ==
 					  pdo_min_voltage(pdo[i - 1])) &&
 					 (pdo_max_voltage(pdo[i]) ==
-					  pdo_min_voltage(pdo[i - 1])))
+					  pdo_max_voltage(pdo[i - 1])))
 					return PDO_ERR_DUPE_PDO;
 				break;
 			/*


