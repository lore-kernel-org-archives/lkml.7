Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51CEECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976BA2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8RYqyzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfJPHKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:10:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46101 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726515AbfJPHKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571209811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48tYkDJe0SqGLusONClw8lIZHFqflqFfRXBr2ATDPpg=;
        b=T8RYqyzimx4RdeDxcO0KTMPYwMEugA7pNbLJu38sWNDezbycXNVTAZpkCR/UtBbKbdlIOm
        FwchR52pSxJws7axv1R8R3vQWySXgCIHglBQyNwru+U5iM1qwUauJ3E2IBpGFHZaGhW8Ht
        SbGGo7aRcvdK/VbDjpvZQx+catYrF9w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-iL3S7sVBPWKE5gfRAJ5S8w-1; Wed, 16 Oct 2019 03:10:10 -0400
Received: by mail-wr1-f69.google.com with SMTP id n3so11306730wrt.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8b7UpnoPmb5i1nQSpxNz3HRMIYoZAJY2z85wR9Og0Oo=;
        b=ilYX57qm82dF5kZ8sp5GpoqGLW68i9IaaZE8ffDWecI1ZAQ11hjIXeim/z9Z54xD8X
         zZtk7x4fF8IXRrHO4iF+Dnb0f7rbfczCDpdl8+uBCQ5hkAcYn4nfPEBW3UeXTfNtDfnJ
         3vrwIummCMp+w8bIEIbItgSg8eAbwkEUJA0nePl3UCGQVTM/UtqneV9Tg8myRhtYT4iz
         Sa6cvnFMbtyRJQdOTWdaURy33THun5gx1PaIZddeXfu+1qANiWtHDidVU8In+n3TSslE
         tTK9/cyH07mcY+lGTwn5IEmB6PI5q9C8GRiMBV79pvZq/FOHBRgGV9+aj/nkJF6wV38w
         MPVQ==
X-Gm-Message-State: APjAAAXL0GFylp/7LAbhHOni4ikGWnaxUSjZDdlG0IvnyDZCbZseTr79
        FsipxBeBD7WPU6V87fM/cgQqd0DcWAUcQ3tbGV8VJJggGXIlGdP3Ck1SeHQGQGjWevzLzxALl2N
        0gA88B1Kuiu7Vs5+S+6PwcU/D
X-Received: by 2002:adf:cc8e:: with SMTP id p14mr1342969wrj.301.1571209809458;
        Wed, 16 Oct 2019 00:10:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzVEQNXaAuAJVOUPKU0UPAGNhg1SfcLUKvaqKnrK8g/JFc1UdJaCdRin1J2hoFdoWeTpE0hnA==
X-Received: by 2002:adf:cc8e:: with SMTP id p14mr1342946wrj.301.1571209809203;
        Wed, 16 Oct 2019 00:10:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e? ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
        by smtp.gmail.com with ESMTPSA id e18sm33448011wrv.63.2019.10.16.00.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 00:10:08 -0700 (PDT)
Subject: Re: [PATCH v5 2/6] ptp: Reorganize ptp_kvm modules to make it
 arch-independent.
To:     Jianyong Wu <jianyong.wu@arm.com>, netdev@vger.kernel.org,
        yangbo.lu@nxp.com, john.stultz@linaro.org, tglx@linutronix.de,
        sean.j.christopherson@intel.com, maz@kernel.org,
        richardcochran@gmail.com, Mark.Rutland@arm.com, will@kernel.org,
        suzuki.poulose@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
        nd@arm.com
References: <20191015104822.13890-1-jianyong.wu@arm.com>
 <20191015104822.13890-3-jianyong.wu@arm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e0260f51-ad29-02ba-a46f-ebaa68f7a9ea@redhat.com>
Date:   Wed, 16 Oct 2019 09:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015104822.13890-3-jianyong.wu@arm.com>
Content-Language: en-US
X-MC-Unique: iL3S7sVBPWKE5gfRAJ5S8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/19 12:48, Jianyong Wu wrote:
> +=09ret =3D kvm_arch_ptp_init();
> +=09if (!ret)
> +=09=09return -EOPNOTSUPP;

This should be "if (ret)".

Paolo

