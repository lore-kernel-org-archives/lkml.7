Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDBFC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710D920673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnRPew3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgAIJQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:16:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35250 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgAIJQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:16:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id i23so3097189pfo.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LhceEG3UhA0whwHt1MK3h6+cCL04vTq3JH/shOvFsrQ=;
        b=cnRPew3XWiPXqcRGiN7BEZsnaW0ivBrmTgYDkqDwMIeibcDlESn0xD67dJ7Hz+B8y+
         Smxe57Zyi9Paz8ABIUBUPcZkV+fqootaT1SgxRAGR7NzM+lty6dI7lmFmSwu6lBJYYdA
         FAHgr/YMtOObVtFEzer6wvXdAcDDBNuPOv8rQGXTRVinSSkKt1nQ961Hg38bz3dMbb7c
         KYCXcXghI9+Nq3YDK5cyhpY8fcFaN4SexwEgSfXWhZEs96Hynh/iI6NJow+ahStMfaB+
         mMiSPeWKHUgoU37yccqkGn7+iR8Ii1KKBK2fgpsTPGcVyjKcQ6CJGnJAgs8gRiF3E2SK
         N1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LhceEG3UhA0whwHt1MK3h6+cCL04vTq3JH/shOvFsrQ=;
        b=mtwIkbF0KLJ1kLhh4m6ddXuX6xSnzom/k/StOYt6+lMi8634j5MrkzdJaQdc97S4CT
         XvYuD8WE/roVeCXCweQGzvVeReH4JyrqEA7AXXcB1Ykvp2idIk3wdse7gcnwxJT46/uF
         Q4GrRDZSD/4vejtg0VeET55WGkhsjWuzeZfxcPSzgXMpBqxxX55ZzVec0QEK1Y4u0LwI
         q3VTGOvKJYMtkiN1nbazTIcct/JP3hhojMHFR/QuwRf9UBssC5sQbqDuw07kYF15p/2n
         9QLDxtWqxXuaTE9MjaqG92pO6ICts4hdD/56+i0gx0jNLfcfVtGDLH2Qgp/F57ETykeP
         XS1A==
X-Gm-Message-State: APjAAAXyVtelLNze2QmmmEiwlPrecj0zpfDLTfn6Wd2O55WqoLEik6/d
        QdCBTt8PJ49BXwhYwtciHiezxD4tHug=
X-Google-Smtp-Source: APXvYqwVlE2aRDWxTdxtk/WQvDtvsNKnq/FDp4We/vNa60vMihisUPjSivxC/byqI4W23qZOZe+56Q==
X-Received: by 2002:a65:4c82:: with SMTP id m2mr9844041pgt.432.1578561376259;
        Thu, 09 Jan 2020 01:16:16 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id j94sm2335952pje.8.2020.01.09.01.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2020 01:16:15 -0800 (PST)
Date:   Thu, 9 Jan 2020 14:46:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20200109091613.fx2ggmmjvgjempks@vireshk-i7>
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
 <CAK8P3a3=q2zX9xQo7eZKp7e70rAeNB8VoSjg2aE06QJuSw8y3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3=q2zX9xQo7eZKp7e70rAeNB8VoSjg2aE06QJuSw8y3Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-20, 09:18, Arnd Bergmann wrote:
> > +static int mailbox_chan_free(int id, void *p, void *data)
> > +{
> > +       struct scmi_chan_info *cinfo = p;
> > +       struct scmi_mailbox *smbox = cinfo->transport_info;
> > +
> > +       if (!IS_ERR_OR_NULL(smbox->chan)) {
> > +               mbox_free_channel(smbox->chan);
> > +               cinfo->transport_info = NULL;
> > +               smbox->chan = NULL;
> > +               smbox->cinfo = NULL;
> > +       }
> 
> There is something wrong if smbox->chan can be be one of
> three things (a valid pointer, a NULL pointer, or an error value).
> 
> I see this is a preexisting problem, but please add a patch to
> make it consistently use either NULL pointers or error codes
> and remove all instances of IS_ERR_OR_NULL() from this
> subsystem.

This isn't a subsystem problem actually. mbox_request_channel() never
returns NULL on error.

@Sudeep, do we really need the IS_ERR_OR_NULL() check in
scmi_mbox_free_channel() helper ? Or can it just be IS_ERR() ?

-- 
viresh
