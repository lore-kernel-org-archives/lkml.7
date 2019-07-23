Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF03C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70522238B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PE4Zoq08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfGWCVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:21:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45078 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfGWCVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:21:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so18565203pgp.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 19:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BnCBC+zUlqDIIAOvfSKLBUp5eSfkGPiVUglDWmp/gR8=;
        b=PE4Zoq08LGucIhGqujRu/QuMdngn1fAHXLyBPyBVeoeIL4QaDln7Ag7evhB/1vWITd
         Iz12quvXzcyb3F9x+U/2kD6J6lvzx45cJRvDOQN7WHsyVubQCP7ZmT0w4LahjIviE90q
         +LhBeVkYuO1tct6jD364mH4L3/nxbWossI1aMQ2I6CU+bIe4H29fqE/AOWIM/4moyv1r
         lUQ+HBkTyS/CeRFtkgjmjXa+6djuHjWQl7nXHpBFaAvpCnA/GQuTok5Zgh8PPO9TFTPg
         z1R8+qqgg2s+rxFI/xaRAcRDzP623lGRAOHfZewEhKDwKB9SdOUHHD+vUrrIJDWZYx0a
         A5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BnCBC+zUlqDIIAOvfSKLBUp5eSfkGPiVUglDWmp/gR8=;
        b=g9yTCtVwaRDGgMxmAMe4pev+Wdcy8M54WNXcuxL6s+ol388aD5x6rK699w/Hm/Mej8
         dn7TnvGEb2mrYCanxFz0Audn4SEepEpxk6j/J27ZhdSTKalSVP8JaNVZAztgyGo+SFJq
         bNLmqMdmO3xkFvJN/a6mZynzMXN5gJXqwZFnfN5o7us/+eLV0mJhGEDYeW2/w73FJagu
         1l4+pDawtELVYNh0jDVt4tN9NHqA7fDq0WduwHj4uShwMQZGIZMASEaMFkOwI1vmCu+a
         oKD3yVp6iSAlXDECM7eqrZq0tTCBJWDtSQ4+320wej0hXVk857ANRfOuumO7Lau5Lux7
         lGxw==
X-Gm-Message-State: APjAAAWAAP7CAQv96e97GYIN+mODq0rvXzCcnXXezMzCz8wucdEacugW
        UTNKwiS5Y43CoMFFQDVJNXkrGQ==
X-Google-Smtp-Source: APXvYqxL2jAvzgpf0MMdvr4SEuFbkxGKEEoNZbidbXR7lRbw9PpJt9A0P4ipBQJ+Wf4gE23lgoCWYw==
X-Received: by 2002:a62:e801:: with SMTP id c1mr3287708pfi.41.1563848467126;
        Mon, 22 Jul 2019 19:21:07 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id p2sm55113862pfb.118.2019.07.22.19.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 19:21:06 -0700 (PDT)
Date:   Tue, 23 Jul 2019 07:51:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        sibis@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: interconnect: Add
 interconnect-opp-table property
Message-ID: <20190723022104.m3zx4w7i6ki5cmgd@vireshk-i7>
References: <20190703011020.151615-1-saravanak@google.com>
 <20190703011020.151615-6-saravanak@google.com>
 <20190722233927.GA1353@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722233927.GA1353@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-19, 17:39, Rob Herring wrote:
> On Tue, Jul 02, 2019 at 06:10:19PM -0700, Saravana Kannan wrote:
> > Add support for listing bandwidth OPP tables for each interconnect path
> > listed using the interconnects property.
> > 
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../devicetree/bindings/interconnect/interconnect.txt     | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > index 6f5d23a605b7..fc5b75b76a2c 100644
> > --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > @@ -55,10 +55,18 @@ interconnect-names : List of interconnect path name strings sorted in the same
> >  			 * dma-mem: Path from the device to the main memory of
> >  			            the system
> >  
> > +interconnect-opp-table: List of phandles to OPP tables (bandwidth OPP tables)
> > +			that specify the OPPs for the interconnect paths listed
> > +			in the interconnects property. This property can only
> > +			point to OPP tables that belong to the device and are
> > +			listed in the device's operating-points-v2 property.
> > +
> 
> IMO, there's no need for this property. Which OPP is which should be 
> defined already as part of the device's binding. That's enough for the 
> driver to know which OPP applies to the interconnect.

And if there is confusion we can actually use the compatible property
to have another string which highlights that it is an interconnect OPP
?

-- 
viresh
