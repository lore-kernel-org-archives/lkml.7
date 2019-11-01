Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A955CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6A521855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifI8SQ9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfKAV0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:26:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57780 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727188AbfKAV0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572643607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VmbUG2xp7oJxAAQUnh6rfZI/GV69GyKIZVQEsGh/h4s=;
        b=ifI8SQ9d54m1sCVXHXHzJ1FKsou0GYaL+bk4Y6oGwVYSAMTvVGHi0sXudpcLEZ5GGqrchh
        R8MbbtXb3Q4Fds4iiC9INOnW2+KD4TI2aF2Bapl3Svfq1CVgnbUvDyxlyMo5+hxqeIowxx
        3zPdQ634eJjz659jxSIH5xt/j9v1ZIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-0s3lOTovP82_VPzjX0IMQw-1; Fri, 01 Nov 2019 17:26:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B926A1005500;
        Fri,  1 Nov 2019 21:26:40 +0000 (UTC)
Received: from amt.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD4785D6B7;
        Fri,  1 Nov 2019 21:26:37 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 61B62105157;
        Fri,  1 Nov 2019 19:03:36 -0200 (BRST)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id xA1L3W81020345;
        Fri, 1 Nov 2019 19:03:32 -0200
Date:   Fri, 1 Nov 2019 19:03:32 -0200
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        joao.m.martins@oracle.com, rafael.j.wysocki@intel.com,
        rkrcmar@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 1/5] KVM: simplify branch check in host poll code
Message-ID: <20191101210331.GA20061@amt.cnet>
References: <1572060239-17401-1-git-send-email-zhenzhong.duan@oracle.com>
 <1572060239-17401-2-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1572060239-17401-2-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0s3lOTovP82_VPzjX0IMQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 11:23:55AM +0800, Zhenzhong Duan wrote:
> Remove redundant check.
>=20
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  virt/kvm/kvm_main.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 67ef3f2..2ca2979 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2366,13 +2366,12 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  =09=09} else if (halt_poll_ns) {
>  =09=09=09if (block_ns <=3D vcpu->halt_poll_ns)
>  =09=09=09=09;
> -=09=09=09/* we had a long block, shrink polling */
> -=09=09=09else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
> -=09=09=09=09shrink_halt_poll_ns(vcpu);
>  =09=09=09/* we had a short halt and our poll time is too small */
> -=09=09=09else if (vcpu->halt_poll_ns < halt_poll_ns &&

This is not a redundant check: it avoids from calling
into grow_halt_poll_ns, which will do:

=091) Multiplication
=092) Cap that back to halt_poll_ns
=093) Invoke the trace_kvm_halt_poll_ns_grow tracepoint
=09   (when in fact vcpu->halt_poll_ns did not grow).

