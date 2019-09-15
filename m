Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32A4C4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 19:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8C0214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 19:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfIOTBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 15:01:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57466 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfIOTBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 15:01:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C100081DBB; Sun, 15 Sep 2019 21:01:16 +0200 (CEST)
Date:   Sun, 15 Sep 2019 21:01:30 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ladi Prosek <lprosek@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 043/190] KVM: hyperv: define VP assist page helpers
Message-ID: <20190915190130.GA18580@amd>
References: <20190913130559.669563815@linuxfoundation.org>
 <20190913130603.202370862@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20190913130603.202370862@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-09-13 14:04:58, Greg Kroah-Hartman wrote:
> [ Upstream commit 72bbf9358c3676bd89dc4bd8fb0b1f2a11c288fc ]
>=20
> The state related to the VP assist page is still managed by the LAPIC
> code in the pv_eoi field.

I don't get it.

> =20
> +bool kvm_hv_assist_page_enabled(struct kvm_vcpu *vcpu)
> +{
> +	if (!(vcpu->arch.hyperv.hv_vapic & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE))
> +		return false;
> +	return vcpu->arch.pv_eoi.msr_val & KVM_MSR_ENABLED;
> +}
> +EXPORT_SYMBOL_GPL(kvm_hv_assist_page_enabled);
> +
> +bool kvm_hv_get_assist_page(struct kvm_vcpu *vcpu,
> +			    struct hv_vp_assist_page *assist_page)
> +{
> +	if (!kvm_hv_assist_page_enabled(vcpu))
> +		return false;
> +	return !kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.pv_eoi.data,
> +				      assist_page, sizeof(*assist_page));
> +}
> +EXPORT_SYMBOL_GPL(kvm_hv_get_assist_page);
> +

This adds two functions, but not their users. What bug is it fixing? I
don't see any users in the next patch, either.

									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1+iooACgkQMOfwapXb+vI8ngCfXco/aA0VMJBsbUO38fe/wpPJ
cBoAoK6tWg+FgybP5rJY1suLqWYyQu53
=nMqr
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
