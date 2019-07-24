Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A269C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00864205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998411;
	bh=TgKenZT6uu0WJD3ZsqrhoJdgAhGX33wkZumBXr0XTZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YJhda/MsJn9eokdoCahf5coo3ttdffeIEh+Gfqcj+NazMg0oYdH6iQxJ7uTxc+jFZ
	 jUog8vVpjMNOBhxhLd5b/2aHDScm6/KD87VvGdkAX3Cq8HmPu7gSEwGGy+R0JvqNDf
	 iLmVmYoLIpPIqpdIqA8IEbaiusQrgCc6xhyZJknc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405186AbfGXUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404425AbfGXUAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:00:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 162D8214AF;
        Wed, 24 Jul 2019 20:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998405;
        bh=TgKenZT6uu0WJD3ZsqrhoJdgAhGX33wkZumBXr0XTZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d3G4K2eeQdM14kovw6GB96e4UY3SUMR+B27z2NQNDlycM3FrrMRjgXzATolV1KBP4
         t0i+2kAP++mLcfIkLG29cUTYjC0/Ttb2m26ozIexxjklIgl2uQbK3Jrfnw+C7z9kMc
         zAHmmq0piCq4dWo4FFFliocif92CEQiS0qEIkAf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.1 355/371] powerpc/pseries: Fix oops in hotplug memory notifier
Date:   Wed, 24 Jul 2019 21:21:47 +0200
Message-Id: <20190724191750.642398704@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Lynch <nathanl@linux.ibm.com>

commit 0aa82c482ab2ece530a6f44897b63b274bb43c8e upstream.

During post-migration device tree updates, we can oops in
pseries_update_drconf_memory() if the source device tree has an
ibm,dynamic-memory-v2 property and the destination has a
ibm,dynamic_memory (v1) property. The notifier processes an "update"
for the ibm,dynamic-memory property but it's really an add in this
scenario. So make sure the old property object is there before
dereferencing it.

Fixes: 2b31e3aec1db ("powerpc/drmem: Add support for ibm, dynamic-memory-v2 property")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/hotplug-memory.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -980,6 +980,9 @@ static int pseries_update_drconf_memory(
 	if (!memblock_size)
 		return -EINVAL;
 
+	if (!pr->old_prop)
+		return 0;
+
 	p = (__be32 *) pr->old_prop->value;
 	if (!p)
 		return -EINVAL;


