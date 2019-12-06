Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E78C2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B041120706
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDb5m2IF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFNvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:51:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39365 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726171AbfLFNvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575640312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cPjTncpDFw41fx9F5xYvf+N54ckom4KcOA71nUG8Pg=;
        b=GDb5m2IFkiz5Q2eCRn8omSoo+avhlHUvLMiIdJxD3MlW20ZkpOqSHTkH8l2+KMZR0IJXo/
        b9G0lVIP9+RUF9NNY0iM1JgqLy3/qwN3m6qVOmQbP8WK5rj/q9YYHS0e+3YjpBbR2XK+j6
        S3OWVaTh0ENk6zmHr+X1Ur8x2ZJ3iig=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-smptZJmoPsKSTjnPLWxBmA-1; Fri, 06 Dec 2019 08:51:49 -0500
Received: by mail-wr1-f70.google.com with SMTP id j13so3164664wrr.20
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 05:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hBPfAz5d6cicO7lOtm3rsxxZRjo5sqJZor8zQVBqKpc=;
        b=tfu6gau09zGClGHP47Fkt0i/3CXEkEUL7EpaMvHxV7DaVvvM2hSP8PPQExW50CY3/4
         cBPClqRZKDMAJvgWi0W8M1uhtg7vHCgUyq3nRACZx4dPAWodX9OD0zOKMFurv+9H48Hd
         rtmxSBXcVq5GNTVODzShx6yJsjm+OyGI/o4j7dsLDAY3o301PlSm3JH2ulZPHNw+sgZJ
         VRPNNkOoMD4O5QAOjfdBN/zfU0Omy9fghyAu74m1NRuNUo9S+S//7zRim9iW4JyPLtss
         z6rcQFHq2NbFXXliIk3hX2UsvLdwIInd3LTMYHmHZQ3dlC4Tnuu02avNSm7AfyeqeFAG
         I/8w==
X-Gm-Message-State: APjAAAU4aIN3em6uYyqCLjSKsie6nlOFxBWjBMovlRC/vEw7KJveGh3W
        xIbdrSNgZLcW+uDePxHigT8K5PWDwETv7evbAZ5nYn1YHW1TXTv/rHuqgZlGlX++ZUkh4O5gTGh
        2lrJgaHL8nPKLz8FEcc9J1qIL
X-Received: by 2002:a05:600c:204c:: with SMTP id p12mr10876582wmg.61.1575640308099;
        Fri, 06 Dec 2019 05:51:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpWiFZTu2cRvelChSMS4nkUKyMuIPCV3x4l7zHobMJy/hcS33YDoKGgKGPEBCEJymenIdYjw==
X-Received: by 2002:a05:600c:204c:: with SMTP id p12mr10876553wmg.61.1575640307831;
        Fri, 06 Dec 2019 05:51:47 -0800 (PST)
Received: from [10.201.49.168] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id b10sm16337198wrt.90.2019.12.06.05.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 05:51:47 -0800 (PST)
Subject: Re: [PATCH] KVM: Radim is no longer available as KVM maintainer
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rkrcmar@redhat.com, radimkrcmar@gmail.com, drjones@redhat.com,
        stable@vger.kernel.org, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org
References: <20191206134511.20036-1-thuth@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2640ebbd-06b9-812f-7ba7-704fdb470220@redhat.com>
Date:   Fri, 6 Dec 2019 14:51:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191206134511.20036-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: smptZJmoPsKSTjnPLWxBmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/19 14:45, Thomas Huth wrote:
> Radim's mail address @redhat.com is not valid anymore, so we should
> remove this line from the MAINTAINERS file to avoid that people send
> mails to this address in vain.
>=20
> Thank you very much for all your work on KVM during the past years,
> Radim!
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 067cae5bde23..54cf6e242e54 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9043,7 +9043,6 @@ F:=09include/linux/umh.h
> =20
>  KERNEL VIRTUAL MACHINE (KVM)
>  M:=09Paolo Bonzini <pbonzini@redhat.com>
> -M:=09Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>  L:=09kvm@vger.kernel.org
>  W:=09http://www.linux-kvm.org
>  T:=09git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> @@ -9115,7 +9114,6 @@ F:=09tools/testing/selftests/kvm/*/s390x/
> =20
>  KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)
>  M:=09Paolo Bonzini <pbonzini@redhat.com>
> -M:=09Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>  R:=09Sean Christopherson <sean.j.christopherson@intel.com>
>  R:=09Vitaly Kuznetsov <vkuznets@redhat.com>
>  R:=09Wanpeng Li <wanpengli@tencent.com>
>=20

Queued, thanks.

Paolo

