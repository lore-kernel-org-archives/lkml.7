Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8545EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593432073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079892;
	bh=4aSin8pIKwx0oLzv+cVii80JV7hNKD07wusy0JpkXGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GstUcjyzDJ2+aYNMarHrhME2sVDXloCwDSgCpsKlopdVL9B3Z1pVPENcjZ3WsijRN
	 JW8DAI/k+h4KdbnWLlGxEFmwk05F8vKGiOgJWsFP+MLRC2hMd3ikC6jGbdJBixK9aE
	 WE1pnAX+zN8o13oKQJoEIhqMwaEzq9ABTo92xkzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfLKP6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:58:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731647AbfLKPOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:14:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C943124654;
        Wed, 11 Dec 2019 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077279;
        bh=4aSin8pIKwx0oLzv+cVii80JV7hNKD07wusy0JpkXGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXztKYCxTBVI1gGHaEPi/xURwl9F7QcrWRefH/Gr6x8bgdhtoNZ1JgRYkRg3l+VIt
         WnBp/TbVw69fw08VJlwnRiIv6Yy6Ov278+pEHbC6do9p6qPSDdpEA6NO8NnF7ZeJom
         SZKGMhZMsqr1ZZ+dEU+/JxP6KQec4wONZY6LtCuo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.3 083/105] KVM: x86: Remove a spurious export of a static function
Date:   Wed, 11 Dec 2019 16:06:12 +0100
Message-Id: <20191211150258.542411204@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 24885d1d79e2e83d49201aeae0bc59f1402fd4f1 upstream.

A recent change inadvertently exported a static function, which results
in modpost throwing a warning.  Fix it.

Fixes: cbbaa2727aa3 ("KVM: x86: fix presentation of TSX feature in ARCH_CAPABILITIES")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1303,7 +1303,6 @@ static u64 kvm_get_arch_capabilities(voi
 	data &= ~ARCH_CAP_TSX_CTRL_MSR;
 	return data;
 }
-EXPORT_SYMBOL_GPL(kvm_get_arch_capabilities);
 
 static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 {


