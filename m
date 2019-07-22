Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6777C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB8921951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563838505;
	bh=ea7bbNWwRc2Jb5gKkCuC0BfPuCo9gTUGpILmdaKsYTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OATYoI4Qe63fMpfkfM/4t5xFVeqas29nRqf88PD2xh2VBXI4TWsX4NgNbgXefQZRv
	 LEip77C09WSBz0E1OZFTKBCnMOyaI6bmWcwUFpiM+YgVfEIARcAWsv9L4DezT1w0rN
	 oHaXwWJ99phjYtXNwOJrTz+XdEZL6KdkUGAROPZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfGVXfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:35:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40178 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfGVXfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:35:04 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so77814041iom.7;
        Mon, 22 Jul 2019 16:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+1l4y3t2UMkEkO+/MJw8aq8fSMYsxde02LarPu3Ozik=;
        b=ZkUvj4cBeAW+x/BaVktMrSHfQkkWUySP21C/SpHbVPlPzwo7rJwqT4lYcClNpOAjRw
         hv8FxCZWvOfyWFwFujwi16xOoyQgUQPDjJB8CfF7otkaDBU01GAm2Qx0OzllZtrVQgU2
         6HMGS7cWwGiFeQz0kPUR+AQeCX3e/7FYqvcemPGlo9zmu6/zIPRp714BnKFY7ubpKAtr
         4+PeYP2JQxsVKNhJYcc9LpNptQDiSl1WKU10loHDHwPC8ZALpb3W7nQnjSmaRatp6KrL
         ic7LPdzafuyaEKfiqXs4PKeVHS5gqWp+5SQ8xjKjlnh+4VHTkEPDSciCFkf62HZVxiOi
         ebSA==
X-Gm-Message-State: APjAAAUHLw/nZcSp5IuZanQcy7hTEdi+fupBsDPgacyeRrbgrEYE4PSy
        EeB0FULVJuHv/NSTfLgwzg==
X-Google-Smtp-Source: APXvYqxPtT8L1B/fbW9iJFp4+RBI7uFqvTbw19TSSehSOpu+f76R4vtucET4OI7dIY9HOM2hAJhqNA==
X-Received: by 2002:a6b:dd17:: with SMTP id f23mr55075087ioc.213.1563838503145;
        Mon, 22 Jul 2019 16:35:03 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id v10sm36428164iob.43.2019.07.22.16.35.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 16:35:02 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:35:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
Message-ID: <20190722233501.GA19594@bogus>
References: <20190703011020.151615-1-saravanak@google.com>
 <20190703011020.151615-2-saravanak@google.com>
 <98b2e315-e8da-80ad-1ef8-e6b222c1c6fe@codeaurora.org>
 <CAGETcx9KSqvyzbM-S8LvBObkNBt38K683Ljm8nNQuhxk7MuvAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9KSqvyzbM-S8LvBObkNBt38K683Ljm8nNQuhxk7MuvAg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:58:08AM -0700, Saravana Kannan wrote:
> On Tue, Jul 16, 2019 at 10:25 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> >
> > Hey Saravana,
> >
> > https://patchwork.kernel.org/patch/10850815/
> > There was already a discussion ^^ on how bandwidth bindings were to be
> > named.
> 
> Yes, I'm aware of that series. That series is trying to define a BW
> mapping for an existing frequency OPP table. This patch is NOT about
> adding a mapping to an existing table. This patch is about adding the
> notion of BW OPP tables where BW is the "key" instead of "frequency".
> 
> So let's not mixed up these two series.

Maybe different reasons, but in the end we'd end up with 2 bandwidth 
properties. We need to sort out how they'd overlap/coexist.

The same comment in that series about defining a standard unit suffix 
also applies to this one.

Rob
