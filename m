Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A01C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F5C207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391653AbfITOeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:34:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36292 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388214AbfITOZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:25:07 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iBJqK-00050x-RV; Fri, 20 Sep 2019 15:25:04 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iBJqH-0007zf-PR; Fri, 20 Sep 2019 15:25:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jim Mattson" <jmattson@google.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Matt Delco" <delco@chromium.org>,
        syzbot+983c866c3dd6efa3662a@syzkaller.appspotmail.com
Date:   Fri, 20 Sep 2019 15:23:35 +0100
Message-ID: <lsq.1568989415.143749949@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 130/132] KVM: coalesced_mmio: add bounds checking
In-Reply-To: <lsq.1568989414.954567518@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.74-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Delco <delco@chromium.org>

commit b60fe990c6b07ef6d4df67bc0530c7c90a62623a upstream.

The first/last indexes are typically shared with a user app.
The app can change the 'last' index that the kernel uses
to store the next result.  This change sanity checks the index
before using it for writing to a potentially arbitrary address.

This fixes CVE-2019-14821.

Fixes: 5f94c1741bdc ("KVM: Add coalesced MMIO support (common part)")
Signed-off-by: Matt Delco <delco@chromium.org>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reported-by: syzbot+983c866c3dd6efa3662a@syzkaller.appspotmail.com
[Use READ_ONCE. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16:
 - Use ACCESS_ONCE() instead of READ_ONCE()
 - kvm_coalesced_mmio_zone::pio field is not supported]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 virt/kvm/coalesced_mmio.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -39,7 +39,7 @@ static int coalesced_mmio_in_range(struc
 	return 1;
 }
 
-static int coalesced_mmio_has_room(struct kvm_coalesced_mmio_dev *dev)
+static int coalesced_mmio_has_room(struct kvm_coalesced_mmio_dev *dev, u32 last)
 {
 	struct kvm_coalesced_mmio_ring *ring;
 	unsigned avail;
@@ -51,7 +51,7 @@ static int coalesced_mmio_has_room(struc
 	 * there is always one unused entry in the buffer
 	 */
 	ring = dev->kvm->coalesced_mmio_ring;
-	avail = (ring->first - ring->last - 1) % KVM_COALESCED_MMIO_MAX;
+	avail = (ring->first - last - 1) % KVM_COALESCED_MMIO_MAX;
 	if (avail == 0) {
 		/* full */
 		return 0;
@@ -65,24 +65,27 @@ static int coalesced_mmio_write(struct k
 {
 	struct kvm_coalesced_mmio_dev *dev = to_mmio(this);
 	struct kvm_coalesced_mmio_ring *ring = dev->kvm->coalesced_mmio_ring;
+	__u32 insert;
 
 	if (!coalesced_mmio_in_range(dev, addr, len))
 		return -EOPNOTSUPP;
 
 	spin_lock(&dev->kvm->ring_lock);
 
-	if (!coalesced_mmio_has_room(dev)) {
+	insert = ACCESS_ONCE(ring->last);
+	if (!coalesced_mmio_has_room(dev, insert) ||
+	    insert >= KVM_COALESCED_MMIO_MAX) {
 		spin_unlock(&dev->kvm->ring_lock);
 		return -EOPNOTSUPP;
 	}
 
 	/* copy data in first free entry of the ring */
 
-	ring->coalesced_mmio[ring->last].phys_addr = addr;
-	ring->coalesced_mmio[ring->last].len = len;
-	memcpy(ring->coalesced_mmio[ring->last].data, val, len);
+	ring->coalesced_mmio[insert].phys_addr = addr;
+	ring->coalesced_mmio[insert].len = len;
+	memcpy(ring->coalesced_mmio[insert].data, val, len);
 	smp_wmb();
-	ring->last = (ring->last + 1) % KVM_COALESCED_MMIO_MAX;
+	ring->last = (insert + 1) % KVM_COALESCED_MMIO_MAX;
 	spin_unlock(&dev->kvm->ring_lock);
 	return 0;
 }

