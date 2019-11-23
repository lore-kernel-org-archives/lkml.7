Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A50C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 10:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DA520706
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 10:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cM6MLQcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKWK3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 05:29:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30192 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbfKWK3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 05:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574504969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=patTDqP6P/12wqJT5SP1aPiZu7eQGy3OK8NDt1fjPUM=;
        b=cM6MLQcD8S4EVgF8sx2LAA4oU9HyFfHsyMB37tcfADMsx1wBstvqQ9aKy4eB3KkR7jZyDN
        o9dfkDgrPibe3VzMPjh/HEjOX45UmUu7m1b6u2iDS8XIzzRyi1LZ+iY3llke7GZAYrjvmV
        eWcCZcAfB4/MVzQyiNA/vGmH3Y9GbOI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-4IYfUaQlOmCVxpj9OB1AsA-1; Sat, 23 Nov 2019 05:29:25 -0500
Received: by mail-wr1-f71.google.com with SMTP id q6so5284546wrv.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 02:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2LxlNznsKDsiNmIvShf/cu1MAgP/XlucV6i+DkqhtvE=;
        b=ZTHUpd/3/BFrVcxoLJieGpokkmdQ4JmN35vcZWqHJqAx7k31KXaA+8mZONdL4JC/W5
         X4lPpS5MfNGw5h83LeQWDTdoRjUw7go6iEoKm4Qgi4PDVM6Qi/RNbW3P4/AVuH0bz45u
         fsSOT4YHYlPfW0/zYhMjXj2HpdcVxhqKMgWpx0JDroiP/g3+hyG4U2E4mKk8OKIEaic+
         yS0xRP1qC0RK8XdMTD+utju5hZn1FI/DdCtxehbAsRD/zMcmb8Je+VWJ3Xm1LLXByF7g
         eymZ0Ap8SrOjRBxfFMCU2zj3zyBxwr3XZFnQrVLM+EQgLD24Dm/zC7+HnDaeKXrlrfYe
         Vl1g==
X-Gm-Message-State: APjAAAWs8il07IH1BYf+I8BnftASskyE5o0NRqDUvGcFaZiXzH+PmMlU
        4MWWaGDQL4Cuf6YQ0j19h4jCdM3lgbbDieSU38ANx/P1yEAh1PtYt99gTz8xUJsNVF8dlP9psfY
        qrDI7qyyhjLPFxGf6da+kmPLd
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr1651199wmc.62.1574504964527;
        Sat, 23 Nov 2019 02:29:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfzOylcMIN+W5QEdcSCnBQn5pl/XoRCsnIZBpf+F3bnbWowWL4VxnTaZnP0L+DqoJrMJleqA==
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr1651177wmc.62.1574504964231;
        Sat, 23 Nov 2019 02:29:24 -0800 (PST)
Received: from [192.168.42.104] (mob-109-112-4-118.net.vodafone.it. [109.112.4.118])
        by smtp.gmail.com with ESMTPSA id w11sm1720910wra.83.2019.11.23.02.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2019 02:29:23 -0800 (PST)
Subject: Re: [PATCH] KVM: Fix jump label out_free_* in kvm_init()
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1574477150-775-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <86ac7d2a-b611-067a-f9cb-bd5f09d0b3a9@redhat.com>
Date:   Sat, 23 Nov 2019 11:29:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1574477150-775-1-git-send-email-linmiaohe@huawei.com>
Content-Language: en-US
X-MC-Unique: 4IYfUaQlOmCVxpj9OB1AsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/19 03:45, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
>=20
> The jump label out_free_1 and out_free_2 deal with
> the same stuff, so git rid of one and rename the
> label out_free_0a to retain the label name order.
>=20
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  virt/kvm/kvm_main.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 13e6b7094596..00268290dcbd 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4354,12 +4354,12 @@ int kvm_init(void *opaque, unsigned vcpu_size, un=
signed vcpu_align,
> =20
>  =09r =3D kvm_arch_hardware_setup();
>  =09if (r < 0)
> -=09=09goto out_free_0a;
> +=09=09goto out_free_1;
> =20
>  =09for_each_online_cpu(cpu) {
>  =09=09smp_call_function_single(cpu, check_processor_compat, &r, 1);
>  =09=09if (r < 0)
> -=09=09=09goto out_free_1;
> +=09=09=09goto out_free_2;
>  =09}
> =20
>  =09r =3D cpuhp_setup_state_nocalls(CPUHP_AP_KVM_STARTING, "kvm/cpu:start=
ing",
> @@ -4416,9 +4416,8 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsi=
gned vcpu_align,
>  =09unregister_reboot_notifier(&kvm_reboot_notifier);
>  =09cpuhp_remove_state_nocalls(CPUHP_AP_KVM_STARTING);
>  out_free_2:
> -out_free_1:
>  =09kvm_arch_hardware_unsetup();
> -out_free_0a:
> +out_free_1:
>  =09free_cpumask_var(cpus_hardware_enabled);
>  out_free_0:
>  =09kvm_irqfd_exit();
>=20

Queued, thanks.

Paolo

