Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D1EC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93A12184B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054918;
	bh=emvwUdVW0+nZbV6MltQoEQlRpt9QAeRJY2O4pV29Klw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m9KaHTSeu3ULZbbMiFmB9cJ5nVCFwP7OmW8DMX69yA38DJeJY4UYSn0L9ilBP9wG/
	 iGn0m4IU7xTW5p0j0dbMeg4QkWrqxXrxtVYg0c5ZrYZtw8yytFiF/0XZcQ/WPC75Uk
	 T84tb3bx2WkJQ1TKZejFX4iE6RT05WyucN7z5pZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfGBIIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbfGBIIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:08:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E3132184C;
        Tue,  2 Jul 2019 08:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054914;
        bh=emvwUdVW0+nZbV6MltQoEQlRpt9QAeRJY2O4pV29Klw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUWmo5WZlxN5laMKAJhO7df4PxKMDv6AJHxFjbelBhJ/1QU+UOJOdDCDXBMYjCIAR
         em3JwSJ8VXKCbQDqT7tbi1Pi5xktKu0Veg6GfeaJqDR/lGICjeRfuT/x7KFJG00w18
         CVNRCIWpB+B3cfYnVr7iW1h6ZTB1PoE4x4jECNXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.19 68/72] arm64: futex: Avoid copying out uninitialised stack in failed cmpxchg()
Date:   Tue,  2 Jul 2019 10:02:09 +0200
Message-Id: <20190702080128.167642047@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
References: <20190702080124.564652899@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

commit 8e4e0ac02b449297b86498ac24db5786ddd9f647 upstream.

Returning an error code from futex_atomic_cmpxchg_inatomic() indicates
that the caller should not make any use of *uval, and should instead act
upon on the value of the error code. Although this is implemented
correctly in our futex code, we needlessly copy uninitialised stack to
*uval in the error case, which can easily be avoided.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/futex.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -134,7 +134,9 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 	: "memory");
 	uaccess_disable();
 
-	*uval = val;
+	if (!ret)
+		*uval = val;
+
 	return ret;
 }
 


