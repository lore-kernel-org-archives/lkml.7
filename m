Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D38DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E9A21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/s0azMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfKGXos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 18:44:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39735 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKGXos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 18:44:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so3503556pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 15:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1U0wPcyIG/9s48x7IfdmB9lT8/kPl3K5MB9kafPq4kQ=;
        b=S/s0azMruXPaRqNJcdoSSNkgORzM89gGHIbVO3fAYv89FVXvjk65KmQCaB+E2lLDHI
         TDhBW5Uvr0wpQNkWB30A72fd1dcPgpNO05sUddxV7PiITIbZb/n1wO8Maymbtu70efAT
         UbvjUadU7q+GmiUrPpH/VD4LB57GqGRa0Djnv62+JAQGXllBk4OkIKDkRrNZ7XF9oxFj
         oL0Sp1ZG6QJFhJ9+XfeKGRPbcU6zVtuM43aCeDuADFRhaWjoYLo0exQ9VPBMjgeG73+J
         GIXl3Q+jtb8RNcoi0EPu6PxrxyHkCTQPYUgnU0Y1UsvyYCApwid1bfnWK+6yN3YMrsnN
         fxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1U0wPcyIG/9s48x7IfdmB9lT8/kPl3K5MB9kafPq4kQ=;
        b=RUjvRO5YWSQh7EXG3fTJc+B539TJ0ze80mrHAKADh54801rMUPszymTZs8+koLbZyu
         1BnBmLc7L5Kcve4RW9Po99IzetNP3AotoDtLRKKF/bCo64W86ThmD4WHpSlSCfCOU4U7
         sGvIZ5M8EXEoi8uYVi21OqqwgUFll0u6fPmLKkfdWONm2Bcn/varaXuo5C7/U74W+vSL
         CtfVydyGXi1iHjYhPGtMukEf6PtuJdD7wa00rlEBFyWPBDqj+3ZKoeWSjAMk64Q85gpf
         C7KaFrhQI04GqSPunYSKRcv+KGEwm2FXHTvXl+DI2/5KrdbOwIj5uudKPv69ep6cl+a9
         YjwA==
X-Gm-Message-State: APjAAAWIj+gtLrvkZV/7fwP2jyDGjCc87AXRzPbq2VA7CqzM1szId5D2
        ZoIo+sT2UI1eUS85xC9fm2nvQg==
X-Google-Smtp-Source: APXvYqy81x91iTDJeaZtLHQ93IDGUFfWCM+caD2RnLcNF36qUqvWx1bxNzAOZp9kckdHErPtHKxvvg==
X-Received: by 2002:a63:cc17:: with SMTP id x23mr7923619pgf.446.1573170287415;
        Thu, 07 Nov 2019 15:44:47 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z5sm3459995pgi.19.2019.11.07.15.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 15:44:46 -0800 (PST)
Date:   Thu, 7 Nov 2019 15:44:44 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     eberman@codeaurora.org
Cc:     saiprakash.ranjan@codeaurora.org, agross@kernel.org,
        tsoni@codeaurora.org, sidgup@codeaurora.org,
        psodagud@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/17] firmware: qcom_scm-64: Improve SMC convention
 detection
Message-ID: <20191107234444.GB3907604@builder>
References: <1572917256-24205-1-git-send-email-eberman@codeaurora.org>
 <1572917256-24205-10-git-send-email-eberman@codeaurora.org>
 <20191107191846.GA3907604@builder>
 <1eb1c0db6f2d9e65479205ddad92bac7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb1c0db6f2d9e65479205ddad92bac7@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Nov 12:20 PST 2019, eberman@codeaurora.org wrote:
> On 2019-11-07 11:18, Bjorn Andersson wrote:
[..]
> > > @@ -583,19 +591,17 @@ int
> > > __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev, bool en)
> > > 
> > >  void __qcom_scm_init(void)
> > >  {
> > > -	u64 cmd;
> > > -	struct arm_smccc_res res;
> > > -	u32 function = SMCCC_FUNCNUM(QCOM_SCM_SVC_INFO,
> > > QCOM_SCM_INFO_IS_CALL_AVAIL);
> > > -
> > > -	/* First try a SMC64 call */
> > > -	cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,
> > > -				 ARM_SMCCC_OWNER_SIP, function);
> > > -
> > > -	arm_smccc_smc(cmd, QCOM_SCM_ARGS(1), cmd &
> > > (~BIT(ARM_SMCCC_TYPE_SHIFT)),
> > > -		      0, 0, 0, 0, 0, &res);
> > > -
> > > -	if (!res.a0 && res.a1)
> > > -		qcom_smccc_convention = ARM_SMCCC_SMC_64;
> > > -	else
> > > -		qcom_smccc_convention = ARM_SMCCC_SMC_32;
> > > +	qcom_smc_convention = SMC_CONVENTION_ARM_64;
> > > +	if (__qcom_scm_is_call_available(NULL, QCOM_SCM_SVC_INFO,
> > > +			QCOM_SCM_INFO_IS_CALL_AVAIL) == 1)
> > > +		goto out;
> > > +
> > > +	qcom_smc_convention = SMC_CONVENTION_ARM_32;
> > > +	if (__qcom_scm_is_call_available(NULL, QCOM_SCM_SVC_INFO,
> > > +			QCOM_SCM_INFO_IS_CALL_AVAIL) == 1)
> > > +		goto out;
> > > +
> > > +	qcom_smc_convention = SMC_CONVENTION_UNKNOWN;
> > 
> > If above two tests can be considered reliable I would suggest that you
> > fail hard here instead.
> 
> Is the suggestion here to BUG out?
> 

We generally do not want that, but leaving it "unknown" feels like the
next scm call will have similar outcome to calling BUG() here, but be
harder to debug...

So I would be willing to accept a BUG() here.

Regards,
Bjorn
