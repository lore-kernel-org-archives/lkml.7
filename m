Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97150C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFC020863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYHJze5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfK0Scj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:32:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54884 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbfK0Scj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:32:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574879557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=29WF8SRJu7k6XWM0r8jhKtWhn/ROnuR/yAPRr+2SCjM=;
        b=FYHJze5yacMgtus3V0trqsn33pfDEQM2AZkq4NstFxoZWMsptVhLzkxff8Y7E/sHW4Srzw
        bRpy5yBbzN+ogAETn3Feysg1V2wIjff6q9hlWeLQkHAmb2DIc1aG6YCBfQbUyzn6hYjUcW
        kyAVLJcRm3uro+T43xTUS09AOkae2MM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-lqGYbTyoMVauNlUik-RkFw-1; Wed, 27 Nov 2019 13:32:36 -0500
X-MC-Unique: lqGYbTyoMVauNlUik-RkFw-1
Received: by mail-wr1-f70.google.com with SMTP id 92so12587345wro.14
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=YxaL1ZT1aGySKkKsMe8gcQSf/mlZomA5ztZxEiMxVxw=;
        b=F99XwGt3a5CTmRiS8v1BR/Vk8v2vHhMzfefwWrgEDO0gnj4Mn2c2lMLtjtB/BcZ4Ca
         tkU/1/USxX03EX9hNMW0vuxTrDDD4vf+IgZCuAZGO8lpzrrdI+iLLLUsKBXCxZXOFi6i
         o0jfRmkX0qqwrDBhA0IliDVwop2ey+4+QbXLq86D7RrbmanCuUA2abo6ED8jyG6AtgAx
         m4yjdTalLWm6MKhYD53TnoZDFfkZXPh3j8zY7CkKYDtrQvo1KjE11OHfGkjsoTbAqS5E
         j6an8kPZ4Z0n+YJ+pjIne9oG6vMS51R7solYdbX+nXkop23ZhK61P6YRyh/tJG30H/YQ
         EEyw==
X-Gm-Message-State: APjAAAUQUrTjEOP7pIQ5nKz/pq7sjU0gs5tl52OIYE8a/37Drmg2DYXL
        PaaR4AReAl8KE72Y4gvSZ9Co0uPTBAKxsG8wo/MxolDad0VCbqHwK2uV7IPUuA/zHh/kNlkqMrY
        2JSZ1wHMiFo6chx9zSrHWpzcI
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr3907198wrs.92.1574879554650;
        Wed, 27 Nov 2019 10:32:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8ika2gcHJ74dgNr0WfljAWH/C85tD9jVcLcwqgkOP5zVcGmWunqYNXZFhQ43XFqfbSu8vdA==
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr3907176wrs.92.1574879554355;
        Wed, 27 Nov 2019 10:32:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:459f:99a9:39f1:65ba? ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
        by smtp.gmail.com with ESMTPSA id o133sm8067506wmb.4.2019.11.27.10.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 10:32:33 -0800 (PST)
Subject: Re: [PATCH] KVM: Add separate helper for putting borrowed reference
 to kvm
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191021225842.23941-1-sean.j.christopherson@intel.com>
 <de313d549a5ae773aad6bbf04c20b395bea7811f.camel@linux.ibm.com>
 <20191126171416.GA22233@linux.intel.com>
 <0009c6c1bb635098fa68cb6db6414634555039fe.camel@linux.ibm.com>
 <e1a4218f-2a70-3de3-1403-dbebf8a8abdf@redhat.com>
 <bfa563e6a584bd85d3abe953ca088281dc0e167b.camel@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6beeff56-7676-5dfd-a578-1732730f8963@redhat.com>
Date:   Wed, 27 Nov 2019 19:32:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bfa563e6a584bd85d3abe953ca088281dc0e167b.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ffsTa9Xe2Ee0ZdRuXdoWLUmRFeQM2p1Zu"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ffsTa9Xe2Ee0ZdRuXdoWLUmRFeQM2p1Zu
Content-Type: multipart/mixed; boundary="aqZUHOq3nlK4WoWx9AL9jxCe3XQdlu06R"

--aqZUHOq3nlK4WoWx9AL9jxCe3XQdlu06R
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27/11/19 19:24, Leonardo Bras wrote:
> By what I could undestand up to now, these functions that use borrowed
> references can only be called while the reference (file descriptor)
> exists.=20
> So, suppose these threads, where:
> - T1 uses a borrowed reference, and=20
> - T2 is releasing the reference (close, release):

Nit: T2 is releasing the *last* reference (as implied by your reference
to close/release).

>=20
> T1=09=09=09=09| T2
> kvm_get_kvm()=09=09=09|
> ...=09=09=09=09| kvm_put_kvm()
> kvm_put_kvm_no_destroy()=09|
>=20
> The above would not trigger a use-after-free bug, but will cause a
> memory leak. Is my above understanding right?

Yes, this is correct.

Paolo


--aqZUHOq3nlK4WoWx9AL9jxCe3XQdlu06R--

--ffsTa9Xe2Ee0ZdRuXdoWLUmRFeQM2p1Zu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl3ewUAACgkQv/vSX3jH
roNHAwf/V5jw3UuEAUr+qwFRt1WbZT7kDY6RcpqwfR7drS3cV9JoPkLaa/vuvUnj
TvZG7Q2ZVR0m2JALj914WOuC5pmAYy8HVawrFbooQ4T5mtc2akQzVD0eshLankPo
RZjfY2ijPzfY+tajHzQJ09U9Rzc33YvOZGmao/zV8/QXtFQokF1549ZJQyZPTVM0
cgiRO5mVfl0/IbchPvczCrgXIT0P4Ca9w+BN7xn1+HFGO8rvUtwaG5ZxVhUfk58B
LArJb8NkIGNDdoh3DF27nHNXak0C95hD1ENiPKVK6RrEkr/wJc6ffOS8eAdUu5yl
WmgTspYVIA7RjqLbTwLXHOQwKrvG7A==
=Shjy
-----END PGP SIGNATURE-----

--ffsTa9Xe2Ee0ZdRuXdoWLUmRFeQM2p1Zu--

