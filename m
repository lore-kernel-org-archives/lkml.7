Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B18C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60AF20825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+DO+bXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfFGGAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:00:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37830 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFGGAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:00:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so398939plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 23:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sNeYqqj7A5jsZjI23KJv1FicJVOUSHOJooPoBup8FeM=;
        b=I+DO+bXX3/U0c5/tJe9YZdOfd9awmUKsKrvLQ6RM5e7ZPbpVdNQ6p467NhbVoMoarQ
         ZTrXnuYi/GBo+EETAJBGN7Pbc4eyxedjJgINnFW2Ljv5sN9z7vOHs6OG+Gfjx+nUFata
         r/SNJ3fb38yconRfVgfs5zO505iUUyDV4G/jHwXknqC1Y7Z1U8rC0v+rvDJyZqa/2SDY
         dFJFBnKgq948wzi26ZcXJ+LY/RNrc3C7DV8bcYap3C5SQTdSlGOwcqCDiElfo5zU+Fni
         UXim+fepv1U8X+0j4guVpm6nZtJBCDBnu6scNE5hLkz6jskKt97gH5ftrO8QkfNEvFqD
         KgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sNeYqqj7A5jsZjI23KJv1FicJVOUSHOJooPoBup8FeM=;
        b=oNGblWHca8vvKu1Oj5vtvXlYmt8Ce9JhRnAwann3SXaGW0K1Iw9VGpUOL/i7e8434j
         l3OkfUwIYmpsa8vqIWLNUTR5rVchD8ilR4gXFniMhPR7zjHJcl2Cn6pfG7NMctundWWl
         5CAViRsL5AYDIihSfVKjTbBiyZ2fUlR+qdclcBqMQCpPo+D+/XnCcu3ywNrF2cL01eha
         1UtoBoplFGm76QfbuVUMSWlOYVOQ/SGSCLQJEK1I5xf067Sl35fgL419DvHaY2kH9enj
         hS8vueMMHb3weinJylQzCPq9vPx30EdZDJ7jNvs59rUKP/tbZ3Kp6TbLhAYtR3bj2ID2
         5Q0g==
X-Gm-Message-State: APjAAAVU0cMxWWvIOyyG4AdlNhaWox6V02xrnBTY4funCZUKsaIlQUSA
        q0h2ExTiUji+lpQHTB08iGK4tA==
X-Google-Smtp-Source: APXvYqxOAWcArkn2cVZZlioTLt/qQbVmliWaDP7qBUla76loZRkDUMwoTY7MzTYQenlQtRiEFq12yQ==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr53039518plh.338.1559887241528;
        Thu, 06 Jun 2019 23:00:41 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id s42sm1593160pjc.5.2019.06.06.23.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 23:00:40 -0700 (PDT)
Date:   Fri, 7 Jun 2019 11:30:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Drop 'const' from argument of vq_present()
Message-ID: <20190607060037.eaof3hllyombxlhc@vireshk-i7>
References: <699121e5c938c6f4b7b14a7e2648fa15af590a4a.1559623368.git.viresh.kumar@linaro.org>
 <20190604095915.GW28398@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604095915.GW28398@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-06-19, 10:59, Dave Martin wrote:
> On Tue, Jun 04, 2019 at 10:13:19AM +0530, Viresh Kumar wrote:
> > We currently get following compilation warning:
> > 
> > arch/arm64/kvm/guest.c: In function 'set_sve_vls':
> > arch/arm64/kvm/guest.c:262:18: warning: passing argument 1 of 'vq_present' from incompatible pointer type
> > arch/arm64/kvm/guest.c:212:13: note: expected 'const u64 (* const)[8]' but argument is of type 'u64 (*)[8]'
> > 
> > The argument can't be const, as it is copied at runtime using
> > copy_from_user(). Drop const from the prototype of vq_present().
> > 
> > Fixes: 9033bba4b535 ("KVM: arm64/sve: Add pseudo-register for the guest's vector lengths")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm64/kvm/guest.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> > index 3ae2f82fca46..78f5a4f45e0a 100644
> > --- a/arch/arm64/kvm/guest.c
> > +++ b/arch/arm64/kvm/guest.c
> > @@ -209,7 +209,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >  #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
> >  
> >  static bool vq_present(
> > -	const u64 (*const vqs)[KVM_ARM64_SVE_VLS_WORDS],
> > +	u64 (*const vqs)[KVM_ARM64_SVE_VLS_WORDS],
> >  	unsigned int vq)
> >  {
> >  	return (*vqs)[vq_word(vq)] & vq_mask(vq);
> 
> Ack, but maybe this should just be converted to a macro?

I will send a patch with that if that's what you want.

Thanks.

-- 
viresh
