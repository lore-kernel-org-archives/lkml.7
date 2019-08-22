Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD67AC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A069A21726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566471208;
	bh=MMLQr7JSx5SsoXIo0mG7WnY9nJFzHjYEQB4fT8kj/38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wh0C3/PgzkoBziwB7GgogJe5cdNhmM4viAI6CIseTP10qyszE9Te5qOWPFYt/IfNl
	 p3rajvkT7t/N2t6xzn26YkFN34l5jqc5nfb/6uYizorp1mM4Wrtkg6tyVD0WbFg0Xd
	 HTUlqfmWDyJzqc/dostzyTfZ/s/YPulGkuGGuDzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbfHVKx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:53:27 -0400
Received: from mail-wm1-f97.google.com ([209.85.128.97]:54456 "EHLO
        mail-wm1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732595AbfHVKx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:53:26 -0400
Received: by mail-wm1-f97.google.com with SMTP id p74so5140713wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 03:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VCTHzgx28DS8kDSwqE8s4qzfBppKuuGKJAfrjTj6g0M=;
        b=sNcfjNVTOhE1MCqfpOXoSjWt/gheE7SkzksxTjLAi8DorfVGhtIhgIV5qQd7urZUHV
         PzYt9ejzutDeWU3XrLS37gDnqmfpr2eB/608T5Tvn8vSWkLeIq280wCkIdjIMlZ3Trap
         ebucJWJGv4E942xI6ncAKncU5qheg6RyqOshWXkW2KBV5Th5QuIvzCEraiUel6jZrN4p
         WFG2PtMYoHZRdZfQV3os4y55+KdmQ3+nb+XJWaHU70tx9J+6Z3kFgFBNSLHKstMYXVOK
         sNm5Kb46z9ano2Og7gvmktgS+Lrw4OJwlV0idVZWznizhmehulmg+S7oiaynevVDpr23
         0sYQ==
X-Gm-Message-State: APjAAAUUczICedaN0GprUpRmCv8wFB1MBxq4QfoyijpPshtj5Tv73oKw
        FpfcSA+a/cjyVSOqmWg9jDkbOstecq0Fqc6WAwzbibFgXF42cV4VV7lvTvh5El9B6g==
X-Google-Smtp-Source: APXvYqzn6IeKLGMdshW7rZXERaLcomrQtLfiJCz/AJBBbt5lUZMP5qyiqUaAV4NVlfvhHjYhQV+dRMiRbyFd
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr5119257wmc.87.1566471204690;
        Thu, 22 Aug 2019 03:53:24 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id b135sm29173wmg.32.2019.08.22.03.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 03:53:24 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0kia-0004i3-8e; Thu, 22 Aug 2019 10:53:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D39D22742A5E; Thu, 22 Aug 2019 11:53:22 +0100 (BST)
Date:   Thu, 22 Aug 2019 11:53:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Takashi Iwai <tiwai@suse.de>, spapothi@codeaurora.org,
        bgoswami@codeaurora.org, plai@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH v2 3/4] ASoC: qdsp6: q6afe-dai: Update max rate for slim
 and tdm dais
Message-ID: <20190822105322.GA4630@sirena.co.uk>
References: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
 <20190822095653.7200-4-srinivas.kandagatla@linaro.org>
 <s5h7e75v7en.wl-tiwai@suse.de>
 <923f1d65-d908-c64c-3109-0da1938d3824@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <923f1d65-d908-c64c-3109-0da1938d3824@linaro.org>
X-Cookie: You dialed 5483.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2019 at 11:45:48AM +0100, Srinivas Kandagatla wrote:
> On 22/08/2019 11:09, Takashi Iwai wrote:

> > This will support a lot more than advertised, e.g. it contains 64000Hz
> > or 22050Hz.  Is this supposed?  If yes, mention it clearly in the
> > changelog, too.

> Some of the rates inbetween are not in the DSP supported rate list for TDM.

> DSP should return error if we try to set any unsupported rate!

The goal with the capabilities is that we should never get as far as
trying to actually set an unsupported rate, we should figure out earlier
on that it won't work and never even try.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1edB0ACgkQJNaLcl1U
h9CyZQf+NkxJ3s3y4A36V4wjspMiCTbPJ1AjcV6Gd6tv7I1R+qKTpJkPTC9Z9rMb
7iMb065hO/nn885r+VvMF66Qihouou4XieX8RMUxUvjAA6v4+napihPwiZOGFIW6
c5rUCzCzZFK4jXD71dMOhOlIJENcKgXdgBQG+9fIfDAPNLHp/4RCWEc9PUDJ5f6w
UW6/aGyZlXypfQxEpsw9maZoYV3VZhCp+uJ1++P7Ps6gjqU6RrcPGRnGm7ZQ+iWk
YKkLmgj3q1FxfNYzxEmXCRNg7mwW9jvGmO85/DD0YtUpl2T0TMOBuzyzkaqqtYj4
IXCrbdaghj8kBw2QyXbzZ7I13DNbag==
=Dx3p
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
