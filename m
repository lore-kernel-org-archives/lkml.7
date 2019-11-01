Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D6CCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DEA218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THQzUrjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfKAV1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:27:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29409 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727079AbfKAV0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572643605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ww5ThBqUA5AQa1e0fbp3gIV8aqc81bpci8inmlnDTyQ=;
        b=THQzUrjnNw1IVioiw6gA10vd3BOdY/jDB1yyVxeZAcNXxtHoXHG3leErqRhaIpR75BJYKb
        7d28/M2ewMtY0uEhigd5N3gc0Q0hoMik0Z/9R4HBDZkiSmjcNCvk3fCGlcxAPcABm+qPQE
        uthNeKjuARxi7w1Qn/pr9Z77lyzn9Y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-6QAwz_2YPc6dnpyhBpdgSg-1; Fri, 01 Nov 2019 17:26:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0460C107ACC0;
        Fri,  1 Nov 2019 21:26:40 +0000 (UTC)
Received: from amt.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB9C25D9CD;
        Fri,  1 Nov 2019 21:26:37 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 77A1110515D;
        Fri,  1 Nov 2019 19:16:31 -0200 (BRST)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id xA1LGRZA020635;
        Fri, 1 Nov 2019 19:16:27 -0200
Date:   Fri, 1 Nov 2019 19:16:26 -0200
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        joao.m.martins@oracle.com, rafael.j.wysocki@intel.com,
        rkrcmar@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 3/5] KVM: ensure pool time is longer than block_ns
Message-ID: <20191101211623.GB20061@amt.cnet>
References: <1572060239-17401-1-git-send-email-zhenzhong.duan@oracle.com>
 <1572060239-17401-4-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1572060239-17401-4-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 6QAwz_2YPc6dnpyhBpdgSg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 11:23:57AM +0800, Zhenzhong Duan wrote:
> When (block_ns =3D=3D vcpu->halt_poll_ns), there is not a margin so that
> vCPU may still get into block state unnecessorily.
>=20
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  virt/kvm/kvm_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1b6fe3b..48a1f1a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2371,7 +2371,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  =09=09if (!vcpu_valid_wakeup(vcpu)) {
>  =09=09=09shrink_halt_poll_ns(vcpu);
>  =09=09} else if (halt_poll_ns) {
> -=09=09=09if (block_ns <=3D vcpu->halt_poll_ns)
> +=09=09=09if (block_ns < vcpu->halt_poll_ns)
>  =09=09=09=09;
>  =09=09=09/* we had a short halt and our poll time is too small */
>  =09=09=09else if (block_ns < halt_poll_ns)
> --=20
> 1.8.3.1

Makes sense.

