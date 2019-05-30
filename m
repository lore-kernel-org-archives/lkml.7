Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCC6C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935E525839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190979;
	bh=2W0LCAp+js594ct7JLGSdDfTbTh5tQVJFIJpPYJMW8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=smt1EA9dWgKqhRnnjD+yGVdeHrTPCLTrk/ubhgbyTUeURoUvz7PPNTC3bJE7LOPN6
	 DJlNQeBh92cbE2a143UH4LKSnjcSXjQasm23ICEI0wl3uQhUsrNIiwlMMyEHDmajXG
	 ow82IvYIyFn+Z7X8TD9hHe2GAOHYXkpxc0og/2Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbfE3EgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbfE3DNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:01 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F035823D83;
        Thu, 30 May 2019 03:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185981;
        bh=2W0LCAp+js594ct7JLGSdDfTbTh5tQVJFIJpPYJMW8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2l75gPO0s28p7c8MenKFYRzUz1x6rSXpyEmQmQXnwDRMmPsqzdZ56HOFHvNDKuU6M
         J6jzo3JLW8lXjOYDFMgPKynnrh30zW7jCwcs3jtQjm0rr70zrMJVWNVBildwe5uIfr
         +q298usc9M6jGiBxTojIdHV/r8oF2xhV5pocm+Hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 004/346] KVM: x86: fix return value for reserved EFER
Date:   Wed, 29 May 2019 20:01:17 -0700
Message-Id: <20190530030540.651104022@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 66f61c92889ff3ca365161fb29dd36d6354682ba upstream.

Commit 11988499e62b ("KVM: x86: Skip EFER vs. guest CPUID checks for
host-initiated writes", 2019-04-02) introduced a "return false" in a
function returning int, and anyway set_efer has a "nonzero on error"
conventon so it should be returning 1.

Reported-by: Pavel Machek <pavel@denx.de>
Fixes: 11988499e62b ("KVM: x86: Skip EFER vs. guest CPUID checks for host-initiated writes")
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1288,7 +1288,7 @@ static int set_efer(struct kvm_vcpu *vcp
 	u64 efer = msr_info->data;
 
 	if (efer & efer_reserved_bits)
-		return false;
+		return 1;
 
 	if (!msr_info->host_initiated) {
 		if (!__kvm_valid_efer(vcpu, efer))


