Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB6CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC44D206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKUMVB+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfKKNto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:49:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41596 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726903AbfKKNtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573480182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=EY5+4NqtD637Jq/iOkgRi0CcCRIMuNTpq8KDCNXJJLA=;
        b=NKUMVB+8n8RzeJtYPblppCnQ1AcTTttwLNCIS0OUXbi+vvfiBEwFghLVOqCOlmi4lPYKZO
        1gQNbjSndP/Z04j2hdiI7zjqP0rFpPJJEVM5AanvA+BYJMBBw56+gTlpNPKy85km07XnHk
        ODaqbDWxUNu6LRKwAdPGPVOBGy+vLr4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-0lIWp_U0PcmtCVaVr_sQRQ-1; Mon, 11 Nov 2019 08:49:39 -0500
Received: by mail-wr1-f69.google.com with SMTP id q6so6508047wrv.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EtDO20YQ4gCjEjWttnh7Y94CePcbnhFksyEQrtJO8cs=;
        b=V+jXL6dUPmG4Aq1QQ3Q0WlMI4Ia5HBqq4Yrkp17usDQqGV2tZXbqDc0UTSKqyxkOHE
         KpsOS2db/QapCmgylsxeYBp8Tntc2dGOIDMyBqcW/Hz89UIdkSAJT5dK4S1nMsM09Wmn
         Sok6BN8jwcXIpiLeooXypXrHBFobtAMhSgV4/fh9vw+ONKCjey5tbOaGR6VLmnCekY/N
         e5vaj6xdKFAIdbP/+OMguMN6cFH/YvkZaZGBwekbNYnm3EP9Ecta9Ikz8Xac++j0Z6km
         jh/35DCH+9lMfbq9IoD50yAm01UjmJTXBl58ZN6AnbzhzUTBrAwpqCDnYpwLpMhcw8gM
         Z0rw==
X-Gm-Message-State: APjAAAUXgIrfBwcvhNtAtpsrbcZynJg3XQW9w8xgfNL7DMjGOAic8p4s
        eJQFeWDFWZyiKLBwipFekYkW8o5+p5gIF/wg/0VzS6E0zTwRnXtrivS1WCmHT1dlui9Ff7wFMzx
        uVhAcWJNBzwSmK+fOk4frbKPc
X-Received: by 2002:adf:c00a:: with SMTP id z10mr10055408wre.81.1573480178214;
        Mon, 11 Nov 2019 05:49:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHJZ7aG6D3DbvVErNHEtfXPfD9Yik6GMDJjGqtT+LDE8STop0GLyX9fdTYVK2/+Xc2br2hTg==
X-Received: by 2002:adf:c00a:: with SMTP id z10mr10055388wre.81.1573480177951;
        Mon, 11 Nov 2019 05:49:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a0f7:472a:1e7:7ef? ([2001:b07:6468:f312:a0f7:472a:1e7:7ef])
        by smtp.gmail.com with ESMTPSA id a15sm14665669wrw.10.2019.11.11.05.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 05:49:37 -0800 (PST)
Subject: Re: [PATCH 2/5] KVM: add a check to ensure grow start value is
 nonzero
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, mtosatti@redhat.com,
        joao.m.martins@oracle.com, rafael.j.wysocki@intel.com,
        rkrcmar@redhat.com
References: <1572060239-17401-1-git-send-email-zhenzhong.duan@oracle.com>
 <1572060239-17401-3-git-send-email-zhenzhong.duan@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <391dd11b-ebbb-28ff-5e57-4a795cd16a1b@redhat.com>
Date:   Mon, 11 Nov 2019 14:49:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1572060239-17401-3-git-send-email-zhenzhong.duan@oracle.com>
Content-Language: en-US
X-MC-Unique: 0lIWp_U0PcmtCVaVr_sQRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/19 05:23, Zhenzhong Duan wrote:
> vcpu->halt_poll_ns could be zeroed in certain cases (e.g. by
> halt_poll_ns_shrink). If halt_poll_ns_grow_start is zero,
> vcpu->halt_poll_ns will never be larger than zero.
>=20
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  virt/kvm/kvm_main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2ca2979..1b6fe3b 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2266,6 +2266,13 @@ static void grow_halt_poll_ns(struct kvm_vcpu *vcp=
u)
>  =09=09goto out;
> =20
>  =09val *=3D grow;
> +
> +=09/*
> +=09 * vcpu->halt_poll_ns needs a nonzero start point to grow if it's zer=
o.
> +=09 */
> +=09if (!grow_start)
> +=09=09grow_start =3D 1;
> +
>  =09if (val < grow_start)
>  =09=09val =3D grow_start;
> =20
>=20

Zeroing grow_start will simply disable halt polling.  Is that a problem?

Paolo

