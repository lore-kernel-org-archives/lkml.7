Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1278C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3462064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697442;
	bh=Wdc2jXh0Tp2BmFlAzEXnnIqAvNx2KOd//LP8av2dQx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zkbRr8kfapkiwVmPOmZ44VUxG6td7UXB2LBxo0nGO9yyrhy31PWZIw7FgavFdoTOS
	 QkYmXzwFSd0NBluauDP0AGNK99e8I6SykZfXAD2+B1qmcwu+Z4Dmmkh3N3uQwNKGRp
	 eaERa3BhyP7vrM5j+Sptg5CE77FTA/kHrbeujMn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390011AbfJJIuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389549AbfJJIug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:50:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EC8920B7C;
        Thu, 10 Oct 2019 08:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697435;
        bh=Wdc2jXh0Tp2BmFlAzEXnnIqAvNx2KOd//LP8av2dQx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEzbGtVOYzs2lcu7oV6RRrc3lQnoDJ0TRmqKGU5XpBmxP2yDMXVHPSL/nOize/8VH
         4q3vNV43G7kAaHwPnDva1I1LADow7Ev3t6E6v5b8sTt0/Y7D6JfONbX0bcys/++Yac
         Axwv7iR92G90Dx3rv11oDkz/41i+XVMFAN9vzOQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 4.14 06/61] KVM: PPC: Book3S HV: Dont lose pending doorbell request on migration on P9
Date:   Thu, 10 Oct 2019 10:36:31 +0200
Message-Id: <20191010083453.052152882@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083449.500442342@linuxfoundation.org>
References: <20191010083449.500442342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mackerras <paulus@ozlabs.org>

commit ff42df49e75f053a8a6b4c2533100cdcc23afe69 upstream.

On POWER9, when userspace reads the value of the DPDES register on a
vCPU, it is possible for 0 to be returned although there is a doorbell
interrupt pending for the vCPU.  This can lead to a doorbell interrupt
being lost across migration.  If the guest kernel uses doorbell
interrupts for IPIs, then it could malfunction because of the lost
interrupt.

This happens because a newly-generated doorbell interrupt is signalled
by setting vcpu->arch.doorbell_request to 1; the DPDES value in
vcpu->arch.vcore->dpdes is not updated, because it can only be updated
when holding the vcpu mutex, in order to avoid races.

To fix this, we OR in vcpu->arch.doorbell_request when reading the
DPDES value.

Cc: stable@vger.kernel.org # v4.13+
Fixes: 579006944e0d ("KVM: PPC: Book3S HV: Virtualize doorbell facility on POWER9")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_hv.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1356,7 +1356,14 @@ static int kvmppc_get_one_reg_hv(struct
 		*val = get_reg_val(id, vcpu->arch.pspb);
 		break;
 	case KVM_REG_PPC_DPDES:
-		*val = get_reg_val(id, vcpu->arch.vcore->dpdes);
+		/*
+		 * On POWER9, where we are emulating msgsndp etc.,
+		 * we return 1 bit for each vcpu, which can come from
+		 * either vcore->dpdes or doorbell_request.
+		 * On POWER8, doorbell_request is 0.
+		 */
+		*val = get_reg_val(id, vcpu->arch.vcore->dpdes |
+				   vcpu->arch.doorbell_request);
 		break;
 	case KVM_REG_PPC_VTB:
 		*val = get_reg_val(id, vcpu->arch.vcore->vtb);


