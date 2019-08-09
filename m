Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70BBC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACFA214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565358475;
	bh=hCOQ/3o6yVkNnmohc565drS708u0WeyH1cciRFIEELU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IH1A5Cv43rihPhzMxEmcVRXFGm/Is1sje06Vqlq/LlDghFVK6nGvU01FNqNixdLo7
	 mJ6qQHMIt79eWkVmShR097+XXGdDKCTWfMJcS1/eGKbii7qp0QBCyYv2OH6Juz6Tua
	 3pww4Oiq2eErpNRn14TJ3rDGIWyT1OKLoobUYSeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436654AbfHINry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436640AbfHINrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:47:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6D6021874;
        Fri,  9 Aug 2019 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565358469;
        bh=hCOQ/3o6yVkNnmohc565drS708u0WeyH1cciRFIEELU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C30VaVVFz9AxHZPmodx53XX+LOeZo+hUK504mW94NFKO4t91FubcW6U/iifTpw3+z
         RUOttRmV9BymgNamz2mtMgxySQLrAOvj4VWXn7rWZ9Dp4qiOf4q1HlKJY+juKjbpaN
         rJ3uCu2ljEA57YXm/6RBqEtVQMgoW4ms8+mm394Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.9 12/32] objtool: Add machine_real_restart() to the noreturn list
Date:   Fri,  9 Aug 2019 15:45:15 +0200
Message-Id: <20190809133923.356917728@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809133922.945349906@linuxfoundation.org>
References: <20190809133922.945349906@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 684fb246578b9e81fc7b4ca5c71eae22edb650b2 upstream.

machine_real_restart() is annotated as '__noreturn", so add it to the
objtool noreturn list.  This fixes the following warning with clang and
CONFIG_CC_OPTIMIZE_FOR_SIZE=y:

  arch/x86/kernel/reboot.o: warning: objtool: native_machine_emergency_restart() falls through to next function machine_power_off()

Reported-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Link: https://lkml.kernel.org/r/791712792aa4431bdd55bf1beb33a169ddf3b4a2.1529423255.git.jpoimboe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -165,6 +165,7 @@ static int __dead_end_function(struct ob
 		"__reiserfs_panic",
 		"lbug_with_loc",
 		"fortify_panic",
+		"machine_real_restart",
 	};
 
 	if (func->bind == STB_WEAK)


