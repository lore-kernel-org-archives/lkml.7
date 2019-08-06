Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE8BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC3920C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KoIGmart"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733033AbfHFSUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:20:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47088 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732949AbfHFST7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:19:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so4809640pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 11:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YagwnSKjQ9AFWb+JwZGJEtizWqnGfGkBH4aRSOhIlmw=;
        b=KoIGmartaNCDHdqRUk7Y5Z8Djc1SV/l1OncetDnEvj8Y7O4V4mxOvdEOuedUC+SE8C
         L3V76Jc0LaKIpmR/+PRqkdcexS0s9/ippez+JIzrD2uaZ8vEiSRslr3cgd+VIuiM52QX
         UKkayxiP3Niz/PnebgM5RJf5bijdRk/QHRPcI2umtokyw+lgh8mUQmZutLc2UavKlAMl
         9DsNUqOCqaJfuNzRa8ybgIg7EngFO9wrtSBuGkOeRiXT33yHIRmdcWOB8NajmQgx6uwm
         EXukoSfpWUj+TmypMGa/lcJH6n5cSEuFwHzMmlTs8RPT39FlDbg/1jHQX/8jCX+N8vYb
         cvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YagwnSKjQ9AFWb+JwZGJEtizWqnGfGkBH4aRSOhIlmw=;
        b=Ti5tCt/tQ3QNGSytNKsNfZzfNFr/FV3UQHdV3Ptg+0RTaZUzBFjmqjm3P5y9h6bjFs
         rOOVZp9qToFw7tjjy8t8yhzzkYdUoLmfRJQmjVxY6j8Z80wPcYqBfTjqCFaX05CYpdc4
         NI586G+7y5Fxd8P0OZZAoYWvW4fWiaicHDC+1K5QNLZ2VF1wbs8ZSxs7RTIAB/aM+aRY
         462TKjVM694doqLmKVr85tnG8lsgKG2N1K+/X7LSGCz1BLnMs562sbDnywMjs12dLVmr
         fuu2H3M90use6rr9I8cvQ1ErrpkhUn4yz16ojcoIdc8ZDWbvO5zj5EdJpUx3N995j75f
         DGUg==
X-Gm-Message-State: APjAAAUHLD0rx9AlRWXyJbugqtZUjzzTybJ5TagPl03Na3D9mRWuRNJs
        t8Ybgg8m7SkrApoDAZS5FTizWA==
X-Google-Smtp-Source: APXvYqxvajvknV5Crc2GPBDACD5q5nc5DS/TZ3iQqT5dzZ4pFCLgRCC1lLvaVW/QfeBBtQ2Q4V9PrA==
X-Received: by 2002:a17:90a:d3d4:: with SMTP id d20mr4673518pjw.28.1565115598199;
        Tue, 06 Aug 2019 11:19:58 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 33sm101572057pgy.22.2019.08.06.11.19.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 11:19:57 -0700 (PDT)
Date:   Tue, 6 Aug 2019 11:21:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Fabien DESSENNE <fabien.dessenne@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH 0/6] hwspinlock: allow sharing of hwspinlocks
Message-ID: <20190806182128.GD26807@tuxbook-pro>
References: <1552492237-28810-1-git-send-email-fabien.dessenne@st.com>
 <20190801191403.GA7234@tuxbook-pro>
 <1a057176-81ab-e302-4375-2717ceef6924@st.com>
 <20190805174659.GA23928@tuxbook-pro>
 <dcd1aeea-cffe-d5fb-af5a-e52efcc2e046@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcd1aeea-cffe-d5fb-af5a-e52efcc2e046@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06 Aug 10:38 PDT 2019, Suman Anna wrote:

> Hi Fabien,
> 
> On 8/5/19 12:46 PM, Bjorn Andersson wrote:
> > On Mon 05 Aug 01:48 PDT 2019, Fabien DESSENNE wrote:
> > 
> >>
> >> On 01/08/2019 9:14 PM, Bjorn Andersson wrote:
> >>> On Wed 13 Mar 08:50 PDT 2019, Fabien Dessenne wrote:
[..]
> >> B/ This would introduce some inconsistency between the two 'request' API
> >> which are hwspin_lock_request() and hwspin_lock_request_specific().
> >> hwspin_lock_request() looks for an unused lock, so requests for an exclusive
> >> usage. On the other side, request_specific() would request shared locks.
> >> Worst the following sequence can transform an exclusive usage into a shared
> >>
> > 
> > There is already an inconsistency in between these; as with above any
> > system that uses both request() and request_specific() will be suffering
> > from intermittent failures due to probe ordering.
> > 
> >> one:
> >>    -hwspin_lock_request() -> returns Id#0 (exclusive)
> >>    -hwspin_lock_request() -> returns Id#1 (exclusive)
> >>    -hwspin_lock_request_specific(0) -> returns Id#0 and makes Id#0 shared
> >> Honestly I am not sure that this is a real issue, but it's better to have it
> >> in mind before we take ay decision
> 
> Wouldn't it be actually simpler to just introduce a new specific API
> variant for this, similar to the reset core for example (it uses a
> separate exclusive API), without having to modify the bindings at all.
> It is just a case of your driver using the right API, and the core can
> be modified to use the additional tag semantics based on the API. It
> should avoid any confusion with say using a different second cell value
> for the same lock in two different nodes.
> 

But this implies that there is an actual need to hold these locks
exclusively. Given that they are (except for the raw case) all wrapped
by Linux locking primitives there shouldn't be a problem sharing a lock
(except possibly for the raw case).


I agree that we shouldn't specify this property in DT - if anything it
should be a variant of the API.

> If you are sharing a hwlock on the Linux side, surely your driver should
> be aware that it is a shared lock. The tag can be set during the first
> request API, and you look through both tags when giving out a handle.
> 

Why would the driver need to know about it?

> Obviously, the hwspin_lock_request() API usage semantics always had the
> implied additional need for communicating the lock id to the other peer
> entity, so a realistic usage is most always the specific API variant. I
> doubt this API would be of much use for the shared driver usage. This
> also implies that the client user does not care about specifying a lock
> in DT.
> 

Afaict if the lock are shared then there shouldn't be a problem with
some clients using the request API and others request_specific(). As any
collisions would simply mean that there are more contention on the lock.

With the current exclusive model that is not possible and the success of
the request_specific will depend on probe order.

But perhaps it should be explicitly prohibited to use both APIs on the
same hwspinlock instance?

Regards,
Bjorn
