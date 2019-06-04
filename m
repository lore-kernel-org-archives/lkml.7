Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19166C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1B023CEB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfFDNuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:50:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbfFDNuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:50:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4CC5307D932;
        Tue,  4 Jun 2019 13:49:56 +0000 (UTC)
Received: from localhost (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24D955D9E5;
        Tue,  4 Jun 2019 13:49:54 +0000 (UTC)
Date:   Tue, 4 Jun 2019 21:49:52 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas.Lendacky@amd.com
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: The current SME implementation fails kexec/kdump kernel booting.
Message-ID: <20190604134952.GC26891@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 04 Jun 2019 13:50:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

Lianbo reported kdump kernel can't boot well with 'nokaslr' added, and
have to enable KASLR in kdump kernel to make it boot successfully. This
blocked his work on enabling sme for kexec/kdump. And on some machines
SME kernel can't boot in 1st kernel.

I checked code of SME implementation, and found out the root cause. The
above failures are caused by SME code, sme_encrypt_kernel(). In
sme_encrypt_kernel(), you get a 2M of encryption work area as intermediate
buffer to encrypt kernel in-place. And the work area is just after _end of
kernel.

This happens to work in 1st kernel. But it will fail kexec/kdump kernel
absolutely. Because we load realmode/kernel/initrd in kexec-tools from
top to down. In kexec-tools, realmode is put just after kernel image. If
KASLR enabled, kernel may be randomized to other position, then kdump
kernel can boot. However, if nokaslr specified, the 2M intermediate
encryption workarea will definitely stump into the following realmode,
and fail kexec/kdump kernel booting. 

I have hacked kexec-tools code to put real mode area 4M away from the
kernel image end, it works and confirm my finding. So the current SME
in-place encryption way is not only a kexec/kdump issue, but also an
issue in 1st kernel. Because KASLR could put kernel at the end of an
available memory region, how to make sure the next 2M intermediate
workarea must exist; if KASLR put kernel to be close to starting address
of any cmdline/initrd/setup_data, how to make sure the gap between them
must be larger than 2M.

Thanks
Baoquan
