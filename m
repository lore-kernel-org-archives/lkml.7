Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02215C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A8D21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsImEtXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391393AbfISPpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:45:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28451 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391382AbfISPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568907928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=40X0vm8+7OBVX9kW6gTq2puO5TD3LRpWUOSeujBTwSI=;
        b=QsImEtXKNhQa4ZdWy3DbJ5T0nFIAK4H6mqwsy/szRWRpPz7kg3LiWTrXeSfwXmefu6h8q7
        lEL9ay2tVjkcYRaoqGqrgX0gGgLsZBk4+9B/c2U8AB3+UUkB04ymGTBqy2c4H0c7WCSpq5
        dKB2LI2Kqi3frTK+9VzW9GcQmbI5zDo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-yDohOsbcNLKPCpR3sZzoIA-1; Thu, 19 Sep 2019 11:45:15 -0400
Received: by mail-wm1-f72.google.com with SMTP id 190so2000881wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 08:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IuQngF1BoEvQ6fP1U7DbaQBImeULLxoa7zH+YgkADWs=;
        b=LvXTCoSMFRQ2AZfmQbeL5WiQvlqCTq3irrGNNVoFKobCeWz4cjCQ93431QXnaS7e2N
         JeNMCyyRTfn1aX2doXt5qZ+7sJE9fOSdmCgHU4e1AzJ0c1O9UwL6ebbvGB1xzMiZpkZf
         sPaorxfagQpT485ARqKaGggF5xdGjqOPg/tsgosT59mb6O0CjlHUuOzteCH79lvQk71s
         Yr471jBs5vBMqmc1QYNcTq3KSH1mvhgSh4d8afQcr7GAU8LVFZKDHtV5pIl+QoiSCYu0
         DiZ22YFWnpN2ScniMPzFrqk1HYmSEthp7ROu3ekGEhmuhe+fG1G5j9rUooJ5+xdwPmSt
         N7MA==
X-Gm-Message-State: APjAAAVP6AmWRY++mMktc6EDSYFmCJK6L07/qiIMsL33kP3EeClcxD/u
        XxZmREnACmbMxi3yG1D8ggmCS5UnKquopR02qDypmW1nu7nUAslHWNpU4qY7Jp62oKBspUmJ3qd
        pYG2ZFCczh8H6dIYy+SWR9cnS
X-Received: by 2002:a5d:4647:: with SMTP id j7mr7581976wrs.106.1568907603865;
        Thu, 19 Sep 2019 08:40:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+OjakhgvaDtsfzFmaFL97O8csbbK+Vo5VIxwaqYYZyJpLvjwzE0u+steLkcP97rvOtdgeNw==
X-Received: by 2002:a5d:4647:: with SMTP id j7mr7581956wrs.106.1568907603602;
        Thu, 19 Sep 2019 08:40:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id y3sm9581998wrw.83.2019.09.19.08.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 08:40:03 -0700 (PDT)
Subject: Re: [RFC patch 14/15] workpending: Provide infrastructure for work
 before entering a guest
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.860645841@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0cc964dc-4d00-05ec-1ed1-f6cee7370d7b@redhat.com>
Date:   Thu, 19 Sep 2019 17:40:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919150809.860645841@linutronix.de>
Content-Language: en-US
X-MC-Unique: yDohOsbcNLKPCpR3sZzoIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quick API review before I dive into the implementation.

On 19/09/19 17:03, Thomas Gleixner wrote:
> +=09/*
> +=09 * Before returning to guest mode handle all pending work
> +=09 */
> +=09if (ti_work & _TIF_SIGPENDING) {
> +=09=09vcpu->run->exit_reason =3D KVM_EXIT_INTR;
> +=09=09vcpu->stat.signal_exits++;
> +=09=09return -EINTR;
> +=09}
> +
> +=09if (ti_work & _TIF_NEED_RESCHED) {
> +=09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> +=09=09schedule();
> +=09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
> +=09}
> +
> +=09if (ti_work & _TIF_PATCH_PENDING) {
> +=09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> +=09=09klp_update_patch_state(current);
> +=09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
> +=09}
> +
> +=09if (ti_work & _TIF_NOTIFY_RESUME) {
> +=09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> +=09=09clear_thread_flag(TIF_NOTIFY_RESUME);
> +=09=09tracehook_notify_resume(NULL);
> +=09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
> +=09}
> +
> +=09/* Any extra architecture specific work */
> +=09return arch_exit_to_guestmode_work(kvm, vcpu, ti_work);
> +}

Perhaps, in virt/kvm/kvm_main.c:

int kvm_exit_to_guestmode_work(struct kvm *kvm, struct kvm_vcpu *vcpu,
=09=09=09=09unsigned long ti_work)
{
=09int r;

=09/*
=09 * Before returning to guest mode handle all pending work
=09 */
=09if (ti_work & _TIF_SIGPENDING) {
=09=09vcpu->run->exit_reason =3D KVM_EXIT_INTR;
=09=09vcpu->stat.signal_exits++;
=09=09return -EINTR;
=09}

=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
=09core_exit_to_guestmode_work(ti_work);
=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);

=09return r;
}

and in kernel/entry/common.c:

int core_exit_to_guestmode_work(unsigned long ti_work)
{
=09/*
=09 * Before returning to guest mode handle all pending work
=09 */
=09if (ti_work & _TIF_NEED_RESCHED)
=09=09schedule();

=09if (ti_work & _TIF_PATCH_PENDING)
=09=09klp_update_patch_state(current);

=09if (ti_work & _TIF_NOTIFY_RESUME) {
=09=09clear_thread_flag(TIF_NOTIFY_RESUME);
=09=09tracehook_notify_resume(NULL);
=09}
=09return arch_exit_to_guestmode_work(ti_work);
}

so that kernel/entry/ is not polluted with KVM structs and APIs.

Perhaps even extract the body of core_exit_to_usermode_work's while loop
to a separate function, and call it as

=09core_exit_to_usermode_work_once(NULL,
=09=09=09=09ti_work & EXIT_TO_GUESTMODE_WORK);

from core_exit_to_guestmode_work.

In general I don't mind having these exit_to_guestmode functions in
kvm_host.h, and only having entry-common.h export EXIT_TO_GUESTMODE_WORK
and ARCH_EXIT_TO_GUESTMODE_WORK.  Unless you had good reasons to do the
opposite...

Paolo

