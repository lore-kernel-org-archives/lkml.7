Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EAAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E6620878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCpDNV+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKUC3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:29:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbfKUC3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574303341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=by/zQ+3yLUz+ix0dbdVmiFHSoojhC/RF88zhiK7/yXo=;
        b=hCpDNV+rk6pJAVht5CARvxS8xQIiB0sCIdEREQaBgiqzoB9MVGRdb0tScGZLc8xf2MSTji
        UVWkVtOJ3WRjWFaxRyE1EkVY56k8X7v5XRUBveLymxlKoTDSesSiBat0eGRKEKu269iaTH
        6zx814V+8jEgFoSG272JJ9cI5qJLBRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-GfRTqIQkMFKGzDPUqseiFQ-1; Wed, 20 Nov 2019 21:22:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1555E107ACC4;
        Thu, 21 Nov 2019 02:22:54 +0000 (UTC)
Received: from localhost (ovpn-116-6.gru2.redhat.com [10.97.116.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 905A95E268;
        Thu, 21 Nov 2019 02:22:53 +0000 (UTC)
Date:   Wed, 20 Nov 2019 23:22:52 -0300
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 5/5] KVM: vmx: use MSR_IA32_TSX_CTRL to hard-disable TSX
 on guest that lack it
Message-ID: <20191121022252.GX3812@habkost.net>
References: <1574101067-5638-1-git-send-email-pbonzini@redhat.com>
 <1574101067-5638-6-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1574101067-5638-6-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: GfRTqIQkMFKGzDPUqseiFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 07:17:47PM +0100, Paolo Bonzini wrote:
> If X86_FEATURE_RTM is disabled, the guest should not be able to access
> MSR_IA32_TSX_CTRL.  We can therefore use it in KVM to force all
> transactions from the guest to abort.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

So, without this patch guest OSes will incorrectly report "Not
affected" at /sys/devices/system/cpu/vulnerabilities/tsx_async_abort
if RTM is disabled in the VM configuration.

Is there anything host userspace can do to detect this situation
and issue a warning on that case?

Is there anything the guest kernel can do to detect this and not
report a false negative at /sys/.../tsx_async_abort?

--=20
Eduardo

